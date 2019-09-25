Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13530C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22DF20665
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633847AbfIYDua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 23:50:30 -0400
Received: from foss.arm.com ([217.140.110.172]:41132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633617AbfIYDu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:50:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3743C1570;
        Tue, 24 Sep 2019 20:50:29 -0700 (PDT)
Received: from [10.162.41.120] (p8cg001049571a15.blr.arm.com [10.162.41.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06B0F3F694;
        Tue, 24 Sep 2019 20:50:26 -0700 (PDT)
Subject: Re: [PATCH] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
 <f505cc64-ddff-4c1a-2659-7a3890055d73@arm.com>
 <20190924201335.0af280458bf68d7f57acb637@linux-foundation.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9262a7bf-72d9-e23a-a8a3-4f026ee2e4a2@arm.com>
Date:   Wed, 25 Sep 2019 09:20:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190924201335.0af280458bf68d7f57acb637@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/25/2019 08:43 AM, Andrew Morton wrote:
> On Mon, 23 Sep 2019 11:16:38 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>>
>>
>> On 09/16/2019 11:17 AM, Anshuman Khandual wrote:
>>> In add_memory_resource() the memory range to be hot added first gets into
>>> the memblock via memblock_add() before arch_add_memory() is called on it.
>>> Reverse sequence should be followed during memory hot removal which already
>>> is being followed in add_memory_resource() error path. This now ensures
>>> required re-order between memblock_[free|remove]() and arch_remove_memory()
>>> during memory hot-remove.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> Original patch https://lkml.org/lkml/2019/9/3/327
>>>
>>> Memory hot remove now works on arm64 without this because a recent commit
>>> 60bb462fc7ad ("drivers/base/node.c: simplify unregister_memory_block_under_nodes()").
>>>
>>> David mentioned that re-ordering should still make sense for consistency
>>> purpose (removing stuff in the reverse order they were added). This patch
>>> is now detached from arm64 hot-remove series.
>>>
>>> https://lkml.org/lkml/2019/9/3/326
>>
>> ...
>>
>> Hello Andrew,
>>
>> Any feedbacks on this, does it look okay ?
>>
> 
> Well.  I'd parked this for 5.4-rc1 processing because it looked like a
> cleanup.

This does not fix a serious problem. It just removes an inconsistency while
freeing resources during memory hot remove which for now does not pose a
real problem.

> 
> But waaaay down below the ^---$ line I see "Memory hot remove now works
> on arm64".  Am I correct in believing that 60bb462fc7ad broke arm64 mem
> hot remove?  And that this patch fixes a serious regression?  If so,

No. [Proposed] arm64 memory hot remove series does not anymore depend on
this particular patch because 60bb462fc7ad has already solved the problem.

> that should have been right there in the patch title and changelog!

V2 (https://patchwork.kernel.org/patch/11159939/) for this patch makes it
very clear in it's commit message.

- Anshuman
