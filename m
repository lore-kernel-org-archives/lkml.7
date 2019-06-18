Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7C0C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6EB2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfFRJ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:28:06 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47479 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfFRJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:28:06 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPGmZ-1hyPk2355h-00PcPO; Tue, 18 Jun 2019 11:27:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Roman Penyaev <rpenyaev@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmalloc: avoid bogus -Wmaybe-uninitialized warning
Date:   Tue, 18 Jun 2019 11:26:28 +0200
Message-Id: <20190618092650.2943749-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9NZTdj7yHA17SVjH2nsfAF6APnEovvSLZjPtTFenlB3oKrJaDJO
 stMbkNAyqRtMaQzlUFZq5gMFl9e5fUH+jLGvVh/1GxRU2mwjU22tOO198CJxWdQkTkKa3Gf
 n2Ur2ohACWrOuIv4HOFefTF6AimVTY39XDgbKSv4ASeO4vIQjq/vqMliduz7kXeQ4KpTxPc
 FDvntWSMeWiJ/cL7slu9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKozyIbKSIg=:4cBighBCTsEi6eFn3Hf1bU
 lTcJF857e6/rZJtR3ljY7QsUglzRcHnQctUHBRPg4y7AiM72cT4uMwRE73kKbK9g5TfwHQY8E
 VQilimjiv/r9kBJAzUZsudyviQqowepJjhFdgOacpEfKiEyWRFRZzzEK6FZOtll9gkRkzOw5r
 8xWT+IqMLi46wA1sStXC+tY/TlF8odu+MWInAbwPk8kRiuCZk4/LkbBrF90jUwXkC4+mH92Jo
 2jRAdjtEO5vQzkNvDlvxnGwwAXDMuinixOGPoDemcwmEPEz22KMOurOO/MxO9QIohwC+wlT67
 f4RVwVRt6BSqgFPXhop+vHSLMQCzafwkOiwhy0XGeUTympDL/b4MkJOAI98cA+pPZJ51IYdf+
 T2X99HWuhxgfjNC6X955THzCzutkwalUcQlCMmjbCdUoQ7Ntx+VobHF7dP5pKP7mda2QWVLHr
 PMjQhKGJT36gCvyMPyfPMNihxXGlX4NBilG7RFYqQd6MrUb40xcMB7IXKzIF8iemdM4lu6gjk
 MDWpUYsKFl7TFnxdCaTrTUMQnbS6D2C95hR77lH2COVISmVvutl9mmRtrMlebExExKkZZLiSF
 GTLThNbIGCAfmNu+T308kS6mfMbrwQ/SzFGeU9WsWRbSUwA7vsylBi+XUT/uIXY8CvCU+exgF
 m7P/Nf1kStwR/esTk5NIlZy/BJeqFP35zmhqtflX9Mt1sq3qXynZjCZFasJkvEGZCg+qBIJWW
 Y6t8thZrqAtdN20hVu4ohWcIwAk59XoX4z5hSg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc gets confused in pcpu_get_vm_areas() because there are too many
branches that affect whether 'lva' was initialized before it gets
used:

mm/vmalloc.c: In function 'pcpu_get_vm_areas':
mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    insert_vmap_area_augment(lva, &va->rb_node,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     &free_vmap_area_root, &free_vmap_area_list);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmalloc.c:916:20: note: 'lva' was declared here
  struct vmap_area *lva;
                    ^~~

Add an intialization to NULL, and check whether this has changed
before the first use.

Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/vmalloc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a9213fc3802d..42a6f795c3ee 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -913,7 +913,12 @@ adjust_va_to_fit_type(struct vmap_area *va,
 	unsigned long nva_start_addr, unsigned long size,
 	enum fit_type type)
 {
-	struct vmap_area *lva;
+	/*
+	 * GCC cannot always keep track of whether this variable
+	 * was initialized across many branches, therefore set
+	 * it NULL here to avoid a warning.
+	 */
+	struct vmap_area *lva = NULL;
 
 	if (type == FL_FIT_TYPE) {
 		/*
@@ -987,7 +992,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
 	if (type != FL_FIT_TYPE) {
 		augment_tree_propagate_from(va);
 
-		if (type == NE_FIT_TYPE)
+		if (lva)
 			insert_vmap_area_augment(lva, &va->rb_node,
 				&free_vmap_area_root, &free_vmap_area_list);
 	}
-- 
2.20.0

