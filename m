Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6071AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377322082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDKGUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:20:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:19996 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfDKGUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:20:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 23:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,336,1549958400"; 
   d="scan'208";a="163291683"
Received: from hmoshe-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.14.247])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2019 23:20:33 -0700
Date:   Thu, 11 Apr 2019 07:20:32 +0100
From:   Eric Engestrom <eric.engestrom@intel.com>
To:     Rob Clark <robdclark@gmail.com>
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
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH libdrm] headers: Sync with drm-next
Message-ID: <20190411062032.qqxz3j7mm4cgzgfp@intel.com>
References: <20190408205422.dj7z4dl36nauwlk7@intel.com>
 <1554809706-15389-1-git-send-email-ayan.halder@arm.com>
 <20190409115913.hvyjxlda4wtzm75t@intel.com>
 <20190409122710.k2bh25xg43lrqzvq@intel.com>
 <CAF6AEGvUsWF+_dZzGBM1BYnwvZRY9T0P7OGq30KJLohFU3soKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF6AEGvUsWF+_dZzGBM1BYnwvZRY9T0P7OGq30KJLohFU3soKg@mail.gmail.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. 1134945 - Pipers Way,
 Swindon SN3 1RJ
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 2019-04-10 21:49:33 -0400, Rob Clark wrote:
> On Tue, Apr 9, 2019 at 8:27 AM Eric Engestrom <eric.engestrom@intel.com> wrote:
> > > > diff --git a/include/drm/msm_drm.h b/include/drm/msm_drm.h
> > > > index c06d0a5..91a16b3 100644
> > > > --- a/include/drm/msm_drm.h
> > > > +++ b/include/drm/msm_drm.h
> > > > @@ -105,14 +105,24 @@ struct drm_msm_gem_new {
> > > >     __u32 handle;         /* out */
> > > >  };
> > > >
> > > > -#define MSM_INFO_IOVA      0x01
> > > > -
> > > > -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> > > > +/* Get or set GEM buffer info.  The requested value can be passed
> > > > + * directly in 'value', or for data larger than 64b 'value' is a
> > > > + * pointer to userspace buffer, with 'len' specifying the number of
> > > > + * bytes copied into that buffer.  For info returned by pointer,
> > > > + * calling the GEM_INFO ioctl with null 'value' will return the
> > > > + * required buffer size in 'len'
> > > > + */
> > > > +#define MSM_INFO_GET_OFFSET        0x00   /* get mmap() offset, returned by value */
> > > > +#define MSM_INFO_GET_IOVA  0x01   /* get iova, returned by value */
> > > > +#define MSM_INFO_SET_NAME  0x02   /* set the debug name (by pointer) */
> > > > +#define MSM_INFO_GET_NAME  0x03   /* get debug name, returned by pointer */
> > > >
> > > >  struct drm_msm_gem_info {
> > > >     __u32 handle;         /* in */
> > > > -   __u32 flags;          /* in - combination of MSM_INFO_* flags */
> > > > -   __u64 offset;         /* out, mmap() offset or iova */
> > > > +   __u32 info;           /* in - one of MSM_INFO_* */
> > > > +   __u64 value;          /* in or out */
> > > > +   __u32 len;            /* in or out */
> > > > +   __u32 pad;
> >
> > freedreno/msm/msm_bo.c needs to be updated to reflect those changes.
> 
> 
> I think you can just rename flags->info and offset->value, the rest of
> the struct should be zero-initialized.. if in doubt you can check
> $mesa/src/freedreno/drm/msm_bo.c
> 
> side-note:  the libdrm_freedreno code was folded into mesa in 19.0, so
> at *some* point we can probably disable libdrm_freedreno build by
> default.

Right now, freedreno's `auto` enables it by default on arm and disables it on
everything else.

I always enable everything to at least build-test it, but Ayan was using
the defaults which is why he didn't see this issue at first.

Btw, the GitLab CI builds everything, so it hopefully won't bitrot unnoticed.

> (I'd kinda still like to keep the code around for some misc
> standalone tools I have, but that is the sort of thing where I can fix
> libdrm if it gets broken).  When to switch to disabled by default I
> guess comes down to how long we want to support mesa 18.x with latest
> libdrm??  Maybe after 19.1, since (selfishly motivated) that gives me
> a long enough window back in case I find myself needing to bisect for
> some regression..
