Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D2C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5238A218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOlHweTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405388AbfIIRIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:08:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34255 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfIIRIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:08:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so8181181pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPMbztDIbzkySjY7Sl5hBHJMX3nYrvhvNzUn5XH0t6c=;
        b=NOlHweTixtLZiLFTKY9rlqejzOTb0XI8x5pPvctE3BJcznEJZ3FxNZlQvAh9lC04jO
         K3R1lSqr2rke+fzifIDoT8r4nDuQV5WTHALeNkJBbCf30U9jzww5EIpkVeDJne9reP+e
         ytupaklu8rOWUlzxcy57xMGgVmjDdVQGJeHuRF7B2d9bgZ2desXOQmN95ADiddHL16gu
         Wcrt7FCsjzPDQf0KTj1xU3iAOZwxrDqBsuvPH65zCxEGjST19J2yxSJKQ1m2WkTw7AZT
         t4+gwRNvigjGmTxG/AwO01QqLlLKLzBJ9kSLli6ywBM2t1fYDfCJcKp3UStwBhaDQUO5
         mCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPMbztDIbzkySjY7Sl5hBHJMX3nYrvhvNzUn5XH0t6c=;
        b=KzitIgbY5NDV9tqgK2SHjEaDSfhfNlyQvpyl9v4J5SFsCu27G89iVqzFw8lxEo02hH
         me/xEBreU08Nfs45ZHYoFzDlg5BtysqHQADWwHPk1v1lN4DvLOGXFUEbn5xAG3cG/zbW
         aGcKqvuw+sCPBEN53jZ2j6JsyVu1l7Tv5cupMaogaqmkGU5gasFRWXneF/NV5Y4kzVT4
         GGte9HaauO9j9+QLr8LNOeLJwn/c1td5HwA5xrh2QzjEze1RYLpG4WKz5FPQM3ULkoP0
         5ZCxMlzYAGYGWMVdoUp5Rir/cFmmUD3+D3u0CByp/V4aGuOKL0uEFdq9CwOiJ3mo9qpp
         nlsg==
X-Gm-Message-State: APjAAAX5lHxXkCnXWfk8KhctozZHdarvznDzsY5rvUnrijrWF2oDV5Lr
        OBjQYt/qEa7aIR6ZOSSklRs=
X-Google-Smtp-Source: APXvYqwjmYInaZx6SDG6wgi8tWtl2/JRBWAdYJG7Ff3sw8EYfzoCAJTs5qn6+Q/ejGCcW1UStRozAQ==
X-Received: by 2002:a63:f907:: with SMTP id h7mr22785468pgi.418.1568048903964;
        Mon, 09 Sep 2019 10:08:23 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id b18sm107015pju.16.2019.09.09.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 10:08:23 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v2 3/4] mm, slab_common: Make 'type' is enum kmalloc_cache_type
Date:   Tue, 10 Sep 2019 01:07:14 +0800
Message-Id: <20190909170715.32545-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909170715.32545-1-lpf.vector@gmail.com>
References: <20190909170715.32545-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'type' of the function new_kmalloc_cache should be
enum kmalloc_cache_type instead of int, so correct it.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index cae27210e4c3..d64a64660f86 100644
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

