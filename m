Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2950EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EFF206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFfvmhy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfDDLLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:11:42 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:36380 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfDDLLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:11:42 -0400
Received: by mail-yw1-f74.google.com with SMTP id o66so1729608ywc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ohmuy2FRJmNGbpBRPmkUMrlc+KtF9yfBWYL3amjSSFw=;
        b=EFfvmhy56/k10A4unE7A7BfH5J/MAscrgo/povumcj8KbRlnS2SGGg6ndx1dHLKXmp
         Y1GrfAbBuab4O/S6BZSpLl+B3pYIj+zP7m+a0JV6Q3cLQUJO+7YJttS9/y3osVXaFJ7Z
         gFzxrOsxGlBhi13WkcArXQLEHwDpZ7yfBhWGhBq/9ABfVeNteSsIzjv/KETmgZLoZY9n
         8IgyNr0wfpl7v/H1KU/eLQYb3uO3hinAh4RNm+RVlrA21LK1TwQxjdoGwmZ8tWe8BtoU
         iGh2Lj55wRgN5u6vFl7QeNhrekuGpCZ9KRg3qgsYm7ERBmIQZ3D6fERAUVENjqP7BR/+
         tycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ohmuy2FRJmNGbpBRPmkUMrlc+KtF9yfBWYL3amjSSFw=;
        b=jFwiaqm54hcx3HmD41Ci4Bapxa8LjmV91qpKcprV5/XiAn/L546hyAAiIobRkwmO4y
         8frGKeI6vyD9NAeK1EPlf4WmOw+G7JzKljnoAJLd6BJoXDjGf7sYznGU9D4qwmrTHjh4
         99+nVaHgj+hfldqgTS5sXt7KqWM3C9N6hsJzQLo8mG21/6jigj+6O0RV3SLI1QzPYN/k
         X3jIWXPl5KOZD6vtnKdSbHJlLRV5Ma47jhHpGneYQE02c8OVwN2YJeUVoclE3N+Ts1bS
         yJHgW+VcBFMv1kyGXmJ8mx4o3bRcio7lRCl82SYX05kQVouxjQFLNQgJ+RcsxZvx/sLU
         XP5g==
X-Gm-Message-State: APjAAAUxfR8rAQin3fSPw0oHHGPNOUq7DoHQoEO4VP4AWuVZ376SBIM0
        UuBwNQkiSfYmkN24UicHLRgOTk1JUg==
X-Google-Smtp-Source: APXvYqwJQ5iR5dAYPzh7lLSjBg9tPk+0biBM8Zqi2CU5UmtIGcwSiMhx2mtwTpeeLynRSW/kVeC3KmLXiA==
X-Received: by 2002:a81:7acf:: with SMTP id v198mr1160658ywc.16.1554376301089;
 Thu, 04 Apr 2019 04:11:41 -0700 (PDT)
Date:   Thu,  4 Apr 2019 13:11:28 +0200
Message-Id: <20190404111128.131157-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] x86/microcode: Refactor Intel microcode loading
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes generic_load_microcode() to use the iov_iter API instead of
an open-coded version. This allows us to avoid explicitly casting between
user and kernel pointers.

Because the iov_iter API makes it hard to read the same location twice, as
a side effect, this also fixes a double-read of the microcode header (which
could e.g. lead to out-of-bounds reads in microcode_sanity_check()).
Not that it matters much, only root can do this anyway...

Signed-off-by: Jann Horn <jannh@google.com>
---
I have tested that with this patch applied, microcode loading still works
both via "iucode-tool -k" and via
/sys/devices/system/cpu/microcode/reload.

 arch/x86/kernel/cpu/microcode/intel.c | 64 +++++++++++++--------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 16936a24795c..cb976e8ef94d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/uio.h>
 #include <linux/mm.h>
 
 #include <asm/microcode_intel.h>
@@ -861,32 +862,33 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
-				int (*get_ucode_data)(void *, const void *, size_t))
+static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	u8 *ucode_ptr = data, *new_mc = NULL, *mc = NULL;
+	u8 *new_mc = NULL, *mc = NULL;
 	int new_rev = uci->cpu_sig.rev;
