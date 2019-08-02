Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBCBC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F834206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uehjDwMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfHBBri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:47:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41902 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfHBBrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:47:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so35119385pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNqYVJSJQaKqgrs//XJVX+Bi7rBtMitLuSGPIbLMf+A=;
        b=uehjDwMtucPY7a0/Xzh17QwaBhRz2LVB4y1KguITSTUcYtz+b4RSsg3BJAEj+q5To9
         dudTlC4IyW7IeR9jEZjRTPUGRvK63k254Bee6d6lkpKCyPGrxzrH3cr40HuQUtaL6ldy
         XEA3KQsNqyEqrlh36sIHz/csRuGPediAfABOAeUnHpldTyU2gNI1/9PCry+ec+jy9lDF
         R24UOTOuLjSj6BA7Bd/v6rcfS7nnd9HrnbCOgrEwQyazbYjLEoJ02GnjWAvlr4XQ7ZoX
         UQgTnbQLdaJd8rYV+egqEfwSutUgBmK7TwexVBrBBJUv+ZFqCOy2nGUTx+mKz4hXuahJ
         JZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNqYVJSJQaKqgrs//XJVX+Bi7rBtMitLuSGPIbLMf+A=;
        b=kOtxYewCmFlcnud+/AeUBQk5K7nVnN7x7CmEg+otgJhyNrWTA9jkfbUXeJSVKUQXJw
         lD00kE3NK6t7E3XcFhC7LlPJlIhZ5MmvdMUH2YPOkyDHqGdHyBV4MfaU/W2wPki+oKIm
         lcHp6DVHGZk9sweKNhtVVVI8YUtiCZFA/Gv9N6PjIpFQmPwXZYWXKA+rbhjcKi1RjDGt
         C2Fg3sv+DFyrZF1nIktuADalXpDlingDWJyCPCfsx6gvapQ9ujERxSoAIhrTyk0/59KN
         uT9VTQHRHHWW9Evm/neTtWS0Z1R3et7uLOgrn2sQT8nAD4u+Jcb3MDKgGOwOK10Ke++E
         CGQg==
X-Gm-Message-State: APjAAAXXQZUKl94Gu2XCa9fyCPkwF2pdOKeVpKb8KaXzt1f8Bq7xVNe2
        5xxVbYvt5N3g7EeleyQrkjI=
X-Google-Smtp-Source: APXvYqyY/ai6BzVKMoBfplCMCFRVPU4dJ3Px0qedM83U0hsY4sZbQyHE61lDElJqxYitswCWXC+sUw==
X-Received: by 2002:a63:36cc:: with SMTP id d195mr80467080pga.157.1564710457178;
        Thu, 01 Aug 2019 18:47:37 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id b30sm102489036pfr.117.2019.08.01.18.47.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:47:36 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 08/10] sched: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:47:32 +0800
Message-Id: <20190802014732.9060-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Revise the description.
  - Utilize str_has_prefix's return value to
    eliminate some hard codes.

 kernel/sched/debug.c     | 5 +++--
 kernel/sched/isolation.c | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..43983ff325b7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -102,10 +102,11 @@ static int sched_feat_set(char *cmp)
 {
 	int i;
 	int neg = 0;
+	size_t len;
 
-	if (strncmp(cmp, "NO_", 3) == 0) {
+	if ((len = str_has_prefix(cmp, "NO_"))) {
 		neg = 1;
-		cmp += 3;
+		cmp += len;
 	}
 
 	i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ccb28085b114..f528bb5996f4 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -141,16 +141,17 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
 static int __init housekeeping_isolcpus_setup(char *str)
 {
 	unsigned int flags = 0;
+	size_t len;
 
 	while (isalpha(*str)) {
-		if (!strncmp(str, "nohz,", 5)) {
-			str += 5;
+		if ((len = str_has_prefix(str, "nohz,"))) {
+			str += len;
 			flags |= HK_FLAG_TICK;
 			continue;
 		}
 
-		if (!strncmp(str, "domain,", 7)) {
-			str += 7;
+		if ((len = str_has_prefix(str, "domain,"))) {
+			str += len;
 			flags |= HK_FLAG_DOMAIN;
 			continue;
 		}
-- 
2.20.1

