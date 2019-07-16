Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A51C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB51221721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iq/IVh/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfGPJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:24:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46985 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:24:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so18904968edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDo+eWmhtTV8VZruvHAv9SmmLeaVvLllVnL2EEq/1Fw=;
        b=iq/IVh/fNvRMT2I9A/QNh3+yF9u1UrtSDEE5nlnN+E5wSnoO0g8wujwp5DraAOQj/x
         q5ZQk9jMRIJtDPWbNs+Izn/+LI6GHhvfmto8XV0lysvrvb8FbU/q8d4q5AGPN8XyAd/u
         I4HdbEX6UxulgC3MXpsn84QXNdagfDvs/QeV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zDo+eWmhtTV8VZruvHAv9SmmLeaVvLllVnL2EEq/1Fw=;
        b=KEKUJT/gox7bgc3k/VHGrKIussKT5zxkEp0NzcDccQfZhMpQ7Id4MLq6rX+RGJ6AVW
         oVjDBb4+3SBnpVZkAnyRbvZ4h+vp8ts3Du+YMG6f24yDhRFjiBXLGieHEQEQrSmPkk+F
         sBSFCYrpOpqgyhkhDSS+hRCDGmUkUFw3oaoP2tbS5JgKGddTbBwWd5px215ODpLkEjyz
         fZikrxTkJQDniQ0viXYB7ggUCstodfeMUoIiQv4ZVhQ8jm9Ilq5HTiQXyibPdeDaMpWC
         GCzMGgHQEQT5w3SBNdi2IPX6K4d4LRX0e9h5DSqFPblJw/ONIejOHCjZeGDSMemMi9To
         NaSQ==
X-Gm-Message-State: APjAAAW8d12FoOdgMCPnCoJJ5XHgV6eX4zgrb90Q6Hm8LdoMgbfsDWJR
        GlRDPEw8Nt5tqdqLKayp4GU=
X-Google-Smtp-Source: APXvYqy8TYWGSmoRD93Iah2eYrZZToh7cQL4GAdEZ/YgeilZWr9vJGPiBFDokpEWtB6tW8xCnLaPDQ==
X-Received: by 2002:a50:9999:: with SMTP id m25mr28327908edb.183.1563269095678;
        Tue, 16 Jul 2019 02:24:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k8sm5739035edr.31.2019.07.16.02.24.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 02:24:55 -0700 (PDT)
Date:   Tue, 16 Jul 2019 11:24:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qian Cai <cai@lca.pw>
Cc:     emil.l.velikov@gmail.com, maarten.lankhorst@linux.intel.com,
        maxime.ripard@bootlin.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu/drm: fix a few kernel-doc "/**" mark warnings
Message-ID: <20190716092453.GA15868@phenom.ffwll.local>
Mail-Followup-To: Qian Cai <cai@lca.pw>, emil.l.velikov@gmail.com,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1563198173-7317-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563198173-7317-1-git-send-email-cai@lca.pw>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 09:42:53AM -0400, Qian Cai wrote:
> The opening comment mark "/**" is reserved for kernel-doc comments, so
> it will generate warnings for comments that are not kernel-doc with
> "make W=1". For example,
> 
> drivers/gpu/drm/drm_memory.c:2: warning: Cannot understand  * \file
> drm_memory.c
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to drm-misc-next for 5.4.
-Daniel

> ---
>  drivers/gpu/drm/drm_agpsupport.c  | 2 +-
>  drivers/gpu/drm/drm_dma.c         | 2 +-
>  drivers/gpu/drm/drm_legacy_misc.c | 2 +-
>  drivers/gpu/drm/drm_lock.c        | 2 +-
>  drivers/gpu/drm/drm_memory.c      | 2 +-
>  drivers/gpu/drm/drm_scatter.c     | 2 +-
>  drivers/gpu/drm/drm_vm.c          | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_agpsupport.c b/drivers/gpu/drm/drm_agpsupport.c
> index 40fba1c04dfc..ef549c95b0b9 100644
> --- a/drivers/gpu/drm/drm_agpsupport.c
> +++ b/drivers/gpu/drm/drm_agpsupport.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file drm_agpsupport.c
>   * DRM support for AGP/GART backend
>   *
> diff --git a/drivers/gpu/drm/drm_dma.c b/drivers/gpu/drm/drm_dma.c
> index 3f83e2ca80ad..cbfaa2eaab00 100644
> --- a/drivers/gpu/drm/drm_dma.c
> +++ b/drivers/gpu/drm/drm_dma.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file drm_dma.c
>   * DMA IOCTL and function support
>   *
> diff --git a/drivers/gpu/drm/drm_legacy_misc.c b/drivers/gpu/drm/drm_legacy_misc.c
> index 2fe786839ca8..745eb9939414 100644
> --- a/drivers/gpu/drm/drm_legacy_misc.c
> +++ b/drivers/gpu/drm/drm_legacy_misc.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file drm_legacy_misc.c
>   * Misc legacy support functions.
>   *
> diff --git a/drivers/gpu/drm/drm_lock.c b/drivers/gpu/drm/drm_lock.c
> index b70058e77a28..2610bff3d539 100644
> --- a/drivers/gpu/drm/drm_lock.c
> +++ b/drivers/gpu/drm/drm_lock.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file drm_lock.c
>   * IOCTLs for locking
>   *
> diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
> index 132fef8ff1b6..d92f24c308a1 100644
> --- a/drivers/gpu/drm/drm_memory.c
> +++ b/drivers/gpu/drm/drm_memory.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file drm_memory.c
>   * Memory management wrappers for DRM
>   *
> diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> index bb829a115fc6..b6d863699d0f 100644
> --- a/drivers/gpu/drm/drm_scatter.c
> +++ b/drivers/gpu/drm/drm_scatter.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file drm_scatter.c
>   * IOCTLs to manage scatter/gather memory
>   *
> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> index 10cf83d569e1..6c74c68f192a 100644
> --- a/drivers/gpu/drm/drm_vm.c
> +++ b/drivers/gpu/drm/drm_vm.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file drm_vm.c
>   * Memory mapping for DRM
>   *
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
