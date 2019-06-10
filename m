Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE290C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85767206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bb8kTA6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbfFJUn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:43:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43162 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfFJUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:43:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so5952110pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gGkvTXexIvtGceUSn9utzUe5r2LZ4KzdTUdP48ifM+M=;
        b=Bb8kTA6m4nCVFqOZtIEow9B13diQQNAYO8m9rlqG++JOoSNrXLWXby9ed3Bni8SyO1
         bq6hT7oA7piaplqbJyrPVSnzDlVIh+ZOAWXVQ2dZ80jC1vxUnBIWgrLFhzzmqzKjchm7
         Is84tMr3rRtCEV29RhB4YU6BwQ8ZLetMaY8RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gGkvTXexIvtGceUSn9utzUe5r2LZ4KzdTUdP48ifM+M=;
        b=ReyhGZRTHIYBPy3/rnMQygn3MJxQUES+C58UsL1huCsG28H4CpS4FXIdClzqqcnqE4
         LkSa9YP5H0tm0TGyjIhBfPsiDD4To3B1rY6WhlEJC47hsj+h4YX1x7P5qQ9ZmXRyWgVU
         2qx+W/jUrpUlGrX98kelpAN5Afceyd7Wdys5BpvAK9wU2sw5lc+H42jLqJLyqvPbfBLV
         IDKpOirZedCTZDSWlwXzfoD0ZYT0FtFi582ddpJzqjdTaw6JQqqziXMsUpIOalB99APQ
         W8blDgqEHXYiU0C/oJOvxX0tWhZ8RqFwLiIOt/pVyTpNPyY6i3ldBF3M2wFcAIw+V2sZ
         mxWw==
X-Gm-Message-State: APjAAAUT4Lq6CJiWVyv107CCUJhNrygd/IL2oeZ3dOgcRBjOeul72+NQ
        lTTSowoPbyTjODwj8iCkvmsZ4g==
X-Google-Smtp-Source: APXvYqy7M61GS3qaZ6++vW5tfTL75JMbeYx+TwRj+kwl4qiCMPZwUchxHuhnjBXiQZmwgvCv0DGxvg==
X-Received: by 2002:a17:90a:f488:: with SMTP id bx8mr22845554pjb.91.1560199437374;
        Mon, 10 Jun 2019 13:43:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e22sm9651308pgb.9.2019.06.10.13.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 13:43:56 -0700 (PDT)
Date:   Mon, 10 Jun 2019 13:43:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/5] x86/vsyscall: Add a new vsyscall=xonly mode
Message-ID: <201906101342.B8A938BB@keescook>
References: <cover.1560198181.git.luto@kernel.org>
 <131caabf9d127db1a077525f978e1f1f74f9088f.1560198181.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131caabf9d127db1a077525f978e1f1f74f9088f.1560198181.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 01:25:28PM -0700, Andy Lutomirski wrote:
> With vsyscall emulation on, we still expose a readable vsyscall page
> that contains syscall instructions that validly implement the
> vsyscalls.  We need this because certain dynamic binary
> instrumentation tools attempt to read the call targets of call
> instructions in the instrumented code.  If the instrumented code
> uses vsyscalls, then the vsyscal page needs to contain readable
> code.
> 
> Unfortunately, leaving readable memory at a deterministic address
> can be used to help various ASLR bypasses, so we gain some hardening
> value if we disallow vsyscall reads.
> 
> Given how rarely the vsyscall page needs to be readable, add a
> mechanism to make the vsyscall page be execute only.

Should the commit log mention that the VVAR portion goes away under
xonly? (Since it's not executable.)

Otherwise, yay! Looks good to me and thanks for updating the selftests!

-Kees

> @@ -357,7 +368,7 @@ void __init map_vsyscall(void)
>  	extern char __vsyscall_page;
>  	unsigned long physaddr_vsyscall = __pa_symbol(&__vsyscall_page);
>  
> -	if (vsyscall_mode != NONE) {
> +	if (vsyscall_mode == EMULATE) {
>  		__set_fixmap(VSYSCALL_PAGE, physaddr_vsyscall,
>  			     PAGE_KERNEL_VVAR);
>  		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> -- 
> 2.21.0
> 

-- 
Kees Cook
