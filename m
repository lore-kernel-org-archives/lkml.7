Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D2FC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04031217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfIPHaT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:30:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:31550 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfIPHaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:30:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 00:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,510,1559545200"; 
   d="scan'208";a="201545238"
Received: from lfgiles-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.121])
  by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2019 00:30:12 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: drivers/gpu/drm/i915/display/intel_display.c:3934 skl_plane_stride() error: testing array offset 'color_plane' after use.
In-Reply-To: <20190914040858.GT20699@kadam>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190914040858.GT20699@kadam>
Date:   Mon, 16 Sep 2019 10:31:35 +0300
Message-ID: <87lfuou27c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2019, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a7f89616b7376495424f682b6086e0c391a89a1d
> commit: df0566a641f959108c152be748a0a58794280e0e drm/i915: move modesetting core code under display/
> date:   3 months ago
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> drivers/gpu/drm/i915/display/intel_display.c:3934 skl_plane_stride() error: testing array offset 'color_plane' after use.
> drivers/gpu/drm/i915/display/intel_display.c:16328 intel_sanitize_encoder() error: we previously assumed 'crtc' could be null (see line 16318)

Odd, what changed to provoke the warnings now? Or is the smatch test
new?

Anyway, Cc: Ville & intel-gfx.

BR,
Jani.


>
> git remote add linus https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout df0566a641f959108c152be748a0a58794280e0e
> vim +/color_plane +3934 drivers/gpu/drm/i915/display/intel_display.c
>
> b3cf5c06ca5001 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-25  3926  
> df79cf44191029 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-11  3927  u32 skl_plane_stride(const struct intel_plane_state *plane_state,
> 5d2a19507cb665 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-07  3928  		     int color_plane)
> d21967740f4b7d drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2016-01-28  3929  {
> df79cf44191029 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-11  3930  	const struct drm_framebuffer *fb = plane_state->base.fb;
> df79cf44191029 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-11  3931  	unsigned int rotation = plane_state->base.rotation;
> 5d2a19507cb665 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-07  3932  	u32 stride = plane_state->color_plane[color_plane].stride;
>                                                                                                                               ^^^^^^^^^^^
> Out of bounds read?
>
> 1b500535c513ac drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2017-03-07  3933  
> 5d2a19507cb665 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-07 @3934  	if (color_plane >= fb->format->num_planes)
>                                                                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Tested too late.
>
> 1b500535c513ac drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2017-03-07  3935  		return 0;
> 1b500535c513ac drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2017-03-07  3936  
> b3cf5c06ca5001 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-25  3937  	return stride / skl_plane_stride_mult(fb, color_plane, rotation);
> d21967740f4b7d drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2016-01-28  3938  }
> d21967740f4b7d drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2016-01-28  3939  
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
Jani Nikula, Intel Open Source Graphics Center
