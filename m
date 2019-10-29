Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A63CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF0E20659
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UptlDa50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfJ2XgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:36:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39041 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJ2XgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:36:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so169123pgn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pO5EP9I+LBxB7yIlj2s2YUsswQ7j2e2u16gjfNSXk60=;
        b=UptlDa50f1JAlt+aS7I4OkBsE2baetlINAb8Lq8yFR96Izhi8NnFnTPbq9c0ob3/uP
         oC+KuRvVRF7Y6/E03mE4kuJE1J9n5saEvqk2igqnDlzdpkY/l5n6kdpAkPwGQs01WTxF
         zMzz0sZ7T7nf4oU10cPjUR4Nof3EPxt55B4UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pO5EP9I+LBxB7yIlj2s2YUsswQ7j2e2u16gjfNSXk60=;
        b=no24WfglrwHYDU37fFML69fHjJED+ZpeQWUvFy/nvMl4nzKZ3SxUfuKLY34/Ho+oSx
         +pMmcDNhbodSaIrcrBbXT+m6LShQuPU0cLtz1lcz4rNSB4Ijz2k7YOOqBEeFKcE2zKnX
         c+WFf4bElNOZnClVr4fKxfQ8mM/UXFEGz3KMWxdOEb+ktCJiwau/1Vw/l0uv3BhBBiG2
         dBht/Pjp/pU7cxxcRepkwOPhCPJVwPhhta36xx1U4dXAFd+l6yjC64S+sybRdRgFivVe
         tgFI+jZ0msYQCq8FIB29AuS5vJzLnkmFrBk2qoABkEpVwa9GyiNqi1a+p1HHVCeKPG56
         Lmgw==
X-Gm-Message-State: APjAAAXCxjJKgJ0+hPWubJBec8HJQ8tpOlJ4FIBhVD8r/+AecZFdnJ/m
        asPwUV88TyeL0oV53pXxRstpWA==
X-Google-Smtp-Source: APXvYqyjQn11mGF5URB+KSojLfEtrQjFMKKR2s9mheYyNy4PKJHiwiJWMMvBfilUsEyYDXaGBmEnZg==
X-Received: by 2002:a17:90a:1424:: with SMTP id j33mr10347220pja.2.1572392176869;
        Tue, 29 Oct 2019 16:36:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e3sm211440pff.134.2019.10.29.16.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:36:16 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:36:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@kvack.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, kristen@linux.intel.com,
        deneen.t.dock@intel.com
Subject: Re: [RFC PATCH 13/13] x86/Kconfig: Add Kconfig for KVM based XO
Message-ID: <201910291634.7993D32374@keescook>
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
 <20191003212400.31130-14-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003212400.31130-14-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 02:24:00PM -0700, Rick Edgecombe wrote:
> Add CONFIG_KVM_XO for supporting KVM based execute only memory.

I would expect this config to be added earlier in the series so that the
code being added that depends on it can be incrementally build tested...

(Also, if this is default=y, why have a Kconfig for it at all? Guests
need to know to use this already, yes?)

-Kees

> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/Kconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 222855cc0158..3a3af2a456e8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -802,6 +802,19 @@ config KVM_GUEST
>  	  underlying device model, the host provides the guest with
>  	  timing infrastructure such as time of day, and system time
>  
> +config KVM_XO
> +	bool "Support for KVM based execute only virtual memory permissions"
> +	select DYNAMIC_PHYSICAL_MASK
> +	select SPARSEMEM_VMEMMAP
> +	depends on KVM_GUEST && X86_64
> +	default y
> +	help
> +	  This option enables support for execute only memory for KVM guests. If
> +	  support from the underlying VMM is not detected at boot, this
> +	  capability will automatically disable.
> +
> +	  If you are unsure how to answer this question, answer Y.
> +
>  config PVH
>  	bool "Support for running PVH guests"
>  	---help---
> -- 
> 2.17.1
> 

-- 
Kees Cook
