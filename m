Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDFDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF45A21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zye5Pv5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfDXKV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40150 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfDXKVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so9166204pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9KulxRHSSh2zFg+VMLczHaM1RFFY8TJzhSl5V4G1aw=;
        b=Zye5Pv5nKFs0r3n6BfENH+tFbbBzen9Ioo6RSKfLKZDBMQIpHI/LFRFYzX8B9SSfWM
         3NHK0VWeDbidz5UO5uoEyMq+DwdQTziGRqDD00GTSuEwU2W9rXtLM0sZwfn3K1b/tp+Z
         wHeeS/x6C2cFZs650Ki68cul3lE9rGeG6M4Zhz+Ogk7pOmz56mphJrmLa7XuATxf37hQ
         lyLrneXLolcHs1t8XEi0DbQ3BUxVew10GGoheqQ57YQ3wrgoorJH8NePk0PloARHSR14
         Y/wkHOSFTZWjjCuIGs5EYgV8IDf0k/V4dI0DfRMe3PbpEkaK2CXx1cmrf4HtJY/j8bY6
         vlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9KulxRHSSh2zFg+VMLczHaM1RFFY8TJzhSl5V4G1aw=;
        b=YDULf7NctKY3bpZPvQlWg+Y1WSACEVKNw73+A54wxZoEe/9r8vVXpfyeGeGOs2jbqY
         tCDTEjk88OrMxzk/dqBTKdXEG7v2gA0UcnMhkf+2tuVFZJ+KeoEG19VLWEnOFTCf7xsw
         kb/89ePJbl0HIL6Zr0SqPX41vaZlI7xReZj8L5VAJtjs2FLk8WigBr1cPgpMTC2pP4GJ
         3jHHzkypj3p3sT2jVDyBO1imMg56ve8kT281JhSiyRYnDuWzaSUh2DDozOtOzqpOuFNF
         GVECSGmga44LLkRWEOm+KG1GEcupAhgZxFEpuDFXnh+RmZ4yN4D+nYc1R/SB9un8RmQ7
         nOCg==
X-Gm-Message-State: APjAAAWJ8aTa0B5THKKMQlpbGvKOOuZb9vN3JTu6Gx7Q7vbv7Q2PsqKk
        Im8UGf4M/+u9XliXzc45z4aru55uBmad6w==
X-Google-Smtp-Source: APXvYqxIegR0ylBbHBxQ59ePlE1ybWfy+wTZp03OnvoBOp4//86O8C4wI3Sq1mKwjrpOKlkfrRpCTg==
X-Received: by 2002:a62:1d94:: with SMTP id d142mr32624004pfd.83.1556101314502;
        Wed, 24 Apr 2019 03:21:54 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:54 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 28/28] locking/lockdep: Reduce lock_list_entries by half
Date:   Wed, 24 Apr 2019 18:19:34 +0800
Message-Id: <20190424101934.51535-29-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The forward and backward dependencies consume the same number of
list_entries. Since backward dependencies are removed, the max number of
list_entries can be halved safely: MAX_LOCKDEP_ENTRIES /= 2, which goes
from 16384 to 8192 or 32768 to 16384.

Besides memory space reduction, the performance gain is also promising
with this new IRQ usage checking algorithm. We briefly show the
performance improvement on a simple workload: Linux kernel build (i.e.,
make clean; reboot; make vmlinux -j8). It is expected that for complex
real-world workloads with heavier lock usage and bigger dependency
graph, the benefits should be more.

Results:

------
Before
------

direct dependencies:                  6900 [max: 32768]
max bfs queue depth:                   272
find-mask forwards checks:            2875
find-mask backwards checks:          50229

-----
After
-----

direct dependencies:                  3444 [max: 16384]   ( -  50 % )
max bfs queue depth:                   223                ( -  18 % )
find-mask forwards checks:             370                ( -  87 % )
find-mask backwards checks:              0                ( - 100 % )

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep_internals.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 30d021b..3b4b3dd 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -92,11 +92,11 @@ enum {
  * table (if it's not there yet), and we check it for lock order
  * conflicts and deadlocks.
  */
-#define MAX_LOCKDEP_ENTRIES	16384UL
+#define MAX_LOCKDEP_ENTRIES	8194UL
 #define MAX_LOCKDEP_CHAINS_BITS	15
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 #else
-#define MAX_LOCKDEP_ENTRIES	32768UL
+#define MAX_LOCKDEP_ENTRIES	16384UL
 
 #define MAX_LOCKDEP_CHAINS_BITS	16
 
-- 
1.8.3.1

