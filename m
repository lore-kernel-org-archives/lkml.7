Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A94C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA932075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M76lnXAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfDDS4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:56:37 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35136 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfDDS4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:56:35 -0400
Received: by mail-yb1-f195.google.com with SMTP id e12so1446529ybq.2;
        Thu, 04 Apr 2019 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czb2ENwQGWnSQaCPQIrYNCynYy2KSbTtKbmrxk8aiuA=;
        b=M76lnXAHZW3E/8sfPEo6AMsEvKo1Fj2EhqlUI6eC714OKjs2ScEs0g5Kdp16SCqkPF
         N0+X6xTwMiV/VBKBoM8U7lCaiLZf0D5h8H0NYyJsPMWgNRUMOJFoGIeE3Kw2Z03GU9vT
         zVyDQ6CnNyqqWAbFqnkhKqeqcKWpSWW3q20J6IQ+uvd8srIqBj9yOsnXEon9ojIURp4v
         bTLlHhqhnN0+9uDyqXd9PWoJbT4ZfrXOkz5CQF3mN7LEVXFyBxCwjgwaWqj7DMqenuLs
         uXedhWbK9lmCM0WnwBXxlX+/J6awXNP/t6T5RlKFdEob9MOiRhxs9ue2K7i3gYHUzYfA
         pf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czb2ENwQGWnSQaCPQIrYNCynYy2KSbTtKbmrxk8aiuA=;
        b=rqXKHcl0Zbn3levc9Ru8bWjIHmlw/kxTP71nbcwpoJIpi0EfVg91xK5ie08/YaRexx
         IPbGujwn8oD2VLRlR+GUy07P7RTkDAH9MGe/KI4IBBLg3sDD6RYxFrRgxV3Ck+i/ykBZ
         Tnr2aStW9kpZCR50QgctV2jcbQa1fbCbq+Ug/LQah9dgju3JoxRnWOicJi+SZ/A/3gph
         piRSERJJu5pSkCSb0tuYN/Uavqu8KRa/xEvWE20NEMerTTrXkCsb+umGgyZb71dlIUW7
         uSujfiSuxMFWXTG4XqDhldRjnLRcTonA5zfO18InGqva4DDxl7JQ3eOjEKLT5O355LB+
         ZyZw==
X-Gm-Message-State: APjAAAVVgVrvAR8XrVv0bk/1de1jVp/tl5Rp8r9rllI34cfFSWJvo0k+
        VMLuT0B1jHV9BTA58kBDK4Qq/llkwrQRrmc74fI=
X-Google-Smtp-Source: APXvYqw2AeCdLcNxw3yXyG2q9A1yJJjPzbkEFkUNasjS0SEO0/rC6tigTrt97xSpbl9QpVkQd9PzuPxHxf4nnJWaXhg=
X-Received: by 2002:a25:6c88:: with SMTP id h130mr6951040ybc.112.1554404194312;
 Thu, 04 Apr 2019 11:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org> <20190401134421.278590567@goodmis.org>
In-Reply-To: <20190401134421.278590567@goodmis.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 4 Apr 2019 11:56:23 -0700
Message-ID: <CAMo8BfK8gdgni3z3PKv1rd0KPFMXgDCpicQQ_obuoDAEz3PkZQ@mail.gmail.com>
Subject: Re: [PATCH 5/6 v3] syscalls: Remove start and number from
 syscall_get_arguments() args
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Dave Martin <dave.martin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 6:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>
> At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
> function call syscall_get_arguments() implemented in x86 was horribly
> written and not optimized for the standard case of passing in 0 and 6 for
> the starting index and the number of system calls to get. When looking at
> all the users of this function, I discovered that all instances pass in only
> 0 and 6 for these arguments. Instead of having this function handle
> different cases that are never used, simply rewrite it to return the first 6
> arguments of a system call.
>
> This should help out the performance of tracing system calls by ptrace,
> ftrace and perf.

[...]

>  arch/xtensa/include/asm/syscall.h     | 16 ++----

For xtensa changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
