Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C8C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C8E2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjAtRwjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfH2IcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37576 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2IcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so1576347pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ndYsBqWw3lm9AlRGDvPEbBOKTM9ZoSmwZ9e8SQkG/N0=;
        b=DjAtRwjg+1iDuOVCiRMy5sYP3FKE2X9YDI0ctZ5u9bmSm/LBFWLNvWwbnu1qZW+ovP
         l4O2p3VwZvMUq1KxE05BG0B69Oz3ZFKFiHvETpdV/MiWTQccyh43YyjW3cVIR1nzGx9L
         pU8xtx+Sf5iUBZ8mo1Q82pkFRkqyYoTgUEBe9DmXlDg1HT0xb0Kd7yRJrnxEss1a/nFs
         a+/a1uDhr6X2n9QE2jJEHkrfmekP+UqiGeOV3eTO3sVymZXzrjPcIcXt4L6mQibmfNEP
         1G6b65i0z/p+X631RaB5dgCgqpUZ6yJDEvW+dBs1Jm5AAES6rBolUnmkNbGRW+ehIRF4
         QWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndYsBqWw3lm9AlRGDvPEbBOKTM9ZoSmwZ9e8SQkG/N0=;
        b=pOWmkE8FSfGrbjEdRupL7SvSfPU7x3oIble5pT4Gf4ZrVKWZ76na3XBTb7nZmhlRxt
         INl6jQptDpQQLLzMJqV70JG9VFCKXhi9Ku4G4Yyw5z+D0YC2g+Fghii7OTVhLUbWRZzN
         YtBI+U0BVkBGxexJYHMwnLV9irBEUZo+2R54lIR0KUrfgaFUf7zSUZmPBLbk2fhleavE
         nk+MAYguVdHEmB3nTEHSycB6aLeJkrEnvtNTkcLnNvJBRshRYJkpviRgZZ/ydByU/cLB
         9c/1eQU2NU73UXqQD9xkG8lUwc5qzP6+8Xz/iHdngv50w1VcLc4ICNXJWEsTPCwrX1DZ
         1/Iw==
X-Gm-Message-State: APjAAAVzmPpfh34qvMkhC/cJxMKrK8mPWMFtXFHom1hTzR0fks8aP/vn
        8MN+/ihkQKrIvcu+ePilr7I=
X-Google-Smtp-Source: APXvYqzvEYz0C2wV6APZyjHXbH6uVZ9XSIU2jnKCsvWzEWIhv09NSsr43OiNxev/TOyQUI3FFN8SVQ==
X-Received: by 2002:a65:6454:: with SMTP id s20mr7164732pgv.15.1567067536958;
        Thu, 29 Aug 2019 01:32:16 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:16 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 08/30] locking/lockdep: Skip checks if direct dependency is already present
Date:   Thu, 29 Aug 2019 16:31:10 +0800
Message-Id: <20190829083132.22394-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given a dependency <prev> -> <next>, two checks are performed:

1. Lock inversion deadlock:

We search whether there is a path from <next> to <prev> in the dependency
graph and if so we have a potential deadlock scenario in check_deadlock_graph().
But if the direct dependency <prev> -> <next> is already in the graph, there
can't be such a path (i.e., <next> to <prev>) because otherwise this path
would have been found when adding the last critical dependency that
completes the circle.

2. IRQ usage violation:

The IRQ usage check searches whether there is a path through <prev> to
<next> that connects an irq-safe lock to an irq-unsafe lock in the
dependency graph in check_irq_usage(). Similarly, if <prev> -> <next> is
already in the graph, there can't be such a path either.

This check skipping should be able to greatly improve performance by
reducing the number of deadlock and IRQ usage checks. This number precisely
equals nr_redundant, which actually is not a small number.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4838c99..de088da 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2433,6 +2433,25 @@ static inline void inc_chains(void)
 	}
 
 	/*
+	 * Is the <prev> -> <next> dependency already present?
+	 *
+	 * (this may occur even though this is a new chain: consider
+	 *  e.g. the L1 -> L2 -> L3 -> L4 and the L5 -> L1 -> L2 -> L3
+	 *  chains - the second one will be new, but L1 already has
+	 *  L2 added to its dependency list, due to the first chain.)
+	 */
+	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
+		if (entry->class == hlock_class(next)) {
+			debug_atomic_inc(nr_redundant);
+
+			if (distance == 1)
+				entry->distance = 1;
+
+			return 1;
+		}
+	}
+
+	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a deadlock scenario in the graph. (We do this by
 	 * a breadth-first search into the graph starting at <next>,
@@ -2459,21 +2478,6 @@ static inline void inc_chains(void)
 	 */
 	if (next->read == 2 || prev->read == 2)
 		return 1;
-	/*
-	 * Is the <prev> -> <next> dependency already present?
-	 *
-	 * (this may occur even though this is a new chain: consider
-	 *  e.g. the L1 -> L2 -> L3 -> L4 and the L5 -> L1 -> L2 -> L3
-	 *  chains - the second one will be new, but L1 already has
-	 *  L2 added to its dependency list, due to the first chain.)
-	 */
-	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
-		if (entry->class == hlock_class(next)) {
-			if (distance == 1)
-				entry->distance = 1;
-			return 1;
-		}
-	}
 
 	if (!*trace) {
 		*trace = save_trace();
-- 
1.8.3.1

