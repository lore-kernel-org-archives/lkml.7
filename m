Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03C8C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8515220863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfFRSci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbfFRSch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:32:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01DB32084B;
        Tue, 18 Jun 2019 18:32:35 +0000 (UTC)
Date:   Tue, 18 Jun 2019 14:32:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/7] powerpc/ftrace: Update ftrace_location() for
 powerpc -mprofile-kernel
Message-ID: <20190618143234.78539805@gandalf.local.home>
In-Reply-To: <1560881840.vz9llflvnf.naveen@linux.ibm.com>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <186656540d3e6225abd98374e791a13d10d86fab.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190618114509.5b1acbe5@gandalf.local.home>
        <1560881411.p0i6a1dkwk.naveen@linux.ibm.com>
        <1560881840.vz9llflvnf.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 23:53:11 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Naveen N. Rao wrote:
> > Steven Rostedt wrote:  
> >> On Tue, 18 Jun 2019 20:17:04 +0530
> >> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >>   
> >>> @@ -1551,7 +1551,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> >>>  	key.flags = end;	/* overload flags, as it is unsigned long */
> >>>  
> >>>  	for (pg = ftrace_pages_start; pg; pg = pg->next) {
> >>> -		if (end < pg->records[0].ip ||
> >>> +		if (end <= pg->records[0].ip ||  
> >> 
> >> This breaks the algorithm. "end" is inclusive. That is, if you look for
> >> a single byte, where "start" and "end" are the same, and it happens to
> >> be the first ip on the pg page, it will be skipped, and not found.  
> > 
> > Thanks. It looks like I should be over-riding ftrace_location() instead.  
> > I will update this patch.  
> 
> I think I will have ftrace own the two instruction range, regardless of 
> whether the preceding instruction is a 'mflr r0' or not. This simplifies 
> things and I don't see an issue with it as of now. I will do more 
> testing to confirm.
> 
> - Naveen
> 
> 
> --- a/arch/powerpc/kernel/trace/ftrace.c
> +++ b/arch/powerpc/kernel/trace/ftrace.c
> @@ -951,6 +951,16 @@ void arch_ftrace_update_code(int command)
>  }
>  
>  #ifdef CONFIG_MPROFILE_KERNEL
> +/*
> + * We consider two instructions -- 'mflr r0', 'bl _mcount' -- to be part
> + * of ftrace. When checking for the first instruction, we want to include
> + * the next instruction in the range check.
> + */
> +unsigned long ftrace_location(unsigned long ip)
> +{
> +	return ftrace_location_range(ip, ip + MCOUNT_INSN_SIZE);
> +}
> +
>  /* Returns 1 if we patched in the mflr */
>  static int __ftrace_make_call_prep(struct dyn_ftrace *rec)
>  {
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 21d8e201ee80..122e2bb4a739 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1573,7 +1573,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>   * the function tracer. It checks the ftrace internal tables to
>   * determine if the address belongs or not.
>   */
> -unsigned long ftrace_location(unsigned long ip)
> +unsigned long __weak ftrace_location(unsigned long ip)
>  {
>  	return ftrace_location_range(ip, ip);
>  }

Actually, instead of making this a weak function, let's do this:


In include/ftrace.h:

#ifndef FTRACE_IP_EXTENSION
# define FTRACE_IP_EXTENSION	0
#endif


In arch/powerpc/include/asm/ftrace.h

#define FTRACE_IP_EXTENSION	MCOUNT_INSN_SIZE


Then we can just have:

unsigned long ftrace_location(unsigned long ip)
{
	return ftrace_location_range(ip, ip + FTRACE_IP_EXTENSION);
}

-- Steve
