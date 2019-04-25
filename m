Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D60C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB482088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="oMT8gLZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfDYQP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38664 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfDYQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1so400345edk.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s3UcERSJ0rzTZ0CHM/lcv2L6+nImqnbPo4r7mwPkBXs=;
        b=oMT8gLZ3V63dC5YKh10UJWh7KnwzHa8GdG7FZQ3uu0CeErZOkdhpwqq8DnaDpmF2tJ
         JmVC0zO7uD4N7YAnC8E6FgXQu88b+gtKgqygfWNR4j1TegK8n3AAY7z0MJ7x1mlnWAps
         dJ9PuV8ryNQovOhHsu9/H8pQUlPidBL4fVn2y5Zu0BPyrIdFN9SxIHdBvwPO/ddpAbAg
         u6+tuP3bv98k7IssAisU8gEVYitl7rIuEEEXtnPXgCZQxjdDk4NTr23QcUzs7F9oiKSA
         w1E8Y02vNHo0V7ub3FuwEs5EBt8OjhFzebwpYU2JMkXKvR/08+FmKdD/3H8EjRa8+qlp
         qyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3UcERSJ0rzTZ0CHM/lcv2L6+nImqnbPo4r7mwPkBXs=;
        b=UUZRo+wv34SMA/O96PVZuRm0ND6CJdlSToyrltsUSvqy8SAnsZQFNqRKjgtlZxFDIX
         RXYMPV2EsCC2RsDfLn3BkQgW07K/kMe061v++5+sdHxppaQQTKlfq6JtPYr7teQmYdz3
         Ak+FUhrSorr4UnVW9GmKRnhoXLHJ3mbLmr6qbR92Q54mvCFFEvuf8IU2/7mCjV1X2+vc
         CiwjUGgWxkED9QiKmnKi1VZgPicUbd9W4YX6u5N4JrFUVKmKAgDnty75PFbMaSdmD1Rd
         zk4Y4hl42xPGuruLl4VLhWrLz08euoryCICvJG5OCDMunOuQRE4y5/EvbTRWfm9fm4Xd
         HyCg==
X-Gm-Message-State: APjAAAU0Xn88LM5ycQpPQN07mowjNi/xcPle3MMHKvUHSu+aDxe7eCRD
        RhHKtKXxjRc7AsqnGKDd1HHRr4Vxqxg=
X-Google-Smtp-Source: APXvYqw2Z5Bp3KFMfHmppxSrH2lXGfFHd23pRPPQtXvwVQqYr5e55qSGhtlcjMrM2n/Jj9OxSpjd+A==
X-Received: by 2002:a50:8b24:: with SMTP id l33mr24776168edl.235.1556208883047;
        Thu, 25 Apr 2019 09:14:43 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:42 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 15/27] x86/vdso: Allocate timens vdso
Date:   Thu, 25 Apr 2019 17:14:04 +0100
Message-Id: <20190425161416.26600-16-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.
It will add a penalty for everybody as branch predictor may mispredict
the jump. Also there are instruction cache lines wasted on cmp/jmp.

Those effects of introducing time namespace are very much unwanted
having in mind how much work have been spent on micro-optimisation
vdso code.

The propose is to allocate a second vdso code with dynamically
patched out (disabled by static_branch) timens code on boot time.

Allocate another vdso and copy original code.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h |  2 +-
 arch/x86/entry/vdso/vma.c    | 36 +++++++++++++++++++++++++++++++-----
 arch/x86/include/asm/vdso.h  |  9 +++++----
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 086a11aee0e8..660f725a02c1 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -156,7 +156,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	}
 	fprintf(outfile, "\n};\n\n");
 
-	fprintf(outfile, "const struct vdso_image %s = {\n", name);
+	fprintf(outfile, "struct vdso_image %s __ro_after_init = {\n", name);
 	fprintf(outfile, "\t.text = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
 	if (alt_sec) {
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 80cbb2167eba..6aae9c0d400d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -30,26 +30,52 @@
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
 
-void __init init_vdso_image(const struct vdso_image *image)
+void __init init_vdso_image(struct vdso_image *image)
 {
 	BUG_ON(image->size % PAGE_SIZE != 0);
 
 	apply_alternatives((struct alt_instr *)(image->text + image->alt),
 			   (struct alt_instr *)(image->text + image->alt +
 						image->alt_len));
+#ifdef CONFIG_TIME_NS
+	image->text_timens = vmalloc_32(image->size);
+	if (WARN_ON(image->text_timens == NULL))
+		return;
+
+	memcpy(image->text_timens, image->text, image->size);
+#endif
 }
 
 struct linux_binprm;
 
+#ifdef CONFIG_TIME_NS
+static inline struct timens_offsets *current_timens_offsets(void)
+{
+	struct time_namespace *ns = current->nsproxy->time_ns;
+
+	return ns->offsets;
+}
+#else
+static inline struct timens_offsets *current_timens_offsets(void)
+{
+	return NULL;
+}
+#endif
+
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
+	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
 
 	if (!image || (vmf->pgoff << PAGE_SHIFT) >= image->size)
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = virt_to_page(image->text + (vmf->pgoff << PAGE_SHIFT));
+	if (current_timens_offsets() && image->text_timens)
+		vmf->page = vmalloc_to_page(image->text_timens + offset);
+	else
+		vmf->page = virt_to_page(image->text + offset);
+
 	get_page(vmf->page);
 	return 0;
 }
@@ -138,13 +164,13 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			return vmf_insert_pfn(vma, vmf->address,
 					vmalloc_to_pfn(tsc_pg));
 	} else if (sym_offset == image->sym_timens_page) {
-		struct time_namespace *ns = current->nsproxy->time_ns;
+		struct timens_offsets *offsets = current_timens_offsets();
 		unsigned long pfn;
 
-		if (!ns->offsets)
+		if (!offsets)
 			pfn = page_to_pfn(ZERO_PAGE(0));
 		else
-			pfn = page_to_pfn(virt_to_page(ns->offsets));
+			pfn = page_to_pfn(virt_to_page(offsets));
 
 		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index b0eb59c198eb..a620c7f23425 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -12,6 +12,7 @@
 
 struct vdso_image {
 	void *text;
+	void *text_timens;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
 	unsigned long alt, alt_len;
@@ -31,18 +32,18 @@ struct vdso_image {
 };
 
 #ifdef CONFIG_X86_64
-extern const struct vdso_image vdso_image_64;
+extern struct vdso_image vdso_image_64;
 #endif
 
 #ifdef CONFIG_X86_X32
-extern const struct vdso_image vdso_image_x32;
+extern struct vdso_image vdso_image_x32;
 #endif
 
 #if defined CONFIG_X86_32 || defined CONFIG_COMPAT
-extern const struct vdso_image vdso_image_32;
+extern struct vdso_image vdso_image_32;
 #endif
 
-extern void __init init_vdso_image(const struct vdso_image *image);
+extern void __init init_vdso_image(struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
 
-- 
2.21.0

