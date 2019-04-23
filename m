Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A5921738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HHPdQ//n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfDWMYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:24:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42783 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:24:23 -0400
Received: by mail-io1-f67.google.com with SMTP id m188so11261033ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUkjPGo5lyAmNt+siaQDsEjZq+3yggXp3oRyxhsGtb4=;
        b=HHPdQ//nBkhr3jwJJ8q0Rg9bnn8GkeGgP7Il6S/ycuDQOKeu5LOjHloc9/gR9KAN+W
         pXJoI3wo1e97jjSAL2+jvDDsRonglUs2MtbyLpihmBiqaEo8FLC82Pupt2Y5iTLYcoOA
         Tm4pxKLvUDiiK8SRxOfhy6J+dJhuPk9zqtpbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUkjPGo5lyAmNt+siaQDsEjZq+3yggXp3oRyxhsGtb4=;
        b=TwqUT5nGmSNynauW1cap1ShwnxqqDvNc99EBNITrePNcXoquZH/rei9W6Qqkx9zayt
         UnRjfrbGm6r/YW3WJa63x6tUttPXBgaOCpcydoOo1do2e/IHHbOt6/bdNXBU6HeHL0YG
         vu9xyTBxDMQVqkPtX7tgyd79GyhXVqry34tJTvGY539d8jm7Hux335CgidU0ubO0R1EV
         cZPZ7ZAbbOALGtx4X27R5DY8OQP8otvgmdqYGaqM9MbQv94h92uudTK7t1VhB+C/dDD+
         TYoLPbED3kAQQT6w4uy6GHpffP1CFnCEG65pO5u6frdULZ3ywwHd6I6d3EQSHmEBrdxO
         g4aA==
X-Gm-Message-State: APjAAAWkdqgfq6i/c12QlP3rdJDoYhbs+uTrq9PL860ucLxFObTdMBdn
        78s0oLc5BFeiP5rlLqYTpfkK0fiBtcrHacp5uJLXhwBD
X-Google-Smtp-Source: APXvYqz+vL4tff/BwneRj0Gg2dixqGdvcHYGb12OagE2OJmTOuor5F6tfUcq0w+y3MUzI5rY0NxKOZsS4yWmGccqrfI=
X-Received: by 2002:a5d:818f:: with SMTP id u15mr6477293ion.291.1556022262713;
 Tue, 23 Apr 2019 05:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <1556016490-6906-1-git-send-email-ben.davis@arm.com>
In-Reply-To: <1556016490-6906-1-git-send-email-ben.davis@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 23 Apr 2019 14:24:11 +0200
Message-ID: <CAKMK7uE=m4dYodGp34Twcs-HEV4rExvvguM5m1Qt9HzUD8ZYEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add writeback scaling
To:     Ben Davis <Ben.Davis@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:48 PM Ben Davis <Ben.Davis@arm.com> wrote:
>
> Add support for scaling on writeback. To do this add writeback_dest_w
> and writeback_dest_h as writeback connector properties to specify the
> desired output dimensions.
> Then implement downscaling on writeback for Malidp-550 and Malidp-650
> (upscaling on writeback is not supported on these devices).
>
> v2: Use 0 as default for writeback_w,h and so update range to use 1 as
>     minimum.

Hm I missed that, I don't think that's good, since it prevents
userspace from blindly writing back the properties it's read. We've
tried hard to avoid that, since we're suggesting compositor can take a
snapshot of all kms properties (including the ones they don't
understand) and restore that on vt switching. Hence stuff like fence
fds returning -1, and accepting -1 as NULL to make this work.

tldr; I think range needs to include 0, and we need make that a
special thing, maybe enforced with a
drm_connector_state_compute_writeback_dst_h/w, which takes
crtc_state->mode.v/hdisplay into account if the writeback_dst_h/w is
0.
-Daniel

>
> v3: Rename properties to specify they are destination width/height.
>     Make sure the values from the properties are passed to
>     enable_memwrite rather than the framebuffer dimensions
>
> Ben Davis (2):
>   drm: Add writeback_dest_w,h properties
>   drm/malidp: Enable writeback scaling
>
>  drivers/gpu/drm/arm/malidp_crtc.c | 49 +++++++++++---------
>  drivers/gpu/drm/arm/malidp_crtc.h | 12 +++++
>  drivers/gpu/drm/arm/malidp_drv.c  | 10 +++--
>  drivers/gpu/drm/arm/malidp_hw.c   | 45 +++++++++++++------
>  drivers/gpu/drm/arm/malidp_hw.h   | 19 ++++++--
>  drivers/gpu/drm/arm/malidp_mw.c   | 94 ++++++++++++++++++++++++++++++---------
>  drivers/gpu/drm/arm/malidp_regs.h |  1 +
>  drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++
>  drivers/gpu/drm/drm_writeback.c   | 30 +++++++++++++
>  include/drm/drm_connector.h       |  4 ++
>  include/drm/drm_mode_config.h     | 10 +++++
>  11 files changed, 220 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/gpu/drm/arm/malidp_crtc.h
>
> --
> 2.7.4
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
