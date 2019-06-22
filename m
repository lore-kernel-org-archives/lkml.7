Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5C4C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EB12086A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ir+0iXqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfFVXxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:53:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42133 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfFVXxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:53:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so4771716plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PICVkDCKF9SBFiTMxs5q7Sx1+1o4x5Q3+GA5H81Tneo=;
        b=ir+0iXqVOalSYgdtJfBgUDb+XYb02QjZQLYL30nGIdtelW50JtaMwO6kcaSwRQlt1v
         WtyAwZqNb/Zgi5T9Y4SDSRjK9h1fUmtIjwltjDA+FHsgmScnDc4+qQRbrDXkHqUTATyk
         dR1WcvK7+lI+sifDQPnJj+I2EmVRxvLxhyKrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PICVkDCKF9SBFiTMxs5q7Sx1+1o4x5Q3+GA5H81Tneo=;
        b=E9V1i5SmWNGbrwacfQtSM/9ry+WM0gxtrd5XLHCvRv+62vy7qibxEV+bokeqOOqdsv
         v2zzl4/N019hBDzQVijsQy+2KNHa0i4BhTkbf8zjrCKaqx3dNB9jN+m7jkMj9aZr6sUj
         QH36qbEW5xQZWO7m2PaJ/ryA/4Cz7b4btah4EKIk0Vu+2C2MoSTepkyAgyJeAPwA4iG/
         itwCRlIl0P/uUjXZqI3Z5NQTOsC0iGNfrYPLHsLdRZ7HdPpmsuweSrAnbqLnNg0mJsEP
         FRDElAzOM8SLW455L18gzLs+EE4PwNuvXcPFxlHy7czXvGxQIhSdXYjK09+3fDkpYUqP
         GU8g==
X-Gm-Message-State: APjAAAVEBphnTLNjX7zVXGBnWMi++1MbRynpWOlklL86c+EdVqoyT7Ak
        Q2Y34u2i+dDANsNPiyKdvkHbTw==
X-Google-Smtp-Source: APXvYqyIBsDGTwOJfW9dMkHubASlKIulYQ/ol1kt2GUts1AGrEooXih3+gYBHqTmtRZlebHe+XVDeA==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr61665941plt.289.1561247580963;
        Sat, 22 Jun 2019 16:53:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f197sm6321039pfa.161.2019.06.22.16.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:53:00 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:52:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH V34 06/29] kexec_load: Disable at runtime if the kernel
 is locked down
Message-ID: <201906221652.2268FEE@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-7-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-7-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:35PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> The kexec_load() syscall permits the loading and execution of arbitrary
> code in ring 0, which is something that lock-down is meant to prevent. It
> makes sense to disable kexec_load() in this situation.
> 
> This does not affect kexec_file_load() syscall which can check for a
> signature on the image to be booted.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> cc: kexec@lists.infradead.org
> ---
>  include/linux/security.h     | 1 +
>  kernel/kexec.c               | 8 ++++++++
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 200175c8605a..00a31ab2e5ba 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -84,6 +84,7 @@ enum lockdown_reason {
>  	LOCKDOWN_NONE,
>  	LOCKDOWN_MODULE_SIGNATURE,
>  	LOCKDOWN_DEV_MEM,
> +	LOCKDOWN_KEXEC,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 68559808fdfa..ec3f07a4b1c0 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -207,6 +207,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	if (result < 0)
>  		return result;
>  
> +	/*
> +	 * kexec can be used to circumvent module loading restrictions, so
> +	 * prevent loading in that case
> +	 */
> +	result = security_locked_down(LOCKDOWN_KEXEC);
> +	if (result)
> +		return result;
> +
>  	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 565c87451f0f..08fcd8116db3 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_NONE] = "none",
>  	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>  	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
> +	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
