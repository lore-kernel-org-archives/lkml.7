Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DFC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1042073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="j/2CmDUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLJJws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:52:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36474 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfLJJws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:52:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so19288148wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JezLvil0eLO2aw1UzQhJ1XxGiTMbCLIXlqvlGg+T2YE=;
        b=j/2CmDUm3QIbQshTMgVTX8LcLuPqgtJEbvKgPM+zo8SwqnUr8dyTkxFgSTUcaYnNI1
         2DG1ShF83ESSZi/exxsPp5NgWf4i9+RW/w7YAHXykOi7NDzBxcyJvmL+XOc1TcVCsqPc
         J1CqXVmNxQEfHQBtnxaRajM+hYsqwCzFJ5Q4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JezLvil0eLO2aw1UzQhJ1XxGiTMbCLIXlqvlGg+T2YE=;
        b=nIyz7uOoyJA+tPi170p3Pmb4ibMWnf3E8ge8oD89tpKfHE1g0xZF0s1Ifg5QToiNll
         g5A5kha32c+OHTCmaZc7gkxR7+YkRNCVRHCBl2xhjWn0h1UR2k+MXa8xY/Ly1K63xfL6
         ebtrm0JXCYP1dr+as+q7xQzstH2l0IATD+shxfIjgeitjp6HFqMh4yX3HKG2LLtIVKsF
         THDZ0A9UX+3LD5doUrKyCTnco3O4lFQFIl1NDl1X5wyKrB77cwF4PN8mSHl9UUZ02ATM
         ESG1MjwBstEh4cQVN3oF57MxQL1EjmlFqtqgs+i1h+mYd6KsBP8MP0aokuyIB9Pe9gEK
         Ofpw==
X-Gm-Message-State: APjAAAVWK6rssdbXGxYWDrQCFm+qmomkVdGby6XIb6zhVCwmD+xzUSMw
        mk6DHXK0tenBPcUsu+ANGWyaFw==
X-Google-Smtp-Source: APXvYqztjH+/E4jJs3q+cB1FhU0Gy5wVXDRkd6pxHK3k2mdTUA/fnMRQd/gLDR7DTlx9yRVXnFiCHg==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr2122395wru.230.1575971565010;
        Tue, 10 Dec 2019 01:52:45 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id 62sm2626546wmb.27.2019.12.10.01.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:52:43 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:52:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "yakui.zhao@intel.com" <yakui.zhao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/modes: remove unused variables
Message-ID: <20191210095241.GO624164@phenom.ffwll.local>
Mail-Followup-To: Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yakui.zhao@intel.com" <yakui.zhao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20191119134706.10893-1-benjamin.gaignard@st.com>
 <8056f838-3ebf-26db-f5be-3e78d61aa512@suse.de>
 <f210413f-2d2f-9887-ca3b-a3c48564d9d6@st.com>
 <87tv6fgkpn.fsf@intel.com>
 <f3a86fe8-6bf8-6767-2ec5-d6fecd81231f@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a86fe8-6bf8-6767-2ec5-d6fecd81231f@st.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:23:51AM +0000, Benjamin GAIGNARD wrote:
