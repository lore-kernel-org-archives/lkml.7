Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E0DECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787032067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2jVvEnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfJJVx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:53:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39020 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:53:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so3441249plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eZ5a1UrQhKc0eFrayHNWPPaPzIDNm8Pl4fc7UtzEcwI=;
        b=C2jVvEnjI3cDO6vB/Rft3tcJex85MLNmn0DKywgUaA+JqHl5XVj8PXi/cisN6F6y3c
         jEyND9KgFacuQi0DUApP9FWNA9RdjSaH2p6/y3f9VUjJTyU7C7G4tqBJKEoaMJdm2xc7
         cC3Xwkvz83wYVon/M1YaWoXbhEZ1L27sCVrzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZ5a1UrQhKc0eFrayHNWPPaPzIDNm8Pl4fc7UtzEcwI=;
        b=FnQhSbGS2fYd0hjy5lmQDGf6hRHvyRxIXtrypRkwnf0upwqW8lo3eKaVOZAsTFXY6N
         A0DpjuSWmend0D6dpom7BFItob3dvrRihsSS1Fe+lAsp1WJiGe7H1zDMbGMZ51fdsTIt
         jb2BDJANMgMd1mVL+0pxNQIT4bPJMiHGZLGHAGT4R11BXtEGVZkUruDQ9fZB7hLfntwU
         guuffU1C8e7xpwdRaKg0z0/+O3cTl/BMzID+cL/CAqstvF0dGA7hllkFKiAL8an7V4So
         Obcx3CkS7UEy2pfIFZNheQpr80LCYhsGO0cE5tbvK4h0aHow0yLzclgnkgEMwJFDFBhW
         Epqw==
X-Gm-Message-State: APjAAAXVh7nvwdwt5XeoW0Af/FhS87lcUOH/DW+Mikoh+jwyOK2m9UsA
        5PgPAkIhs/EsaFFJhq/QSKe/Pw==
X-Google-Smtp-Source: APXvYqzvP9DPNQm4eEFwpmDjtjMePiabTkC2OLVsNO4cce1OJAtguBuNxerHNmLTKublc5lHaVGkBg==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr11153280plo.341.1570744406496;
        Thu, 10 Oct 2019 14:53:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm23629pfr.118.2019.10.10.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:53:25 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:53:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, luto@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, wad@chromium.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1] seccomp: simplify secure_computing()
Message-ID: <201910101450.0B13B7F@keescook>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190924064420.6353-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924064420.6353-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:44:20AM +0200, Christian Brauner wrote:
> Afaict, the struct seccomp_data argument to secure_computing() is unused
> by all current callers. So let's remove it.
> The argument was added in [1]. It was added because having the arch
> supply the syscall arguments used to be faster than having it done by
> secure_computing() (cf. Andy's comment in [2]). This is not true anymore
> though.

Yes; thanks for cleaning this up!

> diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
> index ad71132374f0..ed80bdfbf5fe 100644
> --- a/arch/s390/kernel/ptrace.c
> +++ b/arch/s390/kernel/ptrace.c
> @@ -439,7 +439,7 @@ static int poke_user(struct task_struct *child, addr_t addr, addr_t data)
>  long arch_ptrace(struct task_struct *child, long request,
>  		 unsigned long addr, unsigned long data)
>  {
> -	ptrace_area parea; 
> +	ptrace_area parea;
>  	int copied, ret;
>  
>  	switch (request) {

If this were whitespace cleanup in kernel/seccomp.c, I'd take it without
flinching. As this is only tangentially related and in an arch
directory, I've dropped this hunk out of a cowardly fear of causing
(a likely very unlikely) merge conflict.

I'd rather we globally clean up trailing whitespace at the end of -rc1
and ask Linus to run some crazy script. :)

So, with that hunk removed, I've applied this to for-next/seccomp. :)

Thanks!

-- 
Kees Cook
