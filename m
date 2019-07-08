Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E886DC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8C720861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9GQayeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfGHLsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:48:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46510 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGHLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:48:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so15563420ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=NI3QEPrQIr80BSUs7n24DIiPSAw9kPLEpr0qpD9OC4g=;
        b=S9GQayeHFQ731dT5yJcM/ihOV6PmnB9JiGGWT8EA0FW6/OnrP7Tu3j1AFDYYFTfyWb
         WHF9GBQKnWQ9ThaeB8hccX46QXszkGJFg2f1Lhsa5v90xGgQQBPsCOqgiKgeXAAOVg7s
         BB9cPsgId6WgH6lk4Tgs+NizD9QwDz2nLcvfdRWKBCf6+SVC1xQbsv1ym2LTMTXqeASt
         +2ylCWebiVrsaBtr+u9szHDElMRxFIhQ3ithCuk17+yZzxC2oE0QEPQhQ5Su9EjB/Ah0
         OoxjVjK4tH5+FjedWOLcdf93lzRbERfL8bKRt6DHoVTcT1lvTPKHgUImTpPt7SAuvgDu
         YHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=NI3QEPrQIr80BSUs7n24DIiPSAw9kPLEpr0qpD9OC4g=;
        b=VnIvQd8cOVdNQNrCWYCuQzE38+Z2R7JtJz+rB9Ceia0hMkUKI7VOGBahsumKukCsVB
         GbeTutYfpb5w0jZj8XNOIf45OIStLMOGYIhH7BPqNFzUw4P22lXT6SrqAX6ZepVULVc8
         95L+wUO/NnKRwg8b0HkaHu2zYSLMXnxse6CMNCg868fGBOz3OWAmCIZeP3p6jhAgK4yR
         /uJ6jBRZytEI/Q4zYOFdIetSnLkAyQ2jg03KftjXmfYEUpbb6cczv56xlBtDNgko5mVE
         doyaKanOSCaBijVEgO4o7ZJr38galKmudtg5WB8CE6ZHdbfMuWXU+/SuqbMyvX97PL2I
         RgKg==
X-Gm-Message-State: APjAAAVmsxyfzWqXx+fTQimkYTNaqIVFMmbuBG0Hp6tFvoIJ8vpFyAt+
        9IKPaA/VnfKJxfHBiYyk3uI=
X-Google-Smtp-Source: APXvYqwobzmzNJMY8JHCnmkFYX2leQw1uuMNkq4cZtY/HXbrqG7LWkvAoipYWg4C8v4VY3KRfW1fxg==
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr10478511ljt.175.1562586490182;
        Mon, 08 Jul 2019 04:48:10 -0700 (PDT)
Received: from seldlx21914.corpusers.net ([37.139.156.39])
        by smtp.gmail.com with ESMTPSA id s7sm3612057lje.95.2019.07.08.04.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 04:48:09 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:48:08 +0200
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Henry Burns <henryburns@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>
Subject: [PATCH] mm/z3fold.c: don't try to use buddy slots after free
Message-Id: <20190708134808.e89f3bfadd9f6ffd7eff9ba9@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From fd87fdc38ea195e5a694102a57bd4d59fc177433 Mon Sep 17 00:00:00 2001
From: Vitaly Wool <vitalywool@gmail.com>
Date: Mon, 8 Jul 2019 13:41:02 +0200
[PATCH] mm/z3fold: don't try to use buddy slots after free

As reported by Henry Burns:

Running z3fold stress testing with address sanitization
showed zhdr->slots was being used after it was freed.

z3fold_free(z3fold_pool, handle)
  free_handle(handle)
    kmem_cache_free(pool->c_handle, zhdr->slots)
  release_z3fold_page_locked_list(kref)
    __release_z3fold_page(zhdr, true)
      zhdr_to_pool(zhdr)
        slots_to_pool(zhdr->slots)  *BOOM*

To fix this, add pointer to the pool back to z3fold_header and modify
zhdr_to_pool to return zhdr->pool.

Fixes: 7c2b8baa61fe  ("mm/z3fold.c: add structure for buddy handles")

Reported-by: Henry Burns <henryburns@google.com>
Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
---
 mm/z3fold.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 985732c8b025..e1686bf6d689 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -101,6 +101,7 @@ struct z3fold_buddy_slots {
  * @refcount:		reference count for the z3fold page
  * @work:		work_struct for page layout optimization
  * @slots:		pointer to the structure holding buddy slots
+ * @pool:		pointer to the containing pool
  * @cpu:		CPU which this page "belongs" to
  * @first_chunks:	the size of the first buddy in chunks, 0 if free
  * @middle_chunks:	the size of the middle buddy in chunks, 0 if free
@@ -114,6 +115,7 @@ struct z3fold_header {
 	struct kref refcount;
 	struct work_struct work;
 	struct z3fold_buddy_slots *slots;
+	struct z3fold_pool *pool;
 	short cpu;
 	unsigned short first_chunks;
 	unsigned short middle_chunks;
@@ -320,6 +322,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
 	zhdr->start_middle = 0;
 	zhdr->cpu = -1;
 	zhdr->slots = slots;
+	zhdr->pool = pool;
 	INIT_LIST_HEAD(&zhdr->buddy);
 	INIT_WORK(&zhdr->work, compact_page_work);
 	return zhdr;
@@ -426,7 +429,7 @@ static enum buddy handle_to_buddy(unsigned long handle)
 
 static inline struct z3fold_pool *zhdr_to_pool(struct z3fold_header *zhdr)
 {
-	return slots_to_pool(zhdr->slots);
+	return zhdr->pool;
 }
 
 static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
-- 
2.17.1