-	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
 	unsigned int csig, cpf;
 	enum ucode_state ret = UCODE_OK;
 
-	while (leftover) {
+	while (iov_iter_count(iter)) {
 		struct microcode_header_intel mc_header;
-		unsigned int mc_size;
+		unsigned int mc_size, data_size;
+		u8 *data;
 
-		if (leftover < sizeof(mc_header)) {
-			pr_err("error! Truncated header in microcode data file\n");
+		if (!copy_from_iter_full(&mc_header, sizeof(mc_header), iter)) {
+			pr_err("error! Truncated or inaccessible header in microcode data\n");
 			break;
 		}
 
-		if (get_ucode_data(&mc_header, ucode_ptr, sizeof(mc_header)))
-			break;
-
 		mc_size = get_totalsize(&mc_header);
-		if (!mc_size || mc_size > leftover) {
-			pr_err("error! Bad data in microcode data file\n");
+		if (mc_size < sizeof(mc_header)) {
+			pr_err("error! Bad data in microcode data file (totalsize too small)\n");
+			break;
+		}
+		data_size = mc_size - sizeof(mc_header);
+		if (data_size > iov_iter_count(iter)) {
+			pr_err("error! Bad data in microcode data file (truncated file?)\n");
 			break;
 		}
 
@@ -899,7 +901,9 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 			curr_mc_size = mc_size;
 		}
 
-		if (get_ucode_data(mc, ucode_ptr, mc_size) ||
+		memcpy(mc, &mc_header, sizeof(mc_header));
+		data = mc + sizeof(mc_header);
+		if (!copy_from_iter_full(data, data_size, iter) ||
 		    microcode_sanity_check(mc, 1) < 0) {
 			break;
 		}
@@ -914,14 +918,11 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 			mc = NULL;	/* trigger new vmalloc */
 			ret = UCODE_NEW;
 		}
-
-		ucode_ptr += mc_size;
-		leftover  -= mc_size;
 	}
 
 	vfree(mc);
 
-	if (leftover) {
+	if (iov_iter_count(iter)) {
 		vfree(new_mc);
 		return UCODE_ERROR;
 	}
@@ -945,12 +946,6 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	return ret;
 }
 
-static int get_ucode_fw(void *to, const void *from, size_t n)
-{
-	memcpy(to, from, n);
-	return 0;
-}
-
 static bool is_blacklisted(unsigned int cpu)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -981,6 +976,8 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	const struct firmware *firmware;
 	enum ucode_state ret;
+	struct kvec kvec;
+	struct iov_iter iter;
 
 	if (is_blacklisted(cpu))
 		return UCODE_NFOUND;
@@ -993,26 +990,29 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 		return UCODE_NFOUND;
 	}
 
-	ret = generic_load_microcode(cpu, (void *)firmware->data,
-				     firmware->size, &get_ucode_fw);
+	kvec.iov_base = (void *)firmware->data;
+	kvec.iov_len = firmware->size;
+	iov_iter_kvec(&iter, WRITE, &kvec, 1, firmware->size);
+	ret = generic_load_microcode(cpu, &iter);
 
 	release_firmware(firmware);
 
 	return ret;
 }
 
-static int get_ucode_user(void *to, const void *from, size_t n)
-{
-	return copy_from_user(to, from, n);
-}
-
 static enum ucode_state
 request_microcode_user(int cpu, const void __user *buf, size_t size)
 {
+	struct iovec iov;
+	struct iov_iter iter;
+
 	if (is_blacklisted(cpu))
 		return UCODE_NFOUND;
 
-	return generic_load_microcode(cpu, (void *)buf, size, &get_ucode_user);
+	iov.iov_base = (void __user *)buf;
+	iov.iov_len = size;
+	iov_iter_init(&iter, WRITE, &iov, 1, size);
+	return generic_load_microcode(cpu, &iter);
 }
 
 static struct microcode_ops microcode_intel_ops = {
-- 
2.21.0.392.gf8f6787159e-goog

