Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF41DC47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4B820835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PzUlYZNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfJHAoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 20:44:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42530 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJHAoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:44:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so7671733pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 17:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=trN9p3zclD944pvbb9tZbZNaEC++2nqbN3BsYHyRgOw=;
        b=PzUlYZNoVhkmjCptNa1nlzSUgMSP2rV6Ged4hfsi4S/xvDv/je1v8bY47TUWb+Yg2R
         XNpcAAQvMk4haiMNXCZ9Huy3tnKvTR/1SUmwdR41vqSYz8rGX8S2Kq/ANkPVhozxc6rw
         tmUe5yROO9KXOMlfLfvmRhvoBalPs5vR2rlPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=trN9p3zclD944pvbb9tZbZNaEC++2nqbN3BsYHyRgOw=;
        b=YFEdWowoZK+m2wD8N83jDc2cXBi1dc8fee4iWhz2IolxNjHhvRRZaQiQ5i11Th1IOv
         KziXCBhtNP96S+GrENr2Sc/xe6fsgOvsVf56R+hFLLNIshUiJWsLQzQnwiN/jISSIbOP
         rASQRdf9UCwu+1bot684Lg8YSEBEiSVeOnFb7EhU/ZTdfpsqEWMjS98VW3S6aB6O0Y8p
         x+qQgznw2ZNB3luFbe1m3s6QqOYoFp98JpRBGLlUXlsJmS2eKzk3tELZshuHjqzsC+Gv
         uzZr+QfJhpQ7pptehMpSmWKxar/PpDLy76QuLVoyil9T/rpEKaDBDgDrIYBO9X3sIFLy
         kUeQ==
X-Gm-Message-State: APjAAAUyar6mFyWZPZCmPwEkigXaNsMTAe7m+tu6LOow4RRQAPkujWoE
        3cWCldYbtwgoIJlAMvRUpBsoEQ==
X-Google-Smtp-Source: APXvYqzdJ/mhSn1BTB6qLFnsFwXt58tmYyMdG0quBKYRMfINxm+iXPMLqKu0taAuGj52o3zV8GHdQw==
X-Received: by 2002:a17:902:6b88:: with SMTP id p8mr22772868plk.74.1570495457346;
        Mon, 07 Oct 2019 17:44:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm17744104pfn.150.2019.10.07.17.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 17:44:15 -0700 (PDT)
Date:   Mon, 7 Oct 2019 17:44:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>, pv-drivers@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86/cpu/vmware: use the full form of inl in VMWARE_PORT
Message-ID: <201910071743.1C48038A@keescook>
References: <20191007192129.104336-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007192129.104336-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 12:21:29PM -0700, Sami Tolvanen wrote:
> LLVM's assembler doesn't accept the short form inl (%%dx) instruction,
> but instead insists on the output register to be explicitly specified:
> 
>   <inline asm>:1:7: error: invalid operand for instruction
>           inl (%dx)
>              ^
>   LLVM ERROR: Error parsing inline asm
> 
> Use the full form of the instruction to fix the build.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/kernel/cpu/vmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 9735139cfdf8..46d732696c1c 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -49,7 +49,7 @@
>  #define VMWARE_CMD_VCPU_RESERVED 31
>  
>  #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
> -	__asm__("inl (%%dx)" :						\
> +	__asm__("inl (%%dx), %%eax" :					\
>  		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
>  		"a"(VMWARE_HYPERVISOR_MAGIC),				\
>  		"c"(VMWARE_CMD_##cmd),					\
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

-- 
Kees Cook
