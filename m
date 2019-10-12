Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934CEC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB072089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vU+VS9/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfJLTQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:16:40 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:33112 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfJLTQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:16:23 -0400
Received: by mail-pl1-f201.google.com with SMTP id d2so8000625pll.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iOxLSyvauwwhumHzgnG9xPoY+bBy9JSBRyXvMmFSrNY=;
        b=vU+VS9/Xc5ZZqcPsDEq08NdpvWhOfJ7V11CiZ4nhL2PcL/QGvs8KlCAI5hMoeF6KXe
         J22BspMsEAuiLiJIPH9KeY/UtlpL5m2+iYdd2QjCwngE1+BYX4B5aB6DBGTGa51xcRRZ
         p7auEWHT1k/rJ01trWIMLQO1ktUHOm7ANrHV+EA5oZSdYDeUGDY3HHR10CbCtI6QG7oQ
         FBllhGH81W5jXFSqnF65x0M2rxSJwcQ8Ng0mS9KTEI40+Mi263JknxSzFdEPG2lk53hR
         pxOLF0KEwfV3qblCcW2h0SnwDGbQdhR13Xq+gSVwFlRPNwOmkP1KRthADORsOvx3xHVR
         wpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iOxLSyvauwwhumHzgnG9xPoY+bBy9JSBRyXvMmFSrNY=;
        b=asfCmzSiUWNR7RhzNOr3YOZ/nxmJ/fxAweKheSJEmJoa5xBzyqlnDfuytbREyUT1D2
         5J5Jq9mVk4eCcq577J5CUYSZTySx5+JtC9YtC/6+toaKfsd4O/AHpvmFtKyMCn4u0hn9
         3kPj4HhjzaZZ1I2pgwhnwgphyyHHLtWPn4hSCx9b/EvACobbN+LnzdhAkOfWAsf59awF
         2l73vmyHFtiMPTXbzNB/8X3vd1/fI6sCeZfD3+NbR873ortrSwgylioQ42DqxjLQ4Zs3
         clB2/YvatkrzWx77RE9g2eID2dfv/DnC5Xk2d4ruNYMfDdsmpjlwO0yxYAqLoJdL9eGv
         xIQA==
X-Gm-Message-State: APjAAAXbFyTSnnu8rOMqQyIqQQCgPs+uvvAeFFwzvxgDPeYudhKrDibT
        nOWH1sF4B6yXyvqkYyDxvvzQpxiynUI=
X-Google-Smtp-Source: APXvYqyFl3qNDCqMy0PcJvX0enVhF6M9h9yutHE9ydYGe5euA4uri/08PLCdEMnDDfadqf0JFdrojOzW2zo=
X-Received: by 2002:a63:1e1f:: with SMTP id e31mr3212172pge.303.1570907781014;
 Sat, 12 Oct 2019 12:16:21 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:16:00 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-6-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 5/7] Let userfaultfd opt out of handling kernel-mode faults
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

userfaultfd handles page faults from both user and kernel code.  Add a
new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes the
resulting userfaultfd object refuse to handle faults from kernel mode,
treating these faults as if SIGBUS were always raised, causing the
kernel code to fail with EFAULT.

A future patch adds a knob allowing administrators to give some
processes the ability to create userfaultfd file objects only if they
pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
will exploit userfaultfd's ability to delay kernel page faults to open
timing windows for future exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c                 | 5 ++++-
 include/uapi/linux/userfaultfd.h | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 1123089c3d55..986d23b2cd33 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -389,6 +389,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
+	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
+	    ctx->flags & UFFD_USER_MODE_ONLY)
+		goto out;
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -1959,7 +1962,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
 	struct userfaultfd_ctx *ctx;
 	int fd;
-	static const int uffd_flags = UFFD_SECURE;
+	static const int uffd_flags = UFFD_SECURE | UFFD_USER_MODE_ONLY;
 
 	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
 		return -EPERM;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 12d7d40d7f25..eadd1497e7b5 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -239,4 +239,10 @@ struct uffdio_zeropage {
  * Create a userfaultfd with MAC security checks enabled.
  */
 #define UFFD_SECURE 1
+
+/*
+ * Create a userfaultfd that can handle page faults only in user mode.
+ */
+#define UFFD_USER_MODE_ONLY 2
+
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.23.0.700.g56cf767bdb-goog

