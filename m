Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3F321479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N2nmW2ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389683AbfETQ2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:28:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42060 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbfETQ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:28:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so24709796eda.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3TAoLRVcknBAN1CDMLOgd0qpJGH55GX0voZSdrhkTTo=;
        b=N2nmW2ws30FUiHTgoIIFpXZlTTKRRsCySLymCkEYYEFTN9Th0GQvagYaHPe7XaHWC/
         WysiWAiv4gRH+hAzjCKWKePUEOGGW5OsudN9iwQGugeG6GhPy/1OWu+gl3djhx6/PGy8
         ILLBKOFZEJo2LzLZxDGbHnJeE1VFbkRNwfwOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3TAoLRVcknBAN1CDMLOgd0qpJGH55GX0voZSdrhkTTo=;
        b=umEcleoXBCHpYioso7G02QncabRIZc9ooeL0i4xMLbbZUZCikUlTVUAGtqHnvaKl7S
         feH1uQfzXo+gdKYDxujAUoHhHHn6hTDfUlQfwd+0Rfx3yvDcHhoJZIahRAcW/SqQ09kF
         TDBNyhblM73CzlVY32DFdXRUVxUg4wi8QECe8b9szgatGfdxeYQ4LYLXDke+Stcmt2kT
         b/Q+yGaiBhpUm4XYfMbn41ld9yPNgPEFWvnDn1ST5rRrCBcGC82/RnNpyDLkAdrvvWAA
         Cl8Jvgbt6X+JX5CFM/M8RKY6ymdkKtt8D3ND/O1SXdVJHSiXWXi1p/73FiLfYf2YKdcj
         aNJA==
X-Gm-Message-State: APjAAAXUm8xx3dM46v0YnHY59reFsFWigLZLK5vAWgFHHaPKHo8fv59Z
        4NfYJQt1DFzKARM/NWzakl9EIw==
X-Google-Smtp-Source: APXvYqwSZ6r6BI9og6hE6k63QBHcefsIwO3oA7gFXQ5dFWDya4tJWv1QMXuDvQ1VsBO2WLjw7BQJ5Q==
X-Received: by 2002:a17:906:af57:: with SMTP id ly23mr28429403ejb.98.1558369690157;
        Mon, 20 May 2019 09:28:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id u47sm5613329edm.86.2019.05.20.09.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 09:28:09 -0700 (PDT)
Date:   Mon, 20 May 2019 18:28:07 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        xiaolinkui <xiaolinkui@kylinos.cn>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
Message-ID: <20190520162807.GE21222@phenom.ffwll.local>
Mail-Followup-To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        xiaolinkui <xiaolinkui@kylinos.cn>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
 <SN6PR12MB2800A7AEC22121C8704CBB09870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2800A7AEC22121C8704CBB09870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 04:44:30PM +0000, Pan, Xinhui wrote:
> I am going to put more members which are also array after this struct,
> not only obj[].  Looks like this struct_size did not help on multiple
> array case. Thanks anyway.  ________________________________

You can then add them up, e.g. kmalloc(struct_size()+struct_size(),
GFP_KERNEL), so this patch here still looks like a good idea.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

> From: xiaolinkui <xiaolinkui@kylinos.cn>
> Sent: Friday, May 17, 2019 4:46:00 PM
> To: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); airlied@linux.ie; daniel@ffwll.ch; Pan, Xinhui; Quan, Evan
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; xiaolinkui@kylinos.cn
> Subject: [PATCH] gpu: drm: use struct_size() in kmalloc()
> 
> [CAUTION: External Email]
> 
> Use struct_size() helper to keep code simple.
> 
> Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 22bd21e..4717a64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>         if (con)
>                 return 0;
> 
> -       con = kmalloc(sizeof(struct amdgpu_ras) +
> -                       sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_COUNT,
> +       con = kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
>                         GFP_KERNEL|__GFP_ZERO);
>         if (!con)
>                 return -ENOMEM;
> --
> 2.7.4
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
