Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD59C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715992339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cx1HrGAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfHTUi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:38:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfHTUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:38:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so13766942wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg0EeSG7Bm5jsa3UW2wgdDRJHxKBoYiG0TWysIzVlWY=;
        b=Cx1HrGAEMaeCtHiXxs+M1bsNI1pgf6amva+4Q0ItXlGMK7l9ZvDqZjPKl/NOnE3wYs
         GXgifJMddlQo+kEcK1fnvftC2NtSUTCUpLySDFjCfJdkQPGG6L+xq9L+jol+KmNwr/eB
         M39pPCpVUqB0gf2oIjHBic7F8lnYQrU+x7fWsViG1T2Xa4YAccFEmywBSbABn8bdslUK
         xRNTtjB0e4uPwB6lDYUPv0qXy7GgI2B+TwasFyY0Qo2aKioRIsIwqpkd7h/VkJ5YWV3c
         lEuMNP1NhkE7oU9adDPccG3eqV+5lh7CVZDgYZQsj7RknnI7RP1ounNNvcGpkYmikA/J
         eo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg0EeSG7Bm5jsa3UW2wgdDRJHxKBoYiG0TWysIzVlWY=;
        b=S10w3EzJOs/BbUF2tMxq5FDMRmx9DkksLckipyJ7ZCSMadU09Seoft7IXaNDpO96yE
         SGsQia2LY9+eFynnEOQ7CnApJ/fAerI5eOsbezk8UKXFj7ZX6B35f8yF0Z2VQwQ3mXD3
         b0lqJHyPHtCZ0ZqTK1PwdPqEaJLvzSI76GAUboXlPMfYqb192k3PTHbG/e8gQ0L9TFZe
         r/uHaRN3NA6tAXIhFuHh6ZojguShXlgPKUByHVy7/MCA+sUqh5nadRTG2ssnt0oRSsHQ
         yRLHlf+hE8EWq55NH3wHRmTNDEN1y3J8oITuceZDzHfTzGIsQgTjb1EeVLDjEgs66cij
         fEvQ==
X-Gm-Message-State: APjAAAV97kPw5hbZV8QLe+YT6hMKoxsoVveeMKFtykGk4+ZnEO027ns5
        FK7XjPg2bbTedh/28yyWqv0qj2gJdnsvYvpv0pzpeL6b
X-Google-Smtp-Source: APXvYqxgByFNUhdAX0A7d+Y0VGJlNmcykd/dXgmHsUVsHnRsUBq9o5uEgwus/ju2JbEFk5S8UKGnWaKoF3Bd4UsTGqw=
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr11200522wro.284.1566333504347;
 Tue, 20 Aug 2019 13:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190819230321.56480-1-john.stultz@linaro.org> <20190820200141.GA23191@ravnborg.org>
In-Reply-To: <20190820200141.GA23191@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 20 Aug 2019 13:38:11 -0700
Message-ID: <CALAqxLXVsqZRrxEMTrYQFpPbGNthJrQ+Gx1EP-uuGFNX0=a_+g@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] drm: Kirin driver cleanups to prep for Kirin960 support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 1:01 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi John.
>
> On Mon, Aug 19, 2019 at 11:02:56PM +0000, John Stultz wrote:
> > Sending this out again, to get it based on drm-misc-next.
> >
> > This patchset contains one fix (in the front, so its easier to
> > eventually backport), and a series of changes from YiPing to
> > refactor the kirin drm driver so that it can be used on both
> > kirin620 based devices (like the original HiKey board) as well
> > as kirin960 based devices (like the HiKey960 board).
> >
> > The full kirin960 drm support is still being refactored, but as
> > this base kirin rework was getting to be substantial, I wanted
> > to send out the first chunk, so that the review burden wasn't
> > overwhelming.
> >
> > The full HiKey960 patch stack can be found here:
> >   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey960-mainline-WIP
> >
> > thanks
> > -john
> >
> >
> > New in v4:
> > * Rebased to drm-misc-next, minor tweaks to merge changes
> > * Dropped "drm: kirin: Get rid of drmP.h includes" as similar change
> >   was already in drm-misc next
> > * Added acked-by tag from Xinliang
>
> There was some checkpatch noises in some of the patches - please verify
> with "--strict".

Ah. Apologies. I had not run with --strict.

> And then the build failed like this:
>  LD [M]  drivers/gpu/drm/hisilicon/kirin/kirin-drm.o
> aarch64-linux-gnu-ld: drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.o: in function `init_module':
> dw_drm_dsi.c:(.init.text+0x0): multiple definition of `init_module'; drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.o:kirin_drm_drv.c:(.init.text+0x0): first defined here
> aarch64-linux-gnu-ld: drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.o: in function `cleanup_module':
> dw_drm_dsi.c:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.o:kirin_drm_drv.c:(.exit.text+0x0): first defined here
> make[3]: *** [/home/sam/drm/linux.git/scripts/Makefile.build:464: drivers/gpu/drm/hisilicon/kirin/kirin-drm.o] Error 1
> make[2]: *** [/home/sam/drm/linux.git/scripts/Makefile.build:490: drivers/gpu/drm/hisilicon/kirin] Error 2
> make[1]: *** [/home/sam/drm/linux.git/Makefile:1776: drivers/gpu/drm/hisilicon/] Error 2
> make[1]: Leaving directory '/home/sam/drm/linux.git/.build/arm64-allmodconfig'
> make: *** [Makefile:179: sub-make] Error 2
>
> It was a simple allmodconfig build where I did:
>
> make drivers/gpu/drm/hisilicon/

Yes, I've not used modules much with the board. I'll fix this up.

> Please fix and resend. I did not look further.

Apologies again, thanks so much for finding these issues! I'll get a
new series to you shortly once the issues are resolved and I've
validated things.

thanks
-john
