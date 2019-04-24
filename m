Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386B82175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8sueVEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfDXKVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37953 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfDXKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so9080685pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUbE0l8ESuXny4EMkKvO4cEsxQopKceRf5oHUmqZiWk=;
        b=q8sueVEa+mAx+ibGdxfUCjuFkOzpK/+z3WnPWZHH3OW0cgH052tGuPby23DNrAUzep
         nEeq1W2S839tdTaOZmKWQn+5KW+0/dRYXFKccSCPru8NgNngadZDJE4e9rB9vf5pSY8a
         ZoDLC6n4f+fly03QYmWtPSpBEr7l78vmiiJWAv93DMsnKZxggiuyNBUP9mOdW9apPgCd
         UNwtUL0bqyOf9cSdFH3w1oT2bgLQ9yjfjzVVMdPgPxNE5sR1Xnm2civAaOL/AYC6DmK7
         +uGqt18mFrv+GH9NTAkLw+nS+gTP8Zz8/9sj2JKmeRshGPU1n30tkGddVBehtxSflYHj
         G2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUbE0l8ESuXny4EMkKvO4cEsxQopKceRf5oHUmqZiWk=;
        b=fRyVwFiI98lR9qgMX9BF289wJO37J3gOVb1FcFJBOQlmUp0njTeNH3byy+N/zkzmxM
         vPOS9jCnfQlfVE5kYH989MJQM+sZyvUl741r/4SIAKbqDmLvrmrxRa6il3DxYawCIlkg
         Lk0F5kMvymzjIuf24MzEzC8d4aAmtUsnCYFOAQYSQRyWea6HGkVCSsVcYmsVcTDz3Y6f
         lTaRv7lJ+S/x8YuW+lxVTdlYF7ORg2l+6iayeByRMU0sRs11eQn59eDH/DHWskiFGDxk
         180RMDw6JDuwPwWvIVLa6AZ04rycOrBJtFEk6tm3bvS2nW8Ctnq9/fn7fiAmi5EvDvAX
         JFJA==
X-Gm-Message-State: APjAAAUldTG6LkS7C8l0yUibbPO2HZVTbX+0ED07OLNzkXbywbhCXkAg
        fseW4ha8nvgtcFzJeMro560=
X-Google-Smtp-Source: APXvYqzJ6Y+gpsffadiiZgaNl9K5Qr7lGGsrTzP8AnIol94aQZMPV629zHMlX5TfZ3dcFEk4+PpURg==
X-Received: by 2002:a65:63c3:: with SMTP id n3mr15521869pgv.170.1556101295834;
        Wed, 24 Apr 2019 03:21:35 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:35 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 22/28] locking/lockdep: Adjust new bit cases in mark_lock
Date:   Wed, 24 Apr 2019 18:19:28 +0800
Message-Id: <20190424101934.51535-23-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new bit can be any possible lock usage except it is garbage, so the
cases in switch can be made simpler. Warn early on if wrong usage bit is
passed without taking locks. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c08ec88..291cc9c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3476,6 +3476,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 {
 	unsigned int new_mask = 1 << new_bit, ret = 1;
 
+	if (new_bit >= LOCK_USAGE_STATES) {
+		WARN_ON(1);
+		return 0;
+	}
+
 	/*
 	 * If already set then do not dirty the cacheline,
 	 * nor do any checks:
@@ -3499,25 +3504,13 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		return 0;
 
 	switch (new_bit) {
-#define LOCKDEP_STATE(__STATE)			\
-	case LOCK_USED_IN_##__STATE:		\
-	case LOCK_USED_IN_##__STATE##_READ:	\
-	case LOCK_ENABLED_##__STATE:		\
-	case LOCK_ENABLED_##__STATE##_READ:
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-		ret = mark_lock_irq(curr, this, new_bit);
-		if (!ret)
-			return 0;
-		break;
 	case LOCK_USED:
 		debug_atomic_dec(nr_unused_locks);
 		break;
 	default:
-		if (!debug_locks_off_graph_unlock())
+		ret = mark_lock_irq(curr, this, new_bit);
+		if (!ret)
 			return 0;
-		WARN_ON(1);
-		return 0;
 	}
 
 	graph_unlock();
-- 
1.8.3.1

