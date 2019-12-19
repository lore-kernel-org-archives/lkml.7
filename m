Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6288C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E0220684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLSO5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:57:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44591 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSO5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:57:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id u71so6557656lje.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1bqiGjtD7vGe+8mOC+Trksp96KVnU1v0dtDWNKVC7w=;
        b=Y7VuAX4I/2cCNT1nhDnPEI1JBJgSKLe7Gt1xiYZ8cRpf8HxQhm1xRpomaKVgHb2Nqf
         HOWWMy9IU+YT5gcl3EiPVu5GUTqX1pAdlzNZMUxNbFjkBpXcVFdIAVi/X77YDmdk5EwW
         WFBOiIFKLztLtAfYSWwoqyan9FnFsMMecfu4Zg2K4yJ8cAOi6M5Ye7plXeacJLlWyuO/
         qxeUpldQglM87VtOKi81/kI6jW0Bffpu8xlg+WzsstgI73HCLwc7qRvaGeeKstV6JmZM
         0YmJF5cV0cRH0dLDaeBrzt3EoKPDz9BB08uj2+JTn9oVQYV77S5/pkpmYm37PDYX2xoT
         Ji/Q==
X-Gm-Message-State: APjAAAUdr4YCF9RyS7DQAENwsQHyRJIDCS/+HJ3foRZq7IfieziwbbGq
        4FYjzcF6JuL9ezBC/OaNhog=
X-Google-Smtp-Source: APXvYqzgZGw2EsAp4CVXyS3Fc0c0zezyhaKOVNfH33Y4w1Nur4fdH9U/FurKzvgGt+7YlGj1oYurNw==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr6037911ljh.42.1576767472374;
        Thu, 19 Dec 2019 06:57:52 -0800 (PST)
Received: from localhost.localdomain ([213.87.152.106])
        by smtp.gmail.com with ESMTPSA id y23sm3054591ljk.6.2019.12.19.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:57:51 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     notify@kernel.org
Subject: [PATCH v1 1/1] lkdtm/stackleak: Make the stack erasing test more verbose
Date:   Thu, 19 Dec 2019 17:54:16 +0300
Message-Id: <20191219145416.435508-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the stack erasing test more verbose about the errors that it
can detect. BUG() in case of test failure is useful when the test
is running in a loop.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/misc/lkdtm/stackleak.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index d5a084475abc..d198de4d4c7e 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -16,6 +16,7 @@ void lkdtm_STACKLEAK_ERASING(void)
 	unsigned long *sp, left, found, i;
 	const unsigned long check_depth =
 			STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
+	bool test_failed = false;
 
 	/*
 	 * For the details about the alignment of the poison values, see
@@ -34,7 +35,8 @@ void lkdtm_STACKLEAK_ERASING(void)
 		left--;
 	} else {
 		pr_err("FAIL: not enough stack space for the test\n");
-		return;
+		test_failed = true;
+		goto end;
 	}
 
 	pr_info("checking unused part of the thread stack (%lu bytes)...\n",
@@ -52,22 +54,29 @@ void lkdtm_STACKLEAK_ERASING(void)
 	}
 
 	if (found <= check_depth) {
-		pr_err("FAIL: thread stack is not erased (checked %lu bytes)\n",
+		pr_err("FAIL: the erased part is not found (checked %lu bytes)\n",
 						i * sizeof(unsigned long));
-		return;
+		test_failed = true;
+		goto end;
 	}
 
-	pr_info("first %lu bytes are unpoisoned\n",
+	pr_info("the erased part begins after %lu not poisoned bytes\n",
 				(i - found) * sizeof(unsigned long));
 
 	/* The rest of thread stack should be erased */
 	for (; i < left; i++) {
 		if (*(sp - i) != STACKLEAK_POISON) {
-			pr_err("FAIL: thread stack is NOT properly erased\n");
-			return;
+			pr_err("FAIL: bad value number %lu in the erased part: 0x%lx\n",
+								i, *(sp - i));
+			test_failed = true;
 		}
 	}
 
-	pr_info("OK: the rest of the thread stack is properly erased\n");
-	return;
+end:
+	if (test_failed) {
+		pr_err("FAIL: the thread stack is NOT properly erased\n");
+		BUG();
+	} else {
+		pr_info("OK: the rest of the thread stack is properly erased\n");
+	}
 }
-- 
2.23.0

