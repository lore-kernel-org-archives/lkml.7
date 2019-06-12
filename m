Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA35C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4CA2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IA6asvF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfFLT1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:27:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38109 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFLT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so18129895wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPIuEHDSoxOxKmo/+FURVEIw3vOuo9up5XrlOV13hU0=;
        b=IA6asvF1Rc7iSE5mgDCvQFKnU2Wd9kLTzUgENZgoS4uzBD6kaeAaAKpxF1cKGzO/H3
         0piFvm6hUINvyEhX1kNdfKERtWIyNybl5vWnbu6dmHHNVIfZxhWttDGB9PE8QOtivM37
         L/Fz59o05TpJ+u4DoIdyfHJFaCY9UvGkLVuFnguXhN6p1dK/MG5LK3hiDPdheqS9oF1z
         5hd4ztmsMKxs/8msoaR/MOH5YgB3ZmMZcPs+mdSTxumLpxr5z4bLHy2yMMO5S23SLm/0
         Wvi9gSQbV9qdDhkHYrGZ0s8+cGNTCTZ8M6GL+G9L3C5jkVbsnHU8sziNykKoPHhVBMPX
         eMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPIuEHDSoxOxKmo/+FURVEIw3vOuo9up5XrlOV13hU0=;
        b=SiLC8rQM1aTelYKe6rCKNk5D7BEfmmL+odCo/2Zf2I4TRWwPp+7MAZ3BUc/IIv3H0M
         TeYmTWlS+Qn+V/oqPmi8nGXO1Hnbc6hvM5naMubZiCbvPMOCbST6KKNjOdrLO6RNPbrq
         O8JoBVjr2d3BAb6yMoaiMSg45qadGrXrxsJOt5FSSA7ILg0VP5v4WscmGRtMWVBi3e9t
         D215q69gmYb1eWr/lliGVY3IwqT2UHOtKKNejtdxnjIe2kA5hCIxq/54MQ5LlvNTPZwd
         M4t9HwFjuPSXrrDCSX9keclJ8fHJ5gnIVDA3Da8I5NoUJcjR82niDwY4ynEwxSm+umo+
         zvow==
X-Gm-Message-State: APjAAAVCKJkBAXnjbmxrUOurWZ9lodsKeIr3YeCW2QQbirHx1QzXmtX2
        tDKVMHTgKvX6J6r+WncdzshL2vY2QaI=
X-Google-Smtp-Source: APXvYqwL5oKsKpzakG2xNA9f9ZXT2SwooD+CBKorfGAmtVXIgGit+ZgmHDDgcByAr3/ys1emcMpKEg==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr9949406wrx.80.1560367610127;
        Wed, 12 Jun 2019 12:26:50 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:49 -0700 (PDT)
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
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 14/28] x86/vdso: Rename vdso_image {.data=>.text}
Date:   Wed, 12 Jun 2019 20:26:13 +0100
Message-Id: <20190612192628.23797-15-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid any confusion with VVAR.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 2 +-
 arch/x86/entry/vdso/vma.c    | 6 +++---
 arch/x86/include/asm/vdso.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 80be339ee93e..7556bb70ed8b 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -158,7 +158,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile, "\n};\n\n");
 
 	fprintf(outfile, "const struct vdso_image %s = {\n", image_name);
-	fprintf(outfile, "\t.data = raw_data,\n");
+	fprintf(outfile, "\t.text = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
 	if (alt_sec) {
 		fprintf(outfile, "\t.alt = %lu,\n",
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index d2b421233ba5..c30a33b2963b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -32,8 +32,8 @@ void __init init_vdso_image(const struct vdso_image *image)
 {
 	BUG_ON(image->size % PAGE_SIZE != 0);
 
-	apply_alternatives((struct alt_instr *)(image->data + image->alt),
-			   (struct alt_instr *)(image->data + image->alt +
+	apply_alternatives((struct alt_instr *)(image->text + image->alt),
+			   (struct alt_instr *)(image->text + image->alt +
 						image->alt_len));
 }
 
@@ -47,7 +47,7 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 	if (!image || (vmf->pgoff << PAGE_SHIFT) >= image->size)
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = virt_to_page(image->data + (vmf->pgoff << PAGE_SHIFT));
+	vmf->page = virt_to_page(image->text + (vmf->pgoff << PAGE_SHIFT));
 	get_page(vmf->page);
 	return 0;
 }
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 230474e2ddb5..dffdc12cc7d6 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -11,7 +11,7 @@
 #include <linux/mm_types.h>
 
 struct vdso_image {
-	void *data;
+	void *text;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
 	unsigned long alt, alt_len;
-- 
2.22.0

