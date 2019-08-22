Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A7C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B966233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbfHVEtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:49:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:34556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729695AbfHVEtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 00:49:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90C78ADEC;
        Thu, 22 Aug 2019 04:49:43 +0000 (UTC)
Date:   Wed, 21 Aug 2019 21:49:36 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Message-ID: <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
References: <20190813224620.31005-1-dave@stgolabs.net>
 <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821215707.GA99147@google.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019, Michel Lespinasse wrote:

>On Tue, Aug 13, 2019 at 03:46:18PM -0700, Davidlohr Bueso wrote:
>> o The border cases for overlapping differ -- interval trees are closed,
>> while memtype intervals are open. We need to maintain semantics such
>> that conflict detection and getting the lowest match does not change.
>
>Agree on the need to maintain semantics.
>
>As I had commented some time ago, I wish the interval trees used [start,end)
>intervals instead of [start,last] - it would be a better fit for basically
>all of the current interval tree users.

Yes, after going through all the users of interval-tree,  I agree that
they all want to use [start,end intervals.

>
>I'm not sure where to go with this - would it make sense to add a new
>interval tree header file that uses [start,end) intervals (with the
>thought of eventually converting all current interval tree users to it)
>instead of adding one more use of the less-natural [start,last]
>interval trees ?

It might be the safest way, although I really hate having another
header file for interval_tree... The following is a diffstat of a
tentative conversion (I'll send the patch separately); I'm not sure
if a single shot conversion would be acceptable, albeit with relevant
maintainer acks.

 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c      |  8 +-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  5 +++--
 drivers/gpu/drm/drm_mm.c                    |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 13 +++++--------
 drivers/gpu/drm/radeon/radeon_mn.c          | 10 +++-------
 drivers/gpu/drm/radeon/radeon_vm.c          |  2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c         | 12 ++++++------
 drivers/iommu/virtio-iommu.c                |  4 ++--
 drivers/vhost/vhost.c                       |  6 +++---
 include/drm/drm_mm.h                        |  2 +-
 include/linux/interval_tree_generic.h       | 28 ++++++++++++++--------------
 mm/interval_tree.c                          |  2 +-
 mm/rmap.c                                   |  2 +-
 13 files changed, 42 insertions(+), 54 deletions(-)

This gets rid of 'end - 1' trick from the users and converts
cond1 and cond2 checks in interval_tree_generic.h

Note that I think amdgpu_vm.c actually uses fully open intervals.

>
>> diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
>> index fa16036fa592..1be4d1856a9b 100644
>> --- a/arch/x86/mm/pat_rbtree.c
>> +++ b/arch/x86/mm/pat_rbtree.c
>> @@ -12,7 +12,7 @@
>>  #include <linux/seq_file.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/kernel.h>
>> -#include <linux/rbtree_augmented.h>
>> +#include <linux/interval_tree_generic.h>
>>  #include <linux/sched.h>
>>  #include <linux/gfp.h>
>>
>> @@ -34,68 +34,41 @@
>>   * memtype_lock protects the rbtree.
>>   */
>>
>> -static struct rb_root memtype_rbroot = RB_ROOT;
>> +static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
>> +
>> +#define START(node) ((node)->start)
>> +#define END(node)  ((node)->end)
>> +INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
>> +		     START, END, static, memtype_interval)
>>
>>  static int is_node_overlap(struct memtype *node, u64 start, u64 end)
>>  {
>> -	if (node->start >= end || node->end <= start)
>> +	/*
>> +	 * Unlike generic interval trees, the memtype nodes are ]a, b[
>
>I think the memtype nodes are [a, b)  (which one could also write as [a, b[
>depending on their local customs - but either way, closed on the start side
>and open on the end side) ?
>
>> +	 * therefore we need to adjust the ranges accordingly. Missing
>> +	 * an overlap can lead to incorrectly detecting conflicts,
>> +	 * for example.
>> +	 */
>> +	if (node->start + 1 >= end || node->end - 1 <= start)
>>  		return 0;
>>
>>  	return 1;
>>  }
>
>All right, now I am *really* confused.
>
>My understanding is as follows:
>* the PAT code wants to use [start, end( intervals
>* interval trees are defined to use [start, last] intervals with last == end-1

Yes, we're talking about the same thing, but I overcomplicated things by
considering memtype lookups to be different than the nodes in the tree;
which obviously doesn't make sense... it is actually [a,b[ as you mention.

>
>At first, I thought that you were handling that by removing 1 from the
>end of the interval, to adjust between the PAT and interval tree
>definitions. But, I don't see you doing that anywhere.

This should have been my first approach.

>
>Then, I thought that you were using [start, end( intervals everywhere,
>and the interval tree functions memtype_interval_iter_first and
>memtype_interval_iter_next would just return too many candidate
>matches as as you are passing "end" instead of "last" == end-1 as the
>interval endpoint, but then you would filter out the extra intervals
>using is_node_overlap(). But, if that is the case, then I don't
>understand why you need to redefine is_node_overlap() here.

My original expectation was to actually remove a lot more of pat_rbtree,
including the is_node_overlap() and the filtering. Yes, I think this can
be done if the interval-tree is converted to [a,b[ and we can thus
just iterate the tree seamlessly.

>
>Could you help me out by defining if the intervals are open or closed,
>both when stored in the node->start and node->end values, and when
>passed as start and end arguments to the functions in this file ?

No, no endpoints are modified in pat.

>
>Generally, I think using the interval tree code in this file is a good idea,
>but 1- I do not understand how you are handling the differences in interval
>definitions in this change, and 2- I wonder if it'd be better to just have
>a version of the interval tree code that handles [start,end( half-open
>intervals like we do everywhere else in the kernel.

I think doing the conversion you suggested to [a,b[ for all users, then
redoing this series on top of that would be the way to move forward.

Thanks,
Davidlohr
