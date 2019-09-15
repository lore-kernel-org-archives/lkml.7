Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42578C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19113214DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+yzSSKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfIOQwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:52:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfIOQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:52:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so21102014pfn.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X86RdWoaDKqJbFDIoXti2bda7+kkyeUkiLhSN5JzlKU=;
        b=G+yzSSKXmJhEM++iRzQ5m03oqsOK0gURMOljXVO2EqysSm4iIuA8NRRNAzOgjgp9o0
         sO+oIkPpkU/Sp5z9Xvvt05SjxNgybmP59Iqv0pMgpE1rryezPSIjCAWwBApg9FKuh12a
         A9zRNleYomC430D/DcAJPZTKpZ0d7KXzbh05CtiInyVKSAKWWQbzoJcl+X4HS9XCKvz5
         CZ5W8hKFIdkXo1bHos/qh8RTXnc2JyknMtLKzFSt9JPwYMVbCx62Mlx5XfstNU8ZtmvB
         GNQbyJOz56HKKnNBUbzNEybDic3axGq12Qi4DRLAQBWgVdNA84WHfhVpry3M1Yo33xLu
         idjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X86RdWoaDKqJbFDIoXti2bda7+kkyeUkiLhSN5JzlKU=;
        b=dVG78UCWk25gW81w/MZumChJB03VpnTd9PphBT5SrGKuqnPY2gcNHSAP6vL6ldkeep
         tRk1KOXF3778IfGEQiH1eJGYDJmmwfX4eLCosfDNGq+YMFqGBop7scIK4V4IsNRoEQRs
         E1UuH0Oes2t353Td6tz70Oh7PsGLVDnI6eJ21YzQjqkEzx1KD5QB4xYYwilxS/ZBiNEh
         P0DtS3kNKRcgiji7GM1mNd3K1IZzra3iHpiRCtpyqiNzExF69396HeSa2Rn+vAA5GQaU
         oGhxpky1kwQ5cmF/rllwTzIIpmiiYd6lvUB5nAJSUKV7MUjRqoIvPKELxS8UmtAI3tgh
         kKgA==
X-Gm-Message-State: APjAAAW92ToAACZ9jVfGDf86XXrZ0VbiRyosXSZax1AVpnnRot4qa982
        gGEz38aVB1ODaGKRC1ZtTp0=
X-Google-Smtp-Source: APXvYqyipnT98ResURsw038tfVzIDoxKbCXlrtw3kuy4NXyjm2pDCAcW6gupvqKfpody7f93AEDgXg==
X-Received: by 2002:aa7:9307:: with SMTP id 7mr8117547pfj.224.1568566340018;
        Sun, 15 Sep 2019 09:52:20 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id a4sm4383259pgq.6.2019.09.15.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 09:52:19 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v4 3/7] mm, slab_common: use enum kmalloc_cache_type to iterate over kmalloc caches
Date:   Mon, 16 Sep 2019 00:51:12 +0800
Message-Id: <20190915165121.7237-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915165121.7237-1-lpf.vector@gmail.com>
References: <20190915165121.7237-1-lpf.vector@gmail.com>
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

