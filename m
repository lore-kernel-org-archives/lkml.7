Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50908C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F37F20673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec1UVKtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390639AbfFKNQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:16:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45126 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388792AbfFKNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:16:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so7405481pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=erpJ/1HwU0IvLlhAmNIzQUp5KsGSfUKo8w8/Al+yjSk=;
        b=Ec1UVKtKvBLJ0T9sJsPyd5alNTe1bKz12CZx8Gof7OI7rvWXJWj5zFkM3ELGh3YnZU
         5CAuA549pdnNdT0Zobb0Gww6Kz0jhk4yciYsBVgsmcPC/OSIv8tzo8Vyofj4oSbAL35X
         MmRkQg0R8YNiAUkhapYCNcke40MDw86Dw9XR27m4p2efnJORWFKHm66XLLU32TtBJVzD
         sEMcq/V8QoN391vC86/fNyMRASsmpuUgmGIU01R1gH+V/46mAmddSlaW6mxm3UVdD/9h
         5QVkOz7UHrWtQaHaAHPDn0P3YWAJQ7E7fbh8BIoH+nn9MsOIMu/DmI6MFYA09I23qTK2
         bIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=erpJ/1HwU0IvLlhAmNIzQUp5KsGSfUKo8w8/Al+yjSk=;
        b=EVlwEgxusI440jhCEJMvHqHJB9OmXua1KU8tWfLsNUZ4358CXGV5O64qIbl2cvoNRT
         eTONdZNgml221tqDuvxpCW6TP9fNbQ/ir1OS41DXkSNGpf5t0nzrgkg+EyvPiFnRJ4Ka
         hkSW2z0W7bgUf/mibjMyRfKY4Fwl30KCH30G/gZ0KvDxwp/o4/bGOHUNPxneOFwLdE5j
         GvY1qEqNYorJEBpeW6M2D6MmcFCUaxyUbKLjw5FKDvjOlG237u6knp2PodBlwEgeIDG7
         r5GSbA41aFIyDR0ppjtpGXczsWQOuPZkx3u9bsPVxZXVe890NooHJceulU0vVGaMXyoY
         a13w==
X-Gm-Message-State: APjAAAUIUz3V0KECodbi6J7aoglCXCFKVWHy1c5S0GagvPOGruwHAWVm
        pAyG1e0vb/wQeHuF/0dgdGyZ7tHJ9T0=
X-Google-Smtp-Source: APXvYqyPtIUBJUiGs5CxZdOdOAe9jN/EmeYnquJXnTk6DouJ59ZQuBEv+ih+NRuThJNkl6RYB44pIg==
X-Received: by 2002:aa7:8f24:: with SMTP id y4mr37343494pfr.36.1560258969435;
        Tue, 11 Jun 2019 06:16:09 -0700 (PDT)
Received: from tom-pc.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id q125sm21964880pfq.62.2019.06.11.06.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 06:16:08 -0700 (PDT)
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dianzhang Chen <dianzhangchen0@gmail.com>
Subject: [PATCH] x86: tls: fix possible spectre-v1 in do_get_thread_area()
Date:   Tue, 11 Jun 2019 21:15:58 +0800
Message-Id: <1560258958-19291-1-git-send-email-dianzhangchen0@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idx in do_get_thread_area() is controlled by userspace
via syscall: ptrace(defined in kernel/ptrace.c), hence
leading to a potential exploitation of the Spectre variant 1 vulnerability.
The idx can be controlled from:
	ptrace -> arch_ptrace -> do_get_thread_area.

Fix this by sanitizing idx before using it to index p->thread.tls_array.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
---
 arch/x86/kernel/tls.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index a5b802a..4cd338c 100644
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
+	int index = idx - GDT_ENTRY_TLS_MIN;
 
 	if (idx == -1 && get_user(idx, &u_info->entry_number))
 		return -EFAULT;
@@ -227,8 +229,10 @@ int do_get_thread_area(struct task_struct *p, int idx,
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
+	index = array_index_nospec(index,
+				GDT_ENTRY_TLS_MAX - GDT_ENTRY_TLS_MIN + 1);
 	fill_user_desc(&info, idx,
-		       &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
+		       &p->thread.tls_array[index]);
 
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;
-- 
2.7.4

