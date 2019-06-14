Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B06C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327CC2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFNKjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:39:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39200 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfFNKjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:39:41 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbjcK-0004XL-Mp; Fri, 14 Jun 2019 12:39:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Sean Paul <seanpaul@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric =?ISO-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v5 0/7] drm/panel: simple: Add mode support to devicetree
Date:   Fri, 14 Jun 2019 12:39:31 +0200
Message-ID: <1584725.WvTV0KElQL@phil>
In-Reply-To: <20190401171724.215780-1-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 1. April 2019, 19:17:17 CEST schrieb Douglas Anderson:
> I'm reviving Sean Paul's old patchset to get mode support in device
> tree.  The cover letter for his v3 is at:
> https://lists.freedesktop.org/archives/dri-devel/2018-February/165162.html
> 
> No code is different between v4 and v5, just commit messages and text
> in the bindings.
> 
> I've pulled together the patches that didn't land in v3, addressed
> outstanding feedback, and reposted.  Atop them I've added patches for
> rk3288-veyron-chromebook (used for jaq, jerry, mighty, speedy) and
> rk3288-veryon-minnie.
> 
> Please let me know how they look.
> 
> In general I have added people to the whole series who I think would
> like the whole series and then let get_maintainer pick extra people it
> thinks are relevant to each individual patch.  If I see you respond to
> any of the patches in the series, though, I'll add you to the whole
> series Cc list next time.

sadly it looks like the panel-simple parts haven't made it into
drm-misc yet and the conversation on patch 1/7 seems to have stalled
after Doug's replies.

Thierry, do you have an opinion on these?


Thanks
Heiko

> Changes in v5:
> - Removed bit about OS may ignore (Rob/Ezequiel)
> - Added Heiko's Tested-by
> - It's not just jerry, it's most rk3288 Chromebooks (Heiko)
> 
> Changes in v4:
> - Simplify desc. for when override should be used (Thierry/Laurent)
> - Removed Rob H review since it's been a year and wording changed
> - Don't add mode from timing if override was specified (Thierry)
> - Add warning if timing and fixed mode was specified (Thierry)
> - Don't add fixed mode if timing was specified (Thierry)
> - Refactor/rename a bit to avoid extra indentation from "if" tests
> - i should be unsigned (Thierry)
> - Add annoying WARN_ONs for some cases (Thierry)
> - Simplify 'No display_timing found' handling (Thierry)
> - Rename to panel_simple_parse_override_mode() (Thierry)
> - Rebase to top of Heiko's tree
> - Converted changelog to after-the-cut for non-DRM change.
> - display_timing for Innolux n116bge new for v4.
> - display_timing for AUO b101ean01 new for v4.
> - rk3288-veyron-jerry patch new for v4.
> - rk3288-veyron-minnie patch new for v4.
> 
> Changes in v3:
> - Go back to using the timing subnode directly, but rename to
>   panel-timing (Rob)
> - No longer parse display-timings subnode, use panel-timing (Rob)
> - Unwrap the timing from display-timings and rename panel-timing (Rob)
> 
> Changes in v2:
> - Split out the binding into a new patch (Rob)
> - display-timings is a new section (Rob)
> - Use the full display-timings subnode instead of picking the timing
>   out (Rob/Thierry)
> - Parse the full display-timings node (using the native-mode) (Rob)
> - Wrap the timing in display-timings node to match binding (Rob/Thierry)
> 
> Douglas Anderson (4):
>   drm/panel: simple: Use display_timing for Innolux n116bge
>   drm/panel: simple: Use display_timing for AUO b101ean01
>   ARM: dts: rockchip: Specify rk3288-veyron-chromebook's display timings
>   ARM: dts: rockchip: Specify rk3288-veyron-minnie's display timings
> 
> Sean Paul (3):
>   dt-bindings: Add panel-timing subnode to simple-panel
>   drm/panel: simple: Add ability to override typical timing
>   arm64: dts: rockchip: Specify override mode for kevin panel
> 
>  .../bindings/display/panel/simple-panel.txt   |  22 +++
>  .../boot/dts/rk3288-veyron-chromebook.dtsi    |  14 ++
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts    |  14 ++
>  .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  14 ++
>  drivers/gpu/drm/panel/panel-simple.c          | 171 ++++++++++++++----
>  5 files changed, 203 insertions(+), 32 deletions(-)
> 
> 




