Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24987C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E350B2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="KDhNi2kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfC3OY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:24:59 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37136 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfC3OY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 10:24:59 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so1955158vsc.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmsSr1O7Pz7uLZvpuTLV8ue0HrawrjN9Dr8j7s8mKHM=;
        b=KDhNi2kt2ScxdmDLQRUaWxV+nOqwYYldBhTu2s2d8mjrMZ1IOw/3XE9GhGI8iUSYO5
         gGAgM0nYPbBNm8zkeu0xGvNgVDDj6SrdWBaqHPOzg1+q/UVzGYOPCFixdRMg5hyTJVEI
         R/dYjOpBpCz+2r22mUFo2gsgmA/4ZRkcOmXUAeaGa8+bydnkZqbDOp7J/9NiIbw7hflC
         HSb1KwAeuhvy9qV7ZEX1jvvuAM38wp8aPxZ5G8CbSYQNn8SKGDv4qglThGfRiNQTG5hz
         jq24P1qjgrPRjme4tui8K02mYnWV0vTUGWUMgexqK9fROsR+NLg9okmuTY52njOv2O+6
         qArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmsSr1O7Pz7uLZvpuTLV8ue0HrawrjN9Dr8j7s8mKHM=;
        b=lt9x8CrYhRDOKoDTy2Vd/Djb7IRoc28zmkyVT88attbavmNYkVoeBz7aM2fQuTn5CT
         LdY9KSYBCLtvtokyUgOo+/rGTTNkvhz2K3pP+xlriA7Vem+ROk3cfIZmoZF5Mz9mB6oN
         C4FTDk9ywXt0bju9VU6+oWOsINjNMb1b88QFvY3uygncF05elcq+V9fydqF/AhpyAKuu
         pukxm8scOxdovtWQ6uBhV0gn2/m/IVXetx8/r7nxQGFkY0LvZUfppH90bDWj/uaLplL6
         bYOguZePSX3C8IjyIWa/LdSwJ7fFEb/AGgRiharZZQQ5TP9fNrSgg4KnA5OqXmKBBI0b
         XW/g==
X-Gm-Message-State: APjAAAWqiGGAT0NxeGuEgmICtCPljqGyn0NdbV6H0B0QFpwqNnH2i7xi
        ncCT27u9d0gC1rvRQBhAwqIHlPfHILoiFZ5ZCfkDZg==
X-Google-Smtp-Source: APXvYqxG673oDHyAChn0117+2ZCl2JGuIP+yd82xjE4wl/L1KpRlAk8BR9teff40Yf1z7aILzxgO7PRvQf8XDn5Vaa8=
X-Received: by 2002:a67:edcb:: with SMTP id e11mr10790210vsp.105.1553955897999;
 Sat, 30 Mar 2019 07:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190329215455.159717-1-dianders@chromium.org> <CAAEAJfCvZ_y-No6vQbf_3kUSyuPYujTjW8XhZHiB=-GU2_NWHQ@mail.gmail.com>
In-Reply-To: <CAAEAJfCvZ_y-No6vQbf_3kUSyuPYujTjW8XhZHiB=-GU2_NWHQ@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 30 Mar 2019 11:24:46 -0300
Message-ID: <CAAEAJfCmY+bv5A7+-wgQN+X60r61PzOjWsYCkJ-imW-uvHVKmw@mail.gmail.com>
Subject: Re: [PATCH] clk: rockchip: Fix video codec clocks on rk3288
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Tomasz Figa <tfiga@chromium.org>,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        ryandcase@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 at 20:28, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> On Fri, 29 Mar 2019 at 18:55, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > It appears that there is a typo in the rk3288 TRM.  For
> > GRF_SOC_CON0[7] it says that 0 means "vepu" and 1 means "vdpu".  It's
> > the other way around.
> >
> > How do I know?  Here's my evidence:
> >
> > 1. Prior to commit 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec
> >    using the new muxgrf type on rk3288") we always pretended that we
> >    were using "aclk_vdpu" and the comment in the code said that this
> >    matched the default setting in the system.  In fact the default
> >    setting is 0 according to the TRM and according to reading memory
> >    at bootup.  In addition rk3288-based Chromebooks ran like this and
> >    the video codecs worked.
> > 2. With the existing clock code if you boot up and try to enable the
> >    new VIDEO_ROCKCHIP_VPU as a module (and without "clk_ignore_unused"
> >    on the command line), you get errors like "failed to get ack on
> >    domain 'pd_video', val=0x80208".  After flipping vepu/vdpu things
> >    init OK.
> > 3. If I export and add both the vepu and vdpu to the list of clocks
> >    for RK3288_PD_VIDEO I can get past the power domain errors, but now
> >    I freeze when the vpu_mmu gets initted.
> > 4. If I just mark the "vdpu" as IGNORE_UNUSED then everything boots up
> >    and probes OK showing that somehow the "vdpu" was important to keep
> >    enabled.  This is because we were actually using it as a parent.
> > 5. After this change I can hack "aclk_vcodec_pre" to parent from
> >    "aclk_vepu" using assigned-clocks and the video codec still probes
> >    OK.
> >
> > Fixes: 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec using the new muxgrf type on rk3288")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I currently have no way to test the JPEG mem2mem driver, so hopefully
> > others can test this and make sure it's happy for them.  I'm just
> > happy not to get strange errors at boot anymore.
> >
>
> I won't have access to this hardware for a few days, but I am happy
> to provide a simple test tool.
>
> Still haven't reviewed this, but thanks for chasing it down!
>

Here's a simple tool that tests JPEG encoding. There are two branches,
with request API and without request API:

https://gitlab.collabora.com/ezequiel/v4l-jpeg

Usage is fairly simple, there's a test.sh that runs three tests,
writing three JPEG images.

You can also use v4l2jpegenc gstreamer element,
but it's slightly more involved to set up.

Hope it helps,
Eze
