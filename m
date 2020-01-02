Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3818C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF79B2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgABXtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:49:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37690 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgABXtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:49:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so30873403ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 15:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKUFgkAq6av3fCpY/y8sfQAdG6utgB0okP85MRpDaZQ=;
        b=mNbOkpq105ThOruUsD3+uNqFoSf1FpBRQOk9u0iVBPKJtrPdcQg+fwlvU5sXDxb4WD
         7U3brSbJnwreY6yaZ1DIkoFINwlbZobof+HQm52lfjFcW8No1WcOzSwE6aCsHvNSf+VS
         h1aohpmloWMfdUZPmlJ5jPh43Q2i8ub04soBywnzVxv3IXiIaYOnnFDaWvSbSxGwLVp2
         nDHiWWzKDreD7zvghdcojhkX5eCo8v3t/Xxp0iOQDGA9z1xqDjMdF4Wfe9TdWThk0/Vn
         mQuuyHqnwClNwijfdfpO9sDZ9YUdu79u5Uz1UIWtToy+Kt99txEdxqFMC1A8oV7uf8vS
         +G0g==
X-Gm-Message-State: APjAAAVGCMXP9i9fDJ3fjfP9aqa4DZbVhYiEoAmjQmjwhLtRnNw4kTfn
        yI3s3bSjzs1HrpD8uEyWwCg=
X-Google-Smtp-Source: APXvYqzc6y0aRQtiH+NrSB0EgEeJWiIRr2GgD6oiptOOSmdtOsIeOgWd8rN/uoVJBvCCUhaI14CfPA==
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr49076441ljo.41.1578008959467;
        Thu, 02 Jan 2020 15:49:19 -0800 (PST)
Received: from localhost.localdomain ([213.87.155.29])
        by smtp.gmail.com with ESMTPSA id d24sm23451015lja.82.2020.01.02.15.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 15:49:18 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Cc:     notify@kernel.org
Subject: [PATCH v2 1/1] lkdtm/stackleak: Make the test more verbose
Date:   Fri,  3 Jan 2020 02:49:07 +0300
Message-Id: <20200102234907.585508-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the stack erasing test more verbose about the errors that it
can detect.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/misc/lkdtm/stackleak.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index d5a084475abc..d1a5c0705be3 100644
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
+		dump_stack();
+	} else {
+		pr_info("OK: the rest of the thread stack is properly erased\n");
+	}
 }
-- 
2.23.0

