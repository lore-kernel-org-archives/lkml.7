Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CAFC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFE720859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fKnMVMpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfDVPYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:24:03 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35552 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfDVPYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:24:03 -0400
Received: by mail-vk1-f194.google.com with SMTP id 204so1141733vkv.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3Pnf0PVHhgl+BQ3JKTz8MLka9s6N/KnXRLtBDBZScw=;
        b=fKnMVMpV4Qk4IxDOjs/F0ojtTH4udnkZYVXM75JgNrpsQg6kT3ifiZ6nmak4qpxzg2
         kD7C/w3WyQ6L7+7MQTjTtYCU5fAoCQBuibSnbi3RRYUl+sNVQxY+CexOOWFR+GiZtbwI
         XCo8a5538HHWiJYT8e7jxNQBLVsLVPlgAg/Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3Pnf0PVHhgl+BQ3JKTz8MLka9s6N/KnXRLtBDBZScw=;
        b=k0gVztyfglHuHg+Q9x8b+v8zKG5gVfqJhoarqXxhyxtdg9u43ExxNVUZ2uw5YBrXyq
         51ALNgT0p1Iie8VJvzEys7wDg9AbMTJjYxuZ3m6hBT1a942l2AxyLBl+Ri8YJgFee2M/
         PcpQCpyTnq9hMwH0NweX28EnzPL0zgfTCx9Xrcz7d1RMiz96bhLrmClRNDczKRZRaqMn
         v3MjA4ptFX+SpEE/ulDTwr+Y1YR/Ap2Hn/Tvwi3jsdO95hzQ95mu8jBQSUXR5BhIM08a
         9t/UJl9mSwIz85nWC+XCBk55/cp6lZ32Q7kdcHleVqDQHGrNDMtM1Hq82/N0ozPBwPwn
         BrWw==
X-Gm-Message-State: APjAAAWYd2D/+UVQDFkCL12JiiYbUAIoWKGd640akqnT3xEbnRQohrCM
        cAwFykkU8skLGmVf5Mpl2VpXru0eFwM=
X-Google-Smtp-Source: APXvYqxiWS/9jC3boErQPj3ND4RNVdde5hF4h7eBc7jvCCQZGRfanBqc7yvveySfDb1mm6OBY869Ug==
X-Received: by 2002:a1f:c747:: with SMTP id x68mr971331vkf.26.1555946641693;
        Mon, 22 Apr 2019 08:24:01 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id r199sm4004375vke.30.2019.04.22.08.24.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 08:24:00 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id h4so3694331uaj.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 08:24:00 -0700 (PDT)
X-Received: by 2002:a9f:3c01:: with SMTP id u1mr10131975uah.19.1555946640050;
 Mon, 22 Apr 2019 08:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190412161747.107107-1-dianders@chromium.org>
In-Reply-To: <20190412161747.107107-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Apr 2019 08:23:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xkdc_yPCjVUh96atdiB4fo4h3oNZYe45ef+eLeVUVM8g@mail.gmail.com>
Message-ID: <CAD=FV=Xkdc_yPCjVUh96atdiB4fo4h3oNZYe45ef+eLeVUVM8g@mail.gmail.com>
Subject: Re: [PATCH v2] clk: rockchip: undo several noc and special clocks as
 critical on rk3288
To:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elaine,

On Fri, Apr 12, 2019 at 9:18 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> This is mostly a revert of commit 55bb6a633c33 ("clk: rockchip: mark
> noc and some special clk as critical on rk3288") except that we're
> keeping "pmu_hclk_otg0" as critical still.
>
> NOTE: turning these clocks off doesn't seem to do a whole lot in terms
> of power savings (checking the power on the logic rail).  It appears
> to save maybe 1-2mW.  ...but still it seems like we should turn the
> clocks off if they aren't needed.
>
> About "pmu_hclk_otg0" (the one clock from the original commit we're
> still keeping critical) from an email thread:
>
> > pmu ahb clock
> >
> > Function: Clock to pmu module when hibernation and/or ADP is
> > enabled. Must be greater than or equal to 30 MHz.
> >
> > If the SOC design does not support hibernation/ADP function, only have
> > hclk_otg, this clk can be switched according to the usage of otg.
> > If the SOC design support hibernation/ADP, has two clocks, hclk_otg and
> > pmu_hclk_otg0.
> > Hclk_otg belongs to the closed part of otg logic, which can be switched
> > according to the use of otg.
> >
> > pmu_hclk_otg0 belongs to the always on part.
> >
> > As for whether pmu_hclk_otg0 can be turned off when otg is not in use,
> > we have not tested. IC suggest make pmu_hclk_otg0 always on.
>
> For the rest of the clocks:
>
> atclk: No documentation about this clock other than that it goes to
> the CPU.  CPU functions fine without it on.  Maybe needed for JTAG?
>
> jtag: Presumably this clock is only needed if you're debugging with
> JTAG.  It doesn't seem like it makes sense to waste power for every
> rk3288 user.  In any case to do JTAG you'd need private patches to
> adjust the pinctrl the mux the JTAG out anyway.
>
> pclk_dbg, pclk_core_niu: On veyron Chromebooks we turn these two
> clocks on only during kernel panics in order to access some coresight
> registers.  Since nothing in the upstream kernel does this we should
> be able to leave them off safely.  Maybe also needed for JTAG?
>
> hsicphy12m_xin12m: There is no indication of why this clock would need
> to be turned on for boards that don't use HSIC.
>
> pclk_ddrupctl[0-1], pclk_publ0[0-1]: On veyron Chromebooks we turn
> these 4 clocks on only when doing DDR transitions and they are off
> otherwise.  I see no reason why they'd need to be on in the upstream
> kernel which doesn't support DDRFreq.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Now keep pmu_hclk_otg0 as critical.
> - Updated description since this isn't a clean revert.
> - PWM patches have landed, so just one patch in the series now.
>
>  drivers/clk/rockchip/clk-rk3288.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

From previous discussions I think you're all happy with this patch
now, right?  Care to give it an official Reviewed-by tag?

-Doug
