Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D76FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7992075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbfC0JRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:17:45 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:58174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726257AbfC0JRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:17:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id DD2108368EF3;
        Wed, 27 Mar 2019 09:17:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cap26_262802fd6db42
X-Filterd-Recvd-Size: 1997
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Mar 2019 09:17:42 +0000 (UTC)
Message-ID: <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
From:   Joe Perches <joe@perches.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Mar 2019 02:17:40 -0700
In-Reply-To: <20190327090905.5588-1-leon@kernel.org>
References: <20190327090905.5588-1-leon@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> Kernel is booted with less possible CPUs (possible_cpus kernel boot
> option) than available CPUs will have prints like this:
[]
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
[]
> @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
>  	if (num_processors >= nr_cpu_ids) {
>  		int thiscpu = max + disabled_cpus;
> 
> -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> -			   "reached. Processor %d/0x%x ignored.\n",
> -			   max, thiscpu, apicid);
> +		pr_debug(
> +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> +			max, thiscpu, apicid);

2 lines please

		pr_debug("APIC: etc...",
			 max, thiscpu, ...);

And this would probably be better as

		printk(KERN_DEBUG "APIC: etc...",
		 ...)

to avoid the need to compile with DEBUG or enable
with CONFIG_DYNAMIC_DEBUG



