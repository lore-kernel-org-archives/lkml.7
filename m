Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE64EC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95879208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cwfKaBCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFVXxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:53:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45137 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfFVXxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:53:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id z19so2156735pgl.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pj2xea0nrESVhzCctZSm0ltVMYO4iJ1nFUvuPkZZ1cI=;
        b=cwfKaBCeOLaOWqp6IJxkI+95fC0wmQC5wx7do5nUz2XIOq8cRNwaNOusbZ9iGsmBG2
         Mb1+BntCt1GJVKZHrfSbcQYnT4ri/gLOelLJuOVNd/eJVXuHDdA72ALZapbzQH8U8k4Y
         SUCysr1x6XvgpthBH6ndYduHLchN7YUxCoAhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pj2xea0nrESVhzCctZSm0ltVMYO4iJ1nFUvuPkZZ1cI=;
        b=KAydMclYYIhNDVK6iP7XfEBmzML7htRJQeuayaDWPTLrcN2FsTfKPv16bH5hDp5BZk
         FQXP6cT+nk7sm8LT2WG1uGZmSfGxqckr8QSbbvmIcJMS1Kr6Csxz751zKhw5QsQOe50M
         mHP4amwz+Bhh2okdeHE9ggb+dDgL+zwSZfdEwPi2RTxS3aXaFfYU+gcdFCNAFPoO1NXs
         UokK+3jx+NLtmE7rmZhVb45PJAE0T36FpMlguzZgwli0oPI8XO7ZmJR+cseme+e1jihV
         PrUNkCeM+sKfxZ6Cw84AQ/EuO+BZ/ha+R2wWtOhABA9Y4ItHO37QW0KS8KSg7Z+RaY6L
         8qrw==
X-Gm-Message-State: APjAAAVfkMKM92ZhE2tEieq9hgbFxn7udXAGrFGKzdiG9Q7/izR6XJut
        0N7Nb076Pqc8YK7+lEh9S+V6og==
X-Google-Smtp-Source: APXvYqy1dvhqp+N85ZUG4C15vsX9JYjrWSjT6BJeOPTBm/LfL799mnOFM3VfqlKAk44zO2lXgY2cOA==
X-Received: by 2002:a63:4e07:: with SMTP id c7mr25738042pgb.350.1561247601114;
        Sat, 22 Jun 2019 16:53:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm7377415pfo.49.2019.06.22.16.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:53:20 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:53:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Subject: Re: [PATCH V34 07/29] Copy secure_boot flag in boot params across
 kexec reboot
Message-ID: <201906221653.DDCB3C898@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-8-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-8-matthewgarrett@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:36PM -0700, Matthew Garrett wrote:
> From: Dave Young <dyoung@redhat.com>
> 
> Kexec reboot in case secure boot being enabled does not keep the secure
> boot mode in new kernel, so later one can load unsigned kernel via legacy
> kexec_load.  In this state, the system is missing the protections provided
> by secure boot.
> 
> Adding a patch to fix this by retain the secure_boot flag in original
> kernel.
> 
> secure_boot flag in boot_params is set in EFI stub, but kexec bypasses the
> stub.  Fixing this issue by copying secure_boot flag across kexec reboot.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: kexec@lists.infradead.org
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 22f60dd26460..4243359ac509 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -182,6 +182,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  	if (efi_enabled(EFI_OLD_MEMMAP))
>  		return 0;
>  
> +	params->secure_boot = boot_params.secure_boot;
>  	ei->efi_loader_signature = current_ei->efi_loader_signature;
>  	ei->efi_systab = current_ei->efi_systab;
>  	ei->efi_systab_hi = current_ei->efi_systab_hi;
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
