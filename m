Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC093C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1C9206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TRr3qWeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfCLReE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:34:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42193 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfCLReA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:34:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id v3so640392ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhIphe4VRjFtHXZUAkPPXg12QJmGgjtwf+bidT0AV04=;
        b=TRr3qWeVWNnVAhsbDvGFFytVbzIPOy2ViEtXnCtDEYf4A1nQi4CvuG2uRLzIxIOeuN
         L8Y3pU1aRZKGRSEROVob3TtRESiBZYRQw+Yr/VBMGOEHZkZCblYptO93EYo78yZi7pOn
         6EegDoJKOd1MAjgdhlaaADDxxrrRdqfu5NF8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhIphe4VRjFtHXZUAkPPXg12QJmGgjtwf+bidT0AV04=;
        b=Pua42XzLDQFiIc2kqxp5+RbfPRgPSv+d+2JXsNc1dx4oW1wPACKTsLFglDaD35dcTk
         UeGt70mO/DsAE0zuxPQYm9h3zzNJ0UvZLFgREX7HTuV43G/Bkb/m+/CGSuc2tblvmNHl
         TyX9jkJMm6CrjzEiloN1YBOKvwozbMNVOswpWDOiicUEmcG9VVF1j+B2qQQeasXV4Usb
         E2k6rcs8v/3rmkx9x/YZpKPEb6BThGl0yUpXcenN0E1hjkVZZRJRQ/vQifVDPtrm7mDe
         XAC0pF/AVdB+KGRsBOYKkhoG3M0D21PLqG9hRdxfHmrTxo4jOWZjrapmBHFWZYufAaqq
         zNqQ==
X-Gm-Message-State: APjAAAUlmJrTT0diRdRMWG5EtQCJg+vU4NL9y85ut1REmL/pvmfaVPma
        rOB+aUEqJEZ17Im8jw/Ja1yt0Q==
X-Google-Smtp-Source: APXvYqzAQsRMIl74za9SaP/n3gdUgsJDW93T3+ASDDe4tfviJskPNtoGDxXEVaiUpgPUuKEYhJloiA==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr20472936lji.152.1552412037677;
        Tue, 12 Mar 2019 10:33:57 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j5sm1473609ljg.47.2019.03.12.10.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 10:33:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] irqchip/gic-v3-its: make free_lpi_range a little cheaper
Date:   Tue, 12 Mar 2019 18:33:49 +0100
Message-Id: <20190312173350.4025-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
References: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using list_add + list_sort to insert an element and keeping the list
sorted is a somewhat blunt instrument; one can find the right place to
insert in fewer lines of code than the cmp callback uses. Moreover,
walking the entire list afterwards to merge adjacent ranges is
overkill, since we know that only the just-inserted element may be
merged with its neighbours.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/irqchip/irq-gic-v3-its.c | 61 ++++++++++++++++----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2ebc28a53d96..b362d62d3e91 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
-#include <linux/list_sort.h>
 #include <linux/log2.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
@@ -1474,31 +1473,6 @@ static struct lpi_range *mk_lpi_range(u32 base, u32 span)
 	return range;
 }
 
-static int lpi_range_cmp(void *priv, struct list_head *a, struct list_head *b)
-{
-	struct lpi_range *ra, *rb;
-
-	ra = container_of(a, struct lpi_range, entry);
-	rb = container_of(b, struct lpi_range, entry);
-
-	return ra->base_id - rb->base_id;
-}
-
-static void merge_lpi_ranges(void)
-{
-	struct lpi_range *range, *tmp;
-
-	list_for_each_entry_safe(range, tmp, &lpi_range_list, entry) {
-		if (!list_is_last(&range->entry, &lpi_range_list) &&
-		    (tmp->base_id == (range->base_id + range->span))) {
-			tmp->base_id = range->base_id;
-			tmp->span += range->span;
-			list_del(&range->entry);
-			kfree(range);
-		}
-	}
-}
-
 static int alloc_lpi_range(u32 nr_lpis, u32 *base)
 {
 	struct lpi_range *range, *tmp;
@@ -1528,9 +1502,21 @@ static int alloc_lpi_range(u32 nr_lpis, u32 *base)
 	return err;
 }
 
+static void merge_lpi_ranges(struct lpi_range *a, struct lpi_range *b)
+{
+	if (&a->entry == &lpi_range_list || &b->entry == &lpi_range_list)
+		return;
+	if (a->base_id + a->span != b->base_id)
+		return;
+	b->base_id = a->base_id;
+	b->span += a->span;
+	list_del(&a->entry);
+	kfree(a);
+}
+
 static int free_lpi_range(u32 base, u32 nr_lpis)
 {
-	struct lpi_range *new;
+	struct lpi_range *new, *old;
 
 	new = mk_lpi_range(base, nr_lpis);
 	if (!new)
@@ -1538,9 +1524,24 @@ static int free_lpi_range(u32 base, u32 nr_lpis)
 
 	mutex_lock(&lpi_range_lock);
 
-	list_add(&new->entry, &lpi_range_list);
-	list_sort(NULL, &lpi_range_list, lpi_range_cmp);
-	merge_lpi_ranges();
+	list_for_each_entry_reverse(old, &lpi_range_list, entry) {
+		if (old->base_id < base)
+			break;
+	}
+	/*
+	 * old is the last element with ->base_id smaller than base,
+	 * so new goes right after it. If there are no elements with
+	 * ->base_id smaller than base, &old->entry ends up pointing
+	 * at the head of the list, and inserting new it the start of
+	 * the list is the right thing to do in that case as well.
+	 */
+	list_add(&new->entry, &old->entry);
+	/*
+	 * Now check if we can merge with the preceding and/or
+	 * following ranges.
+	 */
+	merge_lpi_ranges(old, new);
+	merge_lpi_ranges(new, list_next_entry(new, entry));
 
 	mutex_unlock(&lpi_range_lock);
 	return 0;
-- 
2.20.1

