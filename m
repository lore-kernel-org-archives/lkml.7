Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8494B218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RBOirwOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfDXQiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:38:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41499 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732499AbfDXQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:38:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so3630867pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yK7KGyF6dcgyF8+VLqnKkfFFI5sTu/wy7hlOVceGxoo=;
        b=RBOirwOb3Ya7gk2LD0kWtKEUQ22WzVZqXR1xEvR2eCGtH4k8JLwqKMdgxsJYbG6vg7
         WTrIghWf3KFQY4HJmf/07OjLu3nz07eZ0B5v/yXzl82fFcvm49lYscFgR+bLBB5wiF5f
         mQlhjmbSchiELaHYuSL+p1Imw3d2+cwJGUyoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yK7KGyF6dcgyF8+VLqnKkfFFI5sTu/wy7hlOVceGxoo=;
        b=cUNW7BM2UxkUPAfWeyZV8bO1HRtwwCztYZBncaIpYMvWNTfycGKvtWjh0osWyoiUaT
         5a7ev/IEOCRD4B4YS6EQGTSp+xb3EFThiBDhqGPLSPDO6jAMGQYeLFbMdtD+Zc84rfJX
         E1Ul0bO133xGIeZ6t/j81AOytzPAAVypKbgdRbycU9blYNhWkQy9KZH1iKJMrfte/VOZ
         wbgyiYowvNYM8tnZQPF08Vg/RJGMVMy1GhLne9k4sRFMYfXvE5B/2wFt6IDaL49j/6Ih
         Oky8dwPWNYfhVNBgm9t2VINPqDWXM5ypgqJ06wzHX9mw4a+CjHfCSbuVkDfXrPEfKYOD
         kaWQ==
X-Gm-Message-State: APjAAAV3RyfRsPVJCm3qRfVtWG2MZrnlv9RstDvpM40MZ3rJbpJ1o8y8
        HWngkV+oxDPSogyhpSsmP9CKZg==
X-Google-Smtp-Source: APXvYqxxzUoDVfNqGEb9wutnoTpRSACF5noWmblLcg/Pb+2utXlEbmvHezmxGwUHOasMGQtVCUCRxw==
X-Received: by 2002:a17:902:8bc3:: with SMTP id r3mr33857257plo.53.1556123886024;
        Wed, 24 Apr 2019 09:38:06 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j6sm24688302pfe.107.2019.04.24.09.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 09:38:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/seccomp: Prepare for exclusive seccomp flags
Date:   Wed, 24 Apr 2019 09:37:55 -0700
Message-Id: <20190424163756.40001-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424163756.40001-1-keescook@chromium.org>
References: <20190424163756.40001-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some seccomp flags will become exclusive, so the selftest needs to
be adjusted to mask those out and test them individually for the "all
flags" tests.

Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 34 ++++++++++++++-----
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index f69d2ee29742..5019cdae5d0b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2166,11 +2166,14 @@ TEST(detect_seccomp_filter_flags)
 				 SECCOMP_FILTER_FLAG_LOG,
 				 SECCOMP_FILTER_FLAG_SPEC_ALLOW,
 				 SECCOMP_FILTER_FLAG_NEW_LISTENER };
-	unsigned int flag, all_flags;
+	unsigned int exclusive[] = {
+				SECCOMP_FILTER_FLAG_TSYNC,
+				SECCOMP_FILTER_FLAG_NEW_LISTENER };
+	unsigned int flag, all_flags, exclusive_mask;
 	int i;
 	long ret;
 
-	/* Test detection of known-good filter flags */
+	/* Test detection of individual known-good filter flags */
 	for (i = 0, all_flags = 0; i < ARRAY_SIZE(flags); i++) {
 		int bits = 0;
 
@@ -2197,16 +2200,29 @@ TEST(detect_seccomp_filter_flags)
 		all_flags |= flag;
 	}
 
-	/* Test detection of all known-good filter flags */
-	ret = seccomp(SECCOMP_SET_MODE_FILTER, all_flags, NULL);
-	EXPECT_EQ(-1, ret);
-	EXPECT_EQ(EFAULT, errno) {
-		TH_LOG("Failed to detect that all known-good filter flags (0x%X) are supported!",
-		       all_flags);
+	/*
+	 * Test detection of all known-good filter flags combined. But
+	 * for the exclusive flags we need to mask them out and try them
+	 * individually for the "all flags" testing.
+	 */
+	exclusive_mask = 0;
+	for (i = 0; i < ARRAY_SIZE(exclusive); i++)
+		exclusive_mask |= exclusive[i];
+	for (i = 0; i < ARRAY_SIZE(exclusive); i++) {
+		flag = all_flags & ~exclusive_mask;
+		flag |= exclusive[i];
+
+		ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EFAULT, errno) {
+			TH_LOG("Failed to detect that all known-good filter flags (0x%X) are supported!",
+			       flag);
+		}
 	}
 
-	/* Test detection of an unknown filter flag */
+	/* Test detection of an unknown filter flags, without exclusives. */
 	flag = -1;
+	flag &= ~exclusive_mask;
 	ret = seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL);
 	EXPECT_EQ(-1, ret);
 	EXPECT_EQ(EINVAL, errno) {
-- 
2.17.1

