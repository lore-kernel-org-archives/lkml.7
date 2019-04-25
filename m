Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2217EC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708052088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WLmMaAJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfDYQQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:16:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46615 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfDYQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so348120edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEWehqcrwZzDsKvwwSM26zcMEpaLobvBOxtXvx1hRO8=;
        b=WLmMaAJkgc0WWAr+oX/Xz1HPWP+UARBxIh2XikNjeHne5BN17ZaBEVrGZRyaDb88Un
         E60c77DLidPsl8oA9OX+FAPqhu/55IyUDXjmymj8wGDb9igkdoaRVscUCaEFA0CWPAgM
         DdhLP9f+1HtikEtaTAldeSG7tdKyTngg1UpsJy+mV6wpAdIqbTy4eB51ZakEZ9ZzO4du
         toZZIkRgv56yNb+jlEDUr1jIobwQzu5p8Q3xnnryfb0laLFmRlvDM+WLOltvw/0t+x0T
         S7zcsLSgjordFfgyDZgAavq24PTil0uZg+z6R7ku+oCqv7av1N9vuXb/rgUdGKGGrA8K
         vyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEWehqcrwZzDsKvwwSM26zcMEpaLobvBOxtXvx1hRO8=;
        b=fP8zPYe8TLY2+nJriN+3M+cIkXZAw6GT8zFA8vaX14Na0AStvFudQdw1iquyUGUheA
         cEN+Ia6BsV0+OBkdSBZ7SFxtxHAl4rRnOfMUXhU0ns6aDU4xwHQfCzSGuSRkt3HM/ZQr
         3bcI7nFfsXkUiYSwnXV43FqVyoU3z8OkkuWHldbaJ+UyDHwLxL3t/OyqWfUFRbcNoYHe
         1mvfC4O9qeZk4WivXHTog7EKiQisewB7mmpTGCnIGKvVlqhydCoYff8dJYsRgkGvIlsq
         44/u/rU+JiXqe2eqRag5cZZD4WWVi032EhxZtptMAZ8vwA0CSh05RUXSyy1ipwBnO0mW
         PhIA==
X-Gm-Message-State: APjAAAUgLur9P6LwBZ2WdfjhJfm2TeWfE2OMP6hPJozLvdN/rbbXsiU+
        Wi3W4nXBMTzIc6mg0qlthq6GiASpgT8=
X-Google-Smtp-Source: APXvYqwydXVemz95eLqU3pxxTavy/LNcmoFp7jPWS0YasV7lYuUSAqf2OrLsERzgGR33F/Lbgop98w==
X-Received: by 2002:a50:8b95:: with SMTP id m21mr24069671edm.178.1556208879706;
        Thu, 25 Apr 2019 09:14:39 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:39 -0700 (PDT)
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
Subject: [PATCHv3 13/27] x86/vdso: Rename vdso_image {.data=>.text}
Date:   Thu, 25 Apr 2019 17:14:02 +0100
Message-Id: <20190425161416.26600-14-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid any confusion with VVAR.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 2 +-
 arch/x86/entry/vdso/vma.c    | 6 +++---
 arch/x86/include/asm/vdso.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 61c8bb2e5af8..086a11aee0e8 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -157,7 +157,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile, "\n};\n\n");
 
 	fprintf(outfile, "const struct vdso_image %s = {\n", name);
-	fprintf(outfile, "\t.data = raw_data,\n");
+	fprintf(outfile, "\t.text = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
 	if (alt_sec) {
 		fprintf(outfile, "\t.alt = %lu,\n",
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index ff9875a4d53b..35f7a1c1f4bc 100644
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
index 27566e57e87d..02cb843b4c0b 100644
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
2.21.0

