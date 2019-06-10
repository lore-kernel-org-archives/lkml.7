Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C2C28EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 00:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48137206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 00:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P37FY37L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfFJAJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 20:09:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43637 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfFJAJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 20:09:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so4183567pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 17:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0Sw+e+yrQAJOus5kSpEpSxamgCvmkslHejRAQuQBAQ=;
        b=P37FY37L7ltEoAU//FKaOWz0MonnwvK97urT52QAry5ubTBjKmRe+InTCm0VwwjSJg
         xbSKedMSh9PaF88UhOeK7/XPrk/Pwy1ZEtM/Ra8aGaf7uRnosLVPuk8i31l9Q3TD42jU
         7E+dh98H8RGHc1jVManLU5mjd5aczmqKvA3txUFGdX2H2da3+dZCJijaDgLZpvxBqpp9
         85P1rik+/upRGXK+ertXJD+vrvck/0dtN8eAfdR5hqvEMeR1n2hebdZn1kFwQCBao4jM
         wz7TUTcpQWnQvKdAV5jA/KYAia7j21en5PZ20tQZarlzxS77yK6G8KYvxsyn4rqTaquV
         cNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0Sw+e+yrQAJOus5kSpEpSxamgCvmkslHejRAQuQBAQ=;
        b=L0nr+NBL8nn4xrWbAO54gD7yjkBOPO7IxLrUDMldgSfsB3LBh1Nb4XD1Mcj+qN7Otg
         iae1KOxPIEicDMSLnFTdMwgfQctwonNCVIj/1T8QgrDbg/fZpAbWMNGDt1V4kAshtJ8Z
         9mwxWht7K3sn7NY5rZ+KRKbvKLkF/Zl0247x0MLmddl1q5B+UMB02tNav4twSaB8zXJi
         roTDQS0cIkVoIDzgbBDSUSn3+06XUIkgQB2WpNb1gSAgAejiYotmsMyrjX6cH+uYDYzU
         suWoroTtjaAKGdvuH5R1mF1gABfreMj5x/Az2DkMHwCRlCN0kL4LLcyaO7gWVsu5KNYB
         y4Aw==
X-Gm-Message-State: APjAAAVgtEt65xxR56xuHevhShw6659Km3T8jfk9I0kjGHUtjkiS2DbG
        aUYBE23I+46m+J4z+8PU53K6+Rvg
X-Google-Smtp-Source: APXvYqwFbkTrO608A3UK1M9nasJpbBNVFnv55+jXOXHgrVoyAMAeMIGhLIhUNSpaelWgbGmhZ7MWKQ==
X-Received: by 2002:aa7:8203:: with SMTP id k3mr67494287pfi.124.1560125377233;
        Sun, 09 Jun 2019 17:09:37 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id o11sm7527600pjp.31.2019.06.09.17.09.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 17:09:36 -0700 (PDT)
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
Subject: [PATCH v2] lockdep: fix warning: print_lock_trace defined but not used
Date:   Sun,  9 Jun 2019 17:09:33 -0700
Message-Id: <20190610000933.29578-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609135114.GX28207@linux.ibm.com>
References: <20190609135114.GX28207@linux.ibm.com>
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

Fix this by annotating print_lock_trace() with "__maybe_unused".
Thanks to Paul E. McKenney for suggesting this less intrusive fix,
as compared to adding more ifdef noise.

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
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c47788fa85f9..2726dafdb29b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2818,7 +2818,8 @@ static inline int validate_chain(struct task_struct *curr,
 	return 1;
 }
 
-static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
+static void __maybe_unused print_lock_trace(struct lock_trace *trace,
+					    unsigned int spaces)
 {
 }
 #endif
-- 
2.21.0

