Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7675C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8178D21902
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvaSEBZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDFSf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:35:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36418 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDFSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 14:35:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so7901346ljg.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tubI+It4WaUhci6ijaS4JDLrAM+rOnnPle+bQPWXm+g=;
        b=OvaSEBZpSzsCRma3SJ6iXPhpCSlVLCWxzki0MNr2ZNCPUWha4dzB2Vihnr0yhMc5X/
         xP2sU3ApZgon5IL7p1wl7vsdrFD8Vdo0OfuGwE40IjflZvM3bWMOpKVdgN0MKqizMFj0
         lqhSyp0PsVut4DnbZIAJsaFOAuw49s7yVlWUyO3GWV8UW8ucndciA63FQ4+2vpHqiHDJ
         uZ4ggH3uEI1F2SH6x0Vv07bFzmYa2bKvNBXVK8gCX4lHVh6avu+Hf9Dajc+gY48EoA9h
         wtfCQGKDEQFBreZinxvUA819Fez3end6W2oFHgB0llbEZM71CLBkID1dvQ3x4mggIm0Z
         UbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tubI+It4WaUhci6ijaS4JDLrAM+rOnnPle+bQPWXm+g=;
        b=c0qi0vZ+H1tQMlQeMzjN1xKgUztVn1Z+Fv/9SMWpFjpiMSsUeR6zK6082ZbgPPe+QQ
         0W6dD3wMYjPL+9dGiHYjfuhZQpUV94IIM3nIEH0LP4m1DSxdK0kjC7BEbS/09WPOmFz4
         OiGaXWI79IHfvt3DxRdj4/kEQx4VLl8wqYd4f8Px4h4isiXocnMR9RYSzBE94U5GR7xK
         yDvLJTG9TY6AzGwAAGa+aG0g03TFl1aW7ovWDbur7wb1Tv90vF60M9f8buVazBpUfpka
         XRaVFQBVDzQSqjroJu3hzqKh1rRB5rvdVVNSm4ADYwO7iOut1UfzSUQyuRfNELPyWQhF
         3niw==
X-Gm-Message-State: APjAAAU+fHEEf9fp326L3EThNsKKVlqAldhUwzPtV3wwOpEJRJsAGVbS
        syR4XeKLekaCEiu4XLZp24k=
X-Google-Smtp-Source: APXvYqzmWzmTccbPOpN7RuQgilMd5laFLwYDjbbh84uEBNQPmVzC0S/Ghij4eXzcSQOBGG2zVdFafQ==
X-Received: by 2002:a2e:b042:: with SMTP id d2mr8321872ljl.0.1554575722613;
        Sat, 06 Apr 2019 11:35:22 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m1sm5119622lfb.78.2019.04.06.11.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 11:35:22 -0700 (PDT)
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
Subject: [PATCH v4 3/3] mm/vmap: add DEBUG_AUGMENT_LOWEST_MATCH_CHECK macro
Date:   Sat,  6 Apr 2019 20:35:08 +0200
Message-Id: <20190406183508.25273-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190406183508.25273-1-urezki@gmail.com>
References: <20190406183508.25273-1-urezki@gmail.com>
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
Reviewed-by: Roman Gushchin <guro@fb.com>
---
 mm/vmalloc.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a74e605e042f..92b784d8088c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -325,6 +325,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 /*** Global kva allocator ***/
 
 #define DEBUG_AUGMENT_PROPAGATE_CHECK 0
+#define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
 
 #define VM_LAZY_FREE	0x02
 #define VM_VM_AREA	0x04
@@ -833,6 +834,44 @@ find_vmap_lowest_match(unsigned long size,
 	return NULL;
 }
 
+#if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
+#include <linux/random.h>
+
+static struct vmap_area *
+find_vmap_lowest_linear_match(unsigned long size,
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
+find_vmap_lowest_match_check(unsigned long size)
+{
+	struct vmap_area *va_1, *va_2;
+	unsigned long vstart;
+	unsigned int rnd;
+
+	get_random_bytes(&rnd, sizeof(rnd));
+	vstart = VMALLOC_START + rnd;
+
+	va_1 = find_vmap_lowest_match(size, 1, vstart);
+	va_2 = find_vmap_lowest_linear_match(size, 1, vstart);
+
+	if (va_1 != va_2)
+		pr_emerg("not lowest: t: 0x%p, l: 0x%p, v: 0x%lx\n",
+			va_1, va_2, vstart);
+}
+#endif
+
 enum fit_type {
 	NOTHING_FIT = 0,
 	FL_FIT_TYPE = 1,	/* full fit */
@@ -975,6 +1014,10 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 	if (ret)
 		return vend;
 
+#if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
+	find_vmap_lowest_match_check(size);
+#endif
+
 	return nva_start_addr;
 }
 
-- 
2.11.0

