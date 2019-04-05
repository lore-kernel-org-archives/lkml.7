Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56519C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C38218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EczDT7CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfDENaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:30:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38204 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730440AbfDENaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:30:23 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DCBE1EC0A6C;
        Fri,  5 Apr 2019 15:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554471021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4I55q0AfM8zdkUZTm7oGcC1JXxZxYBxds8eFqqVNPcU=;
        b=EczDT7CZBlnPbN2D37qUhUss3hzZMEa/D6K9h9buNGIEBNkfGPuujo/ZuokGPgeKaU5Csv
        r9fNU2JCrgbkWiBJO7XwgeVb/qe5fVUupjlHitiYiknS/C6VCkPSA0NAxcccE0k6zAKtNx
        J50lb4Y1id3ogMzq0aY0DzjgGhT/03k=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/3] x86/microcode/intel: Refactor Intel microcode blob loading
Date:   Fri,  5 Apr 2019 15:30:08 +0200
Message-Id: <20190405133010.24249-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405133010.24249-1-bp@alien8.de>
References: <20190405133010.24249-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

Change generic_load_microcode() to use the iov_iter API instead of a
clumsy open-coded version which has to pay attention to __user data
or kernel data, depending on the loading method. This allows to avoid
explicit casting between user and kernel pointers.

Because the iov_iter API makes it hard to read the same location twice,
as a side effect, also fix a double-read of the microcode header (which
could e.g. lead to out-of-bounds reads in microcode_sanity_check()).

Not that it matters much, only root is allowed to load microcode
anyway...

 [ bp: Massage a bit, sort function-local variables. ]

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190404111128.131157-1-jannh@google.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 71 ++++++++++++++-------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 16936a24795c..a44bdbe7c55e 100644
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
-	int new_rev = uci->cpu_sig.rev;
-	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
-	unsigned int csig, cpf;
 	enum ucode_state ret = UCODE_OK;
+	int new_rev = uci->cpu_sig.rev;
+	u8 *new_mc = NULL, *mc = NULL;
+	unsigned int csig, cpf;
 
-	while (leftover) {
+	while (iov_iter_count(iter)) {
 		struct microcode_header_intel mc_header;
-		unsigned int mc_size;
+		unsigned int mc_size, data_size;
+		u8 *data;
 
-		if (leftover < sizeof(mc_header)) {
-			pr_err("error! Truncated header in microcode data file\n");
+		if (!copy_from_iter_full(&mc_header, sizeof(mc_header), iter)) {
+			pr_err("error! Truncated or inaccessible header in microcode data file\n");
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
@@ -977,10 +972,12 @@ static bool is_blacklisted(unsigned int cpu)
 static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 					     bool refresh_fw)
 {
-	char name[30];
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	const struct firmware *firmware;
+	struct iov_iter iter;
 	enum ucode_state ret;
+	struct kvec kvec;
+	char name[30];
 
 	if (is_blacklisted(cpu))
 		return UCODE_NFOUND;
@@ -993,26 +990,30 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
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
+	struct iov_iter iter;
+	struct iovec iov;
+
 	if (is_blacklisted(cpu))
 		return UCODE_NFOUND;
 
-	return generic_load_microcode(cpu, (void *)buf, size, &get_ucode_user);
+	iov.iov_base = (void __user *)buf;
+	iov.iov_len = size;
+	iov_iter_init(&iter, WRITE, &iov, 1, size);
+
+	return generic_load_microcode(cpu, &iter);
 }
 
 static struct microcode_ops microcode_intel_ops = {
-- 
2.21.0

