Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C761C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FF920857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551461487;
	bh=BQE+SMLxxsmFEvJ/1XIaQOXrWm6bgHplun/ybCjHg+A=;
	h=In-Reply-To:To:Subject:References:From:Cc:Date:List-ID:From;
	b=gCDWKEJoDiiKiUv6A9/E2EmakijV1bJsj75iylFl928PL0fZ+Vb4+fxYu0RlE0hxF
	 qiiqLl4SZ8iF1nipUlJX6gMa5lZLnQhxWB7bOjcWQVOebo1KmOJlbRnSXVC+MKb+0k
	 L3K6f81SmMzU3XdajklBG6PtSCzh4xpS6KFU63RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbfCARbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:31:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfCARbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:31:25 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC0620818;
        Fri,  1 Mar 2019 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551461484;
        bh=BQE+SMLxxsmFEvJ/1XIaQOXrWm6bgHplun/ybCjHg+A=;
        h=In-Reply-To:To:Subject:References:From:Cc:Date:From;
        b=kj6g66x2aa/b/Tec/ACBezsobpCsPcrV/rJ4LPhM94i9xwsFa16OrGt4FiXa2OYel
         iJOjLXPkrWHYyCAW5z0GfATN4QYU47X0bZ9CO82AKcHNueW+UmBCDh781N0xy57EPi
         ojxf6LYPWd7Ldjwv//YyrOmQe24YItesrc/TaqCI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190301052947.32032-4-samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 03/10] clk: sunxi-ng: sun50i: Mark the msgbox clock as critical
Message-ID: <155146148359.16805.78863244252924530@swboyd.mtv.corp.google.com>
References: <20190301052947.32032-1-samuel@sholland.org> <20190301052947.32032-4-samuel@sholland.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
User-Agent: alot/0.8
Date:   Fri, 01 Mar 2019 09:31:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Samuel Holland (2019-02-28 21:29:40)
> The msgbox clock is critical because the hardware is shared between
> Linux and system firmware. The message box may be used by the EL3 secure
> monitor's PSCI implementation. On 64-bit sunxi SoCs, this is provided by
> ARM TF-A; 32-bit SoCs use a different implementation. The secure monitor
> uses the message box to forward requests to power management firmware
> running on a separate CPU.
>=20
> It is not enough for the secure monitor to enable the clock each time
> Linux performs a SMC into EL3, as both the firmware and Linux can run
> concurrently on separate CPUs. So it is never safe for Linux to turn
> this clock off, and it should be marked as critical.
>=20
> At this time, such power management firmware only exists for the A64.
> However, it makes sense to take care of all CCU drivers now for
> consistency, and to ease the transition in the future, once firmware is
> ported to the other SoCs.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
> index 932836d26e2b..7780e855c56f 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -350,7 +350,7 @@ static SUNXI_CCU_GATE(bus_de_clk,   "bus-de",       "=
ahb1",
>  static SUNXI_CCU_GATE(bus_gpu_clk,     "bus-gpu",      "ahb1",
>                       0x064, BIT(20), 0);
>  static SUNXI_CCU_GATE(bus_msgbox_clk,  "bus-msgbox",   "ahb1",
> -                     0x064, BIT(21), 0);
> +                     0x064, BIT(21), CLK_IS_CRITICAL);

Please add a comment explaining why CLK_IS_CRITICAL is used. It helps us
remember years from now without having to dig in the git history.

