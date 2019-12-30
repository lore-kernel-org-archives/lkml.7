Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0460C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A234520718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="ROTOztYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfL3Ujd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:39:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43514 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3Ujd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 15:39:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so18535603pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 12:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCmfcVGhIPIEtkFz9D8Xp0Dnftdi6meO7YleSZubkbI=;
        b=ROTOztYBWpBZLGXNQrTL/Q0Qdb0/8c+RR6XLuTdo1KZU1Sk9qeVVj6JuAj1JZNA9v8
         XkaK5I3NcPUIPdPLogpBJnJECO/wGtYZ1tTipYlEbPIJq58t+7+BQVpnB2kCaQzeva86
         3DW9FwcAVtFRPw2mIPhyCCrtb/5ZG23dMDB3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCmfcVGhIPIEtkFz9D8Xp0Dnftdi6meO7YleSZubkbI=;
        b=ZNszu9QKPe8S4LnvD+NWLDBBblRkJPWUnlmjrR8PAZh5cQqgUbRKaAudoVXbIFmZgH
         szdvDKh6jNFTVYWbbU1YasOoja6PfN6Gow4xAPHhtB6qN67rilK+3JwQNDNiDJBt5jLU
         aD666apfgwqox9Es3oauZqmVZ2GOutYYtXATQjJUNDL2OGaIE+YQHskUnv12V14aRS8A
         FhUwqQn/dFcPO28wSwisvwjtstv6fEkj5JwEcLkaKluzhxjP0vnqGFo4ThyJLekINyio
         DSZnuqRKegugFKB4S+izK65wVL0FpCSeY2JehMzWqy3qmiHAI6LIpw7xLaygMqbcucuK
         Cf7Q==
X-Gm-Message-State: APjAAAUi30qzX9LpkeUzgL/hEwpzYG32AHUseDV2i0rmRwLnDzCQ4ktg
        Jp3cDdc6GcHEwdb/liwg6CfQurxbBu4zyQ==
X-Google-Smtp-Source: APXvYqxwUW9fL1URUJKngKoMr5cA8PVTMrJsDI7VgLFyUzroJ9e36nMKfCg+Y2yU2QILFqs1otRTjA==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr40320076pfg.51.1577738372337;
        Mon, 30 Dec 2019 12:39:32 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id 11sm54053387pfz.25.2019.12.30.12.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 12:39:31 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] selftests/seccomp: Test kernel catches garbage on SECCOMP_IOCTL_NOTIF_RECV
Date:   Mon, 30 Dec 2019 12:38:11 -0800
Message-Id: <20191230203811.4996-1-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds to the user_notification_basic to set a field of seccomp_notif
to an invalid value to ensure that the kernel returns EINVAL if any of the
seccomp_notif fields are set to invalid values.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index f53f14971bff..393578a78dbc 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3158,6 +3158,13 @@ TEST(user_notification_basic)
 	EXPECT_GT(poll(&pollfd, 1, -1), 0);
 	EXPECT_EQ(pollfd.revents, POLLIN);
 
+	/* Test that we can't pass garbage to the kernel. */
+	memset(&req, 0, sizeof(req));
+	req.pid = -1;
+	EXPECT_EQ(-1, ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req));
+	EXPECT_EQ(EINVAL, errno);
+
+	req.pid = 0;
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	pollfd.fd = listener;
-- 
2.20.1

