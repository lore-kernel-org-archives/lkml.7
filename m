Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8504CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901E121929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDIFeZOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfJYDiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:38:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42570 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfJYDiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:38:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so596552pgi.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9xlnRxbz5e5Gec4it5mCjsOFIOEz65fy9CE22wHzOHQ=;
        b=CDIFeZOvtLPMpAoNRpBSSxesK+l4qgc4U4YJQyQQFRn+kMT/tvB+L9xj4psbgj2sDo
         jvOyeTnKCY5Vdkg5ynMXnsCtSKfprt3GCdB2NRnSoe2T+IxxvwlLyHXqHj3uvjvAW4F5
         ExGae8XSp41dxXQYNOqY6m2LQCiWzwvNniKSNN5qH6deGsbFfUlkcIRXEmg+mGxtKF82
         d1dxKP+ae6/4tChL5rR4QPJdUUQczwdtcNxy06WIyZet1a5+MyprNMT0ETqgWRwc/w2w
         WhQXeaeDtgGzZ5CJxDdVnzIHgWKhTxUugvVNzldb875Rv/64nZNe2emrO5YznZ5wltgZ
         8LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9xlnRxbz5e5Gec4it5mCjsOFIOEz65fy9CE22wHzOHQ=;
        b=dcQ7n49V8Jve8nVmEHnFtWqnvzGDFW9Qh5euAA8eQIxlkpr/3puFcG+lY5sQDi8R/o
         kPQIdOW6FPwBPsFCkvPw/58b4afGM2J8ukx12iA+e/x0BEvlGj3U3C/pJ/rL1n01fStI
         X+b+UQWz76bYj/DjKMs1XINdKlrFJYYSgNhxrz2J3CNLB+vSB5IGxG/4CwlXM/RsfuDq
         0z/YqCisnvM5/l7BqAZhS0KNfZf8DFGeLsdVTs83HV67FZd54dGoTB88x7eoat4xSiM5
         sIZzHW12+x6wgQ+61FGGJU9hJaryZhdew1PSHloAlXLX8UFeN/bmeES8vaI6H0IRPDeD
         vXxw==
X-Gm-Message-State: APjAAAUDw388JoXDQmwvssPpxiXgf7LyaiqUQVP5SLZKdIDk+LUzofpk
        G9mkkrhxzxBfBbAitpAoIc9WtvH0OLw/zA==
X-Google-Smtp-Source: APXvYqyiLM+oYDg3f2Jq7wws+N6/oo+jeyQ0Wa3flDhDafSNAtI9iFsg2mHpQeFMm1XG42nR0yF/+Q==
X-Received: by 2002:a63:5909:: with SMTP id n9mr1674233pgb.101.1571974690423;
        Thu, 24 Oct 2019 20:38:10 -0700 (PDT)
Received: from wambui ([197.254.95.2])
        by smtp.gmail.com with ESMTPSA id p36sm489777pgm.55.2019.10.24.20.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 20:38:09 -0700 (PDT)
Date:   Fri, 25 Oct 2019 06:37:58 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Harry Wentland <hwentlan@amd.com>
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, outreachy-kernel@googlegroups.com,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com
Subject: Re: [PATCH] drm/amd/amdgpu: make undeclared variables static
Message-ID: <20191025033758.GA3201@wambui>
Reply-To: 0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com
References: <20191019072426.20535-1-wambui@karuga.xyz>
 <0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3fa30e-0392-054b-a81e-b9cb4475fe07@amd.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:09:34PM +0000, Harry Wentland wrote:
> On 2019-10-19 3:24 a.m., Wambui Karuga wrote:
> > Make the `amdgpu_lockup_timeout` and `amdgpu_exp_hw_support` variables
> > static to remove the following sparse warnings:
> > drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:103:19: warning: symbol 'amdgpu_lockup_timeout' was not declared. Should it be static?
> 
> This should be declared in amdgpu.h. amdgpu is maintained on the
> amd-staging-drm-next branch from
> https://cgit.freedesktop.org/~agd5f/linux/?h=amd-staging-drm-next. Can
> you check there?
> 
Hey Harry,
I checked the amd-staging-drm-next branch, and 'amdgpu_lockup_timeout'
is already declared as extern in amdgpu.h, so sparse only warns about
'amdgpu_exp_hw_support'. 
I'll do the same for 'amdgpu_exp_hw_support' and send an update patch
series for this and the "_LENTH" mispelling.

Thanks,
wambui karuga
> > drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:117:18: warning: symbol 'amdgpu_exp_hw_support' was not declared. Should it be static?
> > 
> > Signed-off-by: Wambui Karuga <wambui@karuga.xyz>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 3fae1007143e..c5b3c0c9193b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -100,7 +100,7 @@ int amdgpu_disp_priority = 0;
> >  int amdgpu_hw_i2c = 0;
> >  int amdgpu_pcie_gen2 = -1;
> >  int amdgpu_msi = -1;
> > -char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
> > +static char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
> >  int amdgpu_dpm = -1;
> >  int amdgpu_fw_load_type = -1;
> >  int amdgpu_aspm = -1;
> > @@ -114,7 +114,7 @@ int amdgpu_vm_block_size = -1;
> >  int amdgpu_vm_fault_stop = 0;
> >  int amdgpu_vm_debug = 0;
> >  int amdgpu_vm_update_mode = -1;
> > -int amdgpu_exp_hw_support = 0;
> > +static int amdgpu_exp_hw_support;
> 
> This is indeed only used in this file but for consistency's sake it's
> probably better to also declare it in amdgpu.h rather than make it
> static here.
> 
> Harry
> 
> >  int amdgpu_dc = -1;
> >  int amdgpu_sched_jobs = 32;
> >  int amdgpu_sched_hw_submission = 2;
> > 
