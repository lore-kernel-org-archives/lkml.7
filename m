Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D057C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2517B20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbfC0KRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:17:06 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:46694 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbfC0KRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:17:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id EAF07180A8137;
        Wed, 27 Mar 2019 10:17:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snow43_77aadd6345f1b
X-Filterd-Recvd-Size: 4100
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Mar 2019 10:17:02 +0000 (UTC)
Message-ID: <a09c69261bdc463b5dc73c8693e4eda15fa1cd03.camel@perches.com>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
From:   Joe Perches <joe@perches.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Mar 2019 03:17:01 -0700
In-Reply-To: <20190327101133.GQ22899@mtr-leonro.mtl.com>
References: <20190327090905.5588-1-leon@kernel.org>
         <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
         <20190327093844.GO22899@mtr-leonro.mtl.com>
         <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
         <20190327095337.GP22899@mtr-leonro.mtl.com>
         <20190327101133.GQ22899@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 12:11 +0200, Leon Romanovsky wrote:
> On Wed, Mar 27, 2019 at 11:53:37AM +0200, Leon Romanovsky wrote:
> > On Wed, Mar 27, 2019 at 02:49:02AM -0700, Joe Perches wrote:
> > > On Wed, 2019-03-27 at 11:38 +0200, Leon Romanovsky wrote:
> > > > On Wed, Mar 27, 2019 at 02:17:40AM -0700, Joe Perches wrote:
> > > > > On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> > > > > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > > > > option) than available CPUs will have prints like this:
> > > > > []
> > > > > > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > > > > []
> > > > > > @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
> > > > > >  	if (num_processors >= nr_cpu_ids) {
> > > > > >  		int thiscpu = max + disabled_cpus;
> > > > > > 
> > > > > > -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> > > > > > -			   "reached. Processor %d/0x%x ignored.\n",
> > > > > > -			   max, thiscpu, apicid);
> > > > > > +		pr_debug(
> > > > > > +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > > > > > +			max, thiscpu, apicid);
> > > > > 
> > > > > 2 lines please
> > > > > 
> > > > > 		pr_debug("APIC: etc...",
> > > > > 			 max, thiscpu, ...);
> > > > 
> > > > It was two lines before, but I changed for two reasons:
> > > >  * It helped me to grep the source code to find the origin of dmesg warning.
> > > >  * i got checkpatch warning about spitted string, can you please fix checkpatch do not complain?
> > > 
> > > Yes, use
> > > 
> > > 	pr_debug("APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > > 		 max, thiscpu, apicid);
> > 
> > Ahh, I see, I got such change from clang formatter.
> > 
> > > or better
> > > 
> > > 	printk(KERN_DEBUG "APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > > 	       max, thiscpu, apicid);
> > > 
> > > > > And this would probably be better as
> > > > > 
> > > > > 		printk(KERN_DEBUG "APIC: etc...",
> > > > > 		 ...)
> > > > > 
> > > > > to avoid the need to compile with DEBUG or enable
> > > > > with CONFIG_DYNAMIC_DEBUG
> > > > 
> > > > You don't need anything like this, just provide dyndbg parameters
> > > > through kernel command line.
> > > 
> > > That assumes CONFIG_DYNAMIC_DEBUG is always enabled,
> > > and it is not enabled in many .config files.
> > 
> > No problem.
> 
> ok, I tested your variant and it still prints a t least on my systems,
> so it won't solve my problem. I'll keep this patch as is.

I believe it's more common to set the console logging level
to exclude the KERN_DEBUG level when appropriate.

https://linuxconfig.org/introduction-to-the-linux-kernel-log-levels


