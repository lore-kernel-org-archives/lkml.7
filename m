Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A2C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D5920679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfFWLxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:53:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33279 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfFWLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:53:02 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf13E-0008VJ-Nn; Sun, 23 Jun 2019 13:52:52 +0200
Date:   Sun, 23 Jun 2019 13:52:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
cc:     oleg@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: fix possible spectre-v1 in ptrace_get_debugreg()
In-Reply-To: <1558702622-15143-1-git-send-email-dianzhangchen0@gmail.com>
Message-ID: <alpine.DEB.2.21.1906231348340.32342@nanos.tec.linutronix.de>
References: <1558702622-15143-1-git-send-email-dianzhangchen0@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019, Dianzhang Chen wrote:

> Subject : [PATCH] x86: fix possible spectre-v1 in ptrace_get_debugreg()

Please use the proper prefix. Run git log on the file and you'll find
it. Also please start the short summary sentence after the prefix with an
upper case letter.

> The n in ptrace_get_debugreg() is indirectly controlled by userspace via syscall: ptrace(defined in kernel/ptrace.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
> The n can be controlled from: ptrace -> arch_ptrace -> ptrace_get_debugreg.
>

Please format the text proper with a line break around column 70.

Also please refrain from '(defined in kernel/ptrace.c)'. Use sys_ptrace()
which is entirely clear.

> Fix this by sanitizing n before using it to index thread->ptrace_bps.
> 
> Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
> ---
>  arch/x86/kernel/ptrace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index 4b8ee05..3f8f158 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -24,6 +24,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/export.h>
>  #include <linux/context_tracking.h>
> +#include <linux/nospec.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/pgtable.h>
> @@ -644,7 +645,8 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
>  	unsigned long val = 0;
>  
>  	if (n < HBP_NUM) {
> -		struct perf_event *bp = thread->ptrace_bps[n];
> +		struct perf_event *bp =
> +			thread->ptrace_bps[array_index_nospec(n, HBP_NUM)];

Please use an intermediate variable to calculate the index instead of this
weird line break.

Thanks,

	tglx
