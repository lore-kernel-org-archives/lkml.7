Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2874F21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niEwRLur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfC2Qa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:30:59 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33614 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfC2Qa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:30:59 -0400
Received: by mail-qt1-f201.google.com with SMTP id k5so2798516qte.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BIUYSdViMIn+To2mUC3qZ7zEN+7GQ3ySY+V/Ekd7gP4=;
        b=niEwRLurvDXcYbjApsEODSo8Ky7sRAWmZAjk2/6GINGFAC7BFsrO+3l/pEmJ7o5Mnz
         gy1SHrct0idcSDWXiz3nlVqchIJgPWWDbKrhIrx8CPstxa+CvUPBvgaTJrvWXvtL4xEO
         AIP4Vvm37UlS8MNCD9HEgLZOHXZ5sI2qpHVlwYAes/CE9ECj9e41ANfKPJUesYTV/aJy
         HXey0uafvnSVhFHADEqBjlISPbDeN0w/FxhKDXPZ0P6Rh7DbEqe30QbIbp/p3zTryjn5
         R+0zQf7PGIvhTpPAvZIyCPkFHOYzqQy0EusYZId30Isp7cHcB91S6SrkYS06FrFjoI6D
         UOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BIUYSdViMIn+To2mUC3qZ7zEN+7GQ3ySY+V/Ekd7gP4=;
        b=DrkZftwLKD2gXqaz5D9odSP8pY7aMIcT+QVVpmF2VG2mHYYpwWmASYpvwNegcrRj1L
         8rB1Khc5OWLm5TjRqcBwsPbTT3ctfDesRTo/CfybRM/8mH6oE5IUM3xjxMRQXogn8+Df
         DE0buyiv7/IiBlPhA8HVxrbEfR64gR4qsV9GBF8k2YJ2SyMMhYCnWTHJects5OIViVeC
         B/JioXhCQM/XosLq2im86dy3iIq+6KEuTmWDvOb+iz3rXRRyvnulpyS0vOyaOLadDPLX
         ofa/yCKBspVha3tAs3MPYYS4SyGTUEOybsh4WR0I1CXCsLN0mIh62TGArZQpxr7C7jii
         2yog==
X-Gm-Message-State: APjAAAXX03xsl12kmxafHKf/r94Zm/ufDc6Ng3s6oNSnqRCgBxdWMAAE
        iN2mB9+9invueSQmbmPMzUTc4eqchQ==
X-Google-Smtp-Source: APXvYqwj9gW2xuXiJKIeDRZrqHaZ8OqvhpjGe7G1z6qgFCdemnjYTjsAnd8icYc8pDKwpFv9BU7nKOywxQ==
X-Received: by 2002:a0c:f851:: with SMTP id g17mr3301508qvo.11.1553877057693;
 Fri, 29 Mar 2019 09:30:57 -0700 (PDT)
Date:   Fri, 29 Mar 2019 17:30:45 +0100
In-Reply-To: <20190329163047.223508-1-jannh@google.com>
Message-Id: <20190329163047.223508-2-jannh@google.com>
Mime-Version: 1.0
References: <20190329163047.223508-1-jannh@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 2/4] x86/microcode: Fix __user annotations around generic_load_microcode()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic_load_microcode() deals with a pointer that can be either a kernel
pointer or a user pointer. Pass it around as a __user pointer so that it
can't be dereferenced accidentally while its address space is unknown.
Use explicit casts to convert between __user and __kernel to inform the
checker that these address space conversions are intentional.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 16936a24795c..e8ef65c275c7 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -861,11 +861,13 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
-				int (*get_ucode_data)(void *, const void *, size_t))
+static enum ucode_state generic_load_microcode(int cpu,
+		const void __user *data, size_t size,
+		int (*get_ucode_data)(void *, const void __user *, size_t))
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	u8 *ucode_ptr = data, *new_mc = NULL, *mc = NULL;
+	const u8 __user *ucode_ptr = data;
+	u8 *new_mc = NULL, *mc = NULL;
 	int new_rev = uci->cpu_sig.rev;
 	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
@@ -945,9 +947,10 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	return ret;
 }
 
-static int get_ucode_fw(void *to, const void *from, size_t n)
+static int get_ucode_fw(void *to, const void __user *from, size_t n)
 {
-	memcpy(to, from, n);
+	/* cast paired with request_microcode_fw() */
+	memcpy(to, (const void __force *)from, n);
 	return 0;
 }
 
@@ -993,7 +996,8 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 		return UCODE_NFOUND;
 	}
 
-	ret = generic_load_microcode(cpu, (void *)firmware->data,
+	/* cast paired with get_ucode_fw() */
+	ret = generic_load_microcode(cpu, (void __force __user *)firmware->data,
 				     firmware->size, &get_ucode_fw);
 
 	release_firmware(firmware);
@@ -1001,7 +1005,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 	return ret;
 }
 
-static int get_ucode_user(void *to, const void *from, size_t n)
+static int get_ucode_user(void *to, const void __user *from, size_t n)
 {
 	return copy_from_user(to, from, n);
 }
@@ -1012,7 +1016,7 @@ request_microcode_user(int cpu, const void __user *buf, size_t size)
 	if (is_blacklisted(cpu))
 		return UCODE_NFOUND;
 
-	return generic_load_microcode(cpu, (void *)buf, size, &get_ucode_user);
+	return generic_load_microcode(cpu, buf, size, &get_ucode_user);
 }
 
 static struct microcode_ops microcode_intel_ops = {
-- 
2.21.0.392.gf8f6787159e-goog

