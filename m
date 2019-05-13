Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D8C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCBF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557763295;
	bh=lEibKcwC5gVE6uqe1w9PcI6jNFCNtyn0TO/fffg8YH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DuG1BneiiAqZpZD4PK3aOnNLSZajOINO1QJgwCqP5Noz5uqKnaAj2OgcOpayHbdy/
	 xemH9frAQFIqTAKU4sdtlBiTX3+EhtF9pB7j17/U7eglFMyOjRHJ3KCN3EL1oYIh9Y
	 6b0IaUMQEJXaOPKHY5W3xQ+y0XeDNm+Bm5yij7Sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfEMQBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbfEMQBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:01:33 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80629216E3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557763292;
        bh=lEibKcwC5gVE6uqe1w9PcI6jNFCNtyn0TO/fffg8YH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k+z5lpybKEi6mIpFrCN17wQ9GoetmotYQ4i88fejJcVpMaoHOZbrljm2PEWhDSswf
         06cEs3sA7iEdSg/w9f9tzMdQIooZs+IfZ3+LMzAYVslGXnDJ50vPScbKZ3yfmR0j61
         V+5Fh+Qm2y15i11H0UpnUapfNJQgFELWxccdwEPU=
Received: by mail-wm1-f48.google.com with SMTP id o189so14476556wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:01:32 -0700 (PDT)
X-Gm-Message-State: APjAAAVabzk9T5/5m1nMh9gXwlgbCyBbK9FIJc0dYvikofp5kdGywWUq
        WUB/oLzavTLF277Y2VLZMwc6HKZiwmDubw3ZiNMPAQ==
X-Google-Smtp-Source: APXvYqySeak5d5b75+WeyRRha6bI26hiE/9igsHZ0v7N1L8hvam3cM49nnezAxrIoHS1OAg32CScL++8+THXngeTOP8=
X-Received: by 2002:a7b:c844:: with SMTP id c4mr5457540wml.108.1557763286508;
 Mon, 13 May 2019 09:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <1557758315-12667-1-git-send-email-alexandre.chartre@oracle.com> <1557758315-12667-26-git-send-email-alexandre.chartre@oracle.com>
In-Reply-To: <1557758315-12667-26-git-send-email-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 May 2019 09:01:14 -0700
X-Gmail-Original-Message-ID: <CALCETrWmvcrO0bBEw7iL-GnCED6hTz=FD+nANZkdQRo2R-w_3Q@mail.gmail.com>
Message-ID: <CALCETrWmvcrO0bBEw7iL-GnCED6hTz=FD+nANZkdQRo2R-w_3Q@mail.gmail.com>
Subject: Re: [RFC KVM 25/27] kvm/isolation: implement actual KVM isolation enter/exit
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 7:40 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> From: Liran Alon <liran.alon@oracle.com>
>
> KVM isolation enter/exit is done by switching between the KVM address
> space and the kernel address space.
>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>  arch/x86/kvm/isolation.c |   30 ++++++++++++++++++++++++------
>  arch/x86/mm/tlb.c        |    1 +
>  include/linux/sched.h    |    1 +
>  3 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/isolation.c b/arch/x86/kvm/isolation.c
> index db0a7ce..b0c789f 100644
> --- a/arch/x86/kvm/isolation.c
> +++ b/arch/x86/kvm/isolation.c
> @@ -1383,11 +1383,13 @@ static bool kvm_page_fault(struct pt_regs *regs, unsigned long error_code,
>         printk(KERN_DEFAULT "KVM isolation: page fault %ld at %pS on %lx (%pS) while switching mm\n"
>                "  cr3=%lx\n"
>                "  kvm_mm=%px pgd=%px\n"
> -              "  active_mm=%px pgd=%px\n",
> +              "  active_mm=%px pgd=%px\n"
> +              "  kvm_prev_mm=%px pgd=%px\n",
>                error_code, (void *)regs->ip, address, (void *)address,
>                cr3,
>                &kvm_mm, kvm_mm.pgd,
> -              active_mm, active_mm->pgd);
> +              active_mm, active_mm->pgd,
> +              current->kvm_prev_mm, current->kvm_prev_mm->pgd);
>         dump_stack();
>
>         return false;
> @@ -1649,11 +1651,27 @@ void kvm_may_access_sensitive_data(struct kvm_vcpu *vcpu)
>         kvm_isolation_exit();
>  }
>
> +static void kvm_switch_mm(struct mm_struct *mm)
> +{
> +       unsigned long flags;
> +
> +       /*
> +        * Disable interrupt before updating active_mm, otherwise if an
> +        * interrupt occurs during the switch then the interrupt handler
> +        * can be mislead about the mm effectively in use.
> +        */
> +       local_irq_save(flags);
> +       current->kvm_prev_mm = current->active_mm;

Peter's NAK aside, why on Earth is this in task_struct?  You cannot
possibly context switch while in isolation mode.

--Andy
