Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF501C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53A520854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554915203;
	bh=pBKCFBcbiZ3h7X8Aa+TYDLQ9aErDgSo/CCG2y62H7JU=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=b3Vlva6+8P1qv1L1O58ggwfkAPE/lhDs0qOvdCLEoWGU2fcj5R9ekGSbFvYyA9rM8
	 vCNqlAhfDJiKEeLsAZgSIFxDyXHBT/Kl8soQ4iar4AaFTAYXqZGlQrZ+/JwGgypbWI
	 XWB5Ib33i1DL4gwEWNp8l5D+XPmWs+ZC/OJJ38JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbfDJQxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730235AbfDJQxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:53:21 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4627820818;
        Wed, 10 Apr 2019 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554915201;
        bh=pBKCFBcbiZ3h7X8Aa+TYDLQ9aErDgSo/CCG2y62H7JU=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=kfPlDLZujwr+z/gH5pXlsQd116EEoal72NZGY+WLyRt+YIEmqs129GBcJpDYbaNgy
         ain2KlPgs8AL2Kd4ulj4aqBwxXmzDWcb3CovRjSp8yP1npjGPGAJuUBOl+8gDkuSkN
         sNh9cacYXKmQ68bB+hWs9Vmnzk5eMOJAxMFBXb5c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f989942c-89fc-76cf-af1b-2ac352d6e60c@codeaurora.org>
References: <20190404215344.6330-1-sboyd@kernel.org> <20190404215344.6330-4-sboyd@kernel.org> <f989942c-89fc-76cf-af1b-2ac352d6e60c@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 3/7] clk: Add of_clk_hw_register() API for early clk drivers
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155491520049.20095.15953237372852019635@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 10 Apr 2019 09:53:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-04-08 14:46:11)
> On 4/4/2019 3:53 PM, Stephen Boyd wrote:
> > In some circumstances drivers register clks early and don't have access
> > to a struct device because the device model isn't initialized yet. Add
> > an API to let drivers register clks associated with a struct device_node
> > so that these drivers can participate in getting parent clks through DT.
>=20
> NACK.  This patch broke boot for me.  I had to pull the below from JTAG. =

>   What do you need to debug this?
>=20

Here's a patch to try to squash in:

---8<----
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 709492d901a1..040ce083c89e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3662,7 +3662,7 @@ __clk_register(struct device *dev, struct device_node=
 *np, struct clk_hw *hw)
  */
 struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 {
-	return __clk_register(dev, dev->of_node, hw);
+	return __clk_register(dev, dev_of_node(dev), hw);
 }
 EXPORT_SYMBOL_GPL(clk_register);
=20
@@ -3678,7 +3678,7 @@ EXPORT_SYMBOL_GPL(clk_register);
  */
 int clk_hw_register(struct device *dev, struct clk_hw *hw)
 {
-	return PTR_ERR_OR_ZERO(__clk_register(dev, dev->of_node, hw));
+	return PTR_ERR_OR_ZERO(__clk_register(dev, dev_of_node(dev), hw));
 }
 EXPORT_SYMBOL_GPL(clk_hw_register);
=20
