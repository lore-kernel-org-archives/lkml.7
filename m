Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30006C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A23218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SRE2VowM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfDXGeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:34:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35322 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfDXGeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:34:02 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so4420907itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mXIT6A4rsLExBKtY/MGFTFxwsiXJFvHCgIPkwFcmlOE=;
        b=SRE2VowMIqsg4FfLdEolqSYfupdzr54ezk6Oz+yUyM4HiUjwy6FCZ62DSyK7FjMoJ7
         nj9R7NWg9e+L3hZdZ8zzh0hfJ8Tckn2Z6ACeA387aOap8EnhTZ5sw4hcnzjc18FY4a4x
         PpQoH9ZSQyZTXJITHhEL9FqsYKfG7Kyf9lw7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mXIT6A4rsLExBKtY/MGFTFxwsiXJFvHCgIPkwFcmlOE=;
        b=qD6PrFZb/qRe6yLYZoBrXsVsXcnauc+5vCva9fZfbUDKImzq+uvUdJ5W03RlAkd30R
         GUdR9FXISqeTzohCXUbd1ZNlxW7ZdVmbuxUmIlD+Yw6dV5ZBAalomcjyPiiESwlM65P5
         8fTAUg+RJekY/qjYaO1hL4RW8HQGCIgi3DZkOp8uV+LYKF23jlUJ5F6Xe0DU2PQHvTrT
         RNuQUSkqy6pmoPek2fzhfBHoDEyvh8RWmiJo/vwG6CAHT8y4zuW8bBkmdmUIux6yc5ml
         0Z4+h+F+MFNIMdeMWaPsgGzRWXr7FGpVCPkSW5m/T7edchGKTGwW9cBRRAKWGYDYwXxg
         MiLQ==
X-Gm-Message-State: APjAAAXvHthcr4wPoDZuRwipzwmhRuRoO5ZCgkYuodPDDLI6hz3Rpjbf
        U5WxHhzvCCth2YQyjYVkB3pkndfRQ8JJUj9tNc086w==
X-Google-Smtp-Source: APXvYqysMBFQhUzEhztRF/tOLjAGcmAfY7q5ly2SpiK6qV6lMViFMKs61kcNPFC6PGra44LNE8h3zIPkyaoWEGaqtXw=
X-Received: by 2002:a02:7f81:: with SMTP id r123mr1862714jac.85.1556087641168;
 Tue, 23 Apr 2019 23:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tygHnQZXS+etRBwYM_sjuQHACtNEOnXyf+KM5CvryVQ7w@mail.gmail.com>
In-Reply-To: <CAPM=9tygHnQZXS+etRBwYM_sjuQHACtNEOnXyf+KM5CvryVQ7w@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 24 Apr 2019 08:33:47 +0200
Message-ID: <CAKMK7uEc2Hx-BPXU9xNndmqLsLodBbz7JSR6W3sXjtxaAp2E6A@mail.gmail.com>
Subject: Re: [git pull] drm fixes (regression special)
To:     Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 3:21 AM Dave Airlie <airlied@gmail.com> wrote:
>
> Hey Linus,
>
> We interrupt your regularly scheduled drm fixes for a regression special.
>
> The first is for a fix in i915 that had unexpected side effects
> fallout in the userspace X.org modesetting driver where X would no
> longer start. I got tired of the nitpicking and issued a large hammer
> on it. The X.org driver is buggy, but blackscreen regressions are
> worse.
>
> The second was an oversight that myself and Gerd should have noticed
> better, Gerd is trying to fix this properly, but the regression is too
> large to leave, even if the original behaviour is bad in some cases,
> it's clearly bad to break a bunch of working use cases.
>
> I'll likely have a regular fixes pull later, but I really wanted to
> highlight these.
>
> Dave.
>
> drm-fixes-2019-04-24:
> drm regression fixes (i915 and virtio-gpu)
> The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4=
bb:
>
>   Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)
>
> are available in the Git repository at:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-24
>
> for you to fetch changes up to a0cecc23cfcbf2626497a8c8770856dd56b67917:
>
>   Revert "drm/virtio: drop prime import/export callbacks" (2019-04-24
> 10:52:52 +1000)
>
> ----------------------------------------------------------------
> drm regression fixes (i915 and virtio-gpu)
>
> ----------------------------------------------------------------
> Dave Airlie (2):
>       Revert "drm/i915/fbdev: Actually configure untiled displays"

This will conflict badly with the refactor in drm-next:

commit 09ded8af57bcef7287b8242087d3e7556380de62
Author: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
Date:   Sun Apr 7 18:52:34 2019 +0200

    drm/i915/fbdev: Move intel_fb_initial_config() to fbdev helper

Probably best if we cherry-pick the revert over to avoid accidentally
reintroducing this regression in the next merge window? Since the code
moved I think a backmerge is to non-obvious about what's going on ...
Adding Noralf.
-Daniel

>       Revert "drm/virtio: drop prime import/export callbacks"
>
>  drivers/gpu/drm/i915/intel_fbdev.c     | 12 +++++-------
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  4 ++++
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++++
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 12 ++++++++++++
>  4 files changed, 25 insertions(+), 7 deletions(-)



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
