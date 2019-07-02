Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AC1C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576102146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmDmyc9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfGBOQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:16:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45744 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfGBOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:16:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so438479plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBzXR4TZZHkqkMNv1E0xRf3mfUwoTzVNVZHPzzbj8rI=;
        b=KmDmyc9UgitUSKmQSbKjb9DdUtjBdj+AJcQslWKkw6oK98VNaeJDCKYNJj8Xam/2nb
         q9U5fjB5iElBuHff6OX+alidJnQw5RbNmku59aKFEPCB+P/0rZolEcyYCH+1Ert5OfM2
         Xarbe5OEYveIN0ypbc+SAgTrgp9/wO6FCTkr5xOcYmm/gje8u/ya7qWqqX2vkkP1LZPV
         prGXdZQ0qj250aBKWIAPwh8LOBHtsv5H+KaxEO/9MciMvlqE9ZJXBz+4Kd+xVGj0PDm3
         kKVW1Wi0E9CO2PYp7DnGZ9EY2A0l4TeMBvxsHmgBqzWm3wz0Qv/U6RPyHUSVPjADVlY/
         y5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBzXR4TZZHkqkMNv1E0xRf3mfUwoTzVNVZHPzzbj8rI=;
        b=cDI2DNIh7E1u8gnC0N2gq9TjsRN7WbC0pCL4nT0IvhCwMXRLk+++xjIwCn2TQ7IXsS
         S/PPe75bPTBD5bYyunpIDUiYAL4FRxM4kt6VOCTM5Pt6SHXa514S7BLQ7YBKI1Yn8HfY
         t5XKaP24xjEUFxglJ2yCut2B8mO57wggciu1fPj+SOyx7hgpTx7Vx3ib/M0vjSNzrhdF
         d78kUTRfCQwmkfxTgxfRkpIZzL6jA1wPUX+qgVx+dn4WEYe2jStd7B3CoCtQ0tJogUHB
         kYfoBkGoM6ZpQk50hL3fPkfTis3jj5hox+7CfX0W6tY7MAB57Dms+OoB3G5aY3F/6h/4
         hnpQ==
X-Gm-Message-State: APjAAAWEjLS11Rg9HokcvA2XCsrBmU+XeMfES+4iF85z5FnyFoIzimCQ
        XeAKfYTOd81h5MrEI87M+l4=
X-Google-Smtp-Source: APXvYqwWEAKTT6dyFXv7dzOsiRMsExc4YRB82MDVaOFpGFRbH99CZs+/cOLzM+zyEfvt2oTwz2Gisg==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr35901637plb.3.1562076979826;
        Tue, 02 Jul 2019 07:16:19 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id a5sm744617pjv.21.2019.07.02.07.16.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 07:16:19 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v2 2/5] mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area_augment()
Date:   Tue,  2 Jul 2019 22:15:38 +0800
Message-Id: <20190702141541.12635-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702141541.12635-1-lpf.vector@gmail.com>
References: <20190702141541.12635-1-lpf.vector@gmail.com>
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

