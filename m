Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B1C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C46A26F6E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cYJJ89qM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEaVmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:42:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33991 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfEaVmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:42:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id h1so2762344qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=g1AXyqxz0kpBCA+W8H1r9BKDUM0/MhlFpXR1YljGlp4=;
        b=cYJJ89qMPDjVLt+JS+jAXDg31F1LeBaCeIiuYc3wVIHYBWVBtX6k3HAa2cXz54hUr8
         vhZ7wberYbNrFkkKqm4I3Br5xV0WBKkRiI3JpUAnXarGpp5aSLcZIdFbknOzJX4eV1JC
         cRQ0qXWQKYaTAICpLTEn9/nhZtv/kT20y2gzXSu/A3Z39IDv1nX+ycKwgfRGoXkzBINO
         lIxgEafk2BeaOX5qbQOUd+pGlZH6oAII3JHssgJSH/U+o9l8vviyNinrMkPsZAt/h7VV
         u6a0FYypomUujYt28uX+05ch0fE3d2OyzSmLbGPEn76hLElOh+wE7WPajba3EBaPSI5A
         p0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g1AXyqxz0kpBCA+W8H1r9BKDUM0/MhlFpXR1YljGlp4=;
        b=GtloMfoFD7Xl3T5kyznNa61sqawJwEUjCbk9NwWnkkZjEJkQj218EgXjWpl5OGXDVT
         EZNpudeJGO6avIyEgi4L5Vb/CZRsUZ7KpJzZN3RTAWvt7VXGuoE/JfU6c6HhrdqJyOta
         6hQ6w2GbzDQ1WFgSFcBqFGFQ+7DTBPvY094s4sgwI4bA0pWrnqIm0zNJgOejOt+ZVOVr
         /kYry9ejbcYLZVNDvo3bZgVZnephiO46YRy/lD9/RmPNVBZE4s3veAc1sGh2aaXBoJDX
         pDBij42J8dYeJ2dw4BhZ0oB9+teaHuDPKNkrCrAmCszpuSMt0Ljs8WDOTm/PQGUBtXkr
         iZiA==
X-Gm-Message-State: APjAAAV7FWSoZBW3PVY34gb3EwSh9HVFAVlcURUP8Ctn4wvJgRXqoqk8
        YIzfFvyXWejJcDA74X9nqNSz4g==
X-Google-Smtp-Source: APXvYqxc5UfKHbqxz/FpaC7nU5JnLfowywxiqTEAOqyBcEJIg1LCbQlEt/ce97SUL4kk/n7qQT3jDg==
X-Received: by 2002:a0c:98c7:: with SMTP id g7mr11137713qvd.13.1559338922919;
        Fri, 31 May 2019 14:42:02 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v186sm4594727qkc.36.2019.05.31.14.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:42:02 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] x86/mm: fix an unused variable "tsk" warning
Date:   Fri, 31 May 2019 17:37:21 -0400
Message-Id: <1559338641-6145-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit "signal: Remove the task parameter from
force_sig_fault", "tsk" is only used when MEMORY_FAILURE=y and generates
a compilation warning without it.

arch/x86/mm/fault.c: In function 'do_sigbus':
arch/x86/mm/fault.c:1017:22: warning: unused variable 'tsk'
[-Wunused-variable]

Also, change to use IS_ENABLED() instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 46ac96aa7c81..40d70bd3fa84 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1014,8 +1014,6 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  vm_fault_t fault)
 {
-	struct task_struct *tsk = current;
-
 	/* Kernel mode? Handle exceptions or die: */
 	if (!(error_code & X86_PF_USER)) {
 		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
@@ -1028,9 +1026,10 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 
 	set_signal_archinfo(address, error_code);
 
-#ifdef CONFIG_MEMORY_FAILURE
-	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
+	    (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))) {
 		unsigned lsb = 0;
+		struct task_struct *tsk = current;
 
 		pr_err(
 	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
@@ -1042,7 +1041,6 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
 		return;
 	}
-#endif
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
-- 
1.8.3.1

