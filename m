Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B20DC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027262068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftBPOest"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK0OVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:21:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44562 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0OVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:21:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so16261244lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 06:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khh+69lU2KetWdK6CIdAngBwxv5Htih9yoOaJIYwrW8=;
        b=ftBPOestA1Q2O3T/wJCQP91u9a+2dv+PtGe5TXzBmISBuZ5b8P2VlrypUP01v211oP
         nl3iaJhqv6FvwSmNQPqJB7Txw2QNsCmzmV35nFVmwl5MDicV0eROeLjyUVEaXkOsR+h2
         f45wdasQw+eaFsW9GSQ61qqDV3WDk9B8XPgf2KN95w/QiBxI2yNHKug4xluvp2YsajaP
         TFJj/kYr1CZhukiFlbAhwZ6vINcB/o/2cUPDUIaiDQzU7o1rMcgtLOwC3O6aPqsbWtz2
         28X6v0bwEgr4umyZPKKYStMmM8HGY9mcGC71AtaTu2tKWTi6M5COaYz0MXZbOWmryi7P
         aU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khh+69lU2KetWdK6CIdAngBwxv5Htih9yoOaJIYwrW8=;
        b=R2UDgEZZjyl8MAltZ2rnR+Pzd3UsPY69Wgxbp8QaxlyvZiyMHQXVDTK5UHOf0bbwof
         n84S3yx/BSgEQ1koV/jufwCvQqLHaD+J/dcw98c2g7dgsG9YA2R8qDWejZvNTQ1J9UXD
         Tmg4Q0E4WgCLNTjNNOOjsTQsb7MHKIfaIdTxlTQpy0MkbopUrJ0T21F9E0GA7b0tXXNf
         wZrVvQASZ5IaOGauZR6fmpDxEqClbU+6eiVmhswYLdQSxzbZlU7AK+g9Cm/QKn0P3uBT
         XWTQYZ1aKnJ0tGatWY7KUMITRRzbEUf2KkM1IbE9PqdX4xLYA3ZRWteps8mVRpqlnuI7
         SnCA==
X-Gm-Message-State: APjAAAUrIw7wgbEzoeLcfma+Vu8oYhjZqOaiSW4l5/r6u1og+U22u338
        j6Pb7UlI8lX8Hy21DueEdVu5TzuM
X-Google-Smtp-Source: APXvYqz42pCtuhbTJGlQld5BLHIqvNKuF+iMyZlJdqMynm4sPrUp72H7xXc79jeihCejanakTg3SIQ==
X-Received: by 2002:a19:c10f:: with SMTP id r15mr20815139lff.172.1574864479752;
        Wed, 27 Nov 2019 06:21:19 -0800 (PST)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id c20sm1879200ljj.55.2019.11.27.06.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:21:18 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:21:18 +0100
From:   Vitaly Wool <vitalywool@gmail.com>
To:     <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] z3fold: avoid subtle race when freeing slots
Message-Id: <20191127152118.6314b99074b0626d4c5a8835@gmail.com>
In-Reply-To: <20191127152012.17a4b35f9e7f6e50f9aaca9c@gmail.com>
References: <20191127152012.17a4b35f9e7f6e50f9aaca9c@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a subtle race between freeing slots and setting the last
slot to zero since the OPRPHANED flag was set after the rwlock
had been released. Fix that to avoid rare memory leaks caused by
this race.

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
---
 mm/z3fold.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index d48d0ec3bcdd..36bd2612f609 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -327,6 +327,10 @@ static inline void free_handle(unsigned long handle)
 	zhdr->foreign_handles--;
 	is_free = true;
 	read_lock(&slots->lock);
+	if (!test_bit(HANDLES_ORPHANED, &slots->pool)) {
+		read_unlock(&slots->lock);
+		return;
+	}
 	for (i = 0; i <= BUDDY_MASK; i++) {
 		if (slots->slot[i]) {
 			is_free = false;
@@ -335,7 +339,7 @@ static inline void free_handle(unsigned long handle)
 	}
 	read_unlock(&slots->lock);
 
-	if (is_free && test_and_clear_bit(HANDLES_ORPHANED, &slots->pool)) {
+	if (is_free) {
 		struct z3fold_pool *pool = slots_to_pool(slots);
 
 		kmem_cache_free(pool->c_handle, slots);
@@ -531,12 +535,12 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 			break;
 		}
 	}
+	if (!is_free)
+		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
 	read_unlock(&zhdr->slots->lock);
 
 	if (is_free)
 		kmem_cache_free(pool->c_handle, zhdr->slots);
-	else
-		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
 
 	if (locked)
 		z3fold_page_unlock(zhdr);
-- 
2.17.1
