Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075C9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4EA2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="jUcez77v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDCPPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:15:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36644 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:15:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so15252341ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHotHzEjU1qzj9BJulC5Ed51CFuyFnl3nK+gD0M9X6A=;
        b=jUcez77vGOxll91oMTJgrsgL/43L+fXpHbXMt2nXXRcnNdZX6or4swAlYGmDujYbr6
         63p9yhQ+oNHQSDcteYTxEhqEeaHn7Xo9Wl/wnQCz+VhdjxRhjpXRvS0QSG8sj0GfAorX
         y+mqAchoAukp5rHxB23LfZaBqPKEm78T8bLukqKaptfUKSA49MVDNf5y1kX6ssj/nNYT
         kHPD5sHJTKR9qQLL3yE31JwyZAGdivoe20u6YwCyvKTimoh/yiUDm11ikcC3466QRoJc
         aY9c4Z/KHKfCm4Xa/z1jrGo16WIAxZxx3Ippi3iRGOuDtGe9+GF+FNtFnsOdiwRiFrF7
         n9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHotHzEjU1qzj9BJulC5Ed51CFuyFnl3nK+gD0M9X6A=;
        b=tLK2bfmnASL88QbJtNaYhkhYnzV7pIvhqoy98LnFQQviQAZidpXA9qMsAugpKJiJkU
         ddbkV1pztQiDe6gG5zA79fwipCMQq+hBpeEoCCkx8JcRTR+Pj3qSFdA+oeG+xHWGi7yn
         zxKFSLSCY+crG8fb3wcJb4LDc8OT5W1KczfL/nyD46fq/EhtPGoYBkRYKpcYSnkUpp8H
         2+lZp44fEOSn+eJfKEz5M8xl4M5XZLal5Qhi07N05GKFitANeBdJbBNP4xCa3r2/giBD
         LIxRmuvMeSS09s/RmT2oa3pO84Ao6oB4S2MVEQF4h0amzTHXKssDTWew9H037X6C+wQc
         xapQ==
X-Gm-Message-State: APjAAAVpdghQDtEtN2ZgHY77Zqotmbk/LpZeMLK2AAWF+IMtGjYFXgH+
        m2WLZlJ7O8oG3KSeaSQMJdN3m1pLGrsYqaFaQQGdJA==
X-Google-Smtp-Source: APXvYqz8gnBbW3N2iTbXKKbUef4OXpN9FLTfdsRvsJgLww+eEHbkwa4onFJvPVzOpUGkS7lL88WDSQudZtH65dzwQOE=
X-Received: by 2002:a2e:9703:: with SMTP id r3mr191509lji.88.1554304519634;
 Wed, 03 Apr 2019 08:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190403072318.31507-1-kraxel@redhat.com> <85ba308177f4e9ddee336d5110cb6df7a447cebf.camel@redhat.com>
In-Reply-To: <85ba308177f4e9ddee336d5110cb6df7a447cebf.camel@redhat.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 3 Apr 2019 16:15:08 +0100
Message-ID: <CAPj87rOE2K9nxV2p+KrMTDnijdKpmNP8BGSUJyK9YtFueJpkqw@mail.gmail.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
To:     Adam Jackson <ajax@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 at 16:12, Adam Jackson <ajax@redhat.com> wrote:
> On Wed, 2019-04-03 at 09:23 +0200, Gerd Hoffmann wrote:
> >  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
> >    that too by default.  There was a module parameter which enables 24/32
> >    bpp support and disables higher resolutions (due to cirrus hardware
> >    constrains).  That parameter wasn't reimplemented.
>
> One slightly annoying aspect of this (well, initially of the patch to
> clamp the default to 16bpp, but this too) is that we only have a way to
> ask the driver which format it prefers, not which ones it supports at
> all. For X's modesetting driver (and yes some of this is because X is
> awful) this creates the following failure mode:
>
> 1: user sets up xorg.conf for depth 24
> 2: user upgrades kernel, reboots
> 3: X driver detects that depth 16 is preferred, but
> 4: X core respects user's xorg.conf and tries depth 24, which
> 5: throws -EINVAL and X won't start.
>
> Possibly X should work around this by transparently setting up a shadow
> framebuffer at the user's requested depth. The problem there is, if 565
> is preferred but 8888 works, you're adding a format-conversion blit in
> the middle for no reason. If I could ask the kernel for the entire list
> of supported formats, I could only set up the shadow if it was
> necessary.

There's already a list of supported formats for each DRM plane, which
you can get via drmModeGetPlane (being careful to enable universal
planes so you can discover the primary plane). The same information is
present in the 'IN_FORMATS' property, which is more difficult to parse
but also tells you about modifiers.

modesetting already pulls all this out (at least in the atomic path)
so we can reason about acceptable modifiers.

Cheers,
Daniel
