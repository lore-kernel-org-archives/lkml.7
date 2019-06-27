Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A514C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B642064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K6jcBLWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF0RaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:30:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37350 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0RaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:30:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so1576548pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32ILLvfn9IklGj2iVrOoB65eWBa8/V+GUb3UmuBUZsA=;
        b=K6jcBLWG1PUhzqSS3gXcuJxACOyXxSDQMCT0XZN8LuhrKm7ke/8lCWFT3TJG0dd6gG
         O3yGe+vnV25OBXXgmTNowCZwthRAm6m00sh1Hz7ca0NbI/1lKg1Cp71oaNRWWn8yyt7V
         orGQZqCWs6YR3Qos6+QwPOHsh6ZCIF2lZ1B6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32ILLvfn9IklGj2iVrOoB65eWBa8/V+GUb3UmuBUZsA=;
        b=eyegVTAeSvk5ThknLydkN5N54dTkO/2wUnw1WcA7iLquGPeAA6q7rHlkE+7HyM0tb8
         /QiWMG74dQiMQ22Wz9rJ9IWgFEbaAelsm+I8868BMyXj6T7ReFXLJuEEe9Qi7ncOZrPi
         TWrADYbQLKl8GnmG0yw6H9fEsA0CSCYNajRiJO2VQSgczu9gI1VA5XezLe3dGD7RAw1m
         xiSYhhoBo9IRz0kQCVsplQLy3xNfQfiiqSsWE5NnUvh5m17p84toE9BnTkzoxEQn/LkD
         KuXra8XtOyeI/2ROOpPhnlt3vrMuyYgyem6tJRUXGNg2nZonc/UmSUU9q252DzJlp8ox
         +nCA==
X-Gm-Message-State: APjAAAURuqqOhflZ9UytHDBgEXApsudDw0MwOCgG7gl0Drpg8PRxKnbJ
        2D3hC3RntjSho/vBY69y8r35yA==
X-Google-Smtp-Source: APXvYqw1+Ez9GlBN2zSdaHnaMFOkEGvFA7MS5ndE0eMDT+bi5WLehm+duqxlqw2K/XKlRkTKlp7HkQ==
X-Received: by 2002:a65:5303:: with SMTP id m3mr4673738pgq.393.1561656615934;
        Thu, 27 Jun 2019 10:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm3683446pfn.3.2019.06.27.10.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:30:15 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:30:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 7/8] x86/vsyscall: Add __ro_after_init to global
 variables
Message-ID: <201906271030.A5C7F4A202@keescook>
References: <cover.1561610354.git.luto@kernel.org>
 <a386925835e49d319e70c4d7404b1f6c3c2e3702.1561610354.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a386925835e49d319e70c4d7404b1f6c3c2e3702.1561610354.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:45:08PM -0700, Andy Lutomirski wrote:
> The vDSO is only configurable by command-line options, so make its
> global variables __ro_after_init.  This seems highly unlikely to
> ever stop an exploit, but I think it's nice anyway.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/entry/vsyscall/vsyscall_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 9c58ab807aeb..07003f3f1bfc 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -42,7 +42,7 @@
>  #define CREATE_TRACE_POINTS
>  #include "vsyscall_trace.h"
>  
> -static enum { EMULATE, XONLY, NONE } vsyscall_mode =
> +static enum { EMULATE, XONLY, NONE } vsyscall_mode __ro_after_init =
>  #ifdef CONFIG_LEGACY_VSYSCALL_NONE
>  	NONE;
>  #elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
> @@ -305,7 +305,7 @@ static const char *gate_vma_name(struct vm_area_struct *vma)
>  static const struct vm_operations_struct gate_vma_ops = {
>  	.name = gate_vma_name,
>  };
> -static struct vm_area_struct gate_vma = {
> +static struct vm_area_struct gate_vma __ro_after_init = {
>  	.vm_start	= VSYSCALL_ADDR,
>  	.vm_end		= VSYSCALL_ADDR + PAGE_SIZE,
>  	.vm_page_prot	= PAGE_READONLY_EXEC,
> -- 
> 2.21.0
> 

-- 
Kees Cook
