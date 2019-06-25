Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CF5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A70213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfFYNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:21:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33725 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbfFYNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:21:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id i4so17443919otk.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgVn9o2XMV2ez9jDzY+0llaXiVjr0qoFXFfqDt3jX2U=;
        b=Wb5+132tpX1Nyv9zh3XZKDYQoeIO36Q3F2IyRRRHbXphiYiVOMsywzzo2zNnsuxC7S
         epBhuGSNonIiUnOJxDa0xotZ9RvJ01IXElFX12HvAztWv1mAYo9sE3i9hggS4dMZOEXN
         EtFy5esDRfp9Wderp5CE/X9RVRfZ0NhqPjyUr5GglS7j+S3LrtoqpRwAktH6ad5ltwSu
         APniWCDl6RI2m1DuOU/wKJjfhxkvNY+j1FFQDKzaB2YXHWirhNqvrzPxhs+y9BBpBjQz
         hCe6hDE35+ZdOLyjzQRMG4Z0wWCFD7vHzDNN3/M/HTRzk6OqO8dwAkCI39qY0pGppxMo
         rz0w==
X-Gm-Message-State: APjAAAV8UgDvONN/YkKliYPQEVR5IM90PJt2Rw4Cubs6FGR+Lh+goK+V
        eXUBY5uWwbYZ5UXeTuLAji2NJCvllFxOGvurNpU=
X-Google-Smtp-Source: APXvYqxtTdkEuscypnU/zXHDBFVFEQQfPBzKSH4cOLu0kIQSsZem/FyWnB8vAkRTtysTKJpjYdQxucZzxLUC8tY+nHQ=
X-Received: by 2002:a9d:4109:: with SMTP id o9mr5521556ote.353.1561468878433;
 Tue, 25 Jun 2019 06:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561459983.git.christophe.leroy@c-s.fr> <290a9673b0adac34f0008f2679efd5ab5a5c4478.1561459984.git.christophe.leroy@c-s.fr>
In-Reply-To: <290a9673b0adac34f0008f2679efd5ab5a5c4478.1561459984.git.christophe.leroy@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 25 Jun 2019 15:21:05 +0200
Message-ID: <CA+7wUsxL0OHvOn51hbJyAhpi=OJye=axKfVyauhEVXLqFuFqHA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 11/13] powerpc/ptrace: create ppc_gethwdinfo()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 1:22 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Create ippc_gethwdinfo() to handle PPC_PTRACE_GETHWDBGINFO and

s/ippc_gethwdinfo/ppc_gethwdinfo/

> reduce ifdef mess
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/ptrace/ptrace-adv.c   | 15 +++++++++++++++
>  arch/powerpc/kernel/ptrace/ptrace-decl.h  |  1 +
>  arch/powerpc/kernel/ptrace/ptrace-noadv.c | 20 +++++++++++++++++++
>  arch/powerpc/kernel/ptrace/ptrace.c       | 32 +------------------------------
>  4 files changed, 37 insertions(+), 31 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-adv.c b/arch/powerpc/kernel/ptrace/ptrace-adv.c
> index dcc765940344..f5f334484ebc 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-adv.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-adv.c
> @@ -83,6 +83,21 @@ void user_disable_single_step(struct task_struct *task)
>         clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>
> +void ppc_gethwdinfo(struct ppc_debug_info *dbginfo)

Would it be possible to rename it to `ppc_gethwdbginfo`, I find it
easier to read.

