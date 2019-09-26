Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B60C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C515222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWYQiVhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfIZIss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:48:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35186 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfIZIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:48:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so1088370lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=VXH3Ua8oN6gJFR5T3GpYv9HdGvkWILtcOQDXfdZ+hho=;
        b=AWYQiVhmU49sBPZnlWVKUJLtD5J5kkDajluEr8cbxdB7n8QKDQV1snnf9VCQNxWf++
         8/71iNzmhwEf8m8tEVAIQ6p+8GOqd2m5n8xkYNrrlM+AiNDOI0LSIZiCDx2aTMAe359h
         Gt7gmb/K/B+/EcOTJDPWh5//R9rBQulHY2hpe2ppcUjaP8NfKEHQKyTZQ397ACmfOJh3
         4dFhTA0hqxLVIhWCcqrYlv5XiN9ZkWQxN4GuWciVIVg9UIkSBZ9KHd7S/iPapzVSwk/b
         1WJAf2wsB73RosaSF5VPUc8hDm7Y+jaed1XCEDpl1KPTi0g++DzFCvV3nEBvvBIOkBbU
         NNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=VXH3Ua8oN6gJFR5T3GpYv9HdGvkWILtcOQDXfdZ+hho=;
        b=MtmKwBn6ZXbxbXqJ0DhzotSuGTf+MEg/G83EVF/21SPGSvGzkimfKTTstiopnT5hQf
         1LRDHCHUw0I1gnyJcCgdMbpG+dvHe/zQD1HQFQxqQR6T73Po4uZihBjuW8t6sr9o7Uh+
         YRPij48XKaU8/UioBC33thG2yqYYxaERUfwd6JH+5aNfbfFmMtV5m1I7ierjfixjwgIS
         oeQVuyVYRXhgF0O1lm73nY4y6cD4QImG87JIqMsSXucKRIjVALrQs985GX6W07d1tTjv
         r3TxYtcuCW/fWvWU1o403fydOCSIz5bfTjvSQ26lPBY7vjVt3/1ZXEet6bsxnwQLykoh
         R17Q==
X-Gm-Message-State: APjAAAV8VPYVObLAEKIhaGTRn472CgMQQaNM+yUV+OyoSYY1TgG70oiV
        6hJLHEIHkN8ivzkqRH0pu69UHKYDg58=
X-Google-Smtp-Source: APXvYqz5ZssKzszNAZn1K3Xua7hwoz9w1G7LyD7AicTX0rheTwnzMtbinDXbqBwmudxqjb2WUvH/9w==
X-Received: by 2002:a19:f817:: with SMTP id a23mr1430709lff.18.1569487726227;
        Thu, 26 Sep 2019 01:48:46 -0700 (PDT)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id g21sm362202lje.67.2019.09.26.01.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:48:45 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:48:44 +0200
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Markus Linnala <markus.linnala@gmail.com>, stable@kernel.org,
        Dan Streetman <ddstreet@ieee.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] z3fold: claim page in the beginning of free
Message-Id: <20190926104844.4f0c6efa1366b8f5741eaba9@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a really hard to reproduce race in z3fold between
z3fold_free() and z3fold_reclaim_page(). z3fold_reclaim_page()
can claim the page after z3fold_free() has checked if the page
was claimed and z3fold_free() will then schedule this page for
compaction which may in turn lead to random page faults (since
that page would have been reclaimed by then). Fix that by
claiming page in the beginning of z3fold_free().

Reported-by: Markus Linnala <markus.linnala@gmail.com>
Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
---
 mm/z3fold.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 05bdf90646e7..01b87c78b984 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -998,9 +998,11 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	struct z3fold_header *zhdr;
 	struct page *page;
 	enum buddy bud;
+	bool page_claimed;
 
 	zhdr = handle_to_z3fold_header(handle);
 	page = virt_to_page(zhdr);
+	page_claimed = test_and_set_bit(PAGE_CLAIMED, &page->private);
 
 	if (test_bit(PAGE_HEADLESS, &page->private)) {
 		/* if a headless page is under reclaim, just leave.
@@ -1008,7 +1010,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		 * has not been set before, we release this page
 		 * immediately so we don't care about its value any more.
 		 */
-		if (!test_and_set_bit(PAGE_CLAIMED, &page->private)) {
+		if (!page_claimed) {
 			spin_lock(&pool->lock);
 			list_del(&page->lru);
 			spin_unlock(&pool->lock);
@@ -1044,7 +1046,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		atomic64_dec(&pool->pages_nr);
 		return;
 	}
-	if (test_bit(PAGE_CLAIMED, &page->private)) {
+	if (page_claimed) {
 		z3fold_page_unlock(zhdr);
 		return;
 	}
-- 
2.17.1
