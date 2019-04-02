Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BFEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B852B2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfDBQtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:49:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:46134 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbfDBQtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:49:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 09:49:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="136976771"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga008.fm.intel.com with ESMTP; 02 Apr 2019 09:49:01 -0700
Date:   Tue, 2 Apr 2019 09:49:00 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch 04/14] x86/exceptions: Make IST index zero based
Message-ID: <20190402164900.GC29004@linux.intel.com>
References: <20190331214020.836098943@linutronix.de>
 <20190331215135.133741719@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331215135.133741719@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:40:24PM +0200, Thomas Gleixner wrote:
> The defines for the exception stack (IST) array in the TSS are using the
> SDM convention IST1 - IST7. That causes all sorts of code to subtract 1 for
> array indices related to IST. That's confusing at best and does not provide
> any value.
> 
> Make the indices zero based and fixup the usage sites. The only code which
> needs to adjust the 0 based index is the interrupt descriptor setup which
> needs to add 1 now.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/x86/kernel-stacks      |    8 ++++----
>  arch/x86/entry/entry_64.S            |    4 ++--
>  arch/x86/include/asm/page_64_types.h |   13 ++++++++-----
>  arch/x86/kernel/cpu/common.c         |    4 ++--
>  arch/x86/kernel/dumpstack_64.c       |   14 +++++++-------
>  arch/x86/kernel/idt.c                |   15 +++++++++------
>  6 files changed, 32 insertions(+), 26 deletions(-)
> 
> --- a/Documentation/x86/kernel-stacks
> +++ b/Documentation/x86/kernel-stacks
> @@ -59,7 +59,7 @@ If that assumption is ever broken then t
>  
>  The currently assigned IST stacks are :-
>  
> -* DOUBLEFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
> +* DOUBLEFAULT_IST.  EXCEPTION_STKSZ (PAGE_SIZE).
>  
>    Used for interrupt 8 - Double Fault Exception (#DF).
>  
> @@ -68,7 +68,7 @@ The currently assigned IST stacks are :-
>    Using a separate stack allows the kernel to recover from it well enough
>    in many cases to still output an oops.
>  
> -* NMI_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
> +* NMI_IST.  EXCEPTION_STKSZ (PAGE_SIZE).
>  
>    Used for non-maskable interrupts (NMI).
>  
> @@ -76,7 +76,7 @@ The currently assigned IST stacks are :-
>    middle of switching stacks.  Using IST for NMI events avoids making
>    assumptions about the previous state of the kernel stack.
>  
> -* DEBUG_STACK.  DEBUG_STKSZ
> +* DEBUG_IST.  DEBUG_STKSZ

What about <name>_STACK_IST, or is that too verbose?  It'd be nice to have
the extra mental cue that IST is referring the 64 exception stacks.

>  
>    Used for hardware debug interrupts (interrupt 1) and for software
>    debug interrupts (INT3).
> @@ -86,7 +86,7 @@ The currently assigned IST stacks are :-
>    avoids making assumptions about the previous state of the kernel
>    stack.
>  
> -* MCE_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
> +* MCE_IST.  EXCEPTION_STKSZ (PAGE_SIZE).
>  
>    Used for interrupt 18 - Machine Check Exception (#MC).
>  
