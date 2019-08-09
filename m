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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6F2C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFC3208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdl5tl0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405802AbfHIHLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:11:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45436 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405601AbfHIHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:11:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so272738pfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Brhr0qTfy6eIZUgUAjbJm4cExvPM1CHKMDl4HPzycKU=;
        b=Qdl5tl0KRHY+tjx50bG3jMFxwG3oW5O+XryiHiCs6NMl6IpKJ32OLhWfv0hPAzfW6c
         7C04HIqzkAFTjbZPGpxwIQDlU3xHxZsIbF3KKS7/mlarPOycLZ2RWL4UeVAY1/XA1Fxv
         R4WCK5N53nBss2s9NUmrWz3BT5Tljk+X8VPGQ2AJ24vLwXVHyFzwE2j4WENG3yLFHy3e
         Zjx1lOZKGpFho+bC81eBCZrX3/GCVPwMMpfgmIn+PhtNHHnn2F2tJswHiBpaYgdybb2m
         5IHp7nCGglVZYkvQsR8+rWSKNRbeKZ08M5/pvhPYJEAZ4rWPN6dNzkr7PY2xXITn1sZk
         x5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Brhr0qTfy6eIZUgUAjbJm4cExvPM1CHKMDl4HPzycKU=;
        b=NWMeK1z+mGYxD4Yhb8+rIU03NFw6EldjqZaB9Gjtvimi9+e526AHRRyBL4DzzivHpy
         TPWdcexn1vhVwDtdMOD6jpxeeT03DfobWNKAbhvQ9pZ88X/O/LIN1cQnCC/q3ikQpFMx
         sVZLAk6PcRnR3RenMo6WhPRKEsbo3H/CzeGhuRDQSxYp+e2mxguZLZmvznptDCWh/XvO
         V8T4Qwsa7A91KabB3QMpWtdoLQUpIRWAQcFmRTPyFDuD1IP5XA7MOSLniFHFWTrduC0A
         JWyy74Y+pwOZSDG6xtMu/YNm2wFAyKXW6KvmO7N6SZFnsMckC6PAG/t20CYEaYxu5oP3
         RtYw==
X-Gm-Message-State: APjAAAX5Z0N2CcY7zWi+0zBomHkqtAAedWLB2ByA/bInktD4j1D5n0vM
        A37XOJlwy0K2roua2XBFMMjBeQVd2M/G8g==
X-Google-Smtp-Source: APXvYqyNuLXAnJIl3BgZ6eVc5t++/qJ2IJxO/67J+tvO7ppwH5ARE07Jx6CIq6+pmXnYuw78X6/jTw==
X-Received: by 2002:a17:90a:26ac:: with SMTP id m41mr2502408pje.59.1565334667285;
        Fri, 09 Aug 2019 00:11:07 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 10sm506324pfv.63.2019.08.09.00.11.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:11:06 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 7/8] userns: Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:11:03 +0800
Message-Id: <20190809071103.17442-1-hslester96@gmail.com>
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

 kernel/user_namespace.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 8eadadc478f9..bd5702f9273a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1138,6 +1138,7 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 	char kbuf[8], *pos;
 	bool setgroups_allowed;
 	ssize_t ret;
+	size_t len;
 
 	/* Only allow a very narrow range of strings to be written */
 	ret = -EINVAL;
@@ -1153,16 +1154,19 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 
 	/* What is being requested? */
 	ret = -EINVAL;
-	if (strncmp(pos, "allow", 5) == 0) {
-		pos += 5;
+
+	len = str_has_prefix(pos, "allow");
+	if (len) {
+		pos += len;
 		setgroups_allowed = true;
+	} else {
+		len = str_has_prefix(pos, "deny");
+		if (len) {
+			pos += len;
+			setgroups_allowed = false;
+		} else
+			goto out;
 	}
-	else if (strncmp(pos, "deny", 4) == 0) {
-		pos += 4;
-		setgroups_allowed = false;
-	}
-	else
-		goto out;
 
 	/* Verify there is not trailing junk on the line */
 	pos = skip_spaces(pos);
-- 
2.20.1

