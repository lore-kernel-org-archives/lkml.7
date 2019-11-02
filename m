Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72917CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487B0217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="saUcRD/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKBQaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 12:30:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfKBQaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 12:30:14 -0400
Received: from nazgul.tnic (x59cc87ab.dyn.telefonica.de [89.204.135.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C42531EC072D;
        Sat,  2 Nov 2019 17:30:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572712213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Qd5RzM8JCXkyITsm1AK1Wi5FgB4p2iPIJeHV7D38U6s=;
        b=saUcRD/xqnmPyOe7ixBBQEC2v/rT/LcGVZyHU3FTwzpJq8Homdx6/jpdJGBS6FfxQ0Icmg
        lnU5Vy6cvqiAs30GactFsAPbE8K8n5QNx6+PobptoKYbO3DBp9een749+tQRNEZtKuVP7+
        tRUhMm0N6YhRAxIVKI6Npa03o6E0DSM=
Date:   Sat, 2 Nov 2019 17:30:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Rik van Riel <riel@surriel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jann Horn <jannh@google.com>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 7/7] x86,rcu: use percpu rcu_preempt_depth
Message-ID: <20191102163005.GA11705@nazgul.tnic>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-8-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-8-laijs@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending again because your mail has the craziest header:

Reply-To: 20191101162109.GN20975@paulmck-ThinkPad-P72

and hitting Reply-to-all creates only confusion. WTF?

On Sat, Nov 02, 2019 at 12:45:59PM +0000, Lai Jiangshan wrote:
> Convert x86 to use a per-cpu rcu_preempt_depth. The reason for doing so
> is that accessing per-cpu variables is a lot cheaper than accessing
> task_struct or thread_info variables.
> 
> We need to save/restore the actual rcu_preempt_depth when switch.
> We also place the per-cpu rcu_preempt_depth close to __preempt_count
> and current_task variable.
> 
> Using the idea of per-cpu __preempt_count.
> 
> No function call when using rcu_read_[un]lock().
> Single instruction for rcu_read_lock().
> 2 instructions for fast path of rcu_read_unlock().
> 
> CC: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/Kconfig                         |  2 +
>  arch/x86/include/asm/rcu_preempt_depth.h | 87 ++++++++++++++++++++++++
>  arch/x86/kernel/cpu/common.c             |  7 ++
>  arch/x86/kernel/process_32.c             |  2 +
>  arch/x86/kernel/process_64.c             |  2 +
>  include/linux/rcupdate.h                 | 24 +++++++
>  init/init_task.c                         |  2 +-
>  kernel/fork.c                            |  2 +-
>  kernel/rcu/Kconfig                       |  3 +
>  kernel/rcu/tree_exp.h                    |  2 +
>  kernel/rcu/tree_plugin.h                 | 37 +++++++---
>  11 files changed, 158 insertions(+), 12 deletions(-)
>  create mode 100644 arch/x86/include/asm/rcu_preempt_depth.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d6e1faa28c58..af9fedc0fdc4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -18,6 +18,7 @@ config X86_32
>  	select MODULES_USE_ELF_REL
>  	select OLD_SIGACTION
>  	select GENERIC_VDSO_32
> +	select ARCH_HAVE_RCU_PREEMPT_DEEPTH

WTF is a "DEEPTH"?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
