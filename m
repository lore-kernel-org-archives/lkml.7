Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E9C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917A9206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDXlWMkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfDBQZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:25:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38161 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfDBQZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:25:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so12168660ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/43d8GqinLiNnRiU8qrBiLiEat+yAFwsrPKMABYDevc=;
        b=TDXlWMkbRngOofXyLknkSFqq9wkR++G+6DvTLmmdDO+HXRUFoMoUOZqL5elKEF4DLJ
         2hJ9NMhDS5BZaADGyhimfmz+wdGrblxvyOnh2IcRwIVGhlBEUXwJnm9MPP29bHh6bSj5
         Ckirz2hXMCwU/hXkeov7lt4A1NOCARq5oSx2F1J+JWdR87ligTFQ1iHlJBZqGu41GpZp
         WB4QNZBi5MvthY1oB+iHdJ5EFf79848mZg/MR3QhJIqY9v86UF5HLUlp1VKQogqSTMKQ
         yTkExUBK982uutRzMqY9hDIhlZQx689/iJkoyodPsTs0JD+0op2gz8gxjFlFmpyOhPOR
         wgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/43d8GqinLiNnRiU8qrBiLiEat+yAFwsrPKMABYDevc=;
        b=llCvLp6NkrzVBPR5j1XFQJz9oRi9tm2qH862zUqYPSDFw8BH0+REhBmyemQplFHdPq
         ck0OFMMm8/WmMoxfTwXYPu6J6IE70tc5jgwqs0sZjIgVqPQI5ej/fLBLG415+9vUYLwG
         DkMt0TY66VC0ve1HTQoOU0q/Wfe2HWCmOxTpY8aLTpg9BEDZ6L5aTZcvAcs4L3uweMz6
         uneCbO2/tARtd9ibruQb2LPWHZehE3H1EskwGhPQCuLp5+MDg4tnBI/4tYFPdAStkCC0
         xhN6kb171ANDgPFLQnyzTZ2LYazKnkcAgE7EPd2aB/NPObb1o9SLMbwjT/z6H7PWbFtd
         rDlw==
X-Gm-Message-State: APjAAAWah1GYLjE/4GLHn4UnurVt9PCiMlZnkz5SCy0wzJ4WNnVvkTEI
        YRIFJ2n9esU6IQtTDCXTbqU=
X-Google-Smtp-Source: APXvYqyLRe0aN9PWEEKn5LA512XPiJ9kvIak6KXspZJFqlvg//a5sxtanZRLBVNFe4LTIPNVLQh3WQ==
X-Received: by 2002:a2e:8582:: with SMTP id b2mr24365587lji.24.1554222344792;
        Tue, 02 Apr 2019 09:25:44 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id 13sm2550377lfy.2.2019.04.02.09.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:25:44 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RESEND PATCH 3/3] mm/vmap: add DEBUG_AUGMENT_LOWEST_MATCH_CHECK macro
Date:   Tue,  2 Apr 2019 18:25:31 +0200
Message-Id: <20190402162531.10888-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190402162531.10888-1-urezki@gmail.com>
References: <20190402162531.10888-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro adds some debug code to check that vmap allocations
are happened in ascending order.

By default this option is set to 0 and not active. It requires
recompilation of the kernel to activate it. Set to 1, compile
the kernel.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1449a8c43aa2..dffc45e645e7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -323,6 +323,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 
 /*** Global kva allocator ***/
 #define DEBUG_AUGMENT_PROPAGATE_CHECK 0
+#define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
 
 #define VM_LAZY_FREE	0x02
 #define VM_VM_AREA	0x04
@@ -844,6 +845,44 @@ __find_vmap_lowest_match(unsigned long size,
 	return NULL;
 }
 
+#if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
+#include <linux/random.h>
+
+static struct vmap_area *
+__find_vmap_lowest_linear_match(unsigned long size,
+	unsigned long align, unsigned long vstart)
+{
+	struct vmap_area *va;
+
+	list_for_each_entry(va, &free_vmap_area_list, list) {
+		if (!is_within_this_va(va, size, align, vstart))
+			continue;
+
+		return va;
+	}
+
+	return NULL;
+}
+
+static void
+__find_vmap_lowest_match_check(unsigned long size)
+{
+	struct vmap_area *va_1, *va_2;
+	unsigned long vstart;
+	unsigned int rnd;
+
+	get_random_bytes(&rnd, sizeof(rnd));
+	vstart = VMALLOC_START + rnd;
+
+	va_1 = __find_vmap_lowest_match(size, 1, vstart);
+	va_2 = __find_vmap_lowest_linear_match(size, 1, vstart);
+
+	if (va_1 != va_2)
+		pr_emerg("not lowest: t: 0x%p, l: 0x%p, v: 0x%lx\n",
+			va_1, va_2, vstart);
+}
+#endif
+
 enum alloc_fit_type {
 	NOTHING_FIT = 0,
 	FL_FIT_TYPE = 1,	/* full fit */
@@ -985,6 +1024,10 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 	if (ret)
 		return vend;
 
+#if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
+	__find_vmap_lowest_match_check(size);
+#endif
+
 	return nva_start_addr;
 }
 
-- 
2.11.0

