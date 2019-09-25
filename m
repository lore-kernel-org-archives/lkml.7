Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16965C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BB32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="avhIse5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392788AbfIYUIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:08:41 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39216 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731229AbfIYUIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:08:40 -0400
Received: by mail-yb1-f193.google.com with SMTP id u15so52840ybm.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VAaiqGoJ4pEXMzYJOikHUUPKtKAF3wx8lqD0K1ST4aU=;
        b=avhIse5/RpZfaFodCvM+4FD3O2mvJQh97DzvaZXBZYVqRDzM/KKnpGktHjBkk6qTo4
         ZluHFmK/j7vB/YDW9UOdND4nib0QCocOdYW/X6Kef74sjmd5WKB/5BQM9YTYF5JwUlah
         7b6fgcEaWaayEw/i5sbJBNPPxwIJ3Hpe1+xBnsozs6pANPepf/cZdcOYXME7lPLtmxPy
         BA2cxyO4o7qTboXkzt0SAlK7IWTxSkCL1zJF4FJ9LLQeW9D2ChBzpHd4ehh3IpTOa/OY
         Lb+9U+F/aiQCQfXqwqZrqtzQaA5kFXasKjTzAY8WbljfS1jXuAa0ci5NT2LMscnsgv7m
         91kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VAaiqGoJ4pEXMzYJOikHUUPKtKAF3wx8lqD0K1ST4aU=;
        b=B/u3+/N2WpsWCzCpDaC2Bm95BJ6fPN1qr0OI5LiSq7zhdyb464ci1pq8JUEBQ1JMkE
         jjMfXLRNUZGBX1jk7Zzhm4yXRrXrm/Ytjz1TJ6NVxxJlfK/UQP+obNaf4Dp/O7fcKOZd
         5cdHtQgwwxghgIyi8sSd0kXYHFYpcy3AljX++zGYi2Q58CPDV/M6EY9gEOBscUUEh27E
         BWfrx6bqtqEdGFpHGwfcnqlMFvyY4hpo8uMEYqDYifPEoXV+jfCAoE7JMJZ12rpnQIW4
         +q0fVHybGkAdOXb5YcdPF8tBfTk3G/HkdoX0TJYEAZrmPG084eJlTZRqlyC51hiHhO59
         as/g==
X-Gm-Message-State: APjAAAWycOLBuQLY2FuNGgROkTuX0nanlQylg1BoX3knRSzkq5Q5mJYV
        WwCoZkumcaQKV1eAGpGH7Eh3iw==
X-Google-Smtp-Source: APXvYqzHtod4n2+whggfrt7HgHX6HJwM31fm7krzjZzFBf0YmRR0H8hZpdFsXRX/JxLZErFMY3j6fA==
X-Received: by 2002:a5b:bc4:: with SMTP id c4mr1267071ybr.270.1569442119582;
        Wed, 25 Sep 2019 13:08:39 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id u67sm1487609ywf.44.2019.09.25.13.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:08:39 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:08:38 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/27] drm/amdgpu/dm: Resume short HPD IRQs before
 resuming MST topology
Message-ID: <20190925200838.GO218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-25-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-25-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:46:02PM -0400, Lyude Paul wrote:
> Since we're going to be reprobing the entire topology state on resume
> now using sideband transactions, we need to ensure that we actually have
> short HPD irqs enabled before calling drm_dp_mst_topology_mgr_resume().
> So, do that.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 73630e2940d4..4d3c8bff77da 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1185,15 +1185,15 @@ static int dm_resume(void *handle)
>  	/* program HPD filter */
>  	dc_resume(dm->dc);
>  
> -	/* On resume we need to  rewrite the MSTM control bits to enamble MST*/
> -	s3_handle_mst(ddev, false);
> -
>  	/*
>  	 * early enable HPD Rx IRQ, should be done before set mode as short
>  	 * pulse interrupts are used for MST
>  	 */
>  	amdgpu_dm_irq_resume_early(adev);
>  
> +	/* On resume we need to  rewrite the MSTM control bits to enamble MST*/

While we're here,

s/  / / && s/enamble/enable/ && s_*/_ */_

> +	s3_handle_mst(ddev, false);
> +
>  	/* Do detection*/
>  	drm_connector_list_iter_begin(ddev, &iter);
>  	drm_for_each_connector_iter(connector, &iter) {
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
