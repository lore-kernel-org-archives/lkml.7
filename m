Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62134C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AF52085A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBbp390l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGCUWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:22:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LHuU3D+fxSQW20MsWAA8+d++JN4yA+fv7e++zT2VJjs=; b=BBbp390lSGDgNpxrKMWWzkELR
        5sam5VSbPB6R87R6j53kvxR3ihcTTpi8qb6vjPVQsUq6O4xg+cqS9xDRUISQo4+UnutSJG7wz1T+u
        CPsqq3nCHrVhqjBteB2wYDlZSTkiSNPtmHKhxuSv1jSAs1i0NhW7+NtzLWr+mijAB6Fc8X623tovd
        OfkChIY6iAw6PL/mTumz7Mq5c9pR4rnaLsY3BxYFs0fpoE1Ug0vaOZR1i+1VSSA672NfCHu8vSiSR
        F/Mw2/uzWCYuyVALQMntHs+buP2PoRYSjU3d+4ykavctRteGXvBP5aIqlRqGs9/Q3UwxWQ+ONIiYw
        kxBEqt9KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hilly-0001YM-MQ; Wed, 03 Jul 2019 20:22:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBB299802C5; Wed,  3 Jul 2019 22:22:31 +0200 (CEST)
Date:   Wed, 3 Jul 2019 22:22:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190703202231.GI16275@worktop.programming.kicks-ass.net>
References: <20190703102731.236024951@infradead.org>
 <20190703102807.588906400@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703102807.588906400@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:27:34PM +0200, root wrote:
> Despire the current efforts to read CR2 before tracing happens there
> still exist a number of possible holes:
> 
>   idtentry page_fault             do_page_fault           has_error_code=1
>     call error_entry
>       TRACE_IRQS_OFF
>         call trace_hardirqs_off*
>           #PF // modifies CR2
> 
>       CALL_enter_from_user_mode
>         __context_tracking_exit()
>           trace_user_exit(0)
>             #PF // modifies CR2
> 
>     call do_page_fault
>       address = read_cr2(); /* whoopsie */
> 
> And similar for i386.
> 
> Fix it by pulling the CR2 read into the entry code, before any of that
> stuff gets a chance to run and ruin things.
> 
> Ideally we'll clean up the entry code by moving this tracing and
> context tracking nonsense into C some day, but let's not delay fixing
> this longer.
> 

> @@ -1180,10 +1189,10 @@ idtentry xenint3		do_int3			has_error_co
>  #endif
>  
>  idtentry general_protection	do_general_protection	has_error_code=1
> -idtentry page_fault		do_page_fault		has_error_code=1
> +idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
>  
>  #ifdef CONFIG_KVM_GUEST
> -idtentry async_page_fault	do_async_page_fault	has_error_code=1
> +idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
>  #endif

While going over the various idt handlers, I found that we probably also
need read_cr2 on do_double_fault(), otherwise it is susceptible to the
same problem.


