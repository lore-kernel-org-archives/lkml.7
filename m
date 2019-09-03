Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63810C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4915E206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfICSBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:01:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54716 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfICSBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:01:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id k2so455344wmj.4;
        Tue, 03 Sep 2019 11:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+j7vGFIuajYqxHIUEx1josnLfHJODn+hIKQuA7Dj6k=;
        b=TTfOrBMgtX7gWYDPuOJ9PpZ2t4ex9K04x8m0qm6+U9HF9aP8wUn5Qf4RA7/bZd4lRT
         6/sd0HFNFakkqfr1T5Ab61WEhymYwGR96jdK1oXdn3DzksxPcQGbFaR8wju6O3Zf5jMv
         WiC5kJCkMRpmJy6IXQOb+LwxHTbwwc8lWbOOgTjg+ury2b0Z8n+Uww6toMlRh5qRuHx8
         QPMLw8A8Y/1/qEs4c/hTFATulrKAxyjfYM4ZiHaS2rHcDH4IjVTOAdW67WT1ULyymFJ/
         BMji2PJ0pJnLtvEc7oAuqRjXqAxCk05U7UU6NiuYBHutiUYDxtEkX0DorlEDcdFJf98W
         E/iQ==
X-Gm-Message-State: APjAAAXqAFRTg7T49CNV2T3S3+8g+6a1128QOS0wBhIO+KYqo0lky5AJ
        KT7Cxoqb8YWZrp9SqRUtpdZ4yMQ6
X-Google-Smtp-Source: APXvYqziqD0+PoZoE7pqsz+OatNdMNyKewQuKhGvLWT7dXvwOj3fBkQa5KLuwzCJDZTdQOPtpNUHrw==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr656855wmj.136.1567533700734;
        Tue, 03 Sep 2019 11:01:40 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id m62sm484019wmm.35.2019.09.03.11.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 11:01:40 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Smack: Move request_buffer from stack to smack_audit_data
Date:   Tue,  3 Sep 2019 21:01:34 +0300
Message-Id: <20190903180134.16176-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_buffer is required to describe an access type in a string for
the audit. The problem here is that the string is saved on the stack
and then passed by reference to the next function in request field of
the smack_audit_data structure. Referencing variables on a stack
and saving them in external data structures is usually considered
as bad and error-prone practice. Thus, this commit simply moves
the request_buffer from the stack to the stack_audit_data structure
and removes the necessity of stack referencing. strcat calls are
replaced with strlcat calls - a safer analog for strings concatenation
with bounds checking.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 security/smack/smack.h        |  6 +++++-
 security/smack/smack_access.c | 12 +++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 62529f382942..9eeefb865dfd 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -278,7 +278,11 @@ struct smack_audit_data {
 	const char *function;
 	char *subject;
 	char *object;
-	char *request;
+#ifdef CONFIG_SECURITY_SMACK_BRINGUP
+	char request[SMK_NUM_ACCESS_TYPE + 5];
+#else
+	char request[SMK_NUM_ACCESS_TYPE + 1];
+#endif
 	int result;
 };
 
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index f1c93a7be9ec..99e58d4a9980 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -340,11 +340,6 @@ static void smack_log_callback(struct audit_buffer *ab, void *a)
 void smack_log(char *subject_label, char *object_label, int request,
 	       int result, struct smk_audit_info *ad)
 {
-#ifdef CONFIG_SECURITY_SMACK_BRINGUP
-	char request_buffer[SMK_NUM_ACCESS_TYPE + 5];
-#else
-	char request_buffer[SMK_NUM_ACCESS_TYPE + 1];
-#endif
 	struct smack_audit_data *sad;
 	struct common_audit_data *a = &ad->a;
 
@@ -360,7 +355,7 @@ void smack_log(char *subject_label, char *object_label, int request,
 		sad->function = "unknown";
 
 	/* end preparing the audit data */
-	smack_str_from_perm(request_buffer, request);
+	smack_str_from_perm(sad->request, request);
 	sad->subject = subject_label;
 	sad->object  = object_label;
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
@@ -371,14 +366,13 @@ void smack_log(char *subject_label, char *object_label, int request,
 	 * the logging policy says to do so.
 	 */
 	if (result == SMACK_UNCONFINED_SUBJECT)
-		strcat(request_buffer, "(US)");
+		strlcat(sad->request, "(US)", sizeof(sad->request));
 	else if (result == SMACK_UNCONFINED_OBJECT)
-		strcat(request_buffer, "(UO)");
+		strlcat(sad->request, "(UO)", sizeof(sad->request));
 
 	if (result > 0)
 		result = 0;
 #endif
-	sad->request = request_buffer;
 	sad->result  = result;
 
 	common_lsm_audit(a, smack_log_callback, NULL);
-- 
2.21.0

