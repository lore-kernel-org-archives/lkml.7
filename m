Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112E6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C1A218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUcOORTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfDXKUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35526 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfDXKUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so9079405plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kfhy/vws18rZpDHDaPIfYHeGOwGyfC2bZ5+sCfkbgA=;
        b=BUcOORThkOGGXmQNzvAJJclaIUYGNaunputWTOxAf+59/+r0e3MFeC84GleoUtDi9D
         FA/k0jtxETYfPTXGndaRDCPNsd263w8qRj4lEXLbJK+4ZLBC1XlAjfMhPirY55cyflck
         uzXT0xnmiUddawjHMo7VmrLlKjQz90hRjSwSeykk0vrByyV/FHvp3qlqMhftYFZX06vW
         00dSm1EJrTkbvhvhI/euq7JjF1+c3Heytc98xXdtQPFWkxYWCXyJ+fCOscMVu8orgm+7
         wF1+MvmzYmJmjrvXrH6Mw/3J590QrKX0Vj9O55Vu/nMMJgsquaTsYtR25ohaZZH2oete
         2Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kfhy/vws18rZpDHDaPIfYHeGOwGyfC2bZ5+sCfkbgA=;
        b=kRVjwMYK1xWkFElQDJJ7IoKt8DzHUBrhDgEVYFF6UsTqX5iJUfkev4SgmUjMzeAfP1
         fOgrIdA9V6K39ooufXlAy/AATvbUu061xlraFy+DdB3nNTu/0xOtDBcsm5/LufYoijh6
         KymDCL8Td7H7NmhxZtcOm24tsJarU2/wXyq87Djj1krBeyFCUnQ3eJffprBINaRmp3xV
         2ANnBeuHQ+F5EnPo+LwGA/G4blmx2qqltNENTxyGPS/JNbRdguoNoQlMYlUwnuxIItVU
         GGayHpSzVuh3AFGDkHhd0DtWRI+6fmRk+COg61EyyR601beTbpGkT9qFHVzUnSBu1vTW
         JJ1Q==
X-Gm-Message-State: APjAAAW/mZwUhIyt62L4ujWnJyCfPDvPtIMO1l5cRTdV50TAaU/JgqaH
        TZgoK/eSNMwnFudmok2AugM=
X-Google-Smtp-Source: APXvYqyOD2OVm4hxdR+4j4Rx5ixpvnmIMo4lhFcqQkPg7YIJ8KGy5EahAfvECVkYSNrVt61HdFfYwQ==
X-Received: by 2002:a17:902:581:: with SMTP id f1mr31880770plf.304.1556101246467;
        Wed, 24 Apr 2019 03:20:46 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:46 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 06/28] locking/lockdep: Update obsolete struct field description
Date:   Wed, 24 Apr 2019 18:19:12 +0800
Message-Id: <20190424101934.51535-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_chain struct definition has outdated comment, update it and add
struct member description.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6e2377e..851d44f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -203,11 +203,17 @@ struct lock_list {
 	struct lock_list		*parent;
 };
 
-/*
- * We record lock dependency chains, so that we can cache them:
+/**
+ * struct lock_chain - lock dependency chain record
+ *
+ * @irq_context: the same as irq_context in held_lock below
+ * @depth:       the number of held locks in this chain
+ * @base:        the index in chain_hlocks for this chain
+ * @entry:       the collided lock chains in lock_chain hash list
+ * @chain_key:   the hash key of this lock_chain
  */
 struct lock_chain {
-	/* see BUILD_BUG_ON()s in lookup_chain_cache() */
+	/* see BUILD_BUG_ON()s in add_chain_cache() */
 	unsigned int			irq_context :  2,
 					depth       :  6,
 					base	    : 24;
-- 
1.8.3.1

