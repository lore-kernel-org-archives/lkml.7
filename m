Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F4C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A802070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbfHFHxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:53:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:42958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfHFHxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:53:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84A25AD29;
        Tue,  6 Aug 2019 07:53:47 +0000 (UTC)
Subject: Re: [PATCH V2] fork: Improve error message for corrupted page tables
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5ba88460-cf01-3d53-6d13-45e650b4eacd@suse.cz>
Date:   Tue, 6 Aug 2019 09:53:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/6/19 5:05 AM, Sai Praneeth Prakhya wrote:
> When a user process exits, the kernel cleans up the mm_struct of the user
> process and during cleanup, check_mm() checks the page tables of the user
> process for corruption (E.g: unexpected page flags set/cleared). For
> corrupted page tables, the error message printed by check_mm() isn't very
> clear as it prints the loop index instead of page table type (E.g: Resident
> file mapping pages vs Resident shared memory pages). The loop index in
> check_mm() is used to index rss_stat[] which represents individual memory
> type stats. Hence, instead of printing index, print memory type, thereby
> improving error message.
> 
> Without patch:
> --------------
> [  204.836425] mm/pgtable-generic.c:29: bad p4d 0000000089eb4e92(800000025f941467)
> [  204.836544] BUG: Bad rss-counter state mm:00000000f75895ea idx:0 val:2
> [  204.836615] BUG: Bad rss-counter state mm:00000000f75895ea idx:1 val:5
> [  204.836685] BUG: non-zero pgtables_bytes on freeing mm: 20480
> 
> With patch:
> -----------
> [   69.815453] mm/pgtable-generic.c:29: bad p4d 0000000084653642(800000025ca37467)
> [   69.815872] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_FILEPAGES val:2
> [   69.815962] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_ANONPAGES val:5
> [   69.816050] BUG: non-zero pgtables_bytes on freeing mm: 20480
> 
> Also, change print function (from printk(KERN_ALERT, ..) to pr_alert()) so
> that it matches the other print statement.
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

I would also add something like this to reduce risk of breaking it in the
future:

----8<----
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index d7016dcb245e..a6f83cbe4603 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -36,6 +36,9 @@ struct vmacache {
 	struct vm_area_struct *vmas[VMACACHE_SIZE];
 };
 
+/*
+ * When touching this, update also resident_page_types in kernel/fork.c
+ */
 enum {
 	MM_FILEPAGES,	/* Resident file mapping pages */
 	MM_ANONPAGES,	/* Resident anonymous pages */
