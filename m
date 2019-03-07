Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA27C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0B920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551982207;
	bh=4WT8tPMLD14jwezUKQ1CVIZ55SNmbjWtDMyGcA9iLP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eNYUq20JqZM13gyqbIa4Ln+/mwraAmkwac3fhB8EaVmooMmSYZcE1wFmdfyrOVpUd
	 QRQKdLLqhfQ/2YcT58pUBkzua3oXaLkKgPe6zGpGkvqwrSfKwgxDkc/XWxN2TzjkHK
	 UhUQHqHkFcofHxYzICaelKdz8APK+HFTtgxG6uAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfCGSKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCGSKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:10:05 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7582721019
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551982204;
        bh=4WT8tPMLD14jwezUKQ1CVIZ55SNmbjWtDMyGcA9iLP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S+1OsjF45be48Kp00tG3RlMoFFmx3q6kWfRz9aGa+IUqEBClOe/YWRxeRY2n3jVAN
         IfOAX4tWBdlB3ou4jy/RWT+JlCSrGLKZSzCPH7HurgwE5hMhhTplkjqhL6DhuXoM9K
         kmoREuwdTKsOBvGLq0+9SwfNt716lN7vCHRfLsms=
Received: by mail-wr1-f41.google.com with SMTP id y6so3410308wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:10:04 -0800 (PST)
X-Gm-Message-State: APjAAAU4Fva55Da6PsjwIXe7DI22OXAWG/OFhKPlegPhmOk25sJMWzW8
        99gwGuKK4iT3Qf4IDnk1c1cA2+WnqUURM5WmGwslWw==
X-Google-Smtp-Source: APXvYqwrO12UgJt1c8GzahjXTae0dXcIiVJO1DRkrSyvOHHvA7wGQkIA7vw5+gyD2GKCcWVq91rQH9cDJJFmTujgxLw=
X-Received: by 2002:a5d:6252:: with SMTP id m18mr7475626wrv.199.1551982202913;
 Thu, 07 Mar 2019 10:10:02 -0800 (PST)
MIME-Version: 1.0
References: <1551947140-22166-1-git-send-email-bo.tong@intel.com>
In-Reply-To: <1551947140-22166-1-git-send-email-bo.tong@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 Mar 2019 10:09:51 -0800
X-Gmail-Original-Message-ID: <CALCETrXvs1thKLHgnHOe94o1kAunxTSw8k-v9_GgoodB=R9M5g@mail.gmail.com>
Message-ID: <CALCETrXvs1thKLHgnHOe94o1kAunxTSw8k-v9_GgoodB=R9M5g@mail.gmail.com>
Subject: Re: [PATCH] selftests/x86: Support Atom for syscall_arg_fault test
To:     Tong Bo <bo.tong@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Andrew Lutomirski <luto@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 12:22 AM Tong Bo <bo.tong@intel.com> wrote:
>
> Atom-based CPUs trigger stack fault when invoke 32-bit SYSENTER instruction
> with invalid register values. So we also need sigbus handling in this case.
>
> Following is assembly when the fault expception happens.
>
> (gdb) disassemble $eip
> Dump of assembler code for function __kernel_vsyscall:
>    0xf7fd8fe0 <+0>:     push   %ecx
>    0xf7fd8fe1 <+1>:     push   %edx
>    0xf7fd8fe2 <+2>:     push   %ebp
>    0xf7fd8fe3 <+3>:     mov    %esp,%ebp
>    0xf7fd8fe5 <+5>:     sysenter
>    0xf7fd8fe7 <+7>:     int    $0x80
> => 0xf7fd8fe9 <+9>:     pop    %ebp
>    0xf7fd8fea <+10>:    pop    %edx
>    0xf7fd8feb <+11>:    pop    %ecx
>    0xf7fd8fec <+12>:    ret
> End of assembler dump.
>
> Accroding to Intel SDM, this could also be a Stack Segment Fault(#SS, 12),
> except a normal Page Fault(#PF, 14).

Really?  What is in the SS register that makes a stack segment fault
possible?  Is it because we're overflowing ESP?  Would a value like -5
instead of -1 in the register change things?

Anyway, I'm okay with the patch, but I think that you should improve
the comment:

> -       sethandler(SIGSEGV, sigsegv, SA_ONSTACK);
> +       sethandler(SIGSEGV, sigsegv_or_sigbus, SA_ONSTACK);
> +       /* Atom CPUs may trigger sigbus for below SYSENTER exception case */
> +       sethandler(SIGBUS, sigsegv_or_sigbus, SA_ONSTACK);

How about "The actual exception can vary.  On Atom CPUs, we get #SS
instead of #PF when the vDSO fails to access the stack when ESP is too
close to 2^32, and #SS causes SIGBUS".

--Andy
