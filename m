Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E2DC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96DE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHVbc2pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfEUHIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:08:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46358 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfEUHIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:08:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id r18so7953501pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCzPCZF+x24sS03YB1jPAhrRBKiDQmd3KZY05F7KSFM=;
        b=RHVbc2pilM+0bkS5Jvwg+Ibm1lvO2wvhsRAO2fMgignObjIx5z3vWUM0z+C45gQZhi
         Wa4VWX1gm3GaCopzJ6cmfM67qu6ffG6TQ9qY4IArdUxmfHIfkN3x5FgqH6t77jb2FEYw
         L/NpJozNluW1oR6+gUdv4Nc0CWZFFkaj+6H8pMGYg7/j7jZBsDKEK4h3h2SVnCXYaDkS
         YONXKVaOf/3Vgu7nUmw7FWZ/B9eSM3d5tKNMyQZA0YwH+0Ct6arNs0Usxw3rzR/XA5fy
         +k8y07igm2aL8ZMoL1Jd69U44LBLOqRkXQ7rH7r4DBQtfr/rMQyxdk70iKwWHghcHz1l
         Ge+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCzPCZF+x24sS03YB1jPAhrRBKiDQmd3KZY05F7KSFM=;
        b=AER/pyUGsaKk54DwG/qohPfvZJqIgWo0jyv/xHKKcQyMfJZbnF1oSeyp/LS6M0kNp/
         t76xUB+4bVN7nmGkzDJevlfi1NK113AsGJ/qn+ek5w+u8F4pjCSFNNzp17JIzedL2rxy
         rSjn8yMX2urOlZGvZEUjNos7iqRPYU48Za/+SDR5KRqktdrzLrGGpm2VuAWhocTLTXec
         CdLXFtWbHjCLBJr3Sk2CDu6BfBWI2vFVVZ0f3Mu6KVYlzPmsssL3C6lX9pfsq84sJXZV
         GsABHBNRk4QcYR3l7LcOht61LZQ+o3DrY811WDwf0efpUTBBE6loYOr+sY+Mrn3loQHY
         SiiA==
X-Gm-Message-State: APjAAAVDBIZ0U7WtzGf/mxZkKniMY6uo0t91zPV2S/JOhvT+352KlXW9
        PQ2Q1B63O63RfUlZUCGr7Vk7g4kt
X-Google-Smtp-Source: APXvYqwIMhGLeBvpXmFvR9E0s9CaVCv1XCJpHrIaVkHroJU2tf2eaVjg+rPx4vIyy5pcQflGB+nAzQ==
X-Received: by 2002:a17:902:84:: with SMTP id a4mr81826578pla.210.1558422492641;
        Tue, 21 May 2019 00:08:12 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q193sm30033885pfc.52.2019.05.21.00.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 00:08:12 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/1] lockdep: fix warning: print_lock_trace defined but not used
Date:   Tue, 21 May 2019 00:08:08 -0700
Message-Id: <20190521070808.3536-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521070808.3536-1-jhubbard@nvidia.com>
References: <20190521070808.3536-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Commit 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside
CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING") moved the only usage of
print_lock_trace() that was originally outside of the CONFIG_PROVE_LOCKING
case. It moved that usage into a different case: CONFIG_PROVE_LOCKING &&
CONFIG_TRACE_IRQFLAGS. That leaves things not symmetrical, and as a result,
the following warning fires on my build, when I have

!CONFIG_TRACE_IRQFLAGS && !CONFIG_PROVE_LOCKING

set:

kernel/locking/lockdep.c:2821:13: warning: ‘print_lock_trace’ defined
    but not used [-Wunused-function]

Fix this by only defining print_lock_trace() in cases in which is it
called.

Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d06190fa5082..3065dc36c27a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2817,11 +2817,14 @@ static inline int validate_chain(struct task_struct *curr,
 	return 1;
 }
 
+#if defined(CONFIG_TRACE_IRQFLAGS)
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 {
 }
 #endif
 
+#endif
+
 /*
  * We are building curr_chain_key incrementally, so double-check
  * it from scratch, to make sure that it's done correctly:
-- 
2.21.0

