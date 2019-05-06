Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E82CC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2216E20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvsUWLx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfEFIU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38814 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfEFIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so6355802pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6Ul8DqLCrwUzW/73FoDcrnG9o+ApspVb0NBeqVAdd8=;
        b=hvsUWLx42A+WRy5nb3rtkdmvbL88ClAOBumICvHHENL9aBosAJJvsojy2mJkQgLe/i
         PJOM51rfzWErur+UtjhVQgkwvI4fvVvtX328WwrFda5xsP/rPA14X7UlH8tmJTEKV5IC
         FVvynx1zFzjcq4u80+/T/Ed40SjJFKCZMnk1rvcosqj8TRSYJMpunekTAP9c3XKPQRIx
         3PJGz1dklrRr4fq5NrS3W3dvvCsskEEG5EQvPvuikNN4JLXpkHPwak5BBYuToi2BeJ82
         yAJTJH7uQeSmeuZFBu1TBNXOcDLETwCA+IoMrdMkwnjfhF4mzfUFJapMcvOoGK7s37rz
         N5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6Ul8DqLCrwUzW/73FoDcrnG9o+ApspVb0NBeqVAdd8=;
        b=ViDJhTs8KSuHwoDDwQXimcu0Z8fC0ovZZOd4quAcqnoD/62X6hwLzjQhNyaApma/sf
         P3iuh9Moo2PR+F4lz/M51qWQwzcm66LaTDPaW4444bEJQGwptyYBra2y9iAKQAU0NSxl
         6Mip++InC7UCuUXSrSelp3+Qfx53MjcLzrOXDiR2ZFHfjZ2FKpcsxGqVEZWCS8bZU3HO
         9vF/mNweoSimU2E9+MLFhR7OFmp1MOU0Qa3BGDlAs/h3gplsiQGutiKyNcWq/mssoXlk
         pMp4bMZwgZK8FVbpDrG+7lk0j50zX0ftBQMswbHGtuJWYn4Mch0dLypz5TSKC0xTNNO8
         cPNg==
X-Gm-Message-State: APjAAAX2aVE2hQ74JGHuQhIkxSVvgkJ5qZNnhsNobOBkUHssV/lm6Hiz
        q1k7k5BcTn72oOpq3J0r28Q=
X-Google-Smtp-Source: APXvYqz4o2SPXUcSTdbu7daT3P7D16Mm9N/Qg38znPGo6ijgAtTye/zW+Mjd0ZciiLiHsNEUVMNKMg==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr32120914pfe.29.1557130852698;
        Mon, 06 May 2019 01:20:52 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:52 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 20/23] locking/lockdep: Check redundant dependency only when CONFIG_LOCKDEP_SMALL
Date:   Mon,  6 May 2019 16:19:36 +0800
Message-Id: <20190506081939.74287-21-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Peter has put it all sound and complete for the cause, I simply quote:

"It (check_redundant) was added for cross-release (which has since been
reverted) which would generate a lot of redundant links (IIRC) but
having it makes the reports more convoluted -- basically, if we had an
A-B-C relation, then A-C will not be added to the graph because it is
already covered. This then means any report will include B, even though
a shorter cycle might have been possible."

This would increase the number of direct dependencies. For a simple workload
(make clean; reboot; make vmlinux -j8), the data looks like this:

 CONFIG_LOCKDEP_SMALL: direct dependencies:                  6926

!CONFIG_LOCKDEP_SMALL: direct dependencies:                  9052    (+30.7%)

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2502ea4..9d2728c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1734,6 +1734,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	return ret;
 }
 
+#ifdef CONFIG_LOCKDEP_SMALL
 /*
  * Check that the dependency graph starting at <src> can lead to
  * <target> or not. If it can, <src> -> <target> dependency is already
@@ -1763,6 +1764,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
@@ -2423,12 +2425,14 @@ static inline void inc_chains(void)
 		}
 	}
 
+#ifdef CONFIG_LOCKDEP_SMALL
 	/*
 	 * Is the <prev> -> <next> link redundant?
 	 */
 	ret = check_redundant(prev, next);
 	if (ret != 1)
 		return ret;
+#endif
 
 	if (!trace->nr_entries && !save_trace(trace))
 		return 0;
-- 
1.8.3.1

