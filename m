Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D2C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5086921019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPlXE6aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDFSfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:35:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44730 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 14:35:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so7859543ljg.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cy3SM5r/wmKJF4gCdfrdBD/mCIoEWm9jyjb4iJPWDQY=;
        b=RPlXE6aPcpZJlEWAL/EPm/scuOysXtYtIatbm0lcJBQwzQTgjYiBFaRYNjwfpnTwx8
         iOZJtE6hC1xvZYBi6jTfvOIiKyPCvo4OnroZn5/SH4BBJuEm2sSHgVty9X/oQgTIIXHX
         z2cZwqD7+4iSVTN2woRotummr5Rnyip5raPV3qVl7FNKy2h9zaRUJetO6lJIiutqN4Sm
         a6cVtcfW3t/FLFHYMYHr6WYKyqwV104LQ0/kvWuZp57WqemiRkggCbeUbMikPBZpt6YQ
         gQaY7yPaWizfBBAu5/QYHa0B9poa+Ck6nADEQtDU5g/c7P6VG63Ovm2YGS8W7jB+mZb8
         V3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cy3SM5r/wmKJF4gCdfrdBD/mCIoEWm9jyjb4iJPWDQY=;
        b=ss58Gvin16AyADPH3XOjk1PweGD5Te/WSeY/N9Ojgeic4ahzDYBbL/hFeY7+UTS/j+
         FZvR4PjibcUM1JZ8oV9fmyGBzI8ywvTkoyF8DWj9l04A9NJtVn4iP48ha6dsRMDrWR4U
         7ZUqLUChWRHAfsMaQVE5/qwzpGBz1NsErxp2zfndvsypbh7Qsp4oRjlNwLU+ltTSisbH
         u5voEXiAF6AUN6zL9elCWl2gOuRLUMRFoJsBH5KIKmGEeLI2lakGx5inNhqlESv8rqFl
         RR8M0w+wCNNwsseEwhpd0DdKqOiNiqezX9FjNm8k04OnxviDHL/YR+f/6h1ok3UPOOkJ
         5Upg==
X-Gm-Message-State: APjAAAXU2WvqBQrACro9Hrxzcgoek/g0bsnpKGj/u8KzLFEVUsso0te/
        BJyYb3ZgzY/dQDNHTAgpATw=
X-Google-Smtp-Source: APXvYqyCsbyKnf+glMe+Mx4ifka7UVeEPa6eRgpmdkqP4YZ01QGsgi5iAR2i2E+iMNqAXoap9K1a/w==
X-Received: by 2002:a2e:1245:: with SMTP id t66mr10862644lje.18.1554575721421;
        Sat, 06 Apr 2019 11:35:21 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m1sm5119622lfb.78.2019.04.06.11.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 11:35:20 -0700 (PDT)
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
Subject: [PATCH v4 2/3] mm/vmap: add DEBUG_AUGMENT_PROPAGATE_CHECK macro
Date:   Sat,  6 Apr 2019 20:35:07 +0200
Message-Id: <20190406183508.25273-3-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190406183508.25273-1-urezki@gmail.com>
References: <20190406183508.25273-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro adds some debug code to check that the augment tree
is maintained correctly, meaning that every node contains valid
subtree_max_size value.

By default this option is set to 0 and not active. It requires
recompilation of the kernel to activate it. Set to 1, compile
the kernel.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
 mm/vmalloc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c6f9d0637464..a74e605e042f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -324,6 +324,8 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 
 /*** Global kva allocator ***/
 
+#define DEBUG_AUGMENT_PROPAGATE_CHECK 0
+
 #define VM_LAZY_FREE	0x02
 #define VM_VM_AREA	0x04
 
@@ -538,6 +540,48 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
 	}
 }
 
+#if DEBUG_AUGMENT_PROPAGATE_CHECK
+static void
+augment_tree_propagate_check(struct rb_node *n)
+{
+	struct vmap_area *va;
+	struct rb_node *node;
+	unsigned long size;
+	bool found = false;
+
+	if (n == NULL)
+		return;
+
+	va = rb_entry(n, struct vmap_area, rb_node);
+	size = va->subtree_max_size;
+	node = n;
+
+	while (node) {
+		va = rb_entry(node, struct vmap_area, rb_node);
+
+		if (get_subtree_max_size(node->rb_left) == size) {
+			node = node->rb_left;
+		} else {
+			if (va_size(va) == size) {
+				found = true;
+				break;
+			}
+
+			node = node->rb_right;
+		}
+	}
+
+	if (!found) {
+		va = rb_entry(n, struct vmap_area, rb_node);
+		pr_emerg("tree is corrupted: %lu, %lu\n",
+			va_size(va), va->subtree_max_size);
+	}
+
+	augment_tree_propagate_check(n->rb_left);
+	augment_tree_propagate_check(n->rb_right);
+}
+#endif
+
 /*
  * This function populates subtree_max_size from bottom to upper
  * levels starting from VA point. The propagation must be done
@@ -587,6 +631,10 @@ augment_tree_propagate_from(struct vmap_area *va)
 		va->subtree_max_size = new_va_sub_max_size;
 		node = rb_parent(&va->rb_node);
 	}
+
+#if DEBUG_AUGMENT_PROPAGATE_CHECK
+	augment_tree_propagate_check(free_vmap_area_root.rb_node);
+#endif
 }
 
 static void
-- 
2.11.0

