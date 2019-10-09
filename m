Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C171AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CE82133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="adk4q/LA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfJIKkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:40:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36398 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:40:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id h2so1572900edn.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pu7YyA32IAxSpGaf7UJZEaSuEYYlTRI6oCWAxFzbJXY=;
        b=adk4q/LAAbwwFzgWpWMggclWXes1NLlMfwEAu7/GRAECCtq0szTh+ZGk69R3LGBtPs
         n4RyZaacxk/cxSmShZLOjt8g7scuRr2iymwZ00dLTV+rtUYTDLcnulhQ/bmdubzPubQC
         Co+98zwwlg32faR9RwAR/awjgX162VhOr8Dgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pu7YyA32IAxSpGaf7UJZEaSuEYYlTRI6oCWAxFzbJXY=;
        b=ekdSw677bcbensFZAWNRl4A3DkMiA/Mu2+ax4MrmVc2/MRJqwIThVmbMEINUOrJcEo
         dyYmAIRs+N/wj/uWXVelhPhWAbw0JwY/Bj7iSdxxcwO5lZQq3sZDDou8q/986Da77GLk
         Us426IrI9t/PGmVXDCB9OIZW6FWl58/xnJlJzfljqG3y6cB5nGgdw8n6C7HpTmzsJCuE
         pShTfBF/EhDn4pWnYvu6lZPSiWtFchvis6H1DsUYRDTpqfTW4EpNVUYNaX6iBrhq/TyQ
         dCjihIjj5LcCd8+qwC8y03dev+OQ7bnivqaALNV6tESrvhmyCQy+98BLBgc21d+iiAol
         e1Pw==
X-Gm-Message-State: APjAAAUeI/n36hrpl8XF0Pu99lxs+tjeQqPSw5k2l+vpyyaNaIHOIGY9
        zgY9OhnClgB7pMwXVvgGPOE49w==
X-Google-Smtp-Source: APXvYqwyGOINerZEr5dHBn3PNkXe0aIw+CM4KDKXiIPYgSTADOGQMh/xYZcxW5vRZMAyYKZIEzcc7g==
X-Received: by 2002:a17:906:3488:: with SMTP id g8mr2062845ejb.162.1570617605611;
        Wed, 09 Oct 2019 03:40:05 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id i63sm293464edi.65.2019.10.09.03.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:40:04 -0700 (PDT)
Date:   Wed, 9 Oct 2019 12:40:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/vkms: Fix an undefined reference error in
 vkms_composer_worker
Message-ID: <20191009104002.GV16989@phenom.ffwll.local>
Mail-Followup-To: zhong jiang <zhongjiang@huawei.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1569201883-18779-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569201883-18779-1-git-send-email-zhongjiang@huawei.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 09:24:43AM +0800, zhong jiang wrote:
> I hit the following error when compile the kernel.
> 
> drivers/gpu/drm/vkms/vkms_composer.o: In function `vkms_composer_worker':
> vkms_composer.c:(.text+0x5e4): undefined reference to `crc32_le'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Queued for -next, thanks for your patch.
-Daniel
> ---
>  drivers/gpu/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index e67c194..285d649 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -257,6 +257,7 @@ config DRM_VKMS
>  	tristate "Virtual KMS (EXPERIMENTAL)"
>  	depends on DRM
>  	select DRM_KMS_HELPER
> +	select CRC32
>  	default n
>  	help
>  	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
