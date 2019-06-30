Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D4DC06508
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A72208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSCmPaA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF3H53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 03:57:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39466 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3H52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 03:57:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so4510444pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pe03FkrBdknzSMi1BJ7D2IonOmPOSw8u72ZV3zS67vk=;
        b=rSCmPaA3Tt5oSbR8YeEqZLqTU9wKXjxK3j8JcnuFn/CLgYMKlAe8T2yM5V2VuoxHpU
         +PFl7JopgZN9CTcY0bnkfcokKmMlyWwSevqjEO9eVRXg6hHGweBdUXjOzLbe4S99zRbo
         gtNWDMZJJNfatXZ/tJbX1OW+n9nfpK0TX4Z8dgQaEGo3OjnfwwbXgmT35liDBpYngBNF
         /ZHQRXtLaNrKH7dbC8sTrGtT0+li7YPW+6CtHDdkZvhsHU87OjpJlTKteGLJ4qM6Ea9R
         dIqbxVmL8kN1ouhitirDiTh6qaDYbAGx48kIlLP9K4FmakIB5YB5bLPSb27PfSZcquLB
         8GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pe03FkrBdknzSMi1BJ7D2IonOmPOSw8u72ZV3zS67vk=;
        b=Xo+bVyqZeK1A7XSTV+2NpfcN2pSxLftOM0ukBn60JNBfIme6afJui73fZ5ruFfAOwD
         VwDkJXLc1Z4XP6xgCd/XXb1fCTjaRqPJUd5Jzd4UCsvnQ2oTwFmzB1f6i3mBuHB1hzUG
         SrbYBeJeqcA1zzpWLi/tHa+PSJZDkD2uXih6wiP3zbnc7cGbdP+wXj0qMrccjRJPklHT
         DlgcijudmNH2OMhI/YxqOJ1stlSZjTWjPRQDkw3SOW/GkRVUbdL75v5dxCewymRGechh
         Laq4gCM9qAbfugBlgFn6+8ZOwIMmfToeM4OWfSyvzgzpQ5W/Gj+wzRKG5cZjchZ+GNjP
         7drw==
X-Gm-Message-State: APjAAAXm8FnbTcc+UQIconzhhZ5Q7YEaLuBd7mSPyvz1iXA+8CabZ4YM
        G6YjJETI7RAF04hLiTKzpfM=
X-Google-Smtp-Source: APXvYqy4FTIlx2aItsuQxIZvVQefOXR9rGZMq4Qqe1wQjbT5xfIvymu1nCUzfNvUSDQww2TREpvbig==
X-Received: by 2002:a17:90a:bf08:: with SMTP id c8mr23664541pjs.75.1561881448164;
        Sun, 30 Jun 2019 00:57:28 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id w10sm5989637pgs.32.2019.06.30.00.57.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 00:57:27 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 1/5] mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
Date:   Sun, 30 Jun 2019 15:56:46 +0800
Message-Id: <20190630075650.8516-2-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630075650.8516-1-lpf.vector@gmail.com>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The red-black tree whose root is vmap_area_root is called the
*BUSY* tree. Since function insert_vmap_area() is only used to
add vmap area to the *BUSY* tree, so add wrapper functions
insert_va_to_busy_tree for readability.

Besides, rename insert_vmap_area to __insert_vmap_area to indicate
that it should not be called directly.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/vmalloc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0f76cca32a1c..0a46be76c63b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -641,7 +641,7 @@ augment_tree_propagate_from(struct vmap_area *va)
 }
 
 static void
-insert_vmap_area(struct vmap_area *va,
+__insert_vmap_area(struct vmap_area *va,
 	struct rb_root *root, struct list_head *head)
 {
 	struct rb_node **link;
@@ -651,6 +651,12 @@ insert_vmap_area(struct vmap_area *va,
 	link_va(va, root, parent, link, head);
 }
 
+static __always_inline void
+insert_va_to_busy_tree(struct vmap_area *va)
+{
+	__insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+}
+
 static void
 insert_vmap_area_augment(struct vmap_area *va,
 	struct rb_node *from, struct rb_root *root,
@@ -1070,7 +1076,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->va_start = addr;
 	va->va_end = addr + size;
 	va->flags = 0;
-	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+	insert_va_to_busy_tree(va);
 
 	spin_unlock(&vmap_area_lock);
 
@@ -1871,7 +1877,7 @@ void __init vmalloc_init(void)
 		va->va_start = (unsigned long)tmp->addr;
 		va->va_end = va->va_start + tmp->size;
 		va->vm = tmp;
-		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+		insert_va_to_busy_tree(va);
 	}
 
 	/*
@@ -3281,7 +3287,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 		va->va_start = start;
 		va->va_end = start + size;
 
-		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+		insert_va_to_busy_tree(va);
 	}
 
 	spin_unlock(&vmap_area_lock);
-- 
2.21.0

