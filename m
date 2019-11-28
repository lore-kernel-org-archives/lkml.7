Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE8BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A039121781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574969105;
	bh=u5IWqduxjDe6iEdQ1DSwk83KBgXgeVONII2/+OP7fTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NhWr34EjEIFIARWVnOpWgJFA+viDvlRJ/OD4XYDEOjpOHwSnf/hWHkTzQr8xxuj+U
	 Xb1LQdTFWPvNXCnOMgmJI0Q5OlqhK06Id2ZbRHQufaFE0PGP+7AiZQGuw7fabs9A9O
	 QJdnrKCAaXa/BSn2oulM+SqKilSUAiOi7nxuF268=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfK1TZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:25:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37305 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfK1TZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:25:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so20809471lfp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZsnKc3g5fDTaGiejE7r1Q2K/HU4vGwibJmTL3Kxzh8=;
        b=AARO3KUA0Ed9Lzp/XDCbJWlA2wX/oQNuxqPR3MrxpmJyIu7GQW/8QbZAhZyDVn3Eh8
         0Ak/kGhIhnfiLyEpsrgu5xOPnslYQreyJFs5/a/HKD6sDqmSqdp3dLzq+VjO2p3QxHIt
         yBGSGjJePXKf3q5cbuKWZ72BxI/e3CHE70jvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZsnKc3g5fDTaGiejE7r1Q2K/HU4vGwibJmTL3Kxzh8=;
        b=Bf9ngpt5+a2HTMYzL58dYSzek33EFXdxSCGShgrS63gsO47EO6ZYH7rlOsH7QAs5vY
         9WU+QUVFU5o0CO/jFq6fF+cL8BezqAcb3QNSE+VaLZH3UJAT/RhM3yh65+bnfhAxRXhw
         CU21Z0Q+K7SRAwDxLQZ39XW+rsBpQTqPd3fmRaFW4x8JIGuznVwsVZp2JrMobbw/xg0V
         F6yOAoDj1+b+ez8wrroHvm2ompC5pMPEIwmrKpz82McgFCtKYhc1u12IaiqdYaMSLeST
         k8nhIDFFZ5IMuV2KGhbyNqHSQ8RpKtLWnruHkc6vKIvpSDH4v5QQrMAkRNDmru2RDHKz
         eEOg==
X-Gm-Message-State: APjAAAWfZgyKMT+L9fHmgC0XExjoxl5uWTju0HLdKZhkQ+6IjwHhbw1n
        Z/OQJEKdWIXE4si6WNje4CvYyQP/I7g=
X-Google-Smtp-Source: APXvYqwHpCpa74ghmy+nnJV+qc0XxwIzXrx2B3Rjn5qugE+4PH+G+LxXOzQGgOTcW5+h/T4bKBd2PQ==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr27476042lfp.162.1574969101137;
        Thu, 28 Nov 2019 11:25:01 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id m9sm58068lfj.57.2019.11.28.11.24.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:25:00 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id k8so18999321ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:24:59 -0800 (PST)
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr35381421ljs.26.1574969099676;
 Thu, 28 Nov 2019 11:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20191126110659.GA14042@redhat.com> <20191126110758.GA14051@redhat.com>
 <CAHk-=whrhuNg_53wc3pBVToH-AUwKDbC5P_cb7=8bYfn=BYCJA@mail.gmail.com>
 <20191127170234.GA26180@redhat.com> <CAHk-=wi9YO5M-LHuTuczQbK6hBrweCoZHVEsiTak6jGuoFt2Sw@mail.gmail.com>
 <20191128153644.GA5508@redhat.com>
In-Reply-To: <20191128153644.GA5508@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Nov 2019 11:24:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whA1h-7MKGdzyViwJR4_rqYKMP91FwuObWneBZE0yH81A@mail.gmail.com>
Message-ID: <CAHk-=whA1h-7MKGdzyViwJR4_rqYKMP91FwuObWneBZE0yH81A@mail.gmail.com>
Subject: Re: [PATCH] ptrace/x86: introduce TS_COMPAT_RESTART to fix get_nr_restart_syscall()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 7:36 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> You misunderstood my question, I do not see a good place for the code
> above. So I am going to uglify */signal.[ch] files.

Ahh, ok, I thought that was kind of understood.

> --- a/arch/x86/include/asm/signal.h
> +++ b/arch/x86/include/asm/signal.h
> @@ -5,6 +5,10 @@
>  #ifndef __ASSEMBLY__
>  #include <linux/linkage.h>
>
> +struct restart_block;
> +extern void arch_set_restart_data(struct restart_block *);
> +#define arch_set_restart_data  arch_set_restart_data

I'd just replace this with

   /* We need to save TS_COMPAT at the time of the call */
   #define arch_set_restart_data(blk) (blk)->arch_data =
current_thread_info()->status

or something like that.

               Linus
