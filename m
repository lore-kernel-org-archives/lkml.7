Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36057C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6322077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aP6TnlrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfHPGYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:24:07 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39786 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHPGYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:24:07 -0400
Received: by mail-ot1-f49.google.com with SMTP id b1so8700684otp.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UbemS0Z3+J8HDXKXNZjWi7HzzaHw4A8dNiqBV6V1Rck=;
        b=aP6TnlrWiVWmS2YmWqIbc6ujqbBXxF1RRQmqDdEDynDuT8y8e2+stArtXrzJF+NFCx
         ZpokzqOSnc2/SQ6T8ZJAvrwtp6xgbO/JPQQzVva9vWLalVQ2fjTke74PJiLH4nLAqGj9
         W+pc8NTOqySX8gyUKXzeeb3sQsIRngfvJIhzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbemS0Z3+J8HDXKXNZjWi7HzzaHw4A8dNiqBV6V1Rck=;
        b=A2SK4hoMjPnhSr8Wfew12+tpxEgpRTfKcoeGjCs5ARNA39WPpatceXQF8fErddtMst
         fgqAJYurTcKMFM5cydP229/y7SHU4T/aj4qUxgMR2idvj8Lnh0FtmIB/hHimeT1Fg1Ef
         EikMdfD3eK9DzCjf8egcLjbuTsoSZ7fGfmQJ6bkms1oqBRV1LcKYoH35Jq90In4AGnMJ
         Z1GGr533KF9l4L66ObIjHMoYVnC8Yxp5BqiirENWrLX88oYZFVDkG4lSVIg5oVAUaUvA
         sPtiIn6bsP+gRTonEdTEKyCuHpUCd3N4kMcUIfraTVctDC+6RmIj7h1QXfElOXzTgHLy
         6m0w==
X-Gm-Message-State: APjAAAVpwsfPAWAfSx7JqHpJuJMWE9hD+mJ4NR0s/HDONca+QNbeMrWa
        HTtBcBzDn0/Z824+tV7j2yb0U444SVFsGLtfbKDScd1rIrA=
X-Google-Smtp-Source: APXvYqym4oO06UAaqAKOdwMX9+ZXUpuUmFqkjQr53j2qEVTw6wqvTfv6JC/8+4MTWKM7ZLy4wXnYnyZPWJJHKs0fIjE=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr6769456oth.281.1565936646046;
 Thu, 15 Aug 2019 23:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190816133132.6b37d7fa@canb.auug.org.au> <20190816044846.GA27781@ravnborg.org>
In-Reply-To: <20190816044846.GA27781@ravnborg.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 16 Aug 2019 08:23:54 +0200
Message-ID: <CAKMK7uFy2vtOpSNrJyPDp0mvPTEvTD3zw7_gTuWe6gRqj18FFg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 6:48 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Stephen.
>
> On Fri, Aug 16, 2019 at 01:31:32PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the drm-misc tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> >
> > warning: same module names found:
> >   drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.ko
> >   drivers/gpu/drm/panel/panel-nec-nl8048hl11.ko
> > warning: same module names found:
> >   drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.ko
> >   drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.ko
> > warning: same module names found:
> >   drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.ko
> >   drivers/gpu/drm/panel/panel-sony-acx565akm.ko
> > warning: same module names found:
> >   drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.ko
> >   drivers/gpu/drm/panel/panel-tpo-td028ttec1.ko
> > warning: same module names found:
> >   drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.ko
> >   drivers/gpu/drm/panel/panel-tpo-td043mtea1.ko
> >
> > Introduced by commits
> >
> >   df439abe6501 ("drm/panel: Add driver for the NEC NL8048HL11 panel")
> >   c9cf4c2a3bd3 ("drm/panel: Add driver for the Sharp LS037V7DW01 panel")
> >   1c8fc3f0c5d2 ("drm/panel: Add driver for the Sony ACX565AKM panel")
> >   415b8dd08711 ("drm/panel: Add driver for the Toppoly TD028TTEC1 panel")
> >   dc2e1e5b2799 ("drm/panel: Add driver for the Toppoly TD043MTEA1 panel")
>
> Ups, had not seen this one coming.
> We are in the process of removing the drivers in drivers/video/fbdev/omap2/omapfb/
> and decided to introduce the new drivers early to get them out of a
> longer patch series.

Should we have a config dependency to not allow the old fbdev omap
when the drm omap driver is enabled? I think that would take care of
all this.

Or too annoying for development?

Also note that fbdev is in drm-misc now, so we should be able to fix
this all without cross-tree conflicts.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
