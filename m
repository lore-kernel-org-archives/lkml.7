Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BEDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCB821874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552593358;
	bh=PXqYivX1b25eJRi4bBGWT97dJYiO1eCVORj7HUvCUMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=il8ZnifRbZettlyPvAb4FEKMWuXakz28JFUFaGJLfsQvDiF1KJhgzji2buYZ0yTRZ
	 OkpgLI0XDhMYeEbI2hauM/La8ZjwJXsjUzjj8/mAIH1suynPHWZQ1MNpDhdBhtpLqL
	 AzQb3wozpvAceoU0Q87kBrVREVgT08J8+aNyW9Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCNTz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfCNTz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 15:55:56 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B1821872
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552593355;
        bh=PXqYivX1b25eJRi4bBGWT97dJYiO1eCVORj7HUvCUMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k3c019J8S2ueeyZJwI/tKvnYpbnnATlIY/+mKnfO/+uPlciWeyQYYiTZBFLtZq72M
         /2jGdhn25Fb77TwPsiUNSrPCm/o36sEs6dxXWSKj/uy7R5UO12ao/kfICU6yJOtY9Y
         Ry3FZu77hLvry2ZqWsxv3feJmRgGqoPY3np5f8ac=
Received: by mail-wr1-f51.google.com with SMTP id y13so2645438wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 12:55:55 -0700 (PDT)
X-Gm-Message-State: APjAAAWt0bYbAEiaxjlX1Glsc9Oohgqs1Ihg3iwjiRkzBa1folnFuwmo
        y9bBoaPu/uxLV9bVDwpuyP+f01ONqto9TXXifi2fHQ==
X-Google-Smtp-Source: APXvYqzWrU6BrA41mpmW2G4rtRK4+RCYVPGpK/Z8JNn+ew/0XwP0cbfRXSgv/oAhZMJSO9zNG92B1abTN2FrW4CYKGQ=
X-Received: by 2002:adf:bc90:: with SMTP id g16mr10775651wrh.77.1552593354081;
 Thu, 14 Mar 2019 12:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <1552056945-29139-1-git-send-email-bo.tong@intel.com>
In-Reply-To: <1552056945-29139-1-git-send-email-bo.tong@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 Mar 2019 12:55:37 -0700
X-Gmail-Original-Message-ID: <CALCETrWpWJgM2dJnB1d7-YJUCye4KwMta3grqsSEgKDvGqD1=g@mail.gmail.com>
Message-ID: <CALCETrWpWJgM2dJnB1d7-YJUCye4KwMta3grqsSEgKDvGqD1=g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/x86: Support Atom for syscall_arg_fault test
To:     Tong Bo <bo.tong@intel.com>, X86 ML <x86@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Andrew Lutomirski <luto@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 6:52 AM Tong Bo <bo.tong@intel.com> wrote:
>
> Atom-based CPUs trigger stack fault when invoke 32-bit SYSENTER instruction
> with invalid register values. So we also need SIGBUS handling in this case.
>
> Following is assembly when the fault exception happens.
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
> According to Intel SDM, this could also be a Stack Segment Fault(#SS, 12),
> except a normal Page Fault(#PF, 14). Especially, in section 6.9 of Vol.3A,
> both stack and page faults are within the 10th(lowest priority) class, and
> as it said, "exceptions within each class are implementation-dependent and
> may vary from processor to processor". It's expected for processors like
> Intel Atom to trigger stack fault(SIGBUS), while we get page fault(SIGSEGV)
> from common Core processors.

Acked-by: Andy Lutomirski <luto@kernel.org>

but:

> -       sethandler(SIGSEGV, sigsegv, SA_ONSTACK);
> +       sethandler(SIGSEGV, sigsegv_or_sigbus, SA_ONSTACK);
> +       /* The actual exception can vary.  On Atom CPUs, we get #SS

Can whoever commits this fix the comment formatting?  That should be:

/*
 * first line here

--Andy
