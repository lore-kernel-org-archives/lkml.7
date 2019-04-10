Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96930C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E3720830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDJUt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:49:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJUt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:49:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3AKnGpp929494
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 13:49:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3AKnFKY929484;
        Wed, 10 Apr 2019 13:49:15 -0700
Date:   Wed, 10 Apr 2019 13:49:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-7e94a7b659eefedda82cde97229a26f319fb1182@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, jannh@google.com,
        mingo@redhat.com, bp@suse.de, hpa@zytor.com, x86@kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, bp@suse.de, hpa@zytor.com, x86@kernel.org,
          mingo@redhat.com, jannh@google.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190404111128.131157-1-jannh@google.com>
References: <20190404111128.131157-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/intel: Refactor Intel microcode
 blob loading
Git-Commit-ID: 7e94a7b659eefedda82cde97229a26f319fb1182
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7e94a7b659eefedda82cde97229a26f319fb1182
Gitweb:     https://git.kernel.org/tip/7e94a7b659eefedda82cde97229a26f319fb1182
Author:     Jann Horn <jannh@google.com>
AuthorDate: Thu, 4 Apr 2019 13:11:28 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 22:40:25 +0200

x86/microcode/intel: Refactor Intel microcode blob loading

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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190404111128.131157-1-jannh@google.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 71 ++++++++++++++++++-----------------
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
@@ -861,32 +862,33 @@ out:
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
