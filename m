Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF898C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C422084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554932744;
	bh=zLuqeFm5+1IIt2wLhyyKYP/R92yhvIHofnZ/EVHVzbg=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=CD592YbIYKdYDEFgWPwwo493QJCsdP01WvGSElB/2N9Ra46WcMGIQKmQo9nSBVOu/
	 DwYzja7zr87EEPq6t/+r37QaFMeKS8uBFoDTSLscMZqNx6EVFMwYsqxqtuCpFwWxv6
	 sY/C97xcgChD1N/dD+oIDS2IRovP32VjGsKNjTSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDJVpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfDJVpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:45:42 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F354B20820;
        Wed, 10 Apr 2019 21:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554932742;
        bh=zLuqeFm5+1IIt2wLhyyKYP/R92yhvIHofnZ/EVHVzbg=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=TeiDB1AtD/CUBPHgpw/bGxhp3IXbjqtO94AbpsaNCaaSAsaMZD8eqsqeL21NMgpxo
         1nOq/1+q5zPPRKnCtzYjcZ0s0znge4uDlLCZPFAalHTNOx7KZw5kQOo7/lpslmyFv/
         ob0Q0OxoOVZZxpLg9mPpK3+dbMEOaObL4jOPI4Tg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c529d12b-5212-7198-4f70-a3f771c0901f@codeaurora.org>
References: <20190404215344.6330-1-sboyd@kernel.org> <20190404215344.6330-4-sboyd@kernel.org> <f989942c-89fc-76cf-af1b-2ac352d6e60c@codeaurora.org> <155491520049.20095.15953237372852019635@swboyd.mtv.corp.google.com> <c529d12b-5212-7198-4f70-a3f771c0901f@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 3/7] clk: Add of_clk_hw_register() API for early clk drivers
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155493274113.20095.6283192313107751284@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 10 Apr 2019 14:45:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-04-10 12:39:16)
> On 4/10/2019 10:53 AM, Stephen Boyd wrote:
> > Quoting Jeffrey Hugo (2019-04-08 14:46:11)
> >> On 4/4/2019 3:53 PM, Stephen Boyd wrote:
> >>> In some circumstances drivers register clks early and don't have acce=
ss
> >>> to a struct device because the device model isn't initialized yet. Add
> >>> an API to let drivers register clks associated with a struct device_n=
ode
> >>> so that these drivers can participate in getting parent clks through =
DT.
> >>
> >> NACK.  This patch broke boot for me.  I had to pull the below from JTA=
G.
> >>    What do you need to debug this?
> >>
> >=20
> > Here's a patch to try to squash in:
>=20
> No dice.  Same issue.

Argh! dev_of_node() doesn't check for NULL device. :-/ I want to be
extremely lazy! Let's get this merged too. Thanks for the testing.

---8<---
diff --git a/include/linux/device.h b/include/linux/device.h
index b425a7ee04ce..0370dd0b3ae7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1231,7 +1231,7 @@ static inline void device_lock_assert(struct device *=
dev)
=20
 static inline struct device_node *dev_of_node(struct device *dev)
 {
-	if (!IS_ENABLED(CONFIG_OF))
+	if (!IS_ENABLED(CONFIG_OF) || !dev)
 		return NULL;
 	return dev->of_node;
 }
