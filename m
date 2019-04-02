Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229FEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2B52075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCTRiPl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfDBQZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:25:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36712 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:25:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so12193864ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOaodrjzogu+AiOzT8YUkjwGghPStMHrCGiELyRiUjU=;
        b=tCTRiPl7RlRiNVO6+7kzd5kmFCdVxV7fp9hmAOiYAMGxwEfVnmjO1Q0i/P2vxA8jiD
         wkYMAASKMBlDYneQEHhjdXSDUp/mI56KUdJVE7ba52w0/cug9CHYTEOLl2o5ZCrj+ok+
         V/VXj3xj1ADW1mRDy2y9QKItT3dj21kU0OlWbju+NjXJsMj63APgLLZz5ZdbUAB/nRXZ
         4IDwdYtm1oNxRgrL8rg3ZmjxtE4PmGu+I3oWnfodhQf5Dzy5+uLZ4o8MvG1LDLR2Fh9v
         THhc1B5B+e4hT+feLzv9TXuhX5bUOdkAfC4edU2WEAE3tBeLKn/E6x+o+dEzcI9IUux4
         DNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOaodrjzogu+AiOzT8YUkjwGghPStMHrCGiELyRiUjU=;
        b=Y9/EMprVBTYPfpDQvBOc+fqn3re5051qaE68Efid2J+/ny4eXvs99oI9aW8o4Zq8cj
         BMzYPfzx3nhQAOMzNPxJkwHScYrobRujChSi49VKYIBU07CilkPm40VQLCrVQ6CQHj9f
         K8BFZaJCKTWXpKAPCLvhjS7GmltvxdMwKQh0mtGM9GWsRYAUMZ40E6WluR1V6+fb7Xgd
         y520vdtsaBCH7RJZ8Fy8wvCI+kP4epm6h0hn3//ZvhRNdumFSoAb3IyWzocklxr3uyo9
         qNJZAtMh0r8AW6IueRyY1qxEDe9U73DC27DKT3hxzHD2mlZiERbXcznGsPtVtAfBGoL+
         0VAg==
X-Gm-Message-State: APjAAAVag9B1DC8wyaRJsVnItWkEibnhegS0J94chiWbNqodbEPgz/KU
        USzMKm41zpLyoINMkZXwqtI=
X-Google-Smtp-Source: APXvYqxIvgt166YyuxYqS2vsjdjC8Q17H5Dq3Pgp4uuVl85W3LEQFMG3xqyqh3fitVUfKKypxQ4DFg==
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr22952891ljj.79.1554222343527;
        Tue, 02 Apr 2019 09:25:43 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id 13sm2550377lfy.2.2019.04.02.09.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:25:42 -0700 (PDT)
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
Subject: [RESEND PATCH 2/3] mm/vmap: add DEBUG_AUGMENT_PROPAGATE_CHECK macro
Date:   Tue,  2 Apr 2019 18:25:30 +0200
Message-Id: <20190402162531.10888-3-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190402162531.10888-1-urezki@gmail.com>
References: <20190402162531.10888-1-urezki@gmail.com>
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
---
 mm/vmalloc.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3adbad3fb6c1..1449a8c43aa2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -322,6 +322,8 @@ unsigned long vmalloc_to_pfn(const void *vmalloc_addr)
 EXPORT_SYMBOL(vmalloc_to_pfn);
 
 /*** Global kva allocator ***/
+#define DEBUG_AUGMENT_PROPAGATE_CHECK 0
+
 #define VM_LAZY_FREE	0x02
 #define VM_VM_AREA	0x04
 
@@ -544,6 +546,53 @@ __unlink_va(struct vmap_area *va, struct rb_root *root)
 	}
 }
 
+#if DEBUG_AUGMENT_PROPAGATE_CHECK
+static void
+augment_tree_propagate_do_check(struct rb_node *n)
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
+			if (__va_size(va) == size) {
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
+			__va_size(va), va->subtree_max_size);
+	}
+
+	augment_tree_propagate_do_check(n->rb_left);
+	augment_tree_propagate_do_check(n->rb_right);
+}
+
+static void augment_tree_propagate_from_check(void)
+{
+	augment_tree_propagate_do_check(free_vmap_area_root.rb_node);
+}
+#endif
+
 /*
  * This function populates subtree_max_size from bottom to upper
  * levels starting from VA point. The propagation must be done
@@ -593,6 +642,10 @@ __augment_tree_propagate_from(struct vmap_area *va)
 		va->subtree_max_size = new_va_sub_max_size;
 		node = rb_parent(&va->rb_node);
 	}
+
+#if DEBUG_AUGMENT_PROPAGATE_CHECK
+	augment_tree_propagate_from_check();
+#endif
 }
 
 static void
-- 
2.11.0

