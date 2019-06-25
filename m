Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A300C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3593E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfFYQiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:38:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfFYQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:38:08 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfoSE-0003tr-Sk; Tue, 25 Jun 2019 18:37:59 +0200
Date:   Tue, 25 Jun 2019 18:37:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/tls: Fix possible spectre-v1 in
 do_get_thread_area()
In-Reply-To: <1561479779-6660-1-git-send-email-dianzhangchen0@gmail.com>
Message-ID: <alpine.DEB.2.21.1906251835370.32342@nanos.tec.linutronix.de>
References: <1561479779-6660-1-git-send-email-dianzhangchen0@gmail.com>
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

On Wed, 26 Jun 2019, Dianzhang Chen wrote:

> The index to access the threads tls array is controlled by userspace
> via syscall: sys_ptrace(), hence leading to a potential exploitation
> of the Spectre variant 1 vulnerability.
> The idx can be controlled from:
>         ptrace -> arch_ptrace -> do_get_thread_area.
> 
> Fix this by sanitizing idx before using it to index p->thread.tls_array.

Just that I can't find a place which sanitizes the value....

> +#include <linux/nospec.h>

and nothing which uses anything from this header file.

>  #include <linux/uaccess.h>
>  #include <asm/desc.h>
> @@ -220,6 +221,7 @@ int do_get_thread_area(struct task_struct *p, int idx,
>  		       struct user_desc __user *u_info)
>  {
>  	struct user_desc info;
> +	int index;
>  
>  	if (idx == -1 && get_user(idx, &u_info->entry_number))
>  		return -EFAULT;
> @@ -227,8 +229,9 @@ int do_get_thread_area(struct task_struct *p, int idx,
>  	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
>  		return -EINVAL;
>  
> -	fill_user_desc(&info, idx,
> -		       &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
> +	index = idx - GDT_ENTRY_TLS_MIN;
> +
> +	fill_user_desc(&info, idx, &p->thread.tls_array[index]);

So this is just a cosmetic change and the compiler will create probably
exactly the same binary.

Thanks,

	tglx

