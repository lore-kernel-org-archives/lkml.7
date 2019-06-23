Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FFFC48BE8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE420840
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfFWLsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:48:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33271 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfFWLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:48:12 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf0yW-0008SL-78; Sun, 23 Jun 2019 13:48:00 +0200
Date:   Sun, 23 Jun 2019 13:47:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: fix possible spectre-v1 in do_get_thread_area()
In-Reply-To: <1558698312-5716-1-git-send-email-dianzhangchen0@gmail.com>
Message-ID: <alpine.DEB.2.21.1906231343260.32342@nanos.tec.linutronix.de>
References: <1558698312-5716-1-git-send-email-dianzhangchen0@gmail.com>
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

> The idx in do_get_thread_area() is controlled by userspace via syscall: ptrace(defined in kernel/ptrace.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
> The idx can be controlled from: ptrace -> arch_ptrace -> do_get_thread_area.
> 
> Fix this by sanitizing idx before using it to index p->thread.tls_array.
> 
> Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
> ---
>  arch/x86/kernel/tls.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
> index a5b802a..e3dc05b 100644
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
> @@ -220,15 +221,19 @@ int do_get_thread_area(struct task_struct *p, int idx,
>  		       struct user_desc __user *u_info)
>  {
>  	struct user_desc info;
> +	int index = idx - GDT_ENTRY_TLS_MIN;
>  
>  	if (idx == -1 && get_user(idx, &u_info->entry_number))
>  		return -EFAULT;

This is broken in case of idx == -1 because index is not reevaluated after
idx is copied from u_info. You have to calculate index _AFTER_ that.
  
> -	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
> +	if (index < 0 || index > GDT_ENTRY_TLS_MAX - GDT_ENTRY_TLS_MIN)
>  		return -EINVAL;
>  
> +	index = array_index_nospec(index,
> +				GDT_ENTRY_TLS_MAX - GDT_ENTRY_TLS_MIN + 1);

What about defining the array size and using it here and in the sanity
check above?

> +
>  	fill_user_desc(&info, idx,
> -		       &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
> +		       &p->thread.tls_array[index]);

Please get rid of the line break. The line now fits into 80 char.

Thanks,

	tglx
