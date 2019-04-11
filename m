Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9144BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F24217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ech443MR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKBts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:49:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38139 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDKBtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:49:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id d13so3733483edr.5;
        Wed, 10 Apr 2019 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGBUzOtz4UlgntJVeZC6/P4en79ynT2N/NyNJk2IxFU=;
        b=ech443MRe2yYmWkh01LaEXj3S+ATTSYZV+xtnaBCYZYgm+Tmsn0B194rioEHS52R7c
         lLuRry5ziPZ1j9mdmNj0BtVmEi/5pChxrAmgzQoCHzb/C/ejvlfeBQJSrP2uQULFlHOK
         3x12Pw9bZGN1I+NRcm57ivGbd/mVIWTdK2Cj0OSp4getc/ZnwHvzv5adP73kx4iI57ho
         IkR44o6ZLKHqS1CL9hI+aLuko7dqy0sxDL/Im5aUGQCwfxkF6z1MKFAlDS58lGver7ds
         wN9gvr9r79x4RN2m/t2waXAio34qlECyO/fsBF3sr9Cx2cUtLKkFzre6GfA6QnPKzuUR
         bKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGBUzOtz4UlgntJVeZC6/P4en79ynT2N/NyNJk2IxFU=;
        b=Kdj+Um8FMTJBY4epT96kREXtlTTOx4KZpIjG7OMHDYgel0KhlQe7ApLMBsd+HkNw92
         Ma+RPSOO9CySvuhfnlZPm9qJLRTUX9rVUywCk7X4lZhuSIHeMnOFLUvYZevmpp55I5Iv
         pve55gaIzJ5Mbzc8Td8nG59GlKpDtsj98ATudSGCoUYuqzIyCyPXOEZWkPpYl+geenbA
         Z6qNJVPjUKQbv3lNjAp0nJKUpvA1WOpQdijrwoWssXuviytj4ZFeK2CnXwFYCZ27GwPM
         QYtxm0Bm4CMqRtJwYG9eD3FslPA6kAjAFba26TaH5c/nG05bjKkLVjRim7GppLxlkFPB
         bN2Q==
X-Gm-Message-State: APjAAAX8S0gN3Fsxcot4U0RicOWQ7w0ihiUBN0Wlr1t9F6kXu94HGcRd
        tCv/J0k8NLArJQN2pypQNGQPUSJLMe8nAsbDAjk=
X-Google-Smtp-Source: APXvYqxEdxX9B+zhjhddm9iB31fJsPsa+NW85wqXiJTKyaAp7CYolOSEjnTEbfcle2MX5K1NKKIu9mgZmnDamcA5sn4=
X-Received: by 2002:a17:906:4f19:: with SMTP id t25mr25803524eju.165.1554947385409;
 Wed, 10 Apr 2019 18:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190408205422.dj7z4dl36nauwlk7@intel.com> <1554809706-15389-1-git-send-email-ayan.halder@arm.com>
 <20190409115913.hvyjxlda4wtzm75t@intel.com> <20190409122710.k2bh25xg43lrqzvq@intel.com>
