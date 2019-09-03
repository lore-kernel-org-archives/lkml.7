Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E553C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3723B22CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4H3OZmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfICQG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:06:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34976 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfICQGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:06:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so8082746plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LViEBVo5/xlaUjZ5GSZNj0pM5S7KZYGyGn2HDxokJJk=;
        b=P4H3OZmR9QVZgWZ2D/glNq5HSvTTrtqxFVkVeg/WZmiL9dTUo7HLjSs+UAauaHV7mt
         OmdGS37DH/UzzuxUriBbekvJtFfsZe4KNE++J97KcSHSY4zyUhWS44PKjvV53bG9d7Ow
         PpUs5C4moOLJL93jkoHpnAfyp4JoJ6d3dTTbCvi5lyfx/clI0zfp2Tpi5Ji7WwXp33Cv
         p7GCekESrk91miSi5xR5uSRp/dx2JHTaBLVp2x+t9peORo7Ett6DiFWSNaqQGa6W9rqY
         gOjY65Jb7D1y+WBAPwK7xtAOF2yavrCA41nuC3aJW27orC+W9Dn78nO5R9CUG9SDFRpL
         U6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LViEBVo5/xlaUjZ5GSZNj0pM5S7KZYGyGn2HDxokJJk=;
        b=CsB91/h1RvdTaoTy/hCegDOWa/IdBCgVcIGShAVEugiaYqTnFAd6/FHqQl51JyjH3n
         Cl3TO3+7eACamBfCHSQZQZT1+4LerF+tjOqrHdV3X/pMiQ3kSOmiF9ntSYdXnX3xBwIB
         skofYW8cRXETf3bNAuppeogyRgfULWW8RlFYPlxlOqEQaLGrf87C77Z3CenEMiG2mwNV
         6eteapLMB9t2pqb+eT3SGF5rQQ0o/IcbSIPRjm6irGMJteTwRDqXnxJyFQoZ1sJ0sNFe
         W7AKq0fkmZUyUBCkUmlk5fukzEFfjjFDtxnC1vqv4H5W6qYZRG5F0yu3j7w8nJbJ79Pk
         pNGw==
X-Gm-Message-State: APjAAAVUGunMvH+NGcC8HDZT+K2Vr6i+/0DqUkdfxWAy07iPrsby/6wJ
        2TznOcpvagXQ2EhhNQ2/6Gs=
X-Google-Smtp-Source: APXvYqyIZTD5K2Wd0BFFfQVmj87nH+2U+ramZbS8wjnzfUW+IK1TUWiksx4/P3FvlglaZ1/zVdGvvQ==
X-Received: by 2002:a17:902:7588:: with SMTP id j8mr18739799pll.280.1567526784988;
        Tue, 03 Sep 2019 09:06:24 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id t11sm18501567pgb.33.2019.09.03.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 09:06:24 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 4/5] mm, slab_common: Make 'type' is enum kmalloc_cache_type
Date:   Wed,  4 Sep 2019 00:04:29 +0800
Message-Id: <20190903160430.1368-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903160430.1368-1-lpf.vector@gmail.com>
References: <20190903160430.1368-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'type' of the function new_kmalloc_cache should be
enum kmalloc_cache_type instead of int, so correct it.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
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

