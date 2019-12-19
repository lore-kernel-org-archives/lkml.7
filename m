Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F0C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E98924650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DAdi4AJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfLSKKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:10:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44014 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:10:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so242143oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Cr4KDsrSrUXnbU/Gr6Foj6VfqdF5VwH1MBdetl2SOg=;
        b=DAdi4AJAgSRWd7DNciQSFAP3HrKk34OYvC989VkKAT5AYDSuaR2HvJQIl7PfwTtmAa
         aRU/cySx3nfaeflRJijnSNuJRonpNKlwMQvd/U0NQ5MDbIwDVdNDLuDFEUDLuEIxYdk7
         Ur6BC0beoIjLF9tjm7iELb/AGfJD783mQajF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Cr4KDsrSrUXnbU/Gr6Foj6VfqdF5VwH1MBdetl2SOg=;
        b=lPN7E1ov9BCbPQy0orOFATaK/WGkV8EuHjRuHFgdEirK4d/3YL4LETTBtI6zotYo1V
         Bn+sGXMM33q/cCJoARdKYV2yjrJpQYp5kQkj/DV5B5xLKrxJQ8rc0ii3zr0tVrDt8ghn
         wNE2cxQEVEkR6mZ0k2Sw71tcFI48j92HAiccvGWSKsxgnxmZjUbgNGbF8/rLEUAYzc6M
         Qs6xvetgVTV4ulpy54blq1bzCZyR9YpG2/fwJgNgt/1pH0KVRrlKpWrKpEKk4xrPRSCT
         xzRGsNK/YtVUW1AA/E75zqTfqLEfrr+SHFrnNN8pC4J97Wn6kev79CqngFFjrDEYXwDe
         xHSQ==
X-Gm-Message-State: APjAAAVTyqb6prrWrQ4OJ1NAm3rRRNAWQ8TkrXKS59wIWQYsJEGn1agH
        zZkFRaTVrChASGdIxlC1iUfdP8mhuqkoJoiZdIZ20A==
X-Google-Smtp-Source: APXvYqw88arFrE2W1gR829kbJEMlM/aJQNJRHg62vPZaoFm7Qq8s5R4EHDI2vmTd/t7qDH93C3EIOQuCRgYi85tiruM=
X-Received: by 2002:aca:d985:: with SMTP id q127mr1737283oig.132.1576750248829;
 Thu, 19 Dec 2019 02:10:48 -0800 (PST)
MIME-Version: 1.0
References: <07899bd5-e9a5-cff0-395f-b4fb3f0f7f6c@huawei.com>
 <f867543cf5d0fc3fdd0534749326411bcfc5e363.camel@collabora.com>
 <c2e5f5a5-5839-42a9-2140-903e99e166db@huawei.com> <fde72f73-d678-2b77-3950-d465f0afe904@huawei.com>
 <CAKMK7uFr03euoB6rY8z9zmRyznP41vwfdaKApZ_0HfYZT4Hq_w@mail.gmail.com> <fcca5732-c7dc-6e1d-dcbe-bfd914a4295b@huawei.com>
In-Reply-To: <fcca5732-c7dc-6e1d-dcbe-bfd914a4295b@huawei.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 19 Dec 2019 11:10:37 +0100
Message-ID: <CAKMK7uE+nfR2hv1ybfv1ZApZbGnnX7ZHfjFCv5K72ZaAmdtfug@mail.gmail.com>
Subject: Re: Warnings in DRM code when removing/unbinding a driver
To:     John Garry <john.garry@huawei.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>, dbueso@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:03 AM John Garry <john.garry@huawei.com> wrote:
>
> On 19/12/2019 09:54, Daniel Vetter wrote:
> > On Wed, Dec 18, 2019 at 7:08 PM John Garry <john.garry@huawei.com> wrote:
> >>
> >> +
> >>
> >> So the v5.4 kernel does not have this issue.
> >>
> >> I have bisected the initial occurrence to:
> >>
> >> commit 37a48adfba6cf6e87df9ba8b75ab85d514ed86d8
> >> Author: Thomas Zimmermann <tzimmermann@suse.de>
> >> Date:   Fri Sep 6 14:20:53 2019 +0200
> >>
> >>       drm/vram: Add kmap ref-counting to GEM VRAM objects
> >>
> >>       The kmap and kunmap operations of GEM VRAM buffers can now be called
> >>       in interleaving pairs. The first call to drm_gem_vram_kmap() maps the
> >>       buffer's memory to kernel address space and the final call to
> >>       drm_gem_vram_kunmap() unmaps the memory. Intermediate calls to these
> >>       functions increment or decrement a reference counter.
> >>
> >> So this either exposes or creates the issue.
> >
> > Yeah that's just shooting the messenger.
>
> OK, so it exposes it.
>
>   Like I said, for most drivers
> > you can pretty much assume that their unload sequence has been broken
> > since forever. It's not often tested, and especially the hotunbind
> > from a device (as opposed to driver unload) stuff wasn't even possible
> > to get right until just recently.
>
> Do you think it's worth trying to fix this for 5.5 and earlier, or just
> switch to the device-managed interface for 5.6 and forget about 5.5 and
> earlier?

I suspect it's going to be quite some trickery to fix this properly
and everywhere, even for just one driver. Lots of drm drivers
unfortunately use anti-patterns with wrong lifetimes (e.g. you can't
use devm_kmalloc for anything that hangs of a drm_device, like
plane/crtc/connector). Except when it's for a real hotunpluggable
device (usb) we've never bothered backporting these fixes. Too much
broken stuff unfortunately.
-Daniel

>
> Thanks,
> John



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
