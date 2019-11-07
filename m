Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E4CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41E421D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xJlo1DuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKGTyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:54:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfKGTyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:54:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id 29so2671480pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yt65JEzI8B4ThC22+VCw7CM+LK+ArEMO8/zLSXCHvk0=;
        b=xJlo1DuPB3YVBQAgFBR+GjVfwFtDBuQ75nv+sOnYtZPQ9qSXZxB8HraZUGDFxy1Drz
         f71wLXCjXxGHlCCs4z60NYnl14ny5cszdYwgmbJgZFxncgjtZ1MXyr1R/0NkJ+bOhIbG
         3pRidFtRgR2sgu8rJHSs23dG8WMz3UGcczVaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yt65JEzI8B4ThC22+VCw7CM+LK+ArEMO8/zLSXCHvk0=;
        b=RD9cAPXEDu2bvCA9smi35gZPXOFYS0+Z222ABpZc4DZ62fb2QQVE2ghtp3+bv7vOdJ
         y6zPvYpN+6NitGo27xSBEt3qcbsFqGIXrzb5zjKvkQzLEP0RLjVROSvvdXlVeqnEpsy/
         jEVFcMWyJNyIG8kx92BGxutObG5JTbPro3WSs4pOBvdJve1jtxFbiyaiOtlnu1ufhVw2
         Od0noE8raSh4TWh4fMuG5EgPNesFk47lgNLY0+SuLmQuLqNxUDGYKOxU66e81WKuZ6z8
         Y55nRiUkWBRaRKfeMGJ6dIX00DwF7snje65voXmcAqL2DF06ux9eqD0TTpC8EQ3e1Hhv
         7E2w==
X-Gm-Message-State: APjAAAVV3zwbrxTr4kpUA4NGCyq2Ss6Z+rwp3XVBA+kiKsJ/pHPFxsiO
        /vE9iCocz85SYK3zRywsi/Y8y3O7roI=
X-Google-Smtp-Source: APXvYqyoeYqV+vMTE2cL67Ov6JWJRzPg3lrGLBosK857p3VGFNE53iEGD9JcdWLwOQIALLrrUutrDg==
X-Received: by 2002:a63:d70f:: with SMTP id d15mr6903311pgg.424.1573156444237;
        Thu, 07 Nov 2019 11:54:04 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y2sm3365870pfe.126.2019.11.07.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:54:03 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 2/2] memfd: Add test for COW on MAP_PRIVATE and F_SEAL_FUTURE_WRITE mappings
Date:   Thu,  7 Nov 2019 14:53:55 -0500
Message-Id: <20191107195355.80608-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191107195355.80608-1-joel@joelfernandes.org>
References: <20191107195355.80608-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this test, the parent and child both have writable private mappings.
The test shows that without the patch in this series, the parent and
child shared the same memory which is incorrect. In other words, COW
needs to be triggered so any writes to child's copy stays local to the
child.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index c67d32eeb668..334a7eea2004 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -290,6 +290,40 @@ static void mfd_assert_read_shared(int fd)
 	munmap(p, mfd_def_size);
 }
 
+static void mfd_assert_fork_private_write(int fd)
+{
+	int *p;
+	pid_t pid;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+
+	p[0] = 22;
+
+	pid = fork();
+	if (pid == 0) {
+		p[0] = 33;
+		exit(0);
+	} else {
+		waitpid(pid, NULL, 0);
+
+		if (p[0] != 22) {
+			printf("MAP_PRIVATE copy-on-write failed: %m\n");
+			abort();
+		}
+	}
+
+	munmap(p, mfd_def_size);
+}
+
 static void mfd_assert_write(int fd)
 {
 	ssize_t l;
@@ -760,6 +794,8 @@ static void test_seal_future_write(void)
 	mfd_assert_read_shared(fd2);
 	mfd_fail_write(fd2);
 
+	mfd_assert_fork_private_write(fd);
+
 	munmap(p, mfd_def_size);
 	close(fd2);
 	close(fd);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

