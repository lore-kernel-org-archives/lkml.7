Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C3BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB98D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfDPWHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:07:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:16594 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPWHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:07:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 15:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,359,1549958400"; 
   d="scan'208";a="338111571"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2019 15:07:45 -0700
Date:   Tue, 16 Apr 2019 15:07:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V3 21/32] x86/exceptions: Split debug IST stack
Message-ID: <20190416220744.GA2487@linux.intel.com>
References: <20190414155936.679808307@linutronix.de>
 <20190414160145.439944544@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414160145.439944544@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 05:59:57PM +0200, Thomas Gleixner wrote:
> The debug IST stack is actually two separate debug stacks to handle #DB
> recursion. This is required because the CPU starts always at top of stack
> on exception entry, which means on #DB recursion the second #DB would
> overwrite the stack of the first.
> 
> The low level entry code therefore adjusts the top of stack on entry so a
> secondary #DB starts from a different stack page. But the stack pages are
> adjacent without a guard page between them.
> 
> Split the debug stack into 3 stacks which are separated by guard pages. The
> 3rd stack is never mapped into the cpu_entry_area and is only there to
> catch triple #DB nesting:
> 
>       --- top of DB_stack	<- Initial stack
>       --- end of DB_stack
>       	  guard page
> 
>       --- top of DB1_stack	<- Top of stack after entering first #DB
>       --- end of DB1_stack
>       	  guard page
> 
>       --- top of DB2_stack	<- Top of stack after entering second #DB
>       --- end of DB2_stack	   
>       	  guard page
> 
> If DB2 would not act as the final guard hole, a second #DB would point the
> top of #DB stack to the stack below #DB1 which would be valid and not catch
> the not so desired triple nesting.
> 
> The backing store does not allocate any memory for DB2 and its guard page
> as it is not going to be mapped into the cpu_entry_area.
> 
>  - Adjust the low level entry code so it adjusts top of #DB with the offset
>    between the stacks instead of exception stack size.
> 
>  - Make the dumpstack code aware of the new stacks.
> 
>  - Adjust the in_debug_stack() implementation and move it into the NMI code
>    where it belongs. As this is NMI hotpath code, it just checks the full
>    area between top of DB_stack and bottom of DB1_stack without checking
>    for the guard page. That's correct because the NMI cannot hit a
>    stackpointer pointing to the guard page between DB and DB1 stack.  Even
>    if it would, then the NMI operation still is unaffected, but the resume
>    of the debug exception on the topmost DB stack will crash by touching
>    the guard page.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

One nit below on the docs, otherwise:

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

> V2 -> V3: Fix off by one in in_debug_stack()
> ---
>  Documentation/x86/kernel-stacks       |    7 ++++++-
>  arch/x86/entry/entry_64.S             |    8 ++++----
>  arch/x86/include/asm/cpu_entry_area.h |   14 ++++++++++----
>  arch/x86/include/asm/debugreg.h       |    2 --
>  arch/x86/include/asm/page_64_types.h  |    3 ---
>  arch/x86/kernel/asm-offsets_64.c      |    2 ++
>  arch/x86/kernel/cpu/common.c          |   11 -----------
>  arch/x86/kernel/dumpstack_64.c        |   12 ++++++++----
>  arch/x86/kernel/nmi.c                 |   20 +++++++++++++++++++-
>  arch/x86/mm/cpu_entry_area.c          |    4 +++-
>  10 files changed, 52 insertions(+), 31 deletions(-)
> 
> --- a/Documentation/x86/kernel-stacks
> +++ b/Documentation/x86/kernel-stacks
> @@ -76,7 +76,7 @@ The currently assigned IST stacks are :-
>    middle of switching stacks.  Using IST for NMI events avoids making
>    assumptions about the previous state of the kernel stack.
>  
> -* ESTACK_DB.  DEBUG_STKSZ
> +* ESTACK_DB.  EXCEPTION_STKSZ (PAGE_SIZE).
>  
>    Used for hardware debug interrupts (interrupt 1) and for software
>    debug interrupts (INT3).
> @@ -86,6 +86,11 @@ The currently assigned IST stacks are :-
>    avoids making assumptions about the previous state of the kernel
>    stack.
>  
> +  To handle nested #DB correctly there exist two instances of DB stacks. On
> +  #DB entry the IST stackpointer for #DB is switched to the second instance
> +  so a nested #DB starts from a clean stack. The nested #DB switches to

Pretty sure the "to" at the end is unwanted.

> +  the IST stackpointer to a guard hole to catch triple nesting.
> +
>  * ESTACK_MCE.  EXCEPTION_STKSZ (PAGE_SIZE).
>  
>    Used for interrupt 18 - Machine Check Exception (#MC).
