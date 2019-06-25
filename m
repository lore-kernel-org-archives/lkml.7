Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3012CC4646B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04BE2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIRno+AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfFYAS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:18:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42061 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFYAS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:18:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so7762787plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNNDPnLZx+KR0jVJlsU7XfT0ox6KotHr4SLhMC572uY=;
        b=BIRno+AS454hBQbuQGJLmDsxNzU2PjmkxXG9qTatuiWkplhN1CHqCV/Ow8BoJdLZny
         xX+0KWbI72KRstm2IUv2lrUGY3kQOuI+p+Eoq41Rp4wF22fbmVeQVEQ26UOUpjq4YznS
         hopQhnxDOthZgau/MzcHHCnoAMHxo/bVipRQUQGzHkk1NLYEze99v8DblYC/XFXJOXOd
         7aip1YZ3Fd4++t1pNyRpdAsIqb6fu4t5C9g3c7QnYtCB4G2ezO0lVbG5MFWLAOtSuSBv
         oDCUDVeaDzHb7cw3OIGGkZKHk+zY/8w/sJVH5NcDYLg7MP1OsI4OsBRuHfJIvfY7U4kq
         hhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNNDPnLZx+KR0jVJlsU7XfT0ox6KotHr4SLhMC572uY=;
        b=qiAIEsnz/QbWTFURDUyC3uaZmZqFKuNiNp4yd7uMPg0c8/X28PITUwH56sDBNDh1V0
         34Szb7QhjJQ/FGo09i9Mes2hGYDOHTP7f0vkxpb0y8PXyrrzEUvIIjqZ5o5jUiJh3qB0
         jz8woBMK7TUgN9uYcpa/4NkFeV7w6IoBFrbs0bcLjK8R68BAafQleBRt/M7UO9AjTeF2
         ZoKyCcd21g+1rbdqWe8TitsYyeTrSifFjzKEa4Od/+zoDJ7nseq5Ou2ob9QjdJB2EiSz
         amROiFC9oI2deZxzTrBzZPC92SmnG3XDVSNcaX4Axk2iXFPecAsJ8NW/WasQN3FnBv2/
         SU9A==
X-Gm-Message-State: APjAAAUJGURb0xqJpUysZA56cRu1lRqHI4F3Khn/gNeMK0u2aPEJUPcc
        lEZE+l2ifmf96mlohH5Jt7Kty77K
X-Google-Smtp-Source: APXvYqyXJrBhQYRtTEGj63jfVn62kEduJJx7AIfCXeJMdRlvSUvKma51TGvNujEEFyIFltIBfb9S0Q==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr18386661plc.78.1561421906556;
        Mon, 24 Jun 2019 17:18:26 -0700 (PDT)
Received: from bobo.ibm.com ([1.129.216.90])
        by smtp.gmail.com with ESMTPSA id j64sm15893351pfb.126.2019.06.24.17.18.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 17:18:25 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2] kernel/isolation: Assert that a housekeeping CPU comes up at boot time
Date:   Tue, 25 Jun 2019 10:17:20 +1000
Message-Id: <20190625001720.19439-1-npiggin@gmail.com>
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
v2: Fix a NULL pointer dereference when not overriding housekeeping,
    noticed by kernel test robot and Qais, who fixed it and verified
    the fix (thanks!)

 kernel/sched/isolation.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 123ea07a3f3b..a9ca8628c1a2 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -63,6 +63,32 @@ void __init housekeeping_init(void)
 	WARN_ON_ONCE(cpumask_empty(housekeeping_mask));
 }
 
+static int __init housekeeping_verify_smp(void)
+{
+	int cpu;
+
+	if (!housekeeping_flags)
+		return 0;
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

