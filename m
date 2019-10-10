Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50230C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284B321835
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570731483;
	bh=0KC8xA9ZBy3AsBFBe/plN/z4+ZJLeyzqAtdvefSmMhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bdo3an92hAHokbIrFZk3PpIPRMcGwsL73yE/QY/bwXHpMaAufxqeFM9ANHLT2F5qe
	 JCbmEtgV/Yjb8HYtXuFCdZgzNkbpZoAem97Ve004q46JglAHIDbTRKh+Kz/JnvedGO
	 Ka9LTZp+tXy7kAK1wWgvZDbavAtdxCjjbksFdL4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfJJSSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfJJSSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:18:00 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E294021835
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570731480;
        bh=0KC8xA9ZBy3AsBFBe/plN/z4+ZJLeyzqAtdvefSmMhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZLTR0HtDz3P2RRoAiQBzAsBVOSYUls5hZ21a6hijqBq91+U//JMiNisw9ROozz+VG
         PK2SH8gc+mL+0yjS9F1QKZRke4vlXA4w66IV8Jj7k59zfg9aUED2+y6Ty4fjIg8eEy
         c7J4+Kp/UWapD09K/T0uMPOlFdHszTB7BjUJArIs=
Received: by mail-wr1-f46.google.com with SMTP id v8so9054856wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:17:59 -0700 (PDT)
X-Gm-Message-State: APjAAAUsioPxnJAXfAdDLFHH8l+ftPX7cvBLo+mx6rFvGEwRDJ13PrB4
        eXxaTu3qQAIlfuroXBy2bXgSVXkt18+YomucIIPUdg==
X-Google-Smtp-Source: APXvYqxtOoDpuy38/n7xJJKFLHNJ498UfovM8YnSjpcvEoj+a0VLIagGtiR3tBc8qsBvkx/yCd2Q+666Vn1NR4g9c+A=
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr9288431wrw.195.1570731478457;
 Thu, 10 Oct 2019 11:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20191008224049.115427-1-samitolvanen@google.com>
In-Reply-To: <20191008224049.115427-1-samitolvanen@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 10 Oct 2019 11:17:47 -0700
X-Gmail-Original-Message-ID: <CALCETrUAQ0of6bViOCmSu6qyoswTL+ThPOo3++9v_f-ek4CtEw@mail.gmail.com>
Message-ID: <CALCETrUAQ0of6bViOCmSu6qyoswTL+ThPOo3++9v_f-ek4CtEw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/5] x86: fix syscall function type mismatches
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 3:41 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This patch set changes x86 syscall wrappers and related functions to
> use function types that match sys_call_ptr_t. This fixes indirect call
> mismatches with Control-Flow Integrity (CFI) checking.

tglx, I'm pretty happy with this series.  Do you need anything else
from me or do you want to just pick it up in -tip?

--Andy

>
> Changes since v1:
>   - Use SYSCALL_DEFINE0 for __x64_sys_ni_syscall.
>   - Include Andy's COMPAT_SYSCALL_DEFINE0 patch and use the macro
>     for (rt_)sigreturn.
>
> Andy Lutomirski (1):
>   x86/syscalls: Wire up COMPAT_SYSCALL_DEFINE0
>
> Sami Tolvanen (4):
>   x86: use the correct function type in SYSCALL_DEFINE0
>   x86: use COMPAT_SYSCALL_DEFINE0 for IA32 (rt_)sigreturn
>   x86: use the correct function type for sys_ni_syscall
>   x86: fix function types in COND_SYSCALL
>
>  arch/x86/entry/syscall_32.c            |  8 +--
>  arch/x86/entry/syscall_64.c            | 14 +++--
>  arch/x86/entry/syscalls/syscall_32.tbl |  8 +--
>  arch/x86/ia32/ia32_signal.c            |  5 +-
>  arch/x86/include/asm/syscall_wrapper.h | 76 ++++++++++++++++++++------
>  5 files changed, 78 insertions(+), 33 deletions(-)
>
> --
> 2.23.0.581.g78d2f28ef7-goog
>
