Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A26C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 02:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A524621473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 02:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557799365;
	bh=4OBmtfQllm0RymwAbmCzcP2d3KH9f8oCMkSmd1HlaAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CHj8aJjOaKFhFKpYAEK8V61eLZGgeovFwrq8fiJz3nnCXn/CSuPL7jJ1AHoMjT51x
	 8wVsxQCS8TazCIBoSf/j2uDfiBCg2Gda5RVh7Tpzvi84X7VkZueNELCHCR8gagePRe
	 RdJUrJVVy5B7dXYMKxnQgNqRIAP3SqDTyKmoQSdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfENCCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 22:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfENCCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 22:02:44 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47249214D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 02:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557799363;
        bh=4OBmtfQllm0RymwAbmCzcP2d3KH9f8oCMkSmd1HlaAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=15OxqietpeRfGcIVu5u4YGK6lQMkA8PXcTMZtnOt1lzuJODROCsf/5K71H11TL4ul
         XIQLz6xsf1OfhAS72AXJbUsNOQo5rEO7Y4JJrc/YQcRpjxUqD+Y1DbYwehJXNSN6/d
         Q0NETdnisf6YcHjz5rFLGoBCziHZbk+A/5MudBlA=
Received: by mail-wm1-f53.google.com with SMTP id x64so1090184wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 19:02:43 -0700 (PDT)
X-Gm-Message-State: APjAAAUBf7JKWvc0NN+BxQCUVK8sdMTVl+E1i7ZPmnoUbvIcG+YBYdy+
        o1jJgPg5Dtrx7LPsZwmfcEQpp3Fgrz4mMSbkV+aEyg==
X-Google-Smtp-Source: APXvYqynOcw9YL9Rj7oZzy310IyYvddcWfkYtYUCrEZa+qhWQKqb0ESZyXTuKlKEYx+4/q84sAUpXBybTnLqOnGPL3A=
X-Received: by 2002:a1c:486:: with SMTP id 128mr16481232wme.83.1557799361797;
 Mon, 13 May 2019 19:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com>
 <1557758315-12667-25-git-send-email-alexandre.chartre@oracle.com>
 <20190513151500.GY2589@hirez.programming.kicks-ass.net> <13F2FA4F-116F-40C6-9472-A1DE689FE061@oracle.com>
In-Reply-To: <13F2FA4F-116F-40C6-9472-A1DE689FE061@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 May 2019 19:02:30 -0700
X-Gmail-Original-Message-ID: <CALCETrUcR=3nfOtFW2qt3zaa7CnNJWJLqRY8AS9FTJVHErjhfg@mail.gmail.com>
Message-ID: <CALCETrUcR=3nfOtFW2qt3zaa7CnNJWJLqRY8AS9FTJVHErjhfg@mail.gmail.com>
Subject: Re: [RFC KVM 24/27] kvm/isolation: KVM page fault handler
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 2:26 PM Liran Alon <liran.alon@oracle.com> wrote:
>
>
>
> > On 13 May 2019, at 18:15, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, May 13, 2019 at 04:38:32PM +0200, Alexandre Chartre wrote:
> >> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> >> index 46df4c6..317e105 100644
> >> --- a/arch/x86/mm/fault.c
> >> +++ b/arch/x86/mm/fault.c
> >> @@ -33,6 +33,10 @@
> >> #define CREATE_TRACE_POINTS
> >> #include <asm/trace/exceptions.h>
> >>
> >> +bool (*kvm_page_fault_handler)(struct pt_regs *regs, unsigned long error_code,
> >> +                           unsigned long address);
> >> +EXPORT_SYMBOL(kvm_page_fault_handler);
> >
> > NAK NAK NAK NAK
> >
> > This is one of the biggest anti-patterns around.
>
> I agree.
> I think that mm should expose a mm_set_kvm_page_fault_handler() or something (give it a better name).
> Similar to how arch/x86/kernel/irq.c have kvm_set_posted_intr_wakeup_handler().
>
> -Liran
>

This sounds like a great use case for static_call().  PeterZ, do you
suppose we could wire up static_call() with the module infrastructure
to make it easy to do "static_call to such-and-such GPL module symbol
if that symbol is in a loaded module, else nop"?
