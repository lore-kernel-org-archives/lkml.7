Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7822C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A097621726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDEUzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:55:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:54006 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfDEUzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:55:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 13:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="313516093"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2019 13:55:49 -0700
Date:   Fri, 5 Apr 2019 13:55:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 19/29] x86/exceptions: Split debug IST stack
Message-ID: <20190405205549.GE15808@linux.intel.com>
References: <20190405150658.237064784@linutronix.de>
 <20190405150930.129884669@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405150930.129884669@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:07:17PM +0200, Thomas Gleixner wrote:
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

...

> +static bool notrace is_debug_stack(unsigned long addr)
> +{
> +	struct cea_exception_stacks *cs = __this_cpu_read(cea_exception_stacks);
> +	unsigned long top = CEA_ESTACK_TOP(cs, DB);
> +	unsigned long bot = CEA_ESTACK_BOT(cs, DB1);
> +
> +	if (__this_cpu_read(debug_stack_usage))
> +		return true;
> +	/*
> +	 * Note, this covers the guard page between DB and DB1 as well to
> +	 * avoid two checks. But by all means @addr can never point into
> +	 * the guard page.
> +	 */
> +	return addr > bot && addr < top;

Isn't this an off by one error?  I.e. "return addr >= bot && addr < top".
%rsp == bot is technically still in the DB1 stack even though the next
PUSH/CALL will explode on the guard page.


> +}
> +NOKPROBE_SYMBOL(is_debug_stack);
>  #endif
>  
>  dotraplinkage notrace void
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -98,10 +98,12 @@ static void __init percpu_setup_exceptio
>  
>  	/*
>  	 * The exceptions stack mappings in the per cpu area are protected
> -	 * by guard pages so each stack must be mapped separately.
> +	 * by guard pages so each stack must be mapped separately. DB2 is
> +	 * not mapped; it just exists to catch triple nesting of #DB.
>  	 */
>  	cea_map_stack(DF);
>  	cea_map_stack(NMI);
> +	cea_map_stack(DB1);
>  	cea_map_stack(DB);
>  	cea_map_stack(MCE);
>  }
> 
> 
