Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD59C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999C721916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aENlgVdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfCUTDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:03:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34097 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfCUTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:03:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id j89so6278877ljb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xGkvEqNGg1FmNgP8daXo8IfQB6aKAByNQhjljGQbHd4=;
        b=aENlgVdh9MW7QBwI+wJLZ0uME7oEYLrbkGUTFRBfPCHa2g/3yaBhPO4wFYGU8/t37B
         D8W2Pkq31HNM/+C1D0feHeQr+0U2cjo521Fo72XEyrCjQkD788yRSdFtExeJOA9rvy+R
         RdlCYXIHZZPY/n2EzJdUtVke14kb6M7/uVtN0m2nUCQrvTkvLYxDUg08iqaFIX/+1gGm
         Gc/qIe4APfWXJ1vM3bprKMoKLRk0avBVeJtGK2VzpUzWptjtrqFthReawQQ3ChTXaew1
         zXrLG6rtdvF6NZyFyBG+dKqVbkwIsCQdxzoGNo6X/YJjdC95zwYgglb6lBuoCLCfeGeo
         21Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xGkvEqNGg1FmNgP8daXo8IfQB6aKAByNQhjljGQbHd4=;
        b=Uf3L3XJSPPuE3qe4R3/7nZmYJUQoDRkfBIS6ZrK/DbHGE8kijN8CeMlMqUfmodTcr2
         gJWFO74tkWEE7KNQIE+rsBCBF5BS+6QEYc1kPMJYSa3una8l7G8JlOP/QCzDwu18h+1e
         eJPhoG0UHctKX3hL/FXCsLiBCEIoIu+Rd4Q8H00ZcPEmNfwMv9p0z/4/DkWZY5KSdGIK
         AqWGvIwlbxSkQeON+lFl1g6TSrujxkRqID9ZD8eQyj7Bi+PsLqLK1P7G8f1n/BDK62vc
         7wsC7lSjsEoLYeO/9bHgzb0NysvZoy0BXg1SogVG3EQM65U/iYR/0MtQNpIxoTBM96uw
         lg8g==
X-Gm-Message-State: APjAAAWF1IUmV161CGl3XRxRCYV7NyiS1aDxDyuoZ2QlNWIFCMpXLAgU
        hN+VMvtCuIdK/K5ss5+wVZU=
X-Google-Smtp-Source: APXvYqzvjTn/SSfN6iZd+YX4flyh4KFycf4Yc7cfMtWourXm25wpNczDOo2kQpr81Way70VfT/hLIQ==
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr2975364ljh.184.1553195018208;
        Thu, 21 Mar 2019 12:03:38 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id o3sm1119032lfd.53.2019.03.21.12.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:03:36 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC PATCH v2 0/1] improve vmap allocation
Date:   Thu, 21 Mar 2019 20:03:26 +0100
Message-Id: <20190321190327.11813-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is the v2 of the https://lkml.org/lkml/2018/10/19/786 rework. Instead of
referring you to that link, i will go through it again describing the improved
allocation method and provide changes between v1 and v2 in the end.

Objective
---------
Please have a look for the description at: https://lkml.org/lkml/2018/10/19/786
But let me also summarize it a bit here as well. The current implementation has O(N)
complexity. Requests with different permissive parameters can lead to long allocation
time. When i say "long" i mean milliseconds. 

Description
-----------
This approach organizes the KVA memory layout into free areas of the 1-ULONG_MAX
range, i.e. an allocation is done over free areas lookups, instead of finding
a hole between two busy blocks. It allows to have lower number of objects which
represent the free space, therefore to have less fragmented memory allocator.
Because free blocks are always as large as possible.

It uses the augment tree where all free areas are sorted in ascending order of
va->va_start address in pair with linked list that provides O(1) access to
prev/next elements.

Since the tree is augment, we also maintain the "subtree_max_size" of VA that
reflects a maximum available free block in its left or right sub-tree. Knowing
that, we can easily traversal toward the lowest(left most path) free area.

Allocation: ~O(log(N)) complexity. It is sequential allocation method therefore
tends to maximize locality. The search is done until a first suitable block is
large enough to encompass the requested parameters. Bigger areas are split.

I copy paste here the description of how the area is split, since i described
it in https://lkml.org/lkml/2018/10/19/786

<snip>
A free block can be split by three different ways. Their names are FL_FIT_TYPE,
LE_FIT_TYPE/RE_FIT_TYPE and NE_FIT_TYPE, i.e. they correspond to how requested
size and alignment fit to a free block.

FL_FIT_TYPE - in this case a free block is just removed from the free list/tree
because it fully fits. Comparing with current design there is an extra work with
rb-tree updating.

LE_FIT_TYPE/RE_FIT_TYPE - left/right edges fit. In this case what we do is
just cutting a free block. It is as fast as a current design. Most of the vmalloc
allocations just end up with this case, because the edge is always aligned to 1.

NE_FIT_TYPE - Is much less common case. Basically it happens when requested size
and alignment does not fit left nor right edges, i.e. it is between them. In this
case during splitting we have to build a remaining left free area and place it
back to the free list/tree.

