Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E71C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 03:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08A22073F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 03:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m959arvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFWDSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 23:18:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34780 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfFWDSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 23:18:22 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so318564iot.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 20:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wt3xjQ5RAsPCKjNF8xOm70W9OHsmPMqo06u/Arlk64Q=;
        b=m959arvkk90yZk7YXjrGbIxse8RaTIzcLbMNGr/tmwdgqes+XUcRnTxTeV4JncLNQc
         YN5pM/vS5Mx/cU8yHEBxNHgfJl7IDi3LManX8AuuD2qAqDOqHwr7dG3yc4ag/kL96LKs
         PAksfOvU1TdpSFiXwu/IVd/UOKig3L2tywLCPhsOfMaAeTwb/WYx/EqdQ6Dt4ofgaGKp
         KmsQhMHUoIQABvO55MiiLXGy4esT+UdNA+v807NyOJKreIhhn7nXv40wb7nEysIiOagQ
         EddjsN/v0nWnyommduqTlSYFceuo6C/o4GUrbCZ4qjQo77tqKi9QHMqds+85BQKabrv+
         rUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wt3xjQ5RAsPCKjNF8xOm70W9OHsmPMqo06u/Arlk64Q=;
        b=DVk7FZVWVx820ddvoFw6pa05m49xNNFXpxXz8Pwmskhb5LiDM6rEDQt2PsvFINQPW6
         TTA1hVa7G8KBHwcy52Cby7hsvsKHzHgtYjgSUPe8UERgPQhJ/d1MLyJnIWpdGq0uyr/B
         9me2IQ4vPQ7czi5mDXlZ4MULwMT4KH+dp+LSvwISKT/J1T9f4agAg4lYoKByyxO/kRdH
         +YqfRkNOb8kPqKHEM4KZ3hndQekUNFcL2xXy3JHO/m3/2hWbvDHL+NTqHSN94RO5pnLH
         WQ7ghSX0+IS87MOUS3r84mTNie/0DdwfIm6htkoYJfhAUovAdarIfhKbJywkblJnJec3
         +RzA==
X-Gm-Message-State: APjAAAXh++RzQSJIh4tSC8W85VjmTBZEaFJ0DkrHchbL/B84JDYDRy7Z
        D4LcVT7NWcjjvQlzFRmiGcTXxX8S5aY+pVjDAkM=
X-Google-Smtp-Source: APXvYqyTHzwArTC4KiRT1IPX4CNm6uqu89+eIkg88AjtBGh1KAm8050QLwI3XoLcAOvV19Se5XCP89cuH9nV859/AYs=
X-Received: by 2002:a5e:8412:: with SMTP id h18mr10275235ioj.268.1561259901755;
 Sat, 22 Jun 2019 20:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <1561112433-5308-1-git-send-email-raymond.smith@arm.com> <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 23 Jun 2019 11:18:10 +0800
Message-ID: <CAKGbVbs2UB-nfwUAJxBhyuVg22a39Tx5BraUBvB5N7+PT=eQLA@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Raymond Smith <Raymond.Smith@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:27 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Jun 21, 2019 at 12:21 PM Raymond Smith <Raymond.Smith@arm.com> wrote:
> >
> > Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> > denote the 16x16 block u-interleaved format used in Arm Utgard and
> > Midgard GPUs.
> >
> > Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> > ---
> >  include/uapi/drm/drm_fourcc.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > index 3feeaa3..8ed7ecf 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -743,6 +743,16 @@ extern "C" {
> >  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> >
> >  /*
> > + * Arm 16x16 Block U-Interleaved modifier
> > + *
> > + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the image
> > + * into 16x16 pixel blocks. Blocks are stored linearly in order, but pixels
> > + * in the block are reordered.
> > + */
> > +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> > +       fourcc_mod_code(ARM, ((1ULL << 55) | 1))
>
Thanks for the patch.

> This seems to be an extremely random pick for a new number. What's the
> thinking here? Aside from "doesnt match any of the afbc combos" ofc.
> If you're already up to having thrown away 55bits, then it's not going
> to last long really :-)
>
> I think a good idea would be to reserve a bunch of the high bits as
> some form of index (afbc would get index 0 for backwards compat). And
> then the lower bits would be for free use for a given index/mode. And
> the first mode is probably an enumeration, where possible modes simple
> get enumerated without further flags or anything.
>
This idea is like my previous patch:
https://patchwork.kernel.org/patch/10852619/

lima driver just need a unique modifier to represent this format, so this patch
is enough for lima needs.

But I'm also a little worry about the expansion of only reserve the top bit
(55) for classification from the ARM point of view. A few more bit (at least 2
for being able to represent 4 class of format) and more clear class/format
fields division would be better.

Thanks,
Qiang




>
> Also ofc needs acks from lima/panfrost people since I assume they'll
> be using this, too.
>
> Thanks, Daniel
>
> > +
> > +/*
> >   * Allwinner tiled modifier
> >   *
> >   * This tiling mode is implemented by the VPU found on all Allwinner platforms,
> > --
> > 2.7.4
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
