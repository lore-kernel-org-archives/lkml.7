Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15F1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F6C217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOe0NwoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfHHHSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:18:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38094 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:18:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id z14so6332922pga.5;
        Thu, 08 Aug 2019 00:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVPifcR7sahFkBeVlX5N51EDmrBppWAvFSrjoG4v/2Q=;
        b=GOe0NwoTzSlHx5pDHohPkW99MO0QgPpFde1nIDO+AB6KkAIr39mx0PFtITXvJUYMLG
         Sl0Fr2i/PIs76xrBKnylRVYAyHHthrsO+nsIkovsrQvJKshzboBKoNpRiuWH+wDb6Rfh
         O/OI8uxCJmsrChUcAbjAJdBMHJC2XZdEPBD5nZ5GPXM6fhhuoPYhfD0RonWHLJZD+MW/
         NXHJD/QUxtecJr4hQWzjgPQHJHFfFXRGWIKkN4MnCE+XnWGWgTZahleV70fxqwDQgMDQ
         3cBxrDH7sLXCjob6IStxIPUJNqAYbnHqGdBj2Dikb4hafHf5saxo9ILq28bcXghQ/ooY
         BU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVPifcR7sahFkBeVlX5N51EDmrBppWAvFSrjoG4v/2Q=;
        b=F9FDMKBtCnjU5sJJTitpoo8LlUV+ILyKI4/E/mcNtIz4OlYw3dI5gEszAx8jQgzRiX
         UWVsYkiBrFQ/3ErnWMzk5JaIOxNL6lxRGkL1jT3GTO1SGUKZJOTJnHkzCGU8fTjjDlJl
         UHe4Eb75fz8GvupQHyKORDcDP9/rvslCHOXsBDt1Xfdc5pLnAizooniqa7XrHEoUyc6c
         ja8YBbC4LUJR0t6Jb2Lss9PhsO29ePLUTxuS5cjy5LOEgDnMLqpHPBK0+mJQ3Eif14EV
         PMcOYJQ92bxmfljjjrTOoBKnyisEDRAFcrsBCaKjsOwxNVj2Fu1p3M977/25A/sJ2gSV
         MN0A==
X-Gm-Message-State: APjAAAXNoAwXBRIx1n8rPgPLgxGocFjznZIVBVum3gZd76RKh7PU5gVX
        3v0xIvu7foocaKU+rDVBHz0=
X-Google-Smtp-Source: APXvYqxaIYkGLx8GfD1tG0E+QjVSgqYFjsnd1IDi1B3lBgpYRIpAxdOZPXLPx38PWGWlL9Q+WHNxXQ==
X-Received: by 2002:a17:90a:360c:: with SMTP id s12mr2623645pjb.30.1565248712488;
        Thu, 08 Aug 2019 00:18:32 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id o12sm1183768pjr.22.2019.08.08.00.18.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:18:31 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 2/2] s390/mm: Use refcount_t for refcount
Date:   Thu,  8 Aug 2019 15:18:26 +0800
Message-Id: <20190808071826.6649-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/s390/include/asm/gmap.h |  4 +++-
 arch/s390/mm/gmap.c          | 10 +++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index fcbd638fb9f4..37f96b6f0e61 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -9,6 +9,8 @@
 #ifndef _ASM_S390_GMAP_H
 #define _ASM_S390_GMAP_H
 
+#include <linux/refcount.h>
+
 /* Generic bits for GMAP notification on DAT table entry changes. */
 #define GMAP_NOTIFY_SHADOW	0x2
 #define GMAP_NOTIFY_MPROT	0x1
@@ -46,7 +48,7 @@ struct gmap {
 	struct radix_tree_root guest_to_host;
 	struct radix_tree_root host_to_guest;
 	spinlock_t guest_table_lock;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	unsigned long *table;
 	unsigned long asce;
 	unsigned long asce_end;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 39c3a6e3d262..cd8e03f04d6d 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -67,7 +67,7 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
 	spin_lock_init(&gmap->guest_table_lock);
 	spin_lock_init(&gmap->shadow_lock);
-	atomic_set(&gmap->ref_count, 1);
+	refcount_set(&gmap->ref_count, 1);
 	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
 	if (!page)
 		goto out_free;
@@ -214,7 +214,7 @@ static void gmap_free(struct gmap *gmap)
  */
 struct gmap *gmap_get(struct gmap *gmap)
 {
-	atomic_inc(&gmap->ref_count);
+	refcount_inc(&gmap->ref_count);
 	return gmap;
 }
 EXPORT_SYMBOL_GPL(gmap_get);
@@ -227,7 +227,7 @@ EXPORT_SYMBOL_GPL(gmap_get);
  */
 void gmap_put(struct gmap *gmap)
 {
-	if (atomic_dec_return(&gmap->ref_count) == 0)
+	if (refcount_dec_and_test(&gmap->ref_count))
 		gmap_free(gmap);
 }
 EXPORT_SYMBOL_GPL(gmap_put);
@@ -1594,7 +1594,7 @@ static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce,
 			continue;
 		if (!sg->initialized)
 			return ERR_PTR(-EAGAIN);
-		atomic_inc(&sg->ref_count);
+		refcount_inc(&sg->ref_count);
 		return sg;
 	}
 	return NULL;
@@ -1682,7 +1682,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 			}
 		}
 	}
-	atomic_set(&new->ref_count, 2);
+	refcount_set(&new->ref_count, 2);
 	list_add(&new->list, &parent->children);
 	if (asce & _ASCE_REAL_SPACE) {
 		/* nothing to protect, return right away */
-- 
2.20.1

