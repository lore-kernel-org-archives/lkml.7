Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D097C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A4A20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfDPSUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:20:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:46945 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfDPSUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:20:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 11:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,358,1549958400"; 
   d="scan'208";a="316507663"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2019 11:20:18 -0700
Date:   Tue, 16 Apr 2019 11:20:18 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V3 11/32] x86/exceptions: Add structs for exception stacks
Message-ID: <20190416182018.GC21674@linux.intel.com>
References: <20190414155936.679808307@linutronix.de>
 <20190414160144.506807893@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414160144.506807893@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 05:59:47PM +0200, Thomas Gleixner wrote:
> At the moment everything assumes a full linear mapping of the various
> exception stacks. Adding guard pages to the cpu entry area mapping of the
> exception stacks will break that assumption.
> 
> As a preparatory step convert both the real storage and the effective
> mapping in the cpu entry area from character arrays to structures.
> 
> To ensure that both arrays have the same ordering and the same size of the
> individual stacks fill the members with a macro. The guard size is the only
> difference between the two resulting structures. For now both have guard
> size 0 until the preparation of all usage sites is done.
> 
> Provide a couple of helper macros which are used in the following
> conversions.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

One comment nit below, but other than that:

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

> V2 -> V3: Move the guards below the stacks and add a top guard. Fix the
>       	  TOP() macro.
> ---
>  arch/x86/include/asm/cpu_entry_area.h |   52 ++++++++++++++++++++++++++++++----
>  arch/x86/kernel/cpu/common.c          |    2 -
>  arch/x86/mm/cpu_entry_area.c          |    8 +----
>  3 files changed, 51 insertions(+), 11 deletions(-)
> 
> --- a/arch/x86/include/asm/cpu_entry_area.h
> +++ b/arch/x86/include/asm/cpu_entry_area.h
> @@ -7,6 +7,51 @@
>  #include <asm/processor.h>
>  #include <asm/intel_ds.h>
>  
> +#ifdef CONFIG_X86_64
> +
> +/* Macro to enforce the same ordering and stack sizes */
> +#define ESTACKS_MEMBERS(guardsize)		\
> +	char	DF_stack_guard[guardsize];	\
> +	char	DF_stack[EXCEPTION_STKSZ];	\
> +	char	NMI_stack_guard[guardsize];	\
> +	char	NMI_stack[EXCEPTION_STKSZ];	\
> +	char	DB_stack_guard[guardsize];	\
> +	char	DB_stack[DEBUG_STKSZ];		\
> +	char	MCE_stack_guard[guardsize];	\
> +	char	MCE_stack[EXCEPTION_STKSZ];	\
> +	char	IST_top_guard[guardsize];	\
> +
> +/* The exception stacks linear storage. No guard pages required */

How about s/linear/physical?  "linear" is confusing for us Intel wonks
(or maybe just me) because in Intel's parlance it means virtual addresses
for all intents and purposes.  And an apostrophe to show possession would
help readability, e.g.:

  /* The exception stacks' physical storage. No guard pages required */

> +struct exception_stacks {
> +	ESTACKS_MEMBERS(0)
> +};
> 
