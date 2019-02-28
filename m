Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C99C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72145218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320338;
	bh=y2AbS58YsJY2/mH3mX5zdeqDSlWLMXC8T8Nw6hv+cmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qcJY/ol/a77PHWWGx3rA6PFbtaP5m/e1th9hBc1v0kxouFZRY2bF/2Nhunx/2/ehn
	 pFbtNl33NlFzEj5jvbjRtvJxX08RV5VW+EpegsPpmqrcp1MaBhn5igbxZzFOQqCIvR
	 b502x+u7XLauH28SlltE7v19+AV7di0pc7Q6RAfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfB1CS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:18:57 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35849 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730706AbfB1CSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id c2so10482096qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O/uMqMX1RLXk35wATf5Bntd/FX1DZTwSKmJPgUmEjAI=;
        b=MCCbKf9KlYbc8pDJ3g8WUZyh0a1kzcM75kR6ogClbXQbKJbmoJzQLAUtNzfWFM6xgx
         GX4VxbcsfV/Unrd+OThj17x8turPAn4ug2vBHfdvtFytzOcpS7i23C6N6XgPgbpAj4zT
         4LZfXEA7kZ96aPC55IPjR/0RGcFqGg3VoS2PcxP59znCwWDO/kOgAZThncDBmUS2OeU4
         6nhzuDKVtTBwAy8ec2rXkMs6c0vhV/p4qsbTLX5Xjg9CP7YOZh6ghT3WgjYKc4zrm4JA
         HGfAfNX9hV7TzaKB5OoIW9/Pm/OCVH8vMYUH0t5XfOz/xISNyYUQ9Hq6IMtovecgNSQQ
         bykQ==
X-Gm-Message-State: AHQUAuZvsq6wPziEvcajc4EhQUtzUQGzY3jAKYu5ivPh6+tJUXVlmCL8
        dU4iaTdOSKpe33Ob3d0ciS0=
X-Google-Smtp-Source: AHgI3IYECaM0BaxRf5kUox7pcWekLOEUD4uDb49QmaHf/LLer2jiYKA1I5O2KDyJ1YPW/ofrNvgcaQ==
X-Received: by 2002:a37:d6c6:: with SMTP id p67mr4570900qkl.329.1551320331211;
        Wed, 27 Feb 2019 18:18:51 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:50 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] percpu: relegate chunks unusable when failing small allocations
Date:   Wed, 27 Feb 2019 21:18:32 -0500
Message-Id: <20190228021839.55779-6-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain cases, requestors of percpu memory may want specific
alignments. However, it is possible to end up in situations where the
contig_hint matches, but the alignment does not. This causes excess
scanning of chunks that will fail. To prevent this, if a small
allocation fails (< 32B), the chunk is moved to the empty list. Once an
allocation is freed from that chunk, it is placed back into rotation.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index c996bcffbb2a..3d7deece9556 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -94,6 +94,8 @@
 
 /* the slots are sorted by free bytes left, 1-31 bytes share the same slot */
 #define PCPU_SLOT_BASE_SHIFT		5
+/* chunks in slots below this are subject to being sidelined on failed alloc */
+#define PCPU_SLOT_FAIL_THRESHOLD	3
 
 #define PCPU_EMPTY_POP_PAGES_LOW	2
 #define PCPU_EMPTY_POP_PAGES_HIGH	4
@@ -488,6 +490,22 @@ static void pcpu_mem_free(void *ptr)
 	kvfree(ptr);
 }
 
+static void __pcpu_chunk_move(struct pcpu_chunk *chunk, int slot,
+			      bool move_front)
+{
+	if (chunk != pcpu_reserved_chunk) {
+		if (move_front)
+			list_move(&chunk->list, &pcpu_slot[slot]);
+		else
+			list_move_tail(&chunk->list, &pcpu_slot[slot]);
+	}
+}
+
+static void pcpu_chunk_move(struct pcpu_chunk *chunk, int slot)
+{
+	__pcpu_chunk_move(chunk, slot, true);
+}
+
 /**
  * pcpu_chunk_relocate - put chunk in the appropriate chunk slot
  * @chunk: chunk of interest
@@ -505,12 +523,8 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *chunk, int oslot)
 {
 	int nslot = pcpu_chunk_slot(chunk);
 
-	if (chunk != pcpu_reserved_chunk && oslot != nslot) {
-		if (oslot < nslot)
-			list_move(&chunk->list, &pcpu_slot[nslot]);
-		else
-			list_move_tail(&chunk->list, &pcpu_slot[nslot]);
-	}
+	if (oslot != nslot)
+		__pcpu_chunk_move(chunk, nslot, oslot < nslot);
 }
 
 /**
@@ -1381,7 +1395,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	bool is_atomic = (gfp & GFP_KERNEL) != GFP_KERNEL;
 	bool do_warn = !(gfp & __GFP_NOWARN);
 	static int warn_limit = 10;
-	struct pcpu_chunk *chunk;
+	struct pcpu_chunk *chunk, *next;
 	const char *err;
 	int slot, off, cpu, ret;
 	unsigned long flags;
@@ -1443,11 +1457,14 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 restart:
 	/* search through normal chunks */
 	for (slot = pcpu_size_to_slot(size); slot < pcpu_nr_slots; slot++) {
-		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
+		list_for_each_entry_safe(chunk, next, &pcpu_slot[slot], list) {
 			off = pcpu_find_block_fit(chunk, bits, bit_align,
 						  is_atomic);
-			if (off < 0)
+			if (off < 0) {
+				if (slot < PCPU_SLOT_FAIL_THRESHOLD)
+					pcpu_chunk_move(chunk, 0);
 				continue;
+			}
 
 			off = pcpu_alloc_area(chunk, bits, bit_align, off);
 			if (off >= 0)
-- 
2.17.1

