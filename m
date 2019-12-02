Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670D5215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLBIcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:32:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:63093 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfLBIcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:32:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 00:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="222345773"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2019 00:32:18 -0800
Subject: Re: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, mceier@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Kenneth R. Crudup" <kenny@panix.com>
References: <20191127005312.GD20422@shao2-debian>
 <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
 <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
 <20191201104624.GA51279@gmail.com> <20191201144947.GA4167@gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <45ca8086-b7ce-1561-c7d1-3580872d2ba8@intel.com>
Date:   Mon, 2 Dec 2019 16:31:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191201144947.GA4167@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

The patch fixes the regression reported by 0day-CI.

    "[LKP] [x86/mm/pat] 8d04a5f97a: phoronix-test-suite.glmark2.0.score 
-23.7% regression": 
https://lkml.kernel.org/r/20191127005312.GD20422@shao2-debian

Best Regards,
Rong Chen

On 12/1/19 10:49 PM, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
>
>> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> But the final difference is a real difference where it used to be WC,
>>> and is now UC-:
>>>
>>>      -write-combining @ 0x2000000000-0x2100000000
>>>      -write-combining @ 0x2000000000-0x2100000000
>>>      +uncached-minus @ 0x2000000000-0x2100000000
>>>      +uncached-minus @ 0x2000000000-0x2100000000
>>>
>>> which certainly could easily explain the huge performance degradation.
>> It's not an unconditional regression, as both Boris and me tried to
>> reproduce it on different systems that do ioremap_wc() as well and didn't
>> measure a slowdown, but something about the memory layout probably
>> triggers the tree management bug.
> Ok, I think I found at least one bug in the new PAT code, the conversion
> of memtype_check_conflict() is buggy I think:
>
>     8d04a5f97a5f: ("x86/mm/pat: Convert the PAT tree to a generic interval tree")
>
>          dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
>          found_type = match->type;
>   
> -       node = rb_next(&match->rb);
> -       while (node) {
> -               match = rb_entry(node, struct memtype, rb);
> -
> -               if (match->start >= end) /* Checked all possible matches */
> -                       goto success;
> -
> -               if (is_node_overlap(match, start, end) &&
> -                   match->type != found_type) {
> +       match = memtype_interval_iter_next(match, start, end);
> +       while (match) {
> +               if (match->type != found_type)
>                          goto failure;
> -               }
>   
> -               node = rb_next(&match->rb);
> +               match = memtype_interval_iter_next(match, start, end);
>          }
>
>
> Note how the '>= end' condition to end the interval check, got converted
> into:
>
> +       match = memtype_interval_iter_next(match, start, end);
>
> This is subtly off by one, because the interval trees interfaces require
> closed interval parameters:
>
>    include/linux/interval_tree_generic.h
>
>   /*                                                                            \
>    * Iterate over intervals intersecting [start;last]                           \
>    *                                                                            \
>    * Note that a node's interval intersects [start;last] iff:                   \
>    *   Cond1: ITSTART(node) <= last                                             \
>    * and                                                                        \
>    *   Cond2: start <= ITLAST(node)                                             \
>    */                                                                           \
>
>    ...
>
>                  if (ITSTART(node) <= last) {            /* Cond1 */           \
>                          if (start <= ITLAST(node))      /* Cond2 */           \
>                                  return node;    /* node is leftmost match */  \
>
> [start;last] is a closed interval (note that '<= last' check) - while the
> PAT 'end' parameter is 1 byte beyond the end of the range, because
> ioremap() and the other mapping APIs usually use the [start,end)
> half-open interval, derived from 'size'.
>
> This is what ioremap() does for example:
>
>          /*
>           * Mappings have to be page-aligned
>           */
>          offset = phys_addr & ~PAGE_MASK;
>          phys_addr &= PHYSICAL_PAGE_MASK;
>          size = PAGE_ALIGN(last_addr+1) - phys_addr;
>
>          retval = reserve_memtype(phys_addr, (u64)phys_addr + size,
>                                                  pcm, &new_pcm);
>
>
> phys_addr+size will be on a page boundary, after the last byte of the
> mapped interval.
>
> So the correct parameter to use in the interval tree searches is not
> 'end' but 'end-1'.
>
> This could have relevance if conflicting PAT ranges are exactly adjacent,
> for example a future WC region is followed immediately by an already
> mapped UC- region - in this case memtype_check_conflict() would
> incorrectly deny the WC memtype region and downgrade the memtype to UC-.
>
> BTW., rather annoyingly this downgrading is done silently in
> memtype_check_insert():
>
> int memtype_check_insert(struct memtype *new,
>                           enum page_cache_mode *ret_type)
> {
>          int err = 0;
>
>          err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
>          if (err)
>                  return err;
>
>          if (ret_type)
>                  new->type = *ret_type;
>
>          memtype_interval_insert(new, &memtype_rbroot);
>          return 0;
> }
>
>
> So on such a conflict we'd just silently get UC- in *ret_type, and write
> it into the new region, never the wiser ...
>
> So assuming that the patch below fixes the primary bug the diagnostics
> side of ioremap() cache attribute downgrades would be another thing to
> fix.
>
> Anyway, I checked all the interval-tree iterations, and most of them are
> off by one - but I think the one related to memtype_check_conflict() is
> the one causing this particular performance regression.
>
> The only correct interval-tree searches were these two:
>
> arch/x86/mm/pat_interval.c:     match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
> arch/x86/mm/pat_interval.c:             match = memtype_interval_iter_next(match, 0, ULONG_MAX);
>
> The ULONG_MAX was hiding the off-by-one in plain sight. :-)
>
> So it would be nice if everyone who is seeing this bug could test the
> patch below against Linus's latest tree - does it fix the regression?
>
> If not then please send the before/after dump of
> /sys/kernel/debug/x86/pat_memtype_list - and even if it works please send
> the dumps so we can double check it all.
>
> Note that the bug was benign in the sense of implementing a too strict
> cache attribute conflict policy and downgrading cache attributes - so
> AFAICS the worst outcome of this bug would be a performance regression.
>
> Patch is only lightly tested, so take care. (Patch is emphatically not
> signed off yet, because I spent most of the day on this and I don't yet
> trust my fix - all of the affected sites need to be reviewed more
> carefully.)
>
> Thanks,
>
> 	Ingo
>
>
> ====================>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Sun, 1 Dec 2019 15:25:50 +0100
> Subject: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
>
> NOT-Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>   arch/x86/mm/pat_interval.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
> index 47a1bf30748f..6855362eaf21 100644
> --- a/arch/x86/mm/pat_interval.c
> +++ b/arch/x86/mm/pat_interval.c
> @@ -56,7 +56,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
>   {
>   	struct memtype *match;
>   
> -	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
> +	match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
>   	while (match != NULL && match->start < end) {
>   		if ((match_type == MEMTYPE_EXACT_MATCH) &&
>   		    (match->start == start) && (match->end == end))
> @@ -66,7 +66,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
>   		    (match->start < start) && (match->end == end))
>   			return match;
>   
> -		match = memtype_interval_iter_next(match, start, end);
> +		match = memtype_interval_iter_next(match, start, end-1);
>   	}
>   
>   	return NULL; /* Returns NULL if there is no match */
> @@ -79,7 +79,7 @@ static int memtype_check_conflict(u64 start, u64 end,
>   	struct memtype *match;
>   	enum page_cache_mode found_type = reqtype;
>   
> -	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
> +	match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
>   	if (match == NULL)
>   		goto success;
>   
> @@ -89,12 +89,12 @@ static int memtype_check_conflict(u64 start, u64 end,
>   	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
>   	found_type = match->type;
>   
> -	match = memtype_interval_iter_next(match, start, end);
> +	match = memtype_interval_iter_next(match, start, end-1);
>   	while (match) {
>   		if (match->type != found_type)
>   			goto failure;
>   
> -		match = memtype_interval_iter_next(match, start, end);
> +		match = memtype_interval_iter_next(match, start, end-1);
>   	}
>   success:
>   	if (newtype)
> @@ -160,7 +160,7 @@ struct memtype *memtype_erase(u64 start, u64 end)
>   struct memtype *memtype_lookup(u64 addr)
>   {
>   	return memtype_interval_iter_first(&memtype_rbroot, addr,
> -					   addr + PAGE_SIZE);
> +					   addr + PAGE_SIZE-1);
>   }
>   
>   #if defined(CONFIG_DEBUG_FS)

