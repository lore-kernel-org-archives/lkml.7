Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA85C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6632C21A4C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQtd53NR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392354AbfIJB1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 21:27:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33580 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392339AbfIJB1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:27:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id t11so7654638plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 18:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X86RdWoaDKqJbFDIoXti2bda7+kkyeUkiLhSN5JzlKU=;
        b=KQtd53NR/T/J/9VekePalACKtC/HOwwkO8bNSV8tk6Dyyj31Kp1PrOu9o88nuHcY/9
         3xRu8xKtgvF63f+93emrR9zYCdNo4OdcB3HZVeczwKML+KIWPN76tISq5lziBwla/bAQ
         12Hq/pLyCY307g2j24oYtaTpPyIj7f6I32O8OiTGxngpTqjq/fqlyq2vFSg28kUl8tqL
         vJ77wfOgKd0crD+8e2kwoTCP1e09W460Su2O8pfXRIQ/5krP0C8WV0kygi6qtS1pyzDS
         8oLossfX3RBTQ3MnlzwWLSkQ8D3dXLJzO6Q7oRH90wXXrKMIb7R8nL/J6rwZRCdVMZdl
         0mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X86RdWoaDKqJbFDIoXti2bda7+kkyeUkiLhSN5JzlKU=;
        b=arFfCtDZy4cibfyR+9fhq5Q21nasIeOzp87ruUZBhUFtkb6ld89mDKSlsSAIruGU1b
         3mnX7uIqnd/NyEIEdOO5WbNYjdSzT67MWRrA8Bi1HaigUTVk0fyMjmETkc9GcRw2sG3S
         W8V7AYp/c4qPUiaaMgtohGaeYjTTYOzg02IkpOF79WzgNKENoYVVjcwkp/lo0W3wXKxU
         pnPTpHqmN28Defoud3s5R9DHTvbgQEpG+95nOEp1UtYKIBMH/zUDXS8IXybuvo9WM1Iq
         1bHKrxOKhz0Z0ECgi1FKNZd/5MDLr7IEj4dGEEnGvW0Rd0IvXMo3eBkUIQp0ovMfB0Z4
         cBkQ==
X-Gm-Message-State: APjAAAWZGGeeNqN/ty/7CL22mEwvy2TiRJISqsr699WH/PwfHHzyamyy
        KKlFCDpUhtvjWtmLgGoHL04=
X-Google-Smtp-Source: APXvYqzMsPmTfBEy4WB28iw7U/+S+kHHAnWKRQ3msjHdY/9xK0yZsfYeo8VDoWYGdBvtPYt+3nsvOw==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr28367384ple.192.1568078857630;
        Mon, 09 Sep 2019 18:27:37 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id b20sm19558629pff.158.2019.09.09.18.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 18:27:37 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v3 3/4] mm, slab_common: use enum kmalloc_cache_type to iterate over kmalloc caches
Date:   Tue, 10 Sep 2019 09:26:51 +0800
Message-Id: <20190910012652.3723-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910012652.3723-1-lpf.vector@gmail.com>
References: <20190910012652.3723-1-lpf.vector@gmail.com>
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

