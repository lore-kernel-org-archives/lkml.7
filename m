Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B50C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F4722466
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDQcXQa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfJLTQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:16:31 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55874 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfJLTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:16:27 -0400
Received: by mail-pg1-f202.google.com with SMTP id k18so9461401pgh.22
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JzOfukPeifzyE+Hzh6AM1ECnC48wv32Xd/UndNRDiTo=;
        b=kDQcXQa0VYmk2lf9nJ7jqZxWRDVdkQVg+UBXlTJRuKtd7I68txAG3zAAgGzWHZffIz
         ACbU48iFgUzzey52gZXZhwXb/RlhFw/BAkjTItM87AJ6j0JppA2oWS/FARYCx8qDlkcS
         C6MPV7I/5wSKFvYULa1jc8EpbWv4WQqH4r2xf84JPOREQyzXwh9pd5BY2PzMQsdzULzf
         Na3ZxHH93Li1yqBwI9w1X881rwDx1lxUmC/T76qqIFsCPHyxai4EgzSUeQ5uvT8BkZjx
         MtlrBaaEFRezoYk0J6qwwXL0aicSKjGgU8B/V9/ZbeQpeV42NsFzOkQl/bKFzOD5Rxfl
         Eoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JzOfukPeifzyE+Hzh6AM1ECnC48wv32Xd/UndNRDiTo=;
        b=ZnQBaLpj4CXJ2ETrwvSjJzpAAjifxKdg3qHSCJldaFeTecgP7K9xP69meNZia2uL+F
         hgk5zEIM2obDIM58rY5Nn+Z6oVDGmWQo4LCeOotNtJ/KY5tpeDYPySRB1ELf3kBubreF
         oiHxeSrNEAYo3YgqZcAm2DCjEjmdQBus2j7IhCyko1Y9Bzt114Otm+JhUHblwZy19lkb
         sNxqrsbg9ZMenYcaTbgaKsjcycNEy9yZcwgwTT68AmTDp8U2Lb9W2qSqv4IpTVhNdUQ0
         SVlSR+WM7mj6G1IcH96FWFphV/2URB87/NIg+EQGAEd3SPq1x3UI3jV1PXvF5fcmPH4C
         gOQg==
X-Gm-Message-State: APjAAAUfmfXDDYavU3+4O6LgzcTSr/qR4yszSIWvK0HTXan6FktTC2oS
        Hbc7+KLmCyH+om15Vd7hXJ8yJTWHkvo=
X-Google-Smtp-Source: APXvYqzw7iabkWhemyxvTnIX/T9BzR5SF73Fi8qy/bKbaOnBvZx+inukMBWdgUDNzzaCq9k8abBUkjs0hT8=
X-Received: by 2002:a65:498c:: with SMTP id r12mr24547774pgs.280.1570907784749;
 Sat, 12 Oct 2019 12:16:24 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:16:02 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-8-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 7/7] Add a new sysctl for limiting userfaultfd to user mode faults
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sysctl knob unprivileged_userfaultfd_user_mode_only.
This sysctl can be set to either zero or one. When zero (the default)
the system lets all users call userfaultfd with or without
UFFD_USER_MODE_ONLY, modulo other access controls. When
unprivileged_userfaultfd_user_mode_only is set to one, users without
CAP_SYS_PTRACE must pass UFFD_USER_MODE_ONLY to userfaultfd or the API
will fail with EPERM. This facility allows administrators to reduce
the likelihood that an attacker with access to userfaultfd can delay
faulting kernel code to widen timing windows for other exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
 fs/userfaultfd.c                        | 12 ++++++++++--
 include/linux/userfaultfd_k.h           |  1 +
 kernel/sysctl.c                         |  9 +++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 6664eec7bd35..330fd82b3f4e 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -849,6 +849,19 @@ they pass the UFFD_SECURE, enabling MAC security checks.
 
 The default value is 1.
 
+unprivileged_userfaultfd_user_mode_only
+========================================
+
+This flag controls whether unprivileged users can use the userfaultfd
+system calls to handle page faults in kernel mode.  If set to zero,
+userfaultfd works with or without UFFD_USER_MODE_ONLY, modulo
+unprivileged_userfaultfd above.  If set to one, users without
+SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for userfaultfd
+to succeed.  Prohibiting use of userfaultfd for handling faults from
+kernel mode may make certain vulnerabilities more difficult
+to exploit.
+
+The default value is 0.
 
 user_reserve_kbytes
 ===================
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index aaed9347973e..02addd425ab7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -29,6 +29,7 @@
 #include <linux/hugetlb.h>
 
 int sysctl_unprivileged_userfaultfd __read_mostly = 1;
+int sysctl_unprivileged_userfaultfd_user_mode_only __read_mostly = 0;
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
@@ -1963,8 +1964,15 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	struct userfaultfd_ctx *ctx;
 	int fd;
 	static const int uffd_flags = UFFD_SECURE | UFFD_USER_MODE_ONLY;
-	bool need_cap_check = sysctl_unprivileged_userfaultfd == 0 ||
-		(sysctl_unprivileged_userfaultfd == 2 && !(flags & UFFD_SECURE));
+	bool need_cap_check = false;
+
+	if (sysctl_unprivileged_userfaultfd == 0 ||
+	    (sysctl_unprivileged_userfaultfd == 2 && !(flags & UFFD_SECURE)))
+		need_cap_check = true;
+
+	if (sysctl_unprivileged_userfaultfd_user_mode_only &&
+	    (flags & UFFD_USER_MODE_ONLY) == 0)
+		need_cap_check = true;
 
 	if (need_cap_check && !capable(CAP_SYS_PTRACE))
 		return -EPERM;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 549c8b0cca52..efe14abb2dc8 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -29,6 +29,7 @@
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
 extern int sysctl_unprivileged_userfaultfd;
+extern int sysctl_unprivileged_userfaultfd_user_mode_only;
 
 extern const struct file_operations userfaultfd_fops;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index fc98d5df344e..4f296676c0ac 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1740,6 +1740,15 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
+	{
+		.procname	= "unprivileged_userfaultfd_user_mode_only",
+		.data		= &sysctl_unprivileged_userfaultfd_user_mode_only,
+		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd_user_mode_only),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 	{ }
 };
-- 
2.23.0.700.g56cf767bdb-goog