Comparing with current design there are two extra steps. First one is we have to
allocate a new vmap_area structure. Second one we have to insert that remaining 
free block to the address sorted list/tree.

In order to optimize a first case there is a cache with free_vmap objects. Instead
of allocating from slab we just take an object from the cache and reuse it.

Second one is pretty optimized. Since we know a start point in the tree we do not
do a search from the top. Instead a traversal begins from a rb-tree node we split.
<snip>

De-allocation. ~O(log(N)) complexity. An area is not inserted straight away to the
tree/list, instead we identify the spot first, checking if it can be merged around
neighbors. The list provides O(1) access to prev/next, so it is pretty fast to check
it. Summarizing. If merged then large coalesced areas are created, if not the area
is just linked making more fragments.

There is one more thing that i should mention here. After modification of VA node,
its subtree_max_size is updated if it was/is the biggest area in its left or right
sub-tree. Apart of that it can also be populated back to upper levels to fix the tree.
For more details please have a look at the __augment_tree_propagate_from() function
and the description.

Tests and stressing
-------------------
I use the "test_vmalloc.sh" test driver available under "tools/testing/selftests/vm/"
since 5.1-rc1 kernel. Just trigger "sudo ./test_vmalloc.sh" to find out how to deal
with it.

Tested on different platforms including x86_64/i686/ARM64/x86_64_NUMA. Regarding last
one, i do not have any physical access to NUMA system, therefore i emulated it. The
time of stressing is days.

If you run the test driver in "stress mode", you also need the patch that is in
Andrew's tree but not in Linux 5.1-rc1. So, please apply it:

http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/commit/?id=e0cf7749bade6da318e98e934a24d8b62fab512c

After massive testing, i have not identified any problems like memory leaks, crashes
or kernel panics. I find it stable, but more testing would be good.

Performance analysis
--------------------
I have used two systems to test. One is i5-3320M CPU @ 2.60GHz and another
is HiKey960(arm64) board. i5-3320M runs on 4.20 kernel, whereas Hikey960
uses 4.15 kernel. I have both system which could run on 5.1-rc1 as well, but
the results have not been ready by time i an writing this.

Currently it consist of 8 tests. There are three of them which correspond to different
types of splitting(to compare with default). We have 3 ones(see above). Another 5 do
allocations in different conditions.

a) sudo ./test_vmalloc.sh performance
When the test driver is run in "performance" mode, it runs all available tests pinned
to first online CPU with sequential execution test order. We do it in order to get stable
and repeatable results. Take a look at time difference in "long_busy_list_alloc_test".
It is not surprising because the worst case is O(N).

# i5-3320M
How many cycles all tests took:
CPU0=646919905370(default) cycles vs CPU0=193290498550(patched) cycles

# See detailed table with results here:
ftp://vps418301.ovh.net/incoming/vmap_test_results_v2/i5-3320M_performance_default.txt
ftp://vps418301.ovh.net/incoming/vmap_test_results_v2/i5-3320M_performance_patched.txt

# Hikey960 8x CPUs
How many cycles all tests took:
CPU0=3478683207 cycles vs CPU0=463767978 cycles

# See detailed table with results here:
ftp://vps418301.ovh.net/incoming/vmap_test_results_v2/HiKey960_performance_default.txt
ftp://vps418301.ovh.net/incoming/vmap_test_results_v2/HiKey960_performance_patched.txt

b) time sudo ./test_vmalloc.sh test_repeat_count=1
With this configuration, all tests are run on all available online CPUs. Before running
each CPU shuffles its tests execution order. It gives random allocation behaviour. So
it is rough comparison, but it puts in the picture for sure.

# i5-3320M
<default>            vs            <patched>
real    101m22.813s                real    0m56.805s
user    0m0.011s                   user    0m0.015s
sys     0m5.076s                   sys     0m0.023s

# See detailed table with results here:
ftp://vps418301.ovh.net/incoming/vmap_test_results_v2/i5-3320M_test_repeat_count_1_default.txt
ftp://vps418301.ovh.net/incoming/vmap_test_results_v2/i5-3320M_test_repeat_count_1_patched.txt

# Hikey960 8x CPUs
<default>            vs            <patched>
real    unknown                    real    4m25.214s
user    unknown                    user    0m0.011s
sys     unknown                    sys     0m0.670s

I did not manage to complete this test on "default Hikey960" kernel version.
After 24 hours it was still running, therefore i had to cancel it. That is why
real/user/sys are "unknown".

Changes in v2
-------------
- do not distinguish vmalloc and other vmap allocations;
- use kmem_cache for vmap_area objects instead of own implementation;
- remove vmap cache globals;
- fix pcpu allocator on NUMA systems;
- now complexity is ~O(log(N)).

Appreciate for any comments and your time spent on it.

Uladzislau Rezki (Sony) (1):
  mm/vmap: keep track of free blocks for vmap allocation

 include/linux/vmalloc.h |    6 +-
 mm/vmalloc.c            | 1109 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 871 insertions(+), 244 deletions(-)

-- 
2.11.0

