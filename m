Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A14C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E90620873
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EmOe+8mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfJCStN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:49:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45901 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCStN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:49:13 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so7906342iot.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bYXjGFVT5M4BPwSyoV9TrBf9Kkv65nfJ31r2xLDzZU=;
        b=EmOe+8mi8SJNDbJCkY/leXIR58hNDc6XJa30oWJMy598KhE/OlmxkDz1hWH2Y1zBSU
         FiEzgzPY69cw6bb7b8ItJYERLWC/ZHGAoieXc82zRqAIXoMlGCLZdazUqZLhMtsrfqHF
         eLszIT8IdmfVVs6uEVjwai/tpfb0EBagW5YH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bYXjGFVT5M4BPwSyoV9TrBf9Kkv65nfJ31r2xLDzZU=;
        b=OQSBdgXMvoIWBvowXi3TZI2CNobIDssUj1Nu8ACN72oUDioJwClHRYzBf2RkQ64n3L
         dYrfwZGiAaTqafDgfHn46Gs3v8WFe0UAvGIG50Oc+z+QzfsPWzS8e0heA0sIVQDhOoyw
         AcNsOddPR/Bpy49rrGZnENrGjcWII7dTCoBBMfMXsWWf0jTbPB/hGLkfo0l9bETIPuGi
         +YRd5WsGFcjgn02EbuWgdyhJ+UtVunt87SdNJmc/T46cG+MS1iW9dnwmnU+Ye9fCX+48
         dLsyhQP0qu2y53s4pE00bZ49ySqwukemm9agradhgvsvx/Dk93TY1RMFHB53SiZFy7CF
         imNA==
X-Gm-Message-State: APjAAAU7iKWio9RHyvVQJ1iUMHYjejX6lFIm5O1YfYjA2MMbB6+c8O0Y
        rpO6Cei8deP3wDRe60k1FkAcOGI2QDk=
X-Google-Smtp-Source: APXvYqw3LRKzNYIEhPcN0HNhZOTe0h4gRk3EjC6X2dMn9CWIY2Ej06JDNw3AGQ/deR5jWsISZWBM2w==
X-Received: by 2002:a02:a999:: with SMTP id q25mr11236693jam.27.1570128550274;
        Thu, 03 Oct 2019 11:49:10 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id c17sm1739638ild.31.2019.10.03.11.49.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 11:49:10 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id n26so7937021ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:49:09 -0700 (PDT)
X-Received: by 2002:a5e:d817:: with SMTP id l23mr9427708iok.142.1570128549025;
 Thu, 03 Oct 2019 11:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191003102003.1.Ib233b3e706cf6317858384264d5b0ed35657456e@changeid>
 <CAMavQKKTdsJmVy1wz8K66qyZ_iONqStM8JXJwX=9XspVAKT28A@mail.gmail.com>
In-Reply-To: <CAMavQKKTdsJmVy1wz8K66qyZ_iONqStM8JXJwX=9XspVAKT28A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Oct 2019 11:48:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UnC_b1DfN0Aq1bcw_1Oz95Kc-2hkkEULY84+bMfd4sNw@mail.gmail.com>
Message-ID: <CAD=FV=UnC_b1DfN0Aq1bcw_1Oz95Kc-2hkkEULY84+bMfd4sNw@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: Round up _before_ giving to the clock framework
To:     Sean Paul <sean@poorly.run>
Cc:     Heiko Stuebner <heiko@sntech.de>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 3, 2019 at 11:37 AM Sean Paul <sean@poorly.run> wrote:
>
> On Thu, Oct 3, 2019 at 1:20 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > I'm embarassed to say that even though I've touched
> > vop_crtc_mode_fixup() twice and I swear I tested it, there's still a
> > stupid glaring bug in it.  Specifically, on veyron_minnie (with all
> > the latest display timings) we want to be setting our pixel clock to
> > 66,666,666.67 Hz and we tell userspace that's what we set, but we're
> > actually choosing 66,000,000 Hz.  This is confirmed by looking at the
> > clock tree.
> >
> > The problem is that in drm_display_mode_from_videomode() we convert
> > from Hz to kHz with:
> >
> >   dmode->clock = vm->pixelclock / 1000;
> >
> > ...so when the device tree specifies a clock of 66666667 for the panel
> > then DRM translates that to 66666000.  The clock framework will always
> > pick a clock that is _lower_ than the one requested, so it will refuse
> > to pick 66666667 and we'll end up at 66000000.
> >
> > While we could try to fix drm_display_mode_from_videomode() to round
> > to the nearest kHz and it would fix our problem,
>
> I got a bit confused reading this and Doug straightened me out in a
> sideband conversation.
>
> To summarize, the drm_display_mode_from_videomode() call referenced
> above is from panel-simple, and this downslotting is specific to
> rockchip's clock driver. So I've asked to clarify these 2 points so
> it's clear from the commit message that this patch is the best
> solution. With that addressed,
>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

Thanks for the review!  Hopefully people don't mind the quick spin...

https://lore.kernel.org/r/20191003114726.v2.1.Ib233b3e706cf6317858384264d5b0ed35657456e@changeid

-Doug
