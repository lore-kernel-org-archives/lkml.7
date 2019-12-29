Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF8BC2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1324C208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 06:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="Cwv3pV7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfL2Gm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 01:42:56 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44943 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfL2Gmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 01:42:55 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so25526073iln.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 22:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bjv6BKmHq7jafW5njryuF9SNoXnHToQ8eDKjbZ/26wg=;
        b=Cwv3pV7nJDx/EkUC5nl4IfPMY+aLsaQqK3divT+i7fyLPimlHU5TMp9Enfu9GG0rSa
         1fUMsgJWKvegTwR8hlcLFSZXymsaw/5UHGwOR9+2QOELzBKRVqCrz1cnW1nwB2MtorqE
         aaFpvqOQO0hrwxfhfPnTQMZOOiiN1YYvOTxQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bjv6BKmHq7jafW5njryuF9SNoXnHToQ8eDKjbZ/26wg=;
        b=YL+BFUcv8qRuWPX9Cm8lBTUbDK48hfcUkU/S/dAKg99YqGaQNANJE0b9pyF5F46RFH
         DIuePBWoHk/eTEXbCDaM8KccjLGQwlQz6zp7xguHHemc8Qe6FNIf2Qff0vabgZxZ9THQ
         t6bWTCFRgHadGIn+M5nD/b1fYZDbGt/Hp3trRS5bvvoWqQXg5B1hfBEKSyJygrXu1tZE
         77gW3X5vuJcF9DCH42eBPV/Xzm9xiI7dKbsIii9QvTzfJG6vMrJOxTLwN2VBjen90pJT
         QgGtAGNkNdzOEncZV8riQu+Jb5jcgiliInIiphG6EO8LlKHJbI5M5b4eUXSHnKQBsKtj
         uAjw==
X-Gm-Message-State: APjAAAVFsuDqmr0koDCKFVOvE9X0i7NAMpiD3s23l0XStIrfpDfKAx1R
        he8UOOP4eOyqfQukupDJdMgdlZNtvMOk2Q==
X-Google-Smtp-Source: APXvYqxWxEN3dlFMkquUlSmmjp7WmwS69IxBWHajCkhjfVYSlUAbJP/ndC/DxkVIZxgM8IDuqvbWXA==
X-Received: by 2002:a92:d451:: with SMTP id r17mr51402716ilm.201.1577601774268;
        Sat, 28 Dec 2019 22:42:54 -0800 (PST)
Received: from ubuntu.netflix.com ([75.104.68.239])
        by smtp.gmail.com with ESMTPSA id y11sm15112053ilp.46.2019.12.28.22.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 22:42:53 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH v3 3/3] selftests/seccomp: Test kernel catches garbage on SECCOMP_IOCTL_NOTIF_RECV
Date:   Sat, 28 Dec 2019 22:24:51 -0800
Message-Id: <20191229062451.9467-3-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191229062451.9467-1-sargun@sargun.me>
References: <20191229062451.9467-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a self-test to make sure that the kernel returns EINVAL, if any
of the fields in seccomp_notif are set to non-null.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index f53f14971bff..379391a7fa41 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3601,6 +3601,29 @@ TEST(user_notification_continue)
 	}
 }
 
+TEST(user_notification_garbage)
+{
+	/*
+	 * intentionally set pid to a garbage value to make sure the kernel
+	 * catches it
+	 */
+	struct seccomp_notif req = {
+		.pid	= 1,
+	};
+	int ret, listener;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	EXPECT_EQ(-1, ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req));
+	EXPECT_EQ(EINVAL, errno);
+}
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.20.1

