Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE5ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1562921A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJXVZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:25:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52046 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfJXVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:25:51 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iNkcA-00040X-EG; Thu, 24 Oct 2019 21:25:50 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, keescook@chromium.org
Cc:     luto@amacapital.net,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] seccomp: rework define for SECCOMP_USER_NOTIF_FLAG_CONTINUE
Date:   Thu, 24 Oct 2019 23:25:39 +0200
Message-Id: <20191024212539.4059-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from BIT(0) to (1UL << 0).
First, there are already two different forms used in the header, so there's
no need to add a third. Second, the BIT() macros is kernel internal and
afaict not actually exposed to userspace. Maybe there's some magic there
I'm missing but it definitely causes issues when compiling a program that
tries to use SECCOMP_USER_NOTIF_FLAG_CONTINUE. It currently fails in the
following way:

	# github.com/lxc/lxd/lxd
	/usr/bin/ld: $WORK/b001/_x003.o: in function
	`__do_user_notification_continue':
	lxd/main_checkfeature.go:240: undefined reference to `BIT'
	collect2: error: ld returned 1 exit status

Switching to (1UL << 0) should prevent that and is more in line what is
already done in the rest of the header.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/uapi/linux/seccomp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 61fbbb7c1ee9..9099972200cd 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -102,7 +102,7 @@ struct seccomp_notif {
  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_USER_NOTIF can
  * equally be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
  */
-#define SECCOMP_USER_NOTIF_FLAG_CONTINUE BIT(0)
+#define SECCOMP_USER_NOTIF_FLAG_CONTINUE (1UL << 0)
 
 struct seccomp_notif_resp {
 	__u64 id;
-- 
2.23.0