> +{
> +       dbginfo->version = 1;
> +       dbginfo->num_instruction_bps = CONFIG_PPC_ADV_DEBUG_IACS;
> +       dbginfo->num_data_bps = CONFIG_PPC_ADV_DEBUG_DACS;
> +       dbginfo->num_condition_regs = CONFIG_PPC_ADV_DEBUG_DVCS;
> +       dbginfo->data_bp_alignment = 4;
> +       dbginfo->sizeof_condition = 4;
> +       dbginfo->features = PPC_DEBUG_FEATURE_INSN_BP_RANGE |
> +                           PPC_DEBUG_FEATURE_INSN_BP_MASK;
> +       if (IS_ENABLED(CONFIG_PPC_ADV_DEBUG_DAC_RANGE))
> +               dbginfo->features |= PPC_DEBUG_FEATURE_DATA_BP_RANGE |
> +                                    PPC_DEBUG_FEATURE_DATA_BP_MASK;
> +}
> +
>  int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
>                         unsigned long __user *datalp)
>  {
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
> index cd5b8256ba56..2404b987b23c 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-decl.h
> +++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
> @@ -141,6 +141,7 @@ int tm_cgpr32_set(struct task_struct *target, const struct user_regset *regset,
>  extern const struct user_regset_view user_ppc_native_view;
>
>  /* ptrace-(no)adv */
> +void ppc_gethwdinfo(struct ppc_debug_info *dbginfo);
>  int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
>                         unsigned long __user *datalp);
>  int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned long data);
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> index 985cca136f85..426fedd7ab6c 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> @@ -64,6 +64,26 @@ void user_disable_single_step(struct task_struct *task)
>         clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>
> +void ppc_gethwdinfo(struct ppc_debug_info *dbginfo)
> +{
> +       dbginfo->version = 1;
> +       dbginfo->num_instruction_bps = 0;
> +       if (ppc_breakpoint_available())
> +               dbginfo->num_data_bps = 1;
> +       else
> +               dbginfo->num_data_bps = 0;
> +       dbginfo->num_condition_regs = 0;
> +       dbginfo->data_bp_alignment = sizeof(long);
> +       dbginfo->sizeof_condition = 0;
> +       if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT)) {
> +               dbginfo->features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
> +               if (dawr_enabled())
> +                       dbginfo->features |= PPC_DEBUG_FEATURE_DATA_BP_DAWR;
> +       } else {
> +               dbginfo->features = 0;
> +       }
> +}
> +
>  int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
>                         unsigned long __user *datalp)
>  {
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index e789afae6f56..31e8c5a9171e 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -159,37 +159,7 @@ long arch_ptrace(struct task_struct *child, long request,
>         case PPC_PTRACE_GETHWDBGINFO: {
>                 struct ppc_debug_info dbginfo;
>
> -               dbginfo.version = 1;
> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> -               dbginfo.num_instruction_bps = CONFIG_PPC_ADV_DEBUG_IACS;
> -               dbginfo.num_data_bps = CONFIG_PPC_ADV_DEBUG_DACS;
> -               dbginfo.num_condition_regs = CONFIG_PPC_ADV_DEBUG_DVCS;
> -               dbginfo.data_bp_alignment = 4;
> -               dbginfo.sizeof_condition = 4;
> -               dbginfo.features = PPC_DEBUG_FEATURE_INSN_BP_RANGE |
> -                                  PPC_DEBUG_FEATURE_INSN_BP_MASK;
> -#ifdef CONFIG_PPC_ADV_DEBUG_DAC_RANGE
> -               dbginfo.features |=
> -                                  PPC_DEBUG_FEATURE_DATA_BP_RANGE |
> -                                  PPC_DEBUG_FEATURE_DATA_BP_MASK;
> -#endif
> -#else /* !CONFIG_PPC_ADV_DEBUG_REGS */
> -               dbginfo.num_instruction_bps = 0;
> -               if (ppc_breakpoint_available())
> -                       dbginfo.num_data_bps = 1;
> -               else
> -                       dbginfo.num_data_bps = 0;
> -               dbginfo.num_condition_regs = 0;
> -               dbginfo.data_bp_alignment = sizeof(long);
> -               dbginfo.sizeof_condition = 0;
> -#ifdef CONFIG_HAVE_HW_BREAKPOINT
> -               dbginfo.features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
> -               if (dawr_enabled())
> -                       dbginfo.features |= PPC_DEBUG_FEATURE_DATA_BP_DAWR;
> -#else
> -               dbginfo.features = 0;
> -#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> -#endif /* CONFIG_PPC_ADV_DEBUG_REGS */
> +               ppc_gethwdinfo(&dbginfo);
>
>                 if (copy_to_user(datavp, &dbginfo,
>                                  sizeof(struct ppc_debug_info)))
> --
> 2.13.3
>
