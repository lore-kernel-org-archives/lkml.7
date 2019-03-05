Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF895C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CFD2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551811112;
	bh=vNWtJziDqcj5y8IiVZyKoaGa+8uas8WT1+Nao7+ki68=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=HIMG7W7weBB/6su0hMBxJ9iEx1zvF259rMX/oUfuM+uAzBs4CK3BY/p5Cf7Wog5bJ
	 +QkaDMr+cZ2DtmR3qLeOWw9Gn7RX/1mkBH9Cgt2tsz5v9LRTpKhfsVjVwy6khyRrrY
	 sczldhAhS0mBUzVOiEHYAc0t5zw95SRfo9gwzetA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfCESib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfCESib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:38:31 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D182064A;
        Tue,  5 Mar 2019 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551811110;
        bh=vNWtJziDqcj5y8IiVZyKoaGa+8uas8WT1+Nao7+ki68=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=eDGJN7WvdgPMgAF6iZYnFErL9KyQh6DnrLdn++4HaAph6wCDNXCMM77cCP86wSvVw
         5Kh8gnOOd7vRr5mVqEbSBOWzUcjCigIK2+vNLeGiR6dU0OYwfvU0vodnDN8IndZ0jV
         OzE3l3eI0qPgkZXZJ0oPwZJTYykgMUrnofNZMAd4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com>
References: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and gaps
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Patrick Wildt <patrick@blueri.se>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Message-ID: <155181110921.20095.1641360339603928947@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 05 Mar 2019 10:38:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-03-05 01:49:16)
> IMX8MQ_CLK_USB_PHY_REF changes from 163 to 153, this way removing the gap.
> All the following clock ids are now decreased by 10 to keep the numbering
> right. Doing this, the IMX8MQ_CLK_CSI2_CORE is not overlapped with
> IMX8MQ_CLK_GPT1 anymore. IMX8MQ_CLK_GPT1_ROOT changes from 193 to 183 and
> all the following ids are updated accordingly.

Why do the numbers need to be consecutive? This looks difficult to merge
given that the commit that's being "fixed" is in v5.0 and thus the
integer value of these defines is pretty much an ABI. So if there are
holes in the space, I suggest we leave them there unless something is
really wrong or unworkable with that solution.

BTW, it would be great if the binding header was generated once and then
never changed again so that we don't have to spend time on these sorts
of patches in the future. Please try to fully describe each possible clk
that might be used with a particular binding instead of adding new clk
ids over time, especially if you have access to the silicon manufacturer
documentation and can easily figure out all the clks that are there
beforehand.

