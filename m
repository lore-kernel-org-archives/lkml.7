Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF47C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BCD206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rf1ilzbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfFVXwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:52:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41556 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFVXwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:52:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so5418608pff.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YImUcuCexeZRlvHVuEgl97R534Yty3oYIKuuE0evjLk=;
        b=Rf1ilzbL8+AgDuWH99sFiAoQpznSrapYKr9e8FEnSk7XhDnhFa72A9R2QKmy5EsDti
         28WtmVru9dtkuS8r3liYz5SjTg/EOFEPjlrzRRJX1Ws6+XX8jAgvQa6/VPUjZ47J4NZd
         qDPfxj0XwdlC5iYG/DtFnJN1puMtJ4LVADSe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YImUcuCexeZRlvHVuEgl97R534Yty3oYIKuuE0evjLk=;
        b=ItIlNAtBKm7gMfqOGKu/bOEaoWXmM7J64TByDA1c2fjrghzh1o2Rcmum7lpASwzY4F
         UYkIpyDbdMbnl10OHOfUBrymZZm8VXm4/XDluL5Zqg1tsogWtLQHIRugaV7kLfvoKng2
         O+RRuHBIYpAceMvTi8ex0pVtKIfNzYKZNgFBu2b03hWXgKS3Ia5FsadNAPQhUyLFOobi
         BUdwo3O4IMeeu57cGYC6EBfdr2c9yKHDR1t50BzqfLClcOEAiHqAlrv0rXcTe7dXniap
         KYBN2xAnrHbpRRFMVLaX8ux3cZ0vzIzO12t7Lrv1VuTOCifJParb/gf493tThK3OO/Np
         B0Jw==
X-Gm-Message-State: APjAAAVEgG+7P0eUYo7Ezuht4h7ElysJCYB1JPbM9wwYPpQVKB5uW+Av
        jxEa/yUL4oZ+iA9Z2AIJgSWHbj0j5VM=
X-Google-Smtp-Source: APXvYqyZbf1k8nXLguShO8CcJZ0g/jEwuvxkTVmi1wi9zDTPNu8HEZNYcrRBr8lKX5YNCq494+RqeQ==
X-Received: by 2002:a17:90a:3590:: with SMTP id r16mr15677484pjb.44.1561247562065;
        Sat, 22 Jun 2019 16:52:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o13sm6826679pje.28.2019.06.22.16.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:52:40 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:52:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, x86@kernel.org
Subject: Re: [PATCH V34 05/29] Restrict /dev/{mem,kmem,port} when the kernel
 is locked down
Message-ID: <201906221648.F8F0741@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-6-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-6-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:34PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> Allowing users to read and write to core kernel memory makes it possible
> for the kernel to be subverted, avoiding module loading restrictions, and
> also to steal cryptographic information.
> 
> Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
> been locked down to prevent this.
> 
> Also disallow /dev/port from being opened to prevent raw ioport access and
> thus DMA from being used to accomplish the same thing.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: x86@kernel.org
> ---
>  drivers/char/mem.c           | 6 +++++-
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index b08dc50f9f26..93c02493f0fa 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -29,8 +29,8 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/uio.h>
> -
>  #include <linux/uaccess.h>
> +#include <linux/security.h>
>  
>  #ifdef CONFIG_IA64
>  # include <linux/efi.h>
> @@ -786,6 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
>  
>  static int open_port(struct inode *inode, struct file *filp)
>  {
> +	int ret = security_locked_down(LOCKDOWN_DEV_MEM);
> +
> +	if (ret)
> +		return ret;
>  	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;

Usually the ordering for LSM tests tends to follow capable checks, which
allows for things like audit to generate logs for capability rejections,
etc. I'd expect this to be:

	if (!capable(CAP_SYS_RAWIO))
		return -EPERM;

	return security_locked_down(LOCKDOWN_DEV_MEM)

With that fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  }
>  
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 46d85cd63b06..200175c8605a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -83,6 +83,7 @@ enum lsm_event {
>  enum lockdown_reason {
>  	LOCKDOWN_NONE,
>  	LOCKDOWN_MODULE_SIGNATURE,
> +	LOCKDOWN_DEV_MEM,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 25a3a5b0aa9c..565c87451f0f 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -19,6 +19,7 @@ static enum lockdown_reason kernel_locked_down;
>  static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_NONE] = "none",
>  	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
> +	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
