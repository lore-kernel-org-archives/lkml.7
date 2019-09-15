Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C67C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB81216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ4lQn8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfIORIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:08:49 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44481 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfIORIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:08:48 -0400
Received: by mail-pg1-f182.google.com with SMTP id i18so18026749pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X86RdWoaDKqJbFDIoXti2bda7+kkyeUkiLhSN5JzlKU=;
        b=SJ4lQn8Y/Rod0i0hqNjNSitEVvQrs8es0QonZHsDCnKam7BbbzVEPHy9+oxknfPvN8
         etneVvl++kTLOnVbyVL3J27f0y0RDkparH82n0CA0OHumA+LjRYK2Xd4Pn/Cwf6pUd9U
         pWOGQXYTwqx9bx6SmhPsjzugvSCmqq5EyYXooQeib3Gteu+s8MoQwXuXqJ5dapDppK4E
         ZEexxMNhYSAcJb5SZhCeLI6aUGaioUwvuSx4bHo6vu8Coi81LXYgcIR+bUAQhjmReZFM
         XxJsBsaBFvMm90tPLA7Yp3Vfz2paaHQs3L/5VMESJcuchf5AGuhYYtmwx7Up5u5AH4CE
         dikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X86RdWoaDKqJbFDIoXti2bda7+kkyeUkiLhSN5JzlKU=;
        b=KEDxqPQzvTTupQe8m/8fcGZEg8KsVUPVt7w1pv3RDJt1JpX7UQIsaOqpzst+UT/q3h
         nVKcLRKnfn6kktA//PAYDHSgO6Q8bg8+MO82W1USg3gOXyQZJjnUBTDZsDZgk7Xpt3FL
         l1OZ0fcUc9M/ZP6cs7h7oJIr8chfUmdO9wiQl/E406jSIouzkXk0/3HUoMWJuFG2ObiV
         YjO6erIUsEUWxaTsYU0ZR9Q1L/vagaKJazHAdGKdRgoj9iSt52yqKJKMSgEEaddqYTN1
         EYBimFsMca4fNjUUcydfC+1+tr6jEXMByC6E8YiritbsneH9Txv+OPtTHXHsXxHgfyq3
         cYZw==
X-Gm-Message-State: APjAAAXJFg5j8DSCKDMUzQAP9CQ3QWecDLIruZ3N/MV089dYkaZ+mjeH
        DsZ8Mckein7aTREhqJU5BHY=
X-Google-Smtp-Source: APXvYqz/PCrVfpnnFdh4p8qjLJANWYL2j9hhouM6ji0IbmKL3O+gmShY1YQqZx7BSLb0nk4Zw7a4Fg==
X-Received: by 2002:a17:90a:8901:: with SMTP id u1mr2904510pjn.70.1568567327646;
        Sun, 15 Sep 2019 10:08:47 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id r28sm62279134pfg.62.2019.09.15.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 10:08:47 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [RESEND v4 3/7] mm, slab_common: Use enum kmalloc_cache_type to iterate over kmalloc caches
Date:   Mon, 16 Sep 2019 01:08:05 +0800
Message-Id: <20190915170809.10702-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915170809.10702-1-lpf.vector@gmail.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of local variable *type* of new_kmalloc_cache() should
be enum kmalloc_cache_type instead of int, so correct it.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/slab_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8b542cfcc4f2..af45b5278fdc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1192,7 +1192,7 @@ void __init setup_kmalloc_cache_index_table(void)
 }
 
 static void __init
-new_kmalloc_cache(int idx, int type, slab_flags_t flags)
+new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
 	if (type == KMALLOC_RECLAIM)
 		flags |= SLAB_RECLAIM_ACCOUNT;
@@ -1210,7 +1210,8 @@ new_kmalloc_cache(int idx, int type, slab_flags_t flags)
  */
 void __init create_kmalloc_caches(slab_flags_t flags)
 {
-	int i, type;
+	int i;
+	enum kmalloc_cache_type type;
 
 	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
-- 
2.21.0

