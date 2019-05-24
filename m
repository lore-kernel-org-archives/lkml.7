Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16B9C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD272081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391448AbfEXMMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:12:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:48482 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391253AbfEXMMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:12:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 05:12:32 -0700
X-ExtLoop1: 1
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 24 May 2019 05:12:27 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 24 May 2019 15:12:26 +0300
Date:   Fri, 24 May 2019 15:12:26 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        nd <nd@arm.com>,
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
Message-ID: <20190524121226.GD5942@intel.com>
References: <20190404110552.15778-1-james.qian.wang@arm.com>
 <20190516135748.GC1372@arm.com>
 <20190521084552.GA20625@james-ThinkStation-P300>
 <20190524111009.beddu67vvx66wvmk@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524111009.beddu67vvx66wvmk@DESKTOP-E1NTVVP.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:10:09AM +0000, Brian Starkey wrote:
> Hi,
> 
> On Tue, May 21, 2019 at 09:45:58AM +0100, james qian wang (Arm Technology China) wrote:
> > On Thu, May 16, 2019 at 09:57:49PM +0800, Ayan Halder wrote:
> > > On Thu, Apr 04, 2019 at 12:06:14PM +0100, james qian wang (Arm Technology China) wrote:
> > > >  
> > > > +static int
> > > > +komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
> > > > +			  const struct drm_mode_fb_cmd2 *mode_cmd)
> > > > +{
> > > > +	struct drm_framebuffer *fb = &kfb->base;
> > > > +	const struct drm_format_info *info = fb->format;
> > > > +	struct drm_gem_object *obj;
> > > > +	u32 alignment_w = 0, alignment_h = 0, alignment_header;
> > > > +	u32 n_blocks = 0, min_size = 0;
> > > > +
> > > > +	obj = drm_gem_object_lookup(file, mode_cmd->handles[0]);
> > > > +	if (!obj) {
> > > > +		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
> > > > +		return -ENOENT;
> > > > +	}
> > > > +
> > > > +	switch (fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> > > > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8:
> > > > +		alignment_w = 32;
> > > > +		alignment_h = 8;
> > > > +		break;
> > > > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> > > > +		alignment_w = 16;
> > > > +		alignment_h = 16;
> > > > +		break;
> > > > +	default:
> > > Can we have something like a warn here ?
> > 
> > will add a WARN here.
> > 
> 
> I think it's better not to. fb->modifier comes from
> userspace, so a malicious app could spam us with WARNs, effectively
> dos-ing the system. -EINVAL should be sufficient.

Should probably check that the entire modifier+format is
actually valid. Otherwise you risk passing on a bogus
modifier deeper into the driver which may trigger
interesting bugs.

Also theoretically (however unlikely) some broken userspace
might start to depend on the ability to create framebuffers
with crap modifiers, which could later break if you change
the way you handle the modifiers. Then you're stuck between
the rock and hard place because you can't break existing
userspace but you still want to change the way modifiers
are handled in the kernel.

Best not give userspace too much rope IMO. Two ways to go about
that:
1) drm_any_plane_has_format() (assumes your .format_mod_supported()
   does its job properly)
2) roll your own 

-- 
Ville Syrjälä
Intel
