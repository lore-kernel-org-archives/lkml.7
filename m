Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DAEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5841820850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbm/nZVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfCAASV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:18:21 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:46547 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732071AbfCAASV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:18:21 -0500
Received: by mail-io1-f74.google.com with SMTP id r21so17267774ioa.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 16:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ckaseLFdofbQ5QZGTQteyCQVA192m0GtDd/BtCB/7D4=;
        b=vbm/nZVubPtmg2BCqxYAN+ZpNkTWhTl31PuCtOuoVDZKdslFL395h39/guMHtQmavQ
         krNkaIHMKUT7NvlnpbhrT49dLMXc15A6+P35+ZF67pOTGHuETKo9awfgo/lAj+CUvG6k
         jFI0CLCk5juCpWnDhGzP5FytWJh0JII/+2SK36jl7PPUz/1Q3ouLH1+1w0XzspczArAb
         /7xf05DR1E/i7MaxSNxpVKRW7r2g3uvVtSRrGg6+vLh9Kx/v/nBwOBz7/pF4Bl4kgwnu
         R0q6J+/IaG3XjyN9sF+aCIEU/EC8xk5ymt8BMQcEawBwE6ODD/HgQmesbGkiSHEOhD5R
         Vqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ckaseLFdofbQ5QZGTQteyCQVA192m0GtDd/BtCB/7D4=;
        b=XGZ+dJo9p8x52iNup+A40rZlKG2sh4smp+mjvl1guXvlPCS36Mj2sXwN6s2n9VLdaa
         InKuF3LH+SeV64kP2Z6gJ/hGJbrA9BMtNmSF8worRTN9cDf2OzUf5qgqALLWcjp8em/S
         zC29VorZkvDJ+ZS2uld9X8FKVgUX/xHwnROsyRnfhHGmZs9QgF7BmoJptaPIoYOQjOGn
         pNRiwz+FwFS6s67rs2zA41S+pFCRQ3pRVUg6RA9QLxC43fgLeSz9Gg2QYmuvjpji8gg6
         lJ184KU5cGHHcd4ORtOwv87BDLrbJCx2RjX1t0N7RYkk8/DDlo+io3bBU8fFke+kpJB6
         cHhg==
X-Gm-Message-State: APjAAAXbOQJ8Sqy/54/nMGjOjkDPf/zTsN9hCLhw1JqckfglE0rsn/vb
        W7HeFZ+sA95dAr0LL6DQs3hRYsBvWaHZ
X-Google-Smtp-Source: APXvYqyhgNWVYVeh8ZMWn1SkZbUx5UDVRrta3X2Kyv0Wl9pfvDFEbTP/ZgOOtb1Yq3v00891XFx4va5aW16T
X-Received: by 2002:a24:6f55:: with SMTP id x82mr1632135itb.13.1551399499719;
 Thu, 28 Feb 2019 16:18:19 -0800 (PST)
Date:   Thu, 28 Feb 2019 16:18:06 -0800
Message-Id: <20190301001806.154271-1-smuckle@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH] selftests: x86: add version check in test_syscall_vdso
From:   Steve Muckle <smuckle@google.com>
To:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 4.17 registers r8-r11 are not clobbered/zeroed by a 64-bit kernel
handling a 32-bit syscall and this behavior is enforced by the
test_syscall_vdso testcase. See commit 8bb2610bc496
("x86/entry/64/compat: Preserve r8-r11 in int $0x80").

Permit the old behavior in the testcase for kernels prior to 4.17.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 .../testing/selftests/x86/test_syscall_vdso.c | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/x86/test_syscall_vdso.c b/tools/testing/selftests/x86/test_syscall_vdso.c
index c9c3281077bc..f7284dc4c32b 100644
--- a/tools/testing/selftests/x86/test_syscall_vdso.c
+++ b/tools/testing/selftests/x86/test_syscall_vdso.c
@@ -30,6 +30,7 @@
 #include <sys/time.h>
 #include <elf.h>
 #include <sys/ptrace.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 
 #if !defined(__i386__)
@@ -71,6 +72,7 @@ struct regs64 {
 };
 struct regs64 regs64;
 int kernel_is_64bit;
+int clobber_ok;
 
 asm (
 	"	.pushsection .text\n"
@@ -130,6 +132,28 @@ void print_regs64(void)
 	printf("12:%016llx 13:%016llx 14:%016llx 15:%016llx\n", regs64.r12,  regs64.r13,  regs64.r14,  regs64.r15);
 }
 
+static void get_kernel_version(int *version, int *patchlevel)
+{
+	int ret, sublevel;
+	struct utsname utsname;
+
+	ret = uname(&utsname);
+	if (ret) {
+		perror("uname");
+		exit(1);
+	}
+
+	ret = sscanf(utsname.release, "%d.%d.%d", version, patchlevel,
+		     &sublevel);
+	if (ret < 0) {
+		perror("sscanf");
+		exit(1);
+	} else if (ret != 3) {
+		printf("Malformed kernel version %s\n", &utsname.release);
+		exit(1);
+	}
+}
+
 int check_regs64(void)
 {
 	int err = 0;
@@ -166,6 +190,8 @@ int check_regs64(void)
 			 * Historically (and probably unintentionally), they
 			 * were clobbered or zeroed.
 			 */
+			if (clobber_ok && *r64 == 0 && num <= 11)
+				continue;
 		}
 		printf("[FAIL]\tR%d has changed:%016llx\n", num, *r64);
 		err++;
@@ -385,6 +411,7 @@ int main(int argc, char **argv, char **envp)
 {
 	int exitcode = 0;
 	int cs;
+	int version, patchlevel;
 
 	asm("\n"
 	"	movl	%%cs, %%eax\n"
@@ -394,6 +421,9 @@ int main(int argc, char **argv, char **envp)
 	if (!kernel_is_64bit)
 		printf("[NOTE]\tNot a 64-bit kernel, won't test R8..R15 leaks\n");
 
+	get_kernel_version(&version, &patchlevel);
+	clobber_ok = version < 4 || (version == 4 && patchlevel < 17);
+
 	/* This only works for non-static builds:
 	 * syscall_addr = dlsym(dlopen("linux-gate.so.1", RTLD_NOW), "__kernel_vsyscall");
 	 */
-- 
2.21.0.352.gf09ad66450-goog

