Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD1CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E38E20856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq2/vV0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfHEMXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:23:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46460 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:23:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so2446170pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ohj8KSWGo2nhApI0RM9RRDG6wa0D5NI6rZtcauJuo7w=;
        b=Lq2/vV0Pqe/r1QH+JpS1FgOvGYFIAlO01kM8v5N/KlNlxGwyokpMvqYyDCGS65/O/L
         ig2qzFoJ/Eub/409Zvm94AZfX6yebCavrf+xRY5jWY4cRssSE4HJivEYfH9Q2ISC6KVS
         mvYyI7U8XATTcf5mS8IGAewp2VfJoj/c0D6bY+X7XZlFz4NDQMagN0yHqNP6JEgXpH6Z
         azH8lLskoWbfDRnEZgDs+IPScmMfaZmRBv84ARcr80KuTHjlMA8ABqveKUV/zx+P94ED
         ntuMOK+EftegUYIHQ+c4LX9TlmVOZxsoBagZByZI6xv41pF6VdxJ5GCidYpPzGyyLjLk
         OO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ohj8KSWGo2nhApI0RM9RRDG6wa0D5NI6rZtcauJuo7w=;
        b=k3/jw0122cR5UyHFqdF8WsFXhEJkMdWoGVSu0OUV77n46PRWx4brV9V33b+hmtPvKa
         5d3HFoeU91MTXSCkfxEfoOYX72pH/ndSc4ft84S+oLTzZK7GzgOcTCwCGk46G8fkfkZI
         76uIzZv0q7ThbFTTm9dJ5qvDCauGCFfQcpPT0C5SY1s/lytaQ0Rj9N9lroF0uvEx6Uk1
         yYHgtiLNygsGVFQcqnRIvaRvHSWNjYE4kGY1eKDPJk1JWrSKJQMZX9g1vgyHkbo6Sidh
         0ArCQp3EOFaGxfjNDUnoO/YrI1AED2qpPlBlf1DtuxRVLRU0MSAMXAaWUPD1+nAuVLoJ
         w/+w==
X-Gm-Message-State: APjAAAWbIWJktD/r1vwQR3BE+XXKemzoWcKVa9KQHn1dba1wA159RNyK
        q6Elf1/c6M2VZD1AZ8g4N+WnBEUwuI0hYA==
X-Google-Smtp-Source: APXvYqxrJ5qMcBRwT7sNV+da6HfSKId4dEVsm8z7SvQmr2tuial6NzBEPnNiwyCq3v+YmURaHnrNyg==
X-Received: by 2002:a65:48c2:: with SMTP id o2mr12700113pgs.45.1565007784005;
        Mon, 05 Aug 2019 05:23:04 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 97sm21685371pjz.12.2019.08.05.05.23.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:23:03 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 4/8] printk: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:22:54 +0800
Message-Id: <20190805122254.13041-1-hslester96@gmail.com>
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
Changes in v3:
  - Revise the description.
  - Remove else uses in printk.c.

 kernel/printk/braille.c | 10 ++++++----
 kernel/printk/printk.c  | 19 +++++++++++++------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index 1d21ebacfdb8..e451b8b1d3d5 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -11,11 +11,13 @@
 
 int _braille_console_setup(char **str, char **brl_options)
 {
-	if (!strncmp(*str, "brl,", 4)) {
+	size_t len;
+
+	if ((len = str_has_prefix(*str, "brl,"))) {
 		*brl_options = "";
-		*str += 4;
-	} else if (!strncmp(*str, "brl=", 4)) {
-		*brl_options = *str + 4;
+		*str += len;
+	} else if ((len = str_has_prefix(*str, "brl="))) {
+		*brl_options = *str + len;
 		*str = strchr(*brl_options, ',');
 		if (!*str) {
 			pr_err("need port name after brl=\n");
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..6b8d9cfebc0b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -118,19 +118,26 @@ static unsigned int __read_mostly devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
 
 static int __control_devkmsg(char *str)
 {
+	size_t len;
+
 	if (!str)
 		return -EINVAL;
 
-	if (!strncmp(str, "on", 2)) {
+	if ((len = str_has_prefix(str, "on"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_ON;
-		return 2;
-	} else if (!strncmp(str, "off", 3)) {
+		return len;
+	}
+
+	if ((len = str_has_prefix(str, "off"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
-		return 3;
-	} else if (!strncmp(str, "ratelimit", 9)) {
+		return len;
+	}
+
+	if ((len = str_has_prefix(str, "ratelimit"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
-		return 9;
+		return len;
 	}
+
 	return -EINVAL;
 }
 
-- 
2.20.1

