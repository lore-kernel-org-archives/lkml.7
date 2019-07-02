Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D8C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711372146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNuV5VsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfGBOQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:16:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37601 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGBOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:16:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so8329747pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pe03FkrBdknzSMi1BJ7D2IonOmPOSw8u72ZV3zS67vk=;
        b=eNuV5VsKp26iw7pwVfUIm1yfBRF9GHZ5iFOPBMFaDQ4eYUSRy++UTay4any9hC7vdh
         SSVIqNhNHw4B03hBw4j0JQaWM1FgGlmuRAz+znOP0rd84XUIQ6tRtygbxpb+JJBD4/FH
         l0rZrhFQSbJ6PGupyvKMf23IQbAfdAPNtPT86S4ml62Yrgd5mJ9bpXL6t7YjBkGyBDvF
         ZMxiMqYpXwh2Ix//4h1Vkr+IhFtLPV6mkB2TJBV5pvHXceZ9tI/90Au9vearEDLJpZVe
         BxoAYQEs0EWsZhQO6tfSSoVnddp6//tb/3NWQqbXnNQM20d0JI7yXkZ3M2rEKI4psBdc
         UTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pe03FkrBdknzSMi1BJ7D2IonOmPOSw8u72ZV3zS67vk=;
        b=hAp76efQQwt7j4DXCWj4xteQel/TRGynFeUb2f2UW8etJpbud77gJO+46GOUhwuCQl
         SyvSBRR1tEuVYLl+j+hRIn/rPL+D733JSr7oxWWQTDELkHwpLl7d0Va1oq3O1LeCYfDg
         SGzSjlHBvJ03NSvSinKP/S68Y4rv6z9d5UhLP450AHAutyyQeVYFXrHkb86BlmKBL8Ja
         1c5uDWeWslAk4InHDpMScjebfE+Tc62qw4uJAkkZrsc65pPSW8EjsGSuR6+FWBRn7gnD
         zT79eYcAIH/l0gFJtPZxgM4A4EHkFRuWcRyQ7Y/gouJzd2i7z2BWWi8Yp38AltkSyEEY
         uvBw==
X-Gm-Message-State: APjAAAX+jEMYMwzzBDcX8JG677qxrh1rh3vhwbvoSuIJpUAkYu5fqSsN
        EChNu4zmlDpxCHm4fR2RBi8=
X-Google-Smtp-Source: APXvYqylYHf/76rs6f7Ml1h5aXwpQU2cxl0zb9G0+PnLAQbVqadmSiRJ+Ne2h/tr9v/4I48k2MLv5g==
X-Received: by 2002:a17:90a:23a4:: with SMTP id g33mr6033264pje.115.1562076970268;
        Tue, 02 Jul 2019 07:16:10 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id a5sm744617pjv.21.2019.07.02.07.16.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 07:16:09 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v2 1/5] mm/vmalloc.c: Introduce a wrapper function of insert_vmap_area()
Date:   Tue,  2 Jul 2019 22:15:37 +0800
Message-Id: <20190702141541.12635-2-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702141541.12635-1-lpf.vector@gmail.com>
References: <20190702141541.12635-1-lpf.vector@gmail.com>
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

