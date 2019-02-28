Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0896C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B172083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320360;
	bh=ut2L2Q3wrZTje6QW3BBnP/r/DX6spmP1d5vjAPVazj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SiTEebgqLf1pSXzH3MwJkkWlT7P3ncTG2yHUgowl27DepEXTq/2A2hVVPyT7NncfJ
	 +Cxlu2aqz3531LT/neN+91or+CUicrQkuwNlOSmwtA5+IREIMoGyfs6iCenCL4ARjR
	 dtLMH+6x+WjUKtkHhgnphH6N++TzuvMhYgipXWJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfB1CTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:19:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37188 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730706AbfB1CS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so11207401qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sHVgXKJ/dpov8r/5Fytj2IJVQNeHCHiREVwJuyicgyI=;
        b=SmKt7tHsUkt0UPGK5fE3FiZFN1lZcLWfNaKMZquZrUxch+F32rPPtPacbgQkvMDh2G
         KR5yLG5CQWwN19RoRGZ4SljaFJbsBIKUHaY8hotTMbQwfflHwdvxNImyyaifwHMzxm/s
         O0/oZxvEPNb1/kdYm2GG5b0iLrZv/SxWjKoZsyw8HdNcnkd9flzydZ3cb3V07rAak1GM
         9wvfHTa6MT+tJ4BYjRSE0Eth7Q/eW7nW4xajKLB8SGIpZ8Zys2EXP3syBeqjUqTv6g5T
         wTt9NRabjZYp5hZcIhT0xRC7YdR0RISxHPs21ja7yE+PTS9qFwgskPNMwuYZOqvhsI6S
         Z4Jg==
X-Gm-Message-State: AHQUAuYwhuLDpCe/kqsK+Vi/4TYtLde1Ig78ZHCTdAm1BfS5vfKVnULR
        lVs+ajRGcfi+p/TwOJ4WNts=
X-Google-Smtp-Source: APXvYqwo0bo97d7l1mZByOoZbYpzKXCP3xYjF3Kj+XUDGx0YrEYUpXA0XMb+iahfYNEOWMBz/mI7Pg==
X-Received: by 2002:a37:4d52:: with SMTP id a79mr4678440qkb.75.1551320337168;
        Wed, 27 Feb 2019 18:18:57 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:56 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] percpu: use block scan_hint to only scan forward
Date:   Wed, 27 Feb 2019 21:18:36 -0500
Message-Id: <20190228021839.55779-10-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blocks now remember the latest scan_hint. This can be used on the
allocation path as when a contig_hint is broken, we can promote the
scan_hint to the contig_hint and scan forward from there. This works
because pcpu_block_refresh_hint() is only called on the allocation path
while block free regions are updated manually in
pcpu_block_update_hint_free().

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index dac18968d79f..e51c151ed692 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -765,14 +765,23 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
 {
 	struct pcpu_block_md *block = chunk->md_blocks + index;
 	unsigned long *alloc_map = pcpu_index_alloc_map(chunk, index);
-	int rs, re;	/* region start, region end */
+	int rs, re, start;	/* region start, region end */
+
+	/* promote scan_hint to contig_hint */
+	if (block->scan_hint) {
+		start = block->scan_hint_start + block->scan_hint;
+		block->contig_hint_start = block->scan_hint_start;
+		block->contig_hint = block->scan_hint;
+		block->scan_hint = 0;
+	} else {
+		start = block->first_free;
+		block->contig_hint = 0;
+	}
 
-	/* clear hints */
-	block->contig_hint = block->scan_hint = 0;
-	block->left_free = block->right_free = 0;
+	block->right_free = 0;
 
 	/* iterate over free areas and update the contig hints */
-	pcpu_for_each_unpop_region(alloc_map, rs, re, block->first_free,
+	pcpu_for_each_unpop_region(alloc_map, rs, re, start,
 				   PCPU_BITMAP_BLOCK_BITS) {
 		pcpu_block_update(block, rs, re);
 	}
@@ -837,6 +846,8 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 				s_off,
 				s_off + bits)) {
 		/* block contig hint is broken - scan to fix it */
+		if (!s_off)
+			s_block->left_free = 0;
 		pcpu_block_refresh_hint(chunk, s_index);
 	} else {
 		/* update left and right contig manually */
@@ -870,11 +881,11 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 			if (e_off > e_block->scan_hint_start)
 				e_block->scan_hint = 0;
 
+			e_block->left_free = 0;
 			if (e_off > e_block->contig_hint_start) {
 				/* contig hint is broken - scan to fix it */
 				pcpu_block_refresh_hint(chunk, e_index);
 			} else {
-				e_block->left_free = 0;
 				e_block->right_free =
 					min_t(int, e_block->right_free,
 					      PCPU_BITMAP_BLOCK_BITS - e_off);
-- 
2.17.1

