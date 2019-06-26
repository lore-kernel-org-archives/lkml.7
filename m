Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C193CC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B082080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAPUke4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFZEup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:50:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35030 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfFZEuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:50:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so706104plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bCahL/6yT/1jlLN2Hc0XJcKCEaxb5WvlkSRDA5kX+/4=;
        b=OAPUke4T9v54nrhFW2tatHLdacZ0Uye7TVxCs+d7p+yo74JfnJv9dtk+tlbYWJxoXE
         TjriPya4ewKp/90t8H+vC4hS6avqmK9LCPVfAg/lZEogepY0axvgqy0k5l6jZ9FWDGuC
         9/qde8ajZJB3y8H/SzjpkxT+4tRvsSZ1SAmCKQc2emkm0L3YIQtFBNlPCUPuHZavuXy4
         /mlOj6yqBVJw3MbFG1FX4GdJEfzJFumnHen4ALRyzGpcbVHBklInkGhdm7Ch2y9wkm1R
         GvU+k8q2L6HE2i3zp519K/B3hXizOYLU9SN/GPbVR5PB2YNCxh0tSZxM+ASSPFvjZfTz
         xCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bCahL/6yT/1jlLN2Hc0XJcKCEaxb5WvlkSRDA5kX+/4=;
        b=YjAxmu8ayiO0MZ7p79xiT8DR+/ODs1f3t4NKQVW8m90TXlV3N2mVnW76P2vMX5sCZu
         H2bavU2dgJ5CFQO1eZXAY0eFw8UMwnzoV0hVrZwxrzWLUmVC6lmAC3oQV6bYg7HWBhWz
         uQduB8xtXoQmPEAu0G43hPnYIOJLEJpXP01rUiPqAv2rxU+y5lASpCE4nhHFLqUgd5Ra
         vc19D35fJ7SkRcnQHb235Vel8vHUszQMJCigetHi60v+bp5B2j0VBeiZoYXg7CE8DerP
         PzMkptYiz54YQf3xPydmBfF++BwkCWuhBkPTccucY/s26ksYwVKHHN7SvJYJCC5H+rwc
         VGag==
X-Gm-Message-State: APjAAAXHN4Fhq1dqzNNf5MTuh7ehWeLengf44RySJZ5sNVV6SEzSIhLa
        dVtBCTvFTCu244yvyJP+588=
X-Google-Smtp-Source: APXvYqxokN1WtrPa3LegU6W2/R7CM9tiA4NWuHH4O0iUiSukFvA88OneYzZba9NytSu8AonNzOPmtQ==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr2855318plb.295.1561524644301;
        Tue, 25 Jun 2019 21:50:44 -0700 (PDT)
Received: from tom-pc.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id j14sm17601902pfn.120.2019.06.25.21.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 21:50:43 -0700 (PDT)
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dianzhang Chen <dianzhangchen0@gmail.com>
Subject: [PATCH v3] x86/tls: Fix possible spectre-v1 in do_get_thread_area()
Date:   Wed, 26 Jun 2019 12:50:30 +0800
Message-Id: <1561524630-3642-1-git-send-email-dianzhangchen0@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The index to access the threads tls array is controlled by userspace
via syscall: sys_ptrace(), hence leading to a potential exploitation
of the Spectre variant 1 vulnerability.
The idx can be controlled from:
        ptrace -> arch_ptrace -> do_get_thread_area.

Fix this by sanitizing idx before using it to index p->thread.tls_array.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
---
 arch/x86/kernel/tls.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index a5b802a..71d3fef 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -5,6 +5,7 @@
 #include <linux/user.h>
 #include <linux/regset.h>
 #include <linux/syscalls.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/desc.h>
@@ -220,6 +221,7 @@ int do_get_thread_area(struct task_struct *p, int idx,
 		       struct user_desc __user *u_info)
 {
 	struct user_desc info;
+	int index;
 
 	if (idx == -1 && get_user(idx, &u_info->entry_number))
 		return -EFAULT;
@@ -227,8 +229,11 @@ int do_get_thread_area(struct task_struct *p, int idx,
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
-	fill_user_desc(&info, idx,
-		       &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
+	index = idx - GDT_ENTRY_TLS_MIN;
+	index = array_index_nospec(index,
+			GDT_ENTRY_TLS_MAX - GDT_ENTRY_TLS_MIN + 1);
+
+	fill_user_desc(&info, idx, &p->thread.tls_array[index]);
 
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;
-- 
2.7.4