> + Zhao Yakui
> 
> On 12/5/19 10:55 AM, Jani Nikula wrote:
> > On Wed, 04 Dec 2019, Benjamin GAIGNARD <benjamin.gaignard@st.com> wrote:
> >> On 12/4/19 10:35 AM, Thomas Zimmermann wrote:
> >>> Hi
> >>>
> >>> Am 19.11.19 um 14:47 schrieb Benjamin Gaignard:
> >>>> When compiling with W=1 few warnings about unused variables show up.
> >>>> This patch removes all the involved variables.
> >>>>
> >>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >>>> ---
> >>>>    drivers/gpu/drm/drm_modes.c | 22 +++-------------------
> >>>>    1 file changed, 3 insertions(+), 19 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> >>>> index 88232698d7a0..aca901aff042 100644
> >>>> --- a/drivers/gpu/drm/drm_modes.c
> >>>> +++ b/drivers/gpu/drm/drm_modes.c
> >>>> @@ -233,7 +233,7 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
> >>>>    		/* 3) Nominal HSync width (% of line period) - default 8 */
> >>>>    #define CVT_HSYNC_PERCENTAGE	8
> >>>>    		unsigned int hblank_percentage;
> >>>> -		int vsyncandback_porch, vback_porch, hblank;
> >>>> +		int vsyncandback_porch, hblank;
> >>>>    
> >>>>    		/* estimated the horizontal period */
> >>>>    		tmp1 = HV_FACTOR * 1000000  -
> >>>> @@ -249,7 +249,6 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
> >>>>    		else
> >>>>    			vsyncandback_porch = tmp1;
> >>>>    		/* 10. Find number of lines in back porch */
> >>>> -		vback_porch = vsyncandback_porch - vsync;
> >>>>    		drm_mode->vtotal = vdisplay_rnd + 2 * vmargin +
> >>>>    				vsyncandback_porch + CVT_MIN_V_PORCH;
> >>>>    		/* 5) Definition of Horizontal blanking time limitation */
> >>>> @@ -386,9 +385,8 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
> >>>>    	int top_margin, bottom_margin;
> >>>>    	int interlace;
> >>>>    	unsigned int hfreq_est;
> >>>> -	int vsync_plus_bp, vback_porch;
> >>>> -	unsigned int vtotal_lines, vfieldrate_est, hperiod;
> >>>> -	unsigned int vfield_rate, vframe_rate;
> >>>> +	int vsync_plus_bp;
> >>>> +	unsigned int vtotal_lines;
> >>>>    	int left_margin, right_margin;
> >>>>    	unsigned int total_active_pixels, ideal_duty_cycle;
> >>>>    	unsigned int hblank, total_pixels, pixel_freq;
> >>>> @@ -451,23 +449,9 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
> >>>>    	/* [V SYNC+BP] = RINT(([MIN VSYNC+BP] * hfreq_est / 1000000)) */
> >>>>    	vsync_plus_bp = MIN_VSYNC_PLUS_BP * hfreq_est / 1000;
> >>>>    	vsync_plus_bp = (vsync_plus_bp + 500) / 1000;
> >>>> -	/*  9. Find the number of lines in V back porch alone: */
> >>>> -	vback_porch = vsync_plus_bp - V_SYNC_RQD;
> >>>>    	/*  10. Find the total number of lines in Vertical field period: */
> >>>>    	vtotal_lines = vdisplay_rnd + top_margin + bottom_margin +
> >>>>    			vsync_plus_bp + GTF_MIN_V_PORCH;
> >>>> -	/*  11. Estimate the Vertical field frequency: */
> >>>> -	vfieldrate_est = hfreq_est / vtotal_lines;
> >>>> -	/*  12. Find the actual horizontal period: */
> >>>> -	hperiod = 1000000 / (vfieldrate_rqd * vtotal_lines);
> >>>> -
> >>>> -	/*  13. Find the actual Vertical field frequency: */
> >>>> -	vfield_rate = hfreq_est / vtotal_lines;
> >>>> -	/*  14. Find the Vertical frame frequency: */
> >>>> -	if (interlaced)
> >>>> -		vframe_rate = vfield_rate / 2;
> >>>> -	else
> >>>> -		vframe_rate = vfield_rate;
> >>> The amount of unused code is quite large, which makes me wonder if
> >>> there's something missing below where these variables are supposed to be
> >>> used.
> >>>
> >>> If these variables can be removed, comments should mention that steps 9
> >>> and 11 to 14 are being left out. After all, the function is fairly
> >>> explicit about implementing the GTF algorithm step by step.
> >>>
> >>> Best regards
> >>> Thomas
> >> If the goal is to keep all the steps then I could prefix all problematic
> >> variables with __maybe_unused macro.
> > The effect is the same; it hides a potential bug that should be analyzed
> > and fixed. If you have the time, please look at the code and figure out
> > what it's supposed to do, and why isn't it using the information. Look
> > at git blame and log, was it always so, or did something change?
> >
> > The warnings are about potential bugs. The objective or end goal is to
> > fix the bugs, not to silence the warnings.
> This code haven't change since it has been added by commit:
> 26bbdadad356e ("drm/mode: add the GTF algorithm in kernel space")
> The variables that I'm removing are not used anywhere else.
> The algorithm is copy from xserver/hw/xfree86/modes/xf86gtf.c where
> vframe_rate and v_back_porch are used with (void) calls:
> (void) v_back_porch;
> (void) v_frame_rate;
> It is another way avoid the warnings.
> Note that if you start removing v_frame_rate then vfield_rate becomes 
> unused, etc...

I'd say we should do the same thing then as xf86 and just mark them up as
unused. Might be good to double-check with the spec at least whether
they're really not unused, or whether we have some issue. But given that
it seems to have worked for ages, I suspect it's all good.

Removing the code otoh feels a bit icky.
-Daniel


> 
> Benjamin
> 
> >
> > BR,
> > Jani.
> >
> >
> >> Benjamin
> >>
> >>>>    	/*  15. Find number of pixels in left margin: */
> >>>>    	if (margins)
> >>>>    		left_margin = (hdisplay_rnd * GTF_MARGIN_PERCENTAGE + 500) /
> >>>>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
