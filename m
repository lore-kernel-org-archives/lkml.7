Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF5C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035A520815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfE0NUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:20:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:6320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfE0NUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:20:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 06:20:04 -0700
X-ExtLoop1: 1
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 27 May 2019 06:20:00 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 27 May 2019 16:19:59 +0300
Date:   Mon, 27 May 2019 16:19:59 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [PATCH] drm/komeda: Added AFBC support for komeda driver
Message-ID: <20190527131959.GH5942@intel.com>
References: <20190404110552.15778-1-james.qian.wang@arm.com>
 <20190516135748.GC1372@arm.com>
 <20190521084552.GA20625@james-ThinkStation-P300>
 <20190524111009.beddu67vvx66wvmk@DESKTOP-E1NTVVP.localdomain>
 <20190524121226.GD5942@intel.com>
 <20190527065110.GA29041@james-ThinkStation-P300>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527065110.GA29041@james-ThinkStation-P300>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 06:51:18AM +0000, james qian wang (Arm Technology China) wrote:
> On Fri, May 24, 2019 at 03:12:26PM +0300, Ville Syrjälä wrote:
> > On Fri, May 24, 2019 at 11:10:09AM +0000, Brian Starkey wrote:
> > > Hi,
> > > 
> > > On Tue, May 21, 2019 at 09:45:58AM +0100, james qian wang (Arm Technology China) wrote:
> > > > On Thu, May 16, 2019 at 09:57:49PM +0800, Ayan Halder wrote:
> > > > > On Thu, Apr 04, 2019 at 12:06:14PM +0100, james qian wang (Arm Technology China) wrote:
> > > > > >  
> > > > > > +static int
> > > > > > +komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
> > > > > > +			  const struct drm_mode_fb_cmd2 *mode_cmd)
> > > > > > +{
> > > > > > +	struct drm_framebuffer *fb = &kfb->base;
> > > > > > +	const struct drm_format_info *info = fb->format;
> > > > > > +	struct drm_gem_object *obj;
> > > > > > +	u32 alignment_w = 0, alignment_h = 0, alignment_header;
> > > > > > +	u32 n_blocks = 0, min_size = 0;
> > > > > > +
> > > > > > +	obj = drm_gem_object_lookup(file, mode_cmd->handles[0]);
> > > > > > +	if (!obj) {
> > > > > > +		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
> > > > > > +		return -ENOENT;
> > > > > > +	}
> > > > > > +
> > > > > > +	switch (fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> > > > > > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8:
> > > > > > +		alignment_w = 32;
> > > > > > +		alignment_h = 8;
> > > > > > +		break;
> > > > > > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> > > > > > +		alignment_w = 16;
> > > > > > +		alignment_h = 16;
> > > > > > +		break;
> > > > > > +	default:
> > > > > Can we have something like a warn here ?
> > > > 
> > > > will add a WARN here.
> > > > 
> > > 
> > > I think it's better not to. fb->modifier comes from
> > > userspace, so a malicious app could spam us with WARNs, effectively
> > > dos-ing the system. -EINVAL should be sufficient.
> > 
> > Should probably check that the entire modifier+format is
> > actually valid. Otherwise you risk passing on a bogus
> > modifier deeper into the driver which may trigger
> > interesting bugs.
> > 
> > Also theoretically (however unlikely) some broken userspace
> > might start to depend on the ability to create framebuffers
> > with crap modifiers, which could later break if you change
> > the way you handle the modifiers. Then you're stuck between
> > the rock and hard place because you can't break existing
> > userspace but you still want to change the way modifiers
> > are handled in the kernel.
> > 
> > Best not give userspace too much rope IMO. Two ways to go about
> > that:
> > 1) drm_any_plane_has_format() (assumes your .format_mod_supported()
> >    does its job properly)
> > 2) roll your own 
> > 
> > -- 
> > Ville Syrjälä
> > Intel
> 
> Hi Brian & Ville:
> 
> komed has a format+modifier check before the fb size check.
> and for komeda_fb_create, the first step is do the format+modifier
> check, the size check is the furthur check after the such format
> valid check. and the detailed fb_create is like:
> 
> struct drm_framebuffer *
> komeda_fb_create(struct drm_device *dev, struct drm_file *file,
> 		 const struct drm_mode_fb_cmd2 *mode_cmd)
> {
>         ...
>         /* Step 1: format+modifier valid check, if it can not be support,
>          * get_format_caps will return a NULL ptr.
>          */
> 	kfb->format_caps = komeda_get_format_caps(&mdev->fmt_tbl,
> 						  mode_cmd->pixel_format,
> 						  mode_cmd->modifier[0]);
> 	if (!kfb->format_caps) {
> 		DRM_DEBUG_KMS("FMT %x is not supported.\n",
> 			      mode_cmd->pixel_format);
> 		kfree(kfb);
> 		return ERR_PTR(-EINVAL);
> 	}
> 
> 	drm_helper_mode_fill_fb_struct(dev, &kfb->base, mode_cmd);
> 
>         /* step 2, do the size check */
> 	if (kfb->base.modifier)
> 		ret = komeda_fb_afbc_size_check(kfb, file, mode_cmd);
> 	else
> 		ret = komeda_fb_none_afbc_size_check(mdev, kfb, file, mode_cmd);
> 	if (ret < 0)
> 		goto err_cleanup;
> 
>         ...
> }
> 
> So theoretically, the WARN in step2 is redundant if get_format_caps
> function has no problem. :). the WARN here is only for reporting
> the kernel BUG or code inconsitent with format caps check and the
> fb size check. And I agree, basically it will not happene.
> @Brian, I'm Ok to remove it. :)
> 
> @Ville:
> Basically komeda follow the way-1, but a little improvement for
> matching komeda's requirement. for komeda which will do two level's
> format+modifier check.
> 1). In fb_create, A roughly check to see if the format+modifier can be
>     supported by current HW.

Yeah, looks like it shouldn't allow any unspecfied modifiers to
sneak through. So should be good.

> 2). In plane_atomic_check: to see if the format+modifier can be
>     supported for a specific layer and with a specific configuration (ROT)
> 
> This is a format valid check example for plane_check.
> https://patchwork.freedesktop.org/patch/301140/?series=59747&rev=2
> 
> James

-- 
Ville Syrjälä
Intel
