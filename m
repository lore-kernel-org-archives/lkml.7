Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B8E2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqV/ELyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCDWyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:54:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35414 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCDWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:54:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so5624562edp.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pa5agJuMNZ6TOStPvOjFrUx0wrZJLT/PiWkjO94VFik=;
        b=cqV/ELyc6/9jzxfL+N8fAds2AVwV9RG8mP9GQ8K6vbXDDScX2aeiBKuyNgokPBlgN1
         mXNXW2EInssBnL9JFRMnvLEVI4FhNvTHkUSQge67v6jublvdCBtGGkt3Z7gtVCoVbhzc
         SN0tLJ/sG2mceEWEOh0parc7aMIM0t9AZNG4by3p7nfc/8ywGwmzO8Q5sh5foVOjbWA9
         s54mfloJGsH3np275MaarDSEcrOEUkwCBgoNwPNflYJmMijtEE1Gk73ckIRX9tHVfrbb
         TDi++vyxiEPoHD8E+d2bg4OPuCVHvNYckWhxyfbf1xpMZyttY+VeTycujSnq0p9FzKTQ
         o7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pa5agJuMNZ6TOStPvOjFrUx0wrZJLT/PiWkjO94VFik=;
        b=YfzlglpNkTrLy2rWnQMKgW4jH5GhbLzWADZvR5sGYeENp0CdTEPfxWbR6Nk20N7IGO
         CmXrx/82S/R69REydgr5GaIN3hkGJqaNkg7HggA9C0epUuVRcbCk1YYUi/361GbVnKmL
         NCreUd13j3u+t74rMNj4Ud7VQAQdabohEXh8sgG7FhzG8UKcXco1BTZHV/NcVLQc6kU0
         n3V30HC0DlzEZCEb50lR3XkrbPaRVBKb1A3o0lF5+87Ea6IL5mB7QP1jKCTZBEME3+Tv
         pNM2IytadOU/1SfGCz7P+Rjb/sd6EQSt2ZM34xKfZKsD+ltIUrlInRz3Bdw3vYmzxSk5
         DWsw==
X-Gm-Message-State: APjAAAV07hcsWTl1bGT6UdeaONaCls9x2UHAF3rX39y+WRvmTgEtKXbA
        k5O+KCoovMkbWgMtuEb2FTU=
X-Google-Smtp-Source: APXvYqxvjffOQdzdqu4SWl8CR5ZmXna+bAHqGQX3t25/H3XxWpVPkCkR9ZzBb/eTaCG4ATHEEsroGg==
X-Received: by 2002:a17:906:24ca:: with SMTP id f10mr14376929ejb.240.1551740062636;
        Mon, 04 Mar 2019 14:54:22 -0800 (PST)
Received: from ltop.local ([2a02:a03f:4034:3c00:d42a:f12f:aba6:97a4])
        by smtp.gmail.com with ESMTPSA id z23sm2481994edz.50.2019.03.04.14.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 14:54:21 -0800 (PST)
Date:   Mon, 4 Mar 2019 23:54:20 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Monk Liu <Monk.Liu@amd.com>, Emily Deng <Emily.Deng@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix typing in amdgpu_virt_ops::trans_msg
Message-ID: <20190304225419.7j5iiqrqm7msyvd7@ltop.local>
References: <20190304131000.17994-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304131000.17994-1-luc.vanoostenryck@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 02:10:00PM +0100, Luc Van Oostenryck wrote:
> The method in struct amdgpu_virt_ops::trans_msg() is defined as
> using an 'u32' for its 2nd argument (the request) but the actual
> implementation()s and calls use an 'enum idh_request' for it.
> 
> Fix this by using 'enum idh_request' for the method declaration too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 722deefc0a7e..3e9aec6f2795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -56,7 +56,7 @@ struct amdgpu_virt_ops {
>  	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
>  	int (*reset_gpu)(struct amdgpu_device *adev);
>  	int (*wait_reset)(struct amdgpu_device *adev);
> -	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
> +	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req, u32 data1, u32 data2, u32 data3);
>  };


Sorry, this is patch is incorrect. Please ignore it.

-- Luc
