Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540BBC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2AD20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QnLisD6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfEWCNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:13:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44379 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWCNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:13:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id w25so2842820qkj.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3/EfmHSRs62elR8A/odK6e3/0Brcb6KqCx2aA27cX0=;
        b=QnLisD6/JMGBjRoEeUEBnzIhET9cvQhrzLkPKkXxNCJuPiuygToVdTcDsAwx42cZ1b
         UlAvySDZcxZSyTgfucQA3QsEb+vUS9fysnn19IhqPclikUfqfkQbzpjx1C7xeWQ/EFm4
         clYt9HU1w6PBTd5Tuk8E+PY0ybn0CgpK3YGFcAI2L9GEobEqfakjbhs3PVghusX4HIZP
         gSNNkIVt4CqnzDSiZWwl2sgaMjpmZUvdh2ByMQtDucxE2HRrledC+a9W0cyhRIOAJ8UA
         EGMeRm8vYCQpbB5aKbglgNRP7qSkS+6hhZCn4KzcVXWcX1GQyD2iiRmOseNAzvUG6t4s
         05Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3/EfmHSRs62elR8A/odK6e3/0Brcb6KqCx2aA27cX0=;
        b=eMzwGKDB3TeO+bgxEs0jzk/W8kQtEswyLKNTrLGqSOICNe6pfDvzIj7kFhTAnif0RV
         BCnbm5BL4o5Wq49TuPkGkAJI2zrl6QsPWykdFrxuRz+F1ERCWSixwJGwAc0S5CMj0bTQ
         Sl5G3aNgfiPLJvLtFeZTh2QiPPyLXwZg28U/xiQGm3kq7pbTJ2shVyjDdc3c6ecz2UZ5
         /+ZgwQXbgloTGR3SNrobJnLK617RWAF1Qqct4oSKRhi5rxSiCDGqfmyU0PWJaqm+sXiw
         MbXG2x4V+/tDoGmTv8IlAOoLxWE0Rcw9+IXMQDPCX2JV55/QuPpL+uqQ+JDPlQMNZfdo
         +6jw==
X-Gm-Message-State: APjAAAUSRyt+MhWNTojboALtuOxkzxNseDsdCtg/QXcTWSfIfwBpf+Jz
        4Sz4YEvssde79yu52QHtSy0qAQ==
X-Google-Smtp-Source: APXvYqwBibUBUKv3IpDQKP/S8DuZjyNQXNlKDOPKwGuuQFaNi+Xo8eCt6bpY/XnH14YiP71Dm3MSig==
X-Received: by 2002:a37:660d:: with SMTP id a13mr35324863qkc.347.1558577590882;
        Wed, 22 May 2019 19:13:10 -0700 (PDT)
Received: from ovpn-121-0.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j29sm11895298qki.39.2019.05.22.19.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 May 2019 19:13:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] sched: fix "runnable_avg_yN_inv" not used warnings
Date:   Wed, 22 May 2019 22:12:45 -0400
Message-Id: <20190523021245.2882-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

runnable_avg_yN_inv[] is only used in kernel/sched/pelt.c but was
included in several other places and causes compilation warnings,

In file included from kernel/sched/pelt.h:2,
                 from kernel/sched/rt.c:8:
kernel/sched/sched-pelt.h:4:18: warning: 'runnable_avg_yN_inv' defined
but not used [-Wunused-const-variable=]
In file included from kernel/sched/pelt.h:2,
                 from kernel/sched/fair.c:705:
kernel/sched/sched-pelt.h:4:18: warning: 'runnable_avg_yN_inv' defined
but not used [-Wunused-const-variable=]
In file included from kernel/sched/pelt.h:2,
                 from kernel/sched/deadline.c:19:
kernel/sched/sched-pelt.h:4:18: warning: 'runnable_avg_yN_inv' defined
but not used [-Wunused-const-variable=]

Fixed it by appending the __maybe_unused attribute for it, so all
generated variables and macros can still be kept in the same file.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 Documentation/scheduler/sched-pelt.c | 2 +-
 kernel/sched/sched-pelt.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-pelt.c b/Documentation/scheduler/sched-pelt.c
index e4219139386a..6c10b8764533 100644
--- a/Documentation/scheduler/sched-pelt.c
+++ b/Documentation/scheduler/sched-pelt.c
@@ -20,7 +20,7 @@ void calc_runnable_avg_yN_inv(void)
 	int i;
 	unsigned int x;
 
-	printf("static const u32 runnable_avg_yN_inv[] = {");
+	printf("static const u32 runnable_avg_yN_inv[] __maybe_unused = {");
 	for (i = 0; i < HALFLIFE; i++) {
 		x = ((1UL<<32)-1)*pow(y, i);
 
diff --git a/kernel/sched/sched-pelt.h b/kernel/sched/sched-pelt.h
index a26473674fb7..c529706bed11 100644
--- a/kernel/sched/sched-pelt.h
+++ b/kernel/sched/sched-pelt.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by Documentation/scheduler/sched-pelt; do not modify. */
 
-static const u32 runnable_avg_yN_inv[] = {
+static const u32 runnable_avg_yN_inv[] __maybe_unused = {
 	0xffffffff, 0xfa83b2da, 0xf5257d14, 0xefe4b99a, 0xeac0c6e6, 0xe5b906e6,
 	0xe0ccdeeb, 0xdbfbb796, 0xd744fcc9, 0xd2a81d91, 0xce248c14, 0xc9b9bd85,
 	0xc5672a10, 0xc12c4cc9, 0xbd08a39e, 0xb8fbaf46, 0xb504f333, 0xb123f581,
-- 
2.20.1 (Apple Git-117)

