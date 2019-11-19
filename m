Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F61C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2172230B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574157692;
	bh=igKe/Irq684yGVXZz57Pixw3CSTAN3NnsvzA3F3g/sM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ODRsl5hg1GnUhKwhJS42MAyLaC+jEWi/VOFq8bMh8mCL6KQxib2tet32CTZFonxIb
	 0Yr23FYJvS6N1nacE5N2zoJ3cHNeGyUwZqfjcQzX1t3apGImGOcVAti2KlvIS8d3Er
	 libq2L0Plds5ifPVnqgJvoG7TAIuugtXYDwFescs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKSKBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSKBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:01:31 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A122230E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574157689;
        bh=igKe/Irq684yGVXZz57Pixw3CSTAN3NnsvzA3F3g/sM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yq1N8H2QrECxrtfQpCvle8h9lOSRJZWvcVd/1guWUqFW5DOYtfuay7YG1iWDJOlct
         rWhsDJLTIAZpSeNr/YINo3JNRjITO94qikJ/H/AwTRLlq9tQXSE+LZIc4O84YNqnYR
         /M9jlj0u3x3sYqbiisRQxIevonrFZMSgm/OZ+X9c=
Received: by mail-wr1-f45.google.com with SMTP id b3so23022956wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:01:29 -0800 (PST)
X-Gm-Message-State: APjAAAWRWoOQT80OhRFTI4E8Q+GSIKfCOQzRHFR9S6H1E35+FUTKqjcb
        TA8MAlpnuR4zHFiku73z/hEaColdVIW9AG+L5oC+rA==
X-Google-Smtp-Source: APXvYqy47nL6cKOqySUeaEx7npZj/GWcb3VjJyBjwq0Zf8jMQStio8EI88WgOAtN2lfctAhhUvR3QJiVzyddGHDly18=
X-Received: by 2002:a5d:490b:: with SMTP id x11mr34617300wrq.111.1574157687971;
 Tue, 19 Nov 2019 02:01:27 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191119051537epcas5p2da5439a60d1167b8cc7e2179487996aa@epcas5p2.samsung.com>
 <1574140520-9738-1-git-send-email-maninder1.s@samsung.com>
In-Reply-To: <1574140520-9738-1-git-send-email-maninder1.s@samsung.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 Nov 2019 02:01:16 -0800
X-Gmail-Original-Message-ID: <CALCETrVSp=Xz1u0gS-RM-LD+qOpfTiRLquJrQU14jQjioF5ejw@mail.gmail.com>
Message-ID: <CALCETrVSp=Xz1u0gS-RM-LD+qOpfTiRLquJrQU14jQjioF5ejw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: Map next task stack in previous mm.
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, v.narang@samsung.com,
        a.sahrawat@samsung.com, avnish.jain@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 9:44 PM Maninder Singh <maninder1.s@samsung.com> wrote:
>
> Issue: In context switch, stack of next task (kernel thread)
> is not mapped in previous task PGD.
>
> Issue faced while porting VMAP stack on ARM.
> currently forcible mapping is done in case of switching mm, but if
> next task is kernel thread then it can cause issue.
>
> Thus Map stack of next task in prev if next task is kernel thread,
> as kernel thread will use mm of prev task.
>
> "Since we don't have reproducible setup for x86,
> changes verified on ARM. So not sure about arch specific handling
> for X86"

I think the code is correct without your patch and is wrong with your
patch.  See below.

>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/x86/mm/tlb.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index e6a9edc5baaf..28328cf8e79c 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -161,11 +161,17 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>         local_irq_restore(flags);
>  }
>
> -static void sync_current_stack_to_mm(struct mm_struct *mm)
> +static void sync_stack_to_mm(struct mm_struct *mm, struct task_struct *tsk)
>  {
> -       unsigned long sp = current_stack_pointer;
> -       pgd_t *pgd = pgd_offset(mm, sp);
> +       unsigned long sp;
> +       pgd_t *pgd;
>
> +       if (!tsk)
> +               sp = current_stack_pointer;
> +       else
> +               sp = (unsigned long)tsk->stack;
> +
> +       pgd = pgd_offset(mm, sp);
>         if (pgtable_l5_enabled()) {
>                 if (unlikely(pgd_none(*pgd))) {
>                         pgd_t *pgd_ref = pgd_offset_k(sp);
> @@ -383,7 +389,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>                          * mapped in the new pgd, we'll double-fault.  Forcibly
>                          * map it.
>                          */
> -                       sync_current_stack_to_mm(next);
> +                       sync_stack_to_mm(next, NULL);

If we set CR3 to point to the next mm's PGD and then touch the current
stack, we'll double-fault.  So we need to sync the *current* stack,
not the next stack.

The code in prepare_switch_to() makes sure that the next task's stack is synced.

>                 }
>
>                 /*
> @@ -460,6 +466,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   */
>  void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>  {
> +       if (IS_ENABLED(CONFIG_VMAP_STACK)) {
> +               /*
> +                * If tsk stack is in vmalloc space and isn't
> +                * mapped in the new pgd, we'll double-fault.  Forcibly
> +                * map it.
> +                */
> +               sync_stack_to_mm(mm, tsk);
> +       }
> +

I don't think this is necessary, since prepare_switch_to() already
does what's needed.
