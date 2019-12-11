Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E355C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EED822B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078565;
	bh=YVUZ/vc6IgD6/Q26ftSCQsbJ+vLqmFJ2jTNAXrSTNDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IJoh1dcrzjHDawOWH8ovnqXegLWUu0MFm3S55DWdDzeFBBy1Rgq6ijwnxkMNoXYRP
	 wLXbvj1WB06GKfsx05IfLcfqc3bdtuSvklglP8py5FVzlosGhBFQIDVAZBSFzDOUrD
	 cO0TPWDWKMnG4lFKQiKVKEbLA8hSCIlCUwlaIkZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfLKPgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388248AbfLKPfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:35:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897C12467A;
        Wed, 11 Dec 2019 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078553;
        bh=YVUZ/vc6IgD6/Q26ftSCQsbJ+vLqmFJ2jTNAXrSTNDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBwJHwSRgLJy69gVIVwZ4kbL4nYD5NZiRVa2hRm79107sA1YrrF9ZWFkFhkjCjtmZ
         E+CeShI53VgNln7NizWztinctv+FA2J+D1wEn9vnOB7pWChm2Icswh8xdZp4ezsAyR
         GwCqER1Iw+UkkyiNlP0SRKGyz6PIeQ1Qceq9clG4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 40/42] s390/cpum_sf: Check for SDBT and SDB consistency
Date:   Wed, 11 Dec 2019 10:35:08 -0500
Message-Id: <20191211153510.23861-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153510.23861-1-sashal@kernel.org>
References: <20191211153510.23861-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 247f265fa502e7b17a0cb0cc330e055a36aafce4 ]

Each SBDT is located at a 4KB page and contains 512 entries.
Each entry of a SDBT points to a SDB, a 4KB page containing
sampled data. The last entry is a link to another SDBT page.

When an event is created the function sequence executed is:

  __hw_perf_event_init()
  +--> allocate_buffers()
       +--> realloc_sampling_buffers()
	    +---> alloc_sample_data_block()

Both functions realloc_sampling_buffers() and
alloc_sample_data_block() allocate pages and the allocation
can fail. This is handled correctly and all allocated
pages are freed and error -ENOMEM is returned to the
top calling function. Finally the event is not created.

Once the event has been created, the amount of initially
allocated SDBT and SDB can be too low. This is detected
during measurement interrupt handling, where the amount
of lost samples is calculated. If the number of lost samples
is too high considering sampling frequency and already allocated
SBDs, the number of SDBs is enlarged during the next execution
of cpumsf_pmu_enable().

If more SBDs need to be allocated, functions

       realloc_sampling_buffers()
       +---> alloc-sample_data_block()

are called to allocate more pages. Page allocation may fail
and the returned error is ignored. A SDBT and SDB setup
already exists.

However the modified SDBTs and SDBs might end up in a situation
where the first entry of an SDBT does not point to an SDB,
but another SDBT, basicly an SBDT without payload.
This can not be handled by the interrupt handler, where an SDBT
must have at least one entry pointing to an SBD.

Add a check to avoid SDBTs with out payload (SDBs) when enlarging
the buffer setup.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index f46e5c0cb6d95..02476d2333df3 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -185,7 +185,7 @@ static int realloc_sampling_buffer(struct sf_buffer *sfb,
 				   unsigned long num_sdb, gfp_t gfp_flags)
 {
 	int i, rc;
-	unsigned long *new, *tail;
+	unsigned long *new, *tail, *tail_prev = NULL;
 
 	if (!sfb->sdbt || !sfb->tail)
 		return -EINVAL;
@@ -224,6 +224,7 @@ static int realloc_sampling_buffer(struct sf_buffer *sfb,
 			sfb->num_sdbt++;
 			/* Link current page to tail of chain */
 			*tail = (unsigned long)(void *) new + 1;
+			tail_prev = tail;
 			tail = new;
 		}
 
@@ -233,10 +234,22 @@ static int realloc_sampling_buffer(struct sf_buffer *sfb,
 		 * issue, a new realloc call (if required) might succeed.
 		 */
 		rc = alloc_sample_data_block(tail, gfp_flags);
-		if (rc)
+		if (rc) {
+			/* Undo last SDBT. An SDBT with no SDB at its first
+			 * entry but with an SDBT entry instead can not be
+			 * handled by the interrupt handler code.
+			 * Avoid this situation.
+			 */
+			if (tail_prev) {
+				sfb->num_sdbt--;
+				free_page((unsigned long) new);
+				tail = tail_prev;
+			}
 			break;
+		}
 		sfb->num_sdb++;
 		tail++;
+		tail_prev = new = NULL;	/* Allocated at least one SBD */
 	}
 
 	/* Link sampling buffer to its origin */
-- 
2.20.1