In-Reply-To: <20190409122710.k2bh25xg43lrqzvq@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 10 Apr 2019 21:49:33 -0400
Message-ID: <CAF6AEGvUsWF+_dZzGBM1BYnwvZRY9T0P7OGq30KJLohFU3soKg@mail.gmail.com>
Subject: Re: [PATCH libdrm] headers: Sync with drm-next
To:     Eric Engestrom <eric.engestrom@intel.com>
Cc:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 8:27 AM Eric Engestrom <eric.engestrom@intel.com> wrote:
>
> On Tuesday, 2019-04-09 12:59:13 +0100, Eric Engestrom wrote:
> > On Tuesday, 2019-04-09 11:35:14 +0000, Ayan Halder wrote:
> > > Generated using make headers_install from the drm-next
> > > tree - git://anongit.freedesktop.org/drm/drm
> > > branch - drm-next
> > > commit - 14d2bd53a47a7e1cb3e03d00a6b952734cf90f3f
> > >
> > > The changes were as follows :-
> > >
> > > core: (drm.h, drm_fourcc.h, drm_mode.h)
> > > - Added 'struct drm_syncobj_transfer', 'struct drm_syncobj_timeline_wait' and 'struct drm_syncobj_timeline_array'
> > > - Added various DRM_IOCTL_SYNCOBJ_ ioctls
> > > - Added some new RGB and YUV formats
> > > - Added 'DRM_FORMAT_MOD_VENDOR_ALLWINNER'
> > > - Added 'SAMSUNG' and Arm's 'AFBC' and 'ALLWINNER' format modifiers
> > > - Added 'struct drm_mode_rect'
> > >
> > > i915:
> > > - Added struct 'struct i915_user_extension' and various 'struct drm_i915_gem_context_'
> > > - Added different modes of per-process Graphics Translation Table
> > >
> > > msm:
> > > - Added various get or set GEM buffer info flags
> > > - Added some MSM_SUBMIT_BO_ macros
> > > - Modified 'struct drm_msm_gem_info'
> > >
> > > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> >
> > This looks sane, and applies cleanly :)
> > Acked-by: Eric Engestrom <eric.engestrom@intel.com>
>
> Actually, revoking that, as this patch breaks the build; see below.
>
> >
> > > ---
> > >  include/drm/drm.h        |  36 +++++++
> > >  include/drm/drm_fourcc.h | 136 +++++++++++++++++++++++++++
> > >  include/drm/drm_mode.h   |  23 ++++-
> > >  include/drm/i915_drm.h   | 237 ++++++++++++++++++++++++++++++++++++++++-------
> > >  include/drm/msm_drm.h    |  25 +++--
> > >  5 files changed, 415 insertions(+), 42 deletions(-)
> > >
> [snip]
> > > diff --git a/include/drm/msm_drm.h b/include/drm/msm_drm.h
> > > index c06d0a5..91a16b3 100644
> > > --- a/include/drm/msm_drm.h
> > > +++ b/include/drm/msm_drm.h
> > > @@ -105,14 +105,24 @@ struct drm_msm_gem_new {
> > >     __u32 handle;         /* out */
> > >  };
> > >
> > > -#define MSM_INFO_IOVA      0x01
> > > -
> > > -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> > > +/* Get or set GEM buffer info.  The requested value can be passed
> > > + * directly in 'value', or for data larger than 64b 'value' is a
> > > + * pointer to userspace buffer, with 'len' specifying the number of
> > > + * bytes copied into that buffer.  For info returned by pointer,
> > > + * calling the GEM_INFO ioctl with null 'value' will return the
> > > + * required buffer size in 'len'
> > > + */
> > > +#define MSM_INFO_GET_OFFSET        0x00   /* get mmap() offset, returned by value */
> > > +#define MSM_INFO_GET_IOVA  0x01   /* get iova, returned by value */
> > > +#define MSM_INFO_SET_NAME  0x02   /* set the debug name (by pointer) */
> > > +#define MSM_INFO_GET_NAME  0x03   /* get debug name, returned by pointer */
> > >
> > >  struct drm_msm_gem_info {
> > >     __u32 handle;         /* in */
> > > -   __u32 flags;          /* in - combination of MSM_INFO_* flags */
> > > -   __u64 offset;         /* out, mmap() offset or iova */
> > > +   __u32 info;           /* in - one of MSM_INFO_* */
> > > +   __u64 value;          /* in or out */
> > > +   __u32 len;            /* in or out */
> > > +   __u32 pad;
>
> freedreno/msm/msm_bo.c needs to be updated to reflect those changes.


I think you can just rename flags->info and offset->value, the rest of
the struct should be zero-initialized.. if in doubt you can check
$mesa/src/freedreno/drm/msm_bo.c

side-note:  the libdrm_freedreno code was folded into mesa in 19.0, so
at *some* point we can probably disable libdrm_freedreno build by
default.  (I'd kinda still like to keep the code around for some misc
standalone tools I have, but that is the sort of thing where I can fix
libdrm if it gets broken).  When to switch to disabled by default I
guess comes down to how long we want to support mesa 18.x with latest
libdrm??  Maybe after 19.1, since (selfishly motivated) that gives me
a long enough window back in case I find myself needing to bisect for
some regression..

BR,
-R

>
> > >  };
> > >
> > >  #define MSM_PREP_READ        0x01
> > > @@ -188,8 +198,11 @@ struct drm_msm_gem_submit_cmd {
> > >   */
> > >  #define MSM_SUBMIT_BO_READ             0x0001
> > >  #define MSM_SUBMIT_BO_WRITE            0x0002
> > > +#define MSM_SUBMIT_BO_DUMP             0x0004
> > >
> > > -#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | MSM_SUBMIT_BO_WRITE)
> > > +#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
> > > +                                   MSM_SUBMIT_BO_WRITE | \
> > > +                                   MSM_SUBMIT_BO_DUMP)
> > >
> > >  struct drm_msm_gem_submit_bo {
> > >     __u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
> > > --
> > > 2.7.4
> > >
