Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0E20850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/NI9+8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfCUH5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:57:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41971 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfCUH5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so3775001pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mpKILmLRkyNwBst3MsqugK5h65K37vdubXnA/ns4PoM=;
        b=M/NI9+8v39ow0TZH8xSP79FRm2TCA3ZtbzCo9sItS+/rua97VBuYYRn06QX69qI9/A
         nrtrEOpl7DC7zWR7UL+FVh9FU/Bq/Met5BTX+0Grsy9xdHJCPeAVBhIpdsc53jFLcSG3
         lVu6CMFUQaGWgpdFvhCnLKfa4wJxIvqp9GRu0zBUP7kX71sxto3kJNBEHcILKrNKRB2L
         w6OmIhmIq+nAtIYNRz86tB+r/Q0+ilpIvmqpAO0UheqTDvUK5pqfZ8mV8VsNw1k7qb1F
         N05PNGQJ1Gp/R2HhHmOpl046FUh86Ts88Dn2fHKM2s/SreqBCpOIJy/V9T3W4xenJihK
         t8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mpKILmLRkyNwBst3MsqugK5h65K37vdubXnA/ns4PoM=;
        b=PHSFIdPyaDTWAq7Q5ZkQpXJhiH/Hp7e96f/W+7d5cnLZNSatc28XC3R/FpYvntSU5D
         kObca1IKxBcuhzCVbN4Y33bm59i01gh5VK1vzHhW0+zUlz8O7IKqzx093sVu6rMD/i5Z
         IpHRJWFfC6IS8eFUKsGaE5Xh9OgETbmLRifbGhbjXN9TordW5bgdmebmRZT79Q1UygUl
         ZqxvIUsx8RLeKLJvZbzYZScYXRZmgamwyWjR8mZyDrGJlumCBaZkt1DUHTMdTV9IAesf
         rtQJt0RAmkpEHML9TghMPBiZPv9CVsP+5mpYc75Uo4ppvWW6noaO/IDLpLOJ/AOOBBc5
         9u0Q==
X-Gm-Message-State: APjAAAWVl5RZ12T1oCTwyIPtIpAz/kZf3fZtQP/Av56MNvh0Xu8ezbun
        APg1W/zSf6IcusDqXWQfobCCo8LI+/hCRw==
X-Google-Smtp-Source: APXvYqxLZKHvyP5NVlaKhLC4GnlnsUo/wGO8lhU8b0iPCHfZxsA3cr/buBjo+YWugdq6lVXsznvYUQ==
X-Received: by 2002:a17:902:848c:: with SMTP id c12mr2144808plo.207.1553155071464;
        Thu, 21 Mar 2019 00:57:51 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:51 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 06/18] locking/lockdep: Update obsolete struct field description
Date:   Thu, 21 Mar 2019 15:57:13 +0800
Message-Id: <20190321075725.14054-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_chain struct definition has outdated comment, update it and add
struct member description.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 79c3873..37706ad 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -199,10 +199,16 @@ struct lock_list {
 };
 
 /*
- * We record lock dependency chains, so that we can cache them:
+ * struct lock_chain - we record lock dependency chains so that we can cache them
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

