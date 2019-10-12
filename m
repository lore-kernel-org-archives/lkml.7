Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA979C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BA02089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjzTDsp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfJLTQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:16:30 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34228 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfJLTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:16:24 -0400
Received: by mail-pf1-f202.google.com with SMTP id a1so10252705pfn.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rndXJobaj7s7XR7/GcIAJKh9KiC/uTxb0FRgsTRBuNU=;
        b=UjzTDsp1v7Pubz24Y7XNFt2EfyIgRfB0QPsy4lwxZqSA25R8SP2JyFxFwcMc7sGNif
         uE92sAIwVTmLb6UoEij3KFtI4e5FKiWTVQHxM80R21s1nBH97wr3yQuTvaKnB0PRFXx4
         YB0CiOoInpXL9ISsfQggztQmFFIsXkVPORagAXt9ecqmIiGDWQ54n+4AaX0+rfXPBGeo
         ohuC1nfuU21BsFaPI8JnTgx4US6JLUPklBiVQAQ7NbzYUlg0HPCbZkiUJ30TYIk7RCPA
         ni+1cdZgsW47/cygSgeFIvF7YEBfM0i7CiepmeQiqkTLRW7G0vNDkucOjP8XknuCld+9
         hUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rndXJobaj7s7XR7/GcIAJKh9KiC/uTxb0FRgsTRBuNU=;
        b=tPglfSsKgEEpnzZ3kyR0pADmT1heIk8Lkm2CedP44xN/a57H0g5iAv4D7UUZdnyV84
         6soQJAv+M/0IKmJq4jJ87nFvb6OGBsh0UpLkY9AOwMaSpjrSh1VH5pOybVIjXOXFQVrd
         mpnrogT4yWTbD2BuJ/zCulrR/xyk7V0FjF6pa28UQYx4hB39e4DjGSxCSDe7cKK0jH3n
         gT38WDCZBDjaOooiHwDNzBXcCeF7c11WR+Ov1IqWfUcFpWrDj8tZkQ7KS36xNciB/a35
         9LXWft0PFWjT+1Y8kjaV71zq36fw4k1ftxqipmAOd4eeBUNCwDXhxM1Fa4TiMtgSrinF
         flqw==
X-Gm-Message-State: APjAAAUFiTLMP5tCuw5hRELP8ZkLl58+1hou0Uk6sACQMUSbzxJD0S1O
        zt5cNvqW2nuQ1GjR5Ytl8NzU7FtZMXA=
X-Google-Smtp-Source: APXvYqz6eiHLYmfCq8q467gPeGBdl/RKcDM8B/ZEjvbdGzPZ2a2CSS9rdnakqc9yLjanGkG9aZK+4D2nfMU=
X-Received: by 2002:a63:e0d:: with SMTP id d13mr24069788pgl.439.1570907782899;
 Sat, 12 Oct 2019 12:16:22 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:16:01 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-7-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 6/7] Allow users to require UFFD_SECURE
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds 2 as an allowable value for
unprivileged_userfaultfd. (Previously, this sysctl could be either 0
or 1.) When unprivileged_userfaultfd is 2, users with CAP_SYS_PTRACE
may create userfaultfd with or without UFFD_SECURE, but users without
CAP_SYS_PTRACE must pass UFFD_SECURE to userfaultfd in order for the
system call to succeed, effectively forcing them to opt into
additional security checks.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 6 ++++--
 fs/userfaultfd.c                        | 4 +++-
 kernel/sysctl.c                         | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 64aeee1009ca..6664eec7bd35 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -842,8 +842,10 @@ unprivileged_userfaultfd
 
 This flag controls whether unprivileged users can use the userfaultfd
 system calls.  Set this to 1 to allow unprivileged users to use the
-userfaultfd system calls, or set this to 0 to restrict userfaultfd to only
-privileged users (with SYS_CAP_PTRACE capability).
+userfaultfd system calls, or set this to 0 to restrict userfaultfd to
+only privileged users (with SYS_CAP_PTRACE capability).  If set to 2,
+unprivileged (non-SYS_CAP_PTRACE) users may use userfaultfd only if
+they pass the UFFD_SECURE, enabling MAC security checks.
 
 The default value is 1.
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 986d23b2cd33..aaed9347973e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1963,8 +1963,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	struct userfaultfd_ctx *ctx;
 	int fd;
 	static const int uffd_flags = UFFD_SECURE | UFFD_USER_MODE_ONLY;
+	bool need_cap_check = sysctl_unprivileged_userfaultfd == 0 ||
+		(sysctl_unprivileged_userfaultfd == 2 && !(flags & UFFD_SECURE));
 
-	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
+	if (need_cap_check && !capable(CAP_SYS_PTRACE))
 		return -EPERM;
 
 	BUG_ON(!current->mm);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 00fcea236eba..fc98d5df344e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1738,7 +1738,7 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= &two,
 	},
 #endif
 	{ }
-- 
2.23.0.700.g56cf767bdb-goog

