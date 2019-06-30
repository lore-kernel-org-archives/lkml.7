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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0EC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B860208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LodeeeW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfF3H5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 03:57:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46499 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3H5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 03:57:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so5010670pfy.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBzXR4TZZHkqkMNv1E0xRf3mfUwoTzVNVZHPzzbj8rI=;
        b=LodeeeW/nj7pp7hR1Gc7VMKCIqYECiaafmBduPR1Q7nIfSYxFi7LRtmN9Zpyz9R5yA
         mo4BKr88aB+42eMCQxXeECb251r8lBqQJhCrpCpy7hAKlMr1sCfshflllq67ssSmnSHd
         zV6wFKupqgYvQO9kmlXp4dR8vVGr0fBKeu5MNOosgoLXhUSMUkHDKPoR7uhFVUIz4ZvZ
         JiTa41qi2ZQpiNCG2LQDLnp9IzUOZrPr2/0bcJahl9gmeuHrjTNIt+kGIV9Ipx8gkkcc
         XOShhSQic1+v4Y9VfvBI4/D8WMBCTuYyKcdi4VWDnC7fW4Sdp10NfV2YKw7gGd0q4Hqo
         uIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBzXR4TZZHkqkMNv1E0xRf3mfUwoTzVNVZHPzzbj8rI=;
        b=fPmgvT2+N6I6zRRlMfsOihYXAg5PZ9AcdP0MgcOTGc2VdUvk3AEq9sDmeE+uL0r/MN
         vXo9nPczrGGVjDJTS3UGh5QL1nKSagVcpvF9d5w/TF7cATMU4H10lbFFih7lue9XjiN5
         hOtqjz/8f3aMQ2aOXSAoqvIl9zykXvReMUm5g4i31Bvmo5Za2bqurO2/pQIgYAMJJNX6
         UCs2VoWxHjlF2S2Os879R8OgaQvEK+fONTrhUm6wYIkyXvxg4sKGJ9Z/n/tyC93CZ9Fj
         QYiPLjGmkrPQKNXuXRBWKorxs1ZG59l6ScJSVQx+rS8bfkZJLgflori8lEaP0myH1PIn
         AScQ==
X-Gm-Message-State: APjAAAWiRW+Sc0jO/1tHlJblDPLrQ4htnMns7RZ6zsjzhM4SuL35BqFM
        1d0Sbt1CKoR3IIC7OvHLjP0=
X-Google-Smtp-Source: APXvYqzAp1tM78DLL0FHyzk+9neGaMIo3OLPUV6Dkkaqj21aX/kfAwowgTQTziiJd4jwZ9HyMjbhTA==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr18847016pgr.52.1561881456345;
        Sun, 30 Jun 2019 00:57:36 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id w10sm5989637pgs.32.2019.06.30.00.57.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 00:57:36 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 2/5] mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area_augment()
Date:   Sun, 30 Jun 2019 15:56:47 +0800
Message-Id: <20190630075650.8516-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630075650.8516-1-lpf.vector@gmail.com>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The red-black tree whose root is free_vmap_area_root is called the
*FREE* tree. Like the previous commit, add wrapper functions
insert_va_to_free_tree and rename insert_vmap_area_augment to
__insert_vmap_area_augment.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/vmalloc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0a46be76c63b..a5065fcb74d3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -658,7 +658,7 @@ insert_va_to_busy_tree(struct vmap_area *va)
 }
 
 static void
-insert_vmap_area_augment(struct vmap_area *va,
+__insert_vmap_area_augment(struct vmap_area *va,
 	struct rb_node *from, struct rb_root *root,
 	struct list_head *head)
 {
@@ -674,6 +674,13 @@ insert_vmap_area_augment(struct vmap_area *va,
 	augment_tree_propagate_from(va);
 }
 
+static __always_inline void
+insert_va_to_free_tree(struct vmap_area *va, struct rb_node *from)
+{
+	__insert_vmap_area_augment(va, from, &free_vmap_area_root,
+				&free_vmap_area_list);
+}
+
 /*
  * Merge de-allocated chunk of VA memory with previous
  * and next free blocks. If coalesce is not done a new
@@ -979,8 +986,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
 		augment_tree_propagate_from(va);
 
 		if (lva)	/* type == NE_FIT_TYPE */
-			insert_vmap_area_augment(lva, &va->rb_node,
-				&free_vmap_area_root, &free_vmap_area_list);
+			insert_va_to_free_tree(lva, &va->rb_node);
 	}
 
 	return 0;
@@ -1822,9 +1828,7 @@ static void vmap_init_free_space(void)
 				free->va_start = vmap_start;
 				free->va_end = busy->va_start;
 
-				insert_vmap_area_augment(free, NULL,
-					&free_vmap_area_root,
-						&free_vmap_area_list);
+				insert_va_to_free_tree(free, NULL);
 			}
 		}
 
@@ -1837,9 +1841,7 @@ static void vmap_init_free_space(void)
 			free->va_start = vmap_start;
 			free->va_end = vmap_end;
 
-			insert_vmap_area_augment(free, NULL,
-				&free_vmap_area_root,
-					&free_vmap_area_list);
+			insert_va_to_free_tree(free, NULL);
 		}
 	}
 }
-- 
2.21.0

