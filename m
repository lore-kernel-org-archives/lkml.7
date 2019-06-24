Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C73C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A26208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DhQ+/n+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfFXKA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:00:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45016 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfFXJ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:59:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so12844812otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TO7x8EhBXzU66EtrEYeDRPj8xFUpXiYIWfJ+43RcQF0=;
        b=DhQ+/n+COi9rVZbL8VQewZMK8QruEkDzMK/ULkBBTCHnjeZViT8GIWP6PEJdB6YXdv
         AGncqxZnOLmr0xOSAV60bJZIzavB5XxbR8KNuh4llY3xavVM+g6GzjBxnP4xy7QWYymB
         QCbV8qfW6SwB2aHSKNp0SlbXtVk/cdeVjtf2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TO7x8EhBXzU66EtrEYeDRPj8xFUpXiYIWfJ+43RcQF0=;
        b=ZuLzx6d3a69qzxzC08N6c2wbFTVORn/W7VviXOf8qo1z/KTKH71sRCR36Ux/mim779
         M5AMbt4fchawbyeoZC67iXbroWJJSBAzXXafiBpiagMHbPWQ6rB1qoJjt5/q3WSdOkYf
         wPdxzQps095AuZMryRMnB4qMunH6ilKMck7WqCgWYsuz1kK49k/yyOjESbcVVCjphvjv
         P5K4/7j9N/kJhI+nJqLA4cOKmc+ZpjBe5G0EYwEkbeag1ELVHAEfdeTgDCq6VJNSCXvo
         Q87HKyazLMhJICKO4kGeDY4+op194MOijuGFNptQ319Dho0FJi9h//h/UT7o4ndrjmeQ
         x2UQ==
X-Gm-Message-State: APjAAAXBGfTnBJ+S37cw8Xqm930zEDzj7J3q8TLNwo9JEW2iZAqYL6QL
        rizTdW9uf+QzmZddiePkOwZ0DUoNvHSlQNoiq66vqw==
X-Google-Smtp-Source: APXvYqwqhZdHZuzmfVR+VAX9an13Ns7LFtzJG2igrynLli0G6v9/gs0AEvy1ep5n9uzT+2IPKsgnfda4dp91vMUqefE=
X-Received: by 2002:a05:6830:4b:: with SMTP id d11mr23676947otp.106.1561370350853;
 Mon, 24 Jun 2019 02:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
 <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com> <20190624093233.73f3tcshewlbogli@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190624093233.73f3tcshewlbogli@DESKTOP-E1NTVVP.localdomain>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 24 Jun 2019 11:58:59 +0200
Message-ID: <CAKMK7uG02qAqH8MMpE6kzRO99HTjnadTFDrY1vVr9RmAiFPvJA@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     Raymond Smith <Raymond.Smith@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuq825@gmail.com" <yuq825@gmail.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:32 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> Hi Daniel,
>
> On Fri, Jun 21, 2019 at 05:27:00PM +0200, Daniel Vetter wrote:
> > On Fri, Jun 21, 2019 at 12:21 PM Raymond Smith <Raymond.Smith@arm.com> wrote:
> > >
> > > Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> > > denote the 16x16 block u-interleaved format used in Arm Utgard and
> > > Midgard GPUs.
> > >
> > > Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> > > ---
> > >  include/uapi/drm/drm_fourcc.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > > index 3feeaa3..8ed7ecf 100644
> > > --- a/include/uapi/drm/drm_fourcc.h
> > > +++ b/include/uapi/drm/drm_fourcc.h
> > > @@ -743,6 +743,16 @@ extern "C" {
> > >  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> > >
> > >  /*
> > > + * Arm 16x16 Block U-Interleaved modifier
> > > + *
> > > + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the image
> > > + * into 16x16 pixel blocks. Blocks are stored linearly in order, but pixels
> > > + * in the block are reordered.
> > > + */
> > > +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> > > +       fourcc_mod_code(ARM, ((1ULL << 55) | 1))
> >
> > This seems to be an extremely random pick for a new number. What's the
> > thinking here? Aside from "doesnt match any of the afbc combos" ofc.
> > If you're already up to having thrown away 55bits, then it's not going
> > to last long really :-)
> >
> > I think a good idea would be to reserve a bunch of the high bits as
> > some form of index (afbc would get index 0 for backwards compat). And
> > then the lower bits would be for free use for a given index/mode. And
> > the first mode is probably an enumeration, where possible modes simple
> > get enumerated without further flags or anything.
>
> Yup, that's the plan:
>
>         (0 << 55): AFBC
>         (1 << 55): This "non-category" for U-Interleaved
>         (1 << 54): Whatever the next category is
>         (3 << 54): Whatever comes after that
>         (1 << 53): Maybe we'll get here someday

Uh, so the index would be encoded with least-significant bit first,
starting from bit55 downwards? Clever idea, but I think this needs a
macro (or at least a comment). Not sure there's a ready-made bitmask
mirror function for this stuff, works case we can hand-code it and
extend every time we need one more bit encoded. Something like:

MIRROR_U32((u & (BIT(0)) << 31 | (u & BIT(1) << 30 | ...)

And then shift that to the correct place. Probably want an

ARM_MODIFIER_ENCODE(space_idx, flags) macro which assembles everything.

>         ...
>
> I didn't want to explicitly reserve some high bits, because we've no
> idea how many to reserve. This way, we can assign exactly as many
> high bits as we need, when we need them. If any of the "modes" start
> encroaching towards the high bits, we'll have to make a decision at
> that point.
>
> Also, this is the only U-Interleaved format (that I know of), so it's
> not worth calling bit 55 "The U-Interleaved bit" because that would be
> a waste of space. It's more like the "misc" bit, but that's not a
> useful name to enshrine in UAPI.

Yeah that's what I meant. Also better to explicitly reserve this, i.e.

#define ARM_FBC_MODIFIER_SPACE 0
#define ARM_MISC_MODIFIER_SPACE 1

and then encode with the mirror trickery.

> Note that isn't the same as the "not-AFBC bit", because we may well
> have something in the future which is neither AFBC nor "misc".
>
> We've been very careful in our code to enforce all
> undefined/unrecognised bits to be zero, to ensure that this works.
>
> >
> > The other bit: Would be real good to define the format a bit more
> > precisely, including the layout within the tile.
>
> It's U-Interleaved, obviously ;-)

:-) I mean full code exists in panfrost/lima, so this won't change
anything really ...

Cheers, Daniel

>
> -Brian
>
> >
> > Also ofc needs acks from lima/panfrost people since I assume they'll
> > be using this, too.
> >
> > Thanks, Daniel
> >
> > > +
> > > +/*
> > >   * Allwinner tiled modifier
> > >   *
> > >   * This tiling mode is implemented by the VPU found on all Allwinner platforms,
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
