Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63CCC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 11:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3460271DA
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 11:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg+vnr5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfFALkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 07:40:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39819 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfFALkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 07:40:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so5078263plm.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIhb0CDPed3D+NHblB8JHYtMxpbrpKM35qjFH9cW0Ms=;
        b=eg+vnr5v5//hD4SkPhlTIVIoI+/DRioFUXAweuAupb+JO1oDoNNQolQY2OHpiVy+JA
         u7N5TgLnrtSUxgq4FKpcXO5DMnAUKLHqqKS/h9yb51G1JpzBucxJQtBlziWBzBop1U8L
         O3UtnMNQhZoNSQBrbrwVar2ep8loBnyFg56v3XAVRJ2qpvKiiKlmiDNeQzQx/jvbTDvA
         zi7fsmKIdq/sRz7tWswemffHJD4SUsCY7GY9r8+zz8p5fLk50d1ZEbK0VblCGicqA6/w
         uuIaB5kXdvmwiCUXIdUD6QzqR9+JEAtFDsyAtTDb5bFYiJyB8GofjazbEMI55MEeXWpY
         vtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIhb0CDPed3D+NHblB8JHYtMxpbrpKM35qjFH9cW0Ms=;
        b=cyV3+5+k+ll/Set9ia90DgMKCrjwj0kB93FbAgTCnugZzZV4pdNXObhBSGYNG0v/gc
         I5DUwQGSRRUiMV4QRw/tg9ta73sKHcgBr0M+SFYNLwvQOi9tahkfsUE7CQDZv7M/lF0Q
         yJJ7QbnhGbWtAyGaSn99G4YP46NVonogYxDIkR4BqOIAl82MXiv7/Gf/klAxxFp8lK1A
         tTnzFS0dzJZGCmAJ7yORdGQ7QJNzBJRlXNjiQ9ygqEuVzUOTadU1iLYVmc+gJOEd7ufi
         IIuJ4L8xfGIPDBh6RfnZ75771JE3IDC5OMFZXy3wb+wNfWc6IH2qsSy8JUVtjVYME6mg
         HGIg==
X-Gm-Message-State: APjAAAUDSMoVv/sP5ThWlpUaWUozwhzga0ZX4LolVPn34J8A8tLfuk6z
        7Xwf3HiaY2tsTA0XEWnKWmK2zbFc
X-Google-Smtp-Source: APXvYqzMK9OXthmpLQ4YSWxsKGJtCYG6DJt9ggVbQKVDBxrKl7dOywO2/N1qE6GwpYdCKPNpoCEV3g==
X-Received: by 2002:a17:902:b084:: with SMTP id p4mr16315511plr.59.1559389205651;
        Sat, 01 Jun 2019 04:40:05 -0700 (PDT)
Received: from bobo.local0.net (193-116-103-22.tpgi.com.au. [193.116.103.22])
        by smtp.gmail.com with ESMTPSA id 2sm4386575pfo.41.2019.06.01.04.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 04:40:04 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] kernel/isolation: Asset that a housekeeping CPU comes up at boot time
Date:   Sat,  1 Jun 2019 21:39:19 +1000
Message-Id: <20190601113919.2678-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the change to allow the boot CPU0 to be isolated, it is possible
to specify command line options that result in no housekeeping CPU
online at boot.

An 8 CPU system booted with "nohz_full=0-6 maxcpus=4", for example.

It is not easily possible at housekeeping init time to know all the
various SMP options that will result in an invalid configuration, so
this patch adds a sanity check after SMP init, to ensure that a
housekeeping CPU has been onlined.

The panic is undesirable, but it's better than the alternative of an
obscure non deterministic failure. The panic will reliably happen
when advanced parameters are used incorrectly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/isolation.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 123ea07a3f3b..7b9e1e0d4ec3 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -63,6 +63,29 @@ void __init housekeeping_init(void)
 	WARN_ON_ONCE(cpumask_empty(housekeeping_mask));
 }
 
+static int __init housekeeping_verify_smp(void)
+{
+	int cpu;
+
+	/*
+	 * Early housekeeping setup is done before CPUs come up, and there are
+	 * a range of options scattered around that can restrict which CPUs
+	 * come up. It is possible to pass in a combination of housekeeping
+	 * and SMP arguments that result in housekeeping assigned to an
+	 * offline CPU.
+	 *
+	 * Check that condition here after SMP comes up, and give a useful
+	 * error message rather than an obscure non deterministic crash or
+	 * hang later.
+	 */
+	for_each_online_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, housekeeping_mask))
+			return 0;
+	}
+	panic("Housekeeping: nohz_full= or isolcpus= resulted in no online CPUs for housekeeping.\n");
+}
+core_initcall(housekeeping_verify_smp);
+
 static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
-- 
2.20.1

