Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A8BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C912168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5eBh8Hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbfEXLp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:45:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36824 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390743AbfEXLpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:45:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so4091451plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pThOH74d8lQhRMWxtImQn30Cs54Ck/famShCD5k4u9k=;
        b=X5eBh8HwaH2kevrFZ4TlTPyn6cWvSzx5HtglUCrryy8Wl14EeYfGa5fds8VoZdWH2Q
         Y5IboCDaK7hJmohhGNaA+8VHgKE08RmVIXejy5dDu6ybTieN93D3+YPvD1Q/cSDsmxTr
         IjUlcOW1i4Ifo4OPnkiLTM2xonIRh0sx7ke8DZxYFFUW6FW9O/kRjSSxWF9nlqS/pHKa
         KEsST7jVvik6X2s0l44VmZvevQUcM3Ws+Lix+L+pTz23y+ITtrxMjbiNQ4KM6+IVXj3M
         SOAscoCG9w41UaSh1UZJcrSAUviHk07oDBzrLa0Kx29mlhRRBM6OM/UO8fblXJcOwL3t
         P5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pThOH74d8lQhRMWxtImQn30Cs54Ck/famShCD5k4u9k=;
        b=W+CPefY/RI4qRqOXu7nlLUQazddPI7oJxDgPEX8DAmSAgiLbHtrYX2iLvdVbZMvY5S
         AqviyAAHDyt2uc1563UrxUo6KUdz+jSyFY+M5UiC2ENPQXKxorRpy5PMqr77cvG6oG4E
         Beqi2trTdVXKLXSW/37K0AAaYCd3CthRYXcW5xOEGxfo86Tjlv+LCyCfHxJVZ8kgBtU6
         7IYlj0TMetnCpLNAEuT0mlOjeK8Rz873wWq+906cLfApUeUTLTPHRmDgJmifm3caSnpS
         atKc3CmNIlR6kTu5qQGpFNuIfOZLm894MuKLz2TsWqAgGVv/F32BEKAZEYQ2bnWHKRYi
         61hw==
X-Gm-Message-State: APjAAAVgVTWdx2DF4iMbZOLFL/V/zK9FDl7lTU4tNFc4ft4bmcnGILBU
        keFfWpd2iEtkc8e663iwcnY=
X-Google-Smtp-Source: APXvYqze+RRkwrHQveGrS6259imBjCp9OcLJ94OtEeaVUC5RKh+JfSsqH5PZudihTnQO6ZBKLjuohA==
X-Received: by 2002:a17:902:b084:: with SMTP id p4mr35671110plr.59.1558698325354;
        Fri, 24 May 2019 04:45:25 -0700 (PDT)
Received: from tom-pc.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id n27sm5688233pfb.129.2019.05.24.04.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 04:45:24 -0700 (PDT)
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Dianzhang Chen <dianzhangchen0@gmail.com>
Subject: [PATCH] x86: fix possible spectre-v1 in do_get_thread_area()
Date:   Fri, 24 May 2019 19:45:12 +0800
Message-Id: <1558698312-5716-1-git-send-email-dianzhangchen0@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idx in do_get_thread_area() is controlled by userspace via syscall: ptrace(defined in kernel/ptrace.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
The idx can be controlled from: ptrace -> arch_ptrace -> do_get_thread_area.

Fix this by sanitizing idx before using it to index p->thread.tls_array.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
---
 arch/x86/kernel/tls.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index a5b802a..e3dc05b 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -5,6 +5,7 @@
 #include <linux/user.h>
 #include <linux/regset.h>
 #include <linux/syscalls.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/desc.h>
@@ -220,15 +221,19 @@ int do_get_thread_area(struct task_struct *p, int idx,
 		       struct user_desc __user *u_info)
 {
 	struct user_desc info;
+	int index = idx - GDT_ENTRY_TLS_MIN;
 
 	if (idx == -1 && get_user(idx, &u_info->entry_number))
 		return -EFAULT;
 
-	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+	if (index < 0 || index > GDT_ENTRY_TLS_MAX - GDT_ENTRY_TLS_MIN)
 		return -EINVAL;
 
+	index = array_index_nospec(index,
+				GDT_ENTRY_TLS_MAX - GDT_ENTRY_TLS_MIN + 1);
+
 	fill_user_desc(&info, idx,
-		       &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
+		       &p->thread.tls_array[index]);
 
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;
-- 
2.7.4

