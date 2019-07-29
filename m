Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B987FC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5452171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EpBU7HAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfG2WBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:01:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37835 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2V6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so38383146wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDD6ysbcq8/fi6dGyfg9N1McraInCy0n2bZF6snhbRo=;
        b=EpBU7HALHo/0prm0kDfzdl0bU0rQpQKOoyZSoBM+J7OmIVjRHfpVuWLNkzhcPowZY+
         k9d0CDSiCtfqacVU4TgScSmWmtVEfImaFyxBJe1kGWqjjn0ZMnIztBuGUR2bL/av9yT4
         Ik05GnFG1prEjOT5QsovvkETKtADtnWl8K3/apL2r6D5amay3q56MR+MlvR3yxKlSlir
         lakli4HgTueUyKJrcQBajw/nZPKH8FmWMM4aokg33I1UEth+FtROkn1PGcb2LHewvUw5
         YmhIpDYd1jeqqzf/P0TBwIOP00WLWNwVCq9sFiMsuLnPcVN57rz8xwSh3o3A8UrbxmYa
         MesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDD6ysbcq8/fi6dGyfg9N1McraInCy0n2bZF6snhbRo=;
        b=XCIBKhereWTVWDWxSvZh9zFO7h/vTie9PNANZYdYa2zEoonF26McHS1gPJDrsvvG6o
         7Ba/JC/wnVb/S+8++z1GwFhI4AADhExrqZrO6MN1xHHkilDGO4Iy2sYQpJSbG1rH38+l
         QnicQab08Ex6XIBP29cUvjGiEOvZXxoTfLxmyUY79tlKGWp29V5pYwatM0fRLDXEXzH0
         imvsw5kezD4Fv4Dze3FJWkCbsBYb2GtC1yQ0+cmTTgK4H1YVGtMf+4ayskKAUFZYD+Z7
         YCtcW0KFwZa6TbdWylxs6Lr9Yroo8BZGD2i7R4aeZebutEwtqiT935lvccVc4R8FBSoM
         NcgA==
X-Gm-Message-State: APjAAAWkpJGSFjUqCOAkW2YS1iqz36wrd1E/OpkRzutVPe7HDEwZ5xMK
        H04GgQzbEa3zXGaEBcJ3Jh3nDoq0Zbua8VgNzkDBd9W7q/ZvoiTWHlAYTbcZCLBOTySSbX0pC9d
        acv4/HfD6YlBUHC5RnNJO7ByD3DbfvLvPal6cJbskTRxDKqopxXeRD+Ph9Q8OG3p3yjuGru2sk3
        m2aMD5cfEzx+IqWpS+DhVTLyuVjfYnvMw3mBvoDhc=
X-Google-Smtp-Source: APXvYqxoEWpgwKDwrBGamkwnMV/z+4IT1Oqc7hGPBGvJ46pfHt3zj7agrcSjojOAIKIzkyrrQX2M4w==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr19655699wrl.281.1564437510818;
        Mon, 29 Jul 2019 14:58:30 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:30 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
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
Subject: [PATCHv5 22/37] x86/vdso: Rename vdso_image {.data=>.text}
Date:   Mon, 29 Jul 2019 22:57:04 +0100
Message-Id: <20190729215758.28405-23-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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
index 3f05418642a8..2dc4f0b5481c 100644
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

