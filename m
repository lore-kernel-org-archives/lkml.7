Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24428217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbfKFWeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:34:11 -0500
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:38489 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727196AbfKFWeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:34:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 130DC1260;
        Wed,  6 Nov 2019 22:34:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean84_5e4a6809fff01
X-Filterd-Recvd-Size: 1842
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Nov 2019 22:34:07 +0000 (UTC)
Message-ID: <a9e2f6b65d4c098ab027ea849120d3cf61858e67.camel@perches.com>
Subject: Re: [PATCH] xtensa: improve stack dumping
From:   Joe Perches <joe@perches.com>
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>
Date:   Wed, 06 Nov 2019 14:33:55 -0800
In-Reply-To: <20191106181617.1832-1-jcmvbkbc@gmail.com>
References: <20191106181617.1832-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 10:16 -0800, Max Filippov wrote:
> Collect whole stack dump lines in a buffer and print the whole buffer
> when it's ready with pr_info instead of pr_cont. This makes stack dump
> lines consistent in SMP case and relies less on pr_cont/printk
> differences related to timestamps.
> Make size of stack dump configurable.
> Drop extra newline output in show_trace as its output format does not
> depend on CONFIG_KALLSYMS.
[]
> diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
[]
> @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
>  	for (i = 0; i < kstack_depth_to_print; i++) {
>  		if (kstack_end(sp))
>  			break;
> -		pr_cont(" %08lx", *sp++);
> +		sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
>  		if (i % 8 == 7)
> -			pr_cont("\n");
> +			pr_info("%s\n", buf);
>  	}
> +	if (i % 8)
> +		pr_info("%s\n", buf);

Could this be done using hex_dump_to_buffer
by precalculating kstack_end ?


