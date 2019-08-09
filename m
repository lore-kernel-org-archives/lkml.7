Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533EBC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A19208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExW1GuZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405791AbfHIHK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:10:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36184 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405637AbfHIHK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:10:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so45391695pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HmVTzMroi4wKPHeymf1bmR1J99J9U+VX7aA5kNGTesM=;
        b=ExW1GuZ7EVry7wLfjaaBcxIuJkZtbypTeIQO5+tsrYw2aoD1hkftD+zza89I8E6a0f
         pwKHck5/S6YgLE/PXazozkfggA339pOqhQKDES/tmWhrEDiXOsfLZhXk9KKQyRUJ87Vd
         d+UWYeqeT0VRMYZWwDl6cTzRJB1n4JULsLiBv6LzF8+BZ2DKe9t78cIwzzqYb2wHvIj7
         zc+KK/P4FZD63zDFH6lI4TuzrE5FKz3YY8DUmDxi1LrH4F7XuC2gqKF3y+2FpU17g7jp
         HeA8ClQmCxUXoZu6Ig0QRbFa3YUATrqQY6nxdI2N1P8i1hkN20iRh54BTZj+AZyy6lOa
         xyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HmVTzMroi4wKPHeymf1bmR1J99J9U+VX7aA5kNGTesM=;
        b=tL4nuehXkN0pXyQYY8Be+p7DrjQ1O/1tcR7zifHauhPpGAKmK6WVl84GuUzjmjkowP
         enwQPH7gk2JXYA5CzmKYOP3PHmb8GY/U8NlVYNcCrE7+YQR8wAbaEBJUr556veYn8bwm
         YdKwiQ355g+xD62wwOVWpTQgmih5njzskRO4A5Fh+iWx8If4ItYwiI0XtiFDIwlJ97WC
         BiIunzVoDM6IaHU75K33SE5BNyFW+pN/3T1mXSzYLhN+mLIS9PJxPiiLQQSSOcp+kzCH
         oR+rWUqQP3eGypZDxP6NAhxu41/sy2EFXXZ/b0Y7KlCqB00MyoCZMSnFmbiHWWdVVl5u
         4+Yw==
X-Gm-Message-State: APjAAAUb6akHbJJi47odhbQGM8DkxcT/O6jgq/bZOWk0PIfKjaWpD5jL
        /jr4mY+/emrb0RLhob08JmE=
X-Google-Smtp-Source: APXvYqzB4F+yS7f1sgEjUNcOjRCCmtgwl96RqnbPCksZpxp2Ya1m4QtKRIu6e88VZSMxmphd2yU8kg==
X-Received: by 2002:aa7:9514:: with SMTP id b20mr20281567pfp.223.1565334656644;
        Fri, 09 Aug 2019 00:10:56 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id c26sm100738897pfr.172.2019.08.09.00.10.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:10:56 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 6/8] sched: Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:10:51 +0800
Message-Id: <20190809071051.17387-1-hslester96@gmail.com>
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
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v4:
  - Eliminate assignments in if conditions.

 kernel/sched/debug.c     |  6 ++++--
 kernel/sched/isolation.c | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..a03900523e5d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -102,10 +102,12 @@ static int sched_feat_set(char *cmp)
 {
 	int i;
 	int neg = 0;
+	size_t len;
 
-	if (strncmp(cmp, "NO_", 3) == 0) {
+	len = str_has_prefix(cmp, "NO_");
+	if (len) {
 		neg = 1;
-		cmp += 3;
+		cmp += len;
 	}
 
 	i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ccb28085b114..ea2ead4b1906 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -141,16 +141,19 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
 static int __init housekeeping_isolcpus_setup(char *str)
 {
 	unsigned int flags = 0;
+	size_t len;
 
 	while (isalpha(*str)) {
-		if (!strncmp(str, "nohz,", 5)) {
-			str += 5;
+		len = str_has_prefix(str, "nohz,");
+		if (len) {
+			str += len;
 			flags |= HK_FLAG_TICK;
 			continue;
 		}
 
-		if (!strncmp(str, "domain,", 7)) {
-			str += 7;
+		len = str_has_prefix(str, "domain,");
+		if (len) {
+			str += len;
 			flags |= HK_FLAG_DOMAIN;
 			continue;
 		}
-- 
2.20.1

