Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12343C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AF920679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFWL4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:56:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33289 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFWL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:56:05 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf16F-00006C-EP; Sun, 23 Jun 2019 13:55:59 +0200
Date:   Sun, 23 Jun 2019 13:55:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: tls: fix possible spectre-v1 in
 do_get_thread_area()
In-Reply-To: <1560258958-19291-1-git-send-email-dianzhangchen0@gmail.com>
Message-ID: <alpine.DEB.2.21.1906231353120.32342@nanos.tec.linutronix.de>
References: <1560258958-19291-1-git-send-email-dianzhangchen0@gmail.com>
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

On Tue, 11 Jun 2019, Dianzhang Chen wrote:

Subject prefix is 'x86/tls:' please.

> The idx in do_get_thread_area() is controlled by userspace

The idx? Please to not variable names in the change log. The variable name
is an implementation detail.

  The index to access the threads tls array is controlled ....

Hmm?

> via syscall: ptrace(defined in kernel/ptrace.c), hence

sys_ptrace() again.

> leading to a potential exploitation of the Spectre variant 1 vulnerability.
> The idx can be controlled from:
> 	ptrace -> arch_ptrace -> do_get_thread_area.
> 
> Fix this by sanitizing idx before using it to index p->thread.tls_array.
> 
> Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
> ---
>  arch/x86/kernel/tls.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
> index a5b802a..4cd338c 100644
> --- a/arch/x86/kernel/tls.c
> +++ b/arch/x86/kernel/tls.c
> @@ -5,6 +5,7 @@
>  #include <linux/user.h>
>  #include <linux/regset.h>
>  #include <linux/syscalls.h>
> +#include <linux/nospec.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/desc.h>
> @@ -220,6 +221,7 @@ int do_get_thread_area(struct task_struct *p, int idx,
>  		       struct user_desc __user *u_info)
>  {
>  	struct user_desc info;
> +	int index = idx - GDT_ENTRY_TLS_MIN;
>  
>  	if (idx == -1 && get_user(idx, &u_info->entry_number))
>  		return -EFAULT;

Broken in the same way as the other one.

Thanks,

	tglx
