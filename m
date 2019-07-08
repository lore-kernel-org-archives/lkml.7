Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31180C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0281F21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9aA4vJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbfGHPDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:03:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40678 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfGHPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:02:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so14856829eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReYLa8THvYygLIMuMww1npiIyJn+z8O5eLERg05TxLo=;
        b=A9aA4vJcOv8CTIvKmXM6kq35C/loFJT19B7b2TukXUKPT6njRUK1RmmhZTEqsdS3qj
         B/aeEn9/YcXxeIJj1htl+z5PO/UQiWeLNwxBtYB8t5EW3A60vRrhG8ZU2cHIs256H2hu
         nE+QmPOhOh4rGjUOqtPM1iGrK6XbqsUvSn+DEYqY664YddVYLLg/Xb2WRlojeTg3w1UF
         6xe370Hd4Bqnhom1jefZdABzOE8G5EtDcQNhXhGwEw1tuMyLHy3oHacGt0mlEkODy1Yi
         4gnYr4mkNmvaT5+I/YF3IwvhgCvXT4ZnfERrQYPAViMcuGfT7sIloPJB9HElHTMx3KBh
         iz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReYLa8THvYygLIMuMww1npiIyJn+z8O5eLERg05TxLo=;
        b=QTv6vfw1JRfOnPTlAz09lTmfTSTifTnd4V8In/kXxD/tS/qTg09lFT3Q7nXVJYf+L2
         EoLiU4vQYMCHNIVvsQ39oJ3L8vI4Sc9M9Gtit1xtVrap6wKhKfMZ4mXR+makDoCu6plH
         wrwiiaLc7zm8ZcqfzRhc7hpbYCTXWnqMs9fcM61MeP2sC5fAtgl4mq7o/v9v6eWDgU3p
         qWGkGWOwayJJBtnNggxU4i301yQi/I3UTCAWusxuCSqnwuDEBGYbwgxRg9QH3CUGx/O8
         aDfP6xP+4iNg7g10HtDoJZ/Qn+lnzNkUoD11j5EHNqqCOyhOkul5dBHeBePnFDGzKjMv
         Vrgg==
X-Gm-Message-State: APjAAAWH360q6hdiGLMjdYAUb0Axkd8nNjl+2ljRavp7lNSMztDV7Rjh
        y6NhVux47wKaaysU/EMAJsUBaIlCeszsGA==
X-Google-Smtp-Source: APXvYqz5PyyErTzOCG114M0gE89vrP4oMgOAjm1oJ9lZL8Sh1Wv96cphR6rttUBJkwL11m1mMwIDCw==
X-Received: by 2002:a50:aa7c:: with SMTP id p57mr20601951edc.179.1562598177936;
        Mon, 08 Jul 2019 08:02:57 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id a6sm5425241eds.19.2019.07.08.08.02.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 08:02:57 -0700 (PDT)
Date:   Mon, 8 Jul 2019 08:02:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chengming Gui <Jack.Gui@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
        dri-devel@lists.freedesktop.org, Likun Gao <Likun.Gao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [1/2] drm/amd/powerplay: smu_v11_0: fix uninitialized variable
 use
Message-ID: <20190708150255.GA32266@archlinux-epyc>
References: <20190708140816.1334640-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708140816.1334640-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:07:58PM +0200, Arnd Bergmann wrote:
> A mistake in the error handling caused an uninitialized
> variable to be used:
> 
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1102:10: error: variable 'freq' is used uninitialized whenever '?:' condition is false [-Werror,-Wsometimes-uninitialized]
>                 ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:880:3: note: expanded from macro 'smu_get_current_clk_freq_by_table'
>         ((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1114:2: note: uninitialized use occurs here
>         freq *= 100;
>         ^~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1102:10: note: remove the '?:' if its condition is always true
>                 ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
>                        ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:880:3: note: expanded from macro 'smu_get_current_clk_freq_by_table'
>         ((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
>          ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1095:15: note: initialize the variable 'freq' to silence this warning
>         uint32_t freq;
>                      ^
>                       = 0
> 
> Bail out of smu_v11_0_get_current_clk_freq() before we get there.
> 
> Fixes: e36182490dec ("drm/amd/powerplay: fix dpm freq unit error (10KHz -> Mhz)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index c3f9714e9047..bd89a13b6679 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1099,9 +1099,11 @@ static int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
>  		return -EINVAL;
>  
>  	/* if don't has GetDpmClockFreq Message, try get current clock by SmuMetrics_t */
> -	if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0)
> +	if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0) {
>  		ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
> -	else {
> +		if (ret)
> +			return ret;

I am kind of surprised that this fixes the warning. If I am interpreting
the warning correctly, it is complaining that the member
get_current_clk_freq_by_table could be NULL and not be called to
initialize freq and that entire statement will become 0. If that is the
case, it seems like this added error handling won't fix that problem,
right?

Cheers,
Nathan
