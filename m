Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14CAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8157B206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="mMIfpm/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLQEGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:06:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35407 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQEGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:06:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2837177plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 20:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uocyHCicgyR54zqlYy/1WC7vL6RVUN8Yp7Wz/S3z2fQ=;
        b=mMIfpm/iIionAh/tCeO/BqlPJh3nTdejcnbgxeuHQOdySh/Zeqtu1wr1ZgXqjZFKWD
         NU6HdolWLOh6KGTp8DpW3R/JjV7gWlDuGDscGnU3K88CkP1Pa75eREuIAVHVRzUYqfDF
         FQVbMZ1URnIa+5EutPbVRcfIWY9qN+sUHuwlq56kaLrqfQ3xINFk3EpScb4G2rUK2yfT
         cXIXjYUPoBwfsYn7/17s/RacpR0EqomQT9SjF/Tk8lJ6wcqTGkvwGV4EKyjt14vTGWBQ
         Wyr5L6XhAFwnpZAvZr7ItYaJjqgerzeRokD3MFLB+R/0WV0gw1vdjnVnvHu/JZwwu8kE
         Lw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uocyHCicgyR54zqlYy/1WC7vL6RVUN8Yp7Wz/S3z2fQ=;
        b=cUo0e/T0RX4y7otNV2dLdLBznYki+WgOrX86Up0enbnaFXLjp2wIir6djK9z6fHcfB
         bWS9mIyGvnLSHjBm8PxaZ+KypSORDQDr1znkAH3ZPuzJnuTnmgCFDyIzH1rEtHn6Lwp8
         zA3FZBsrzSClHZYZHmXXuyq2ytFB9XmsvpcERHRC6e0CIBLIDshf9iG+J/nwkJ2EIeBu
         lsYi07pbUrbR/7izZJUZoBNRIb1B6e2qpGM8PiUWfHfTLaM4v2zYgdHAoSdXfsHj3OjJ
         3YYLIYVh0pdq5UiNvsZpG8oX3hfLsQOeRpVTbcXslGIVMOkZz19JHnlH/+xe/uPC2mBB
         3r/g==
X-Gm-Message-State: APjAAAW72TfXx5AGUcVlhi/T4/yEOvXLIWtg3WUT/NAItrfpPP6JoeUX
        NvUhhfA8NoRMMUTchWVpmXySlQ==
X-Google-Smtp-Source: APXvYqwOUj/es4Lnlocupmtdv8ocU/JXMsOcO3BzL3fK+Fb2LapV0v2iGm5bIMFOwMpMaZF7mnGB5g==
X-Received: by 2002:a17:902:b7cc:: with SMTP id v12mr3439330plz.284.1576555600540;
        Mon, 16 Dec 2019 20:06:40 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id j125sm24830738pfg.160.2019.12.16.20.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 20:06:39 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] riscv: Less inefficient gcc tishift helpers (and export their symbols)
Date:   Mon, 16 Dec 2019 20:06:31 -0800
Message-Id: <20191217040631.91886-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191217003057.39300-1-olof@lixom.net>
References: <20191217003057.39300-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing __lshrti3 was really inefficient, and the other two helpers
are also needed to compile some modules.

Add the missing versions, and export all of the symbols like arm64
already does.

This fixes a build break triggered by ubsan:

riscv64-unknown-linux-gnu-ld: lib/ubsan.o: in function `.L2':
ubsan.c:(.text.unlikely+0x38): undefined reference to `__ashlti3'
riscv64-unknown-linux-gnu-ld: ubsan.c:(.text.unlikely+0x42): undefined reference to `__ashrti3'

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/include/asm/asm-prototypes.h |  4 ++
 arch/riscv/lib/tishift.S                | 71 +++++++++++++++++++++++++--------
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index dd62b691c443d..27e005fca5849 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -5,4 +5,8 @@
 #include <linux/ftrace.h>
 #include <asm-generic/asm-prototypes.h>
 
+long long __lshrti3(long long a, int b);
+long long __ashrti3(long long a, int b);
+long long __ashlti3(long long a, int b);
+
 #endif /* _ASM_RISCV_PROTOTYPES_H */
diff --git a/arch/riscv/lib/tishift.S b/arch/riscv/lib/tishift.S
index 15f9d54c7db63..64a7b6abd38fb 100644
--- a/arch/riscv/lib/tishift.S
+++ b/arch/riscv/lib/tishift.S
@@ -4,34 +4,73 @@
  */
 
 #include <linux/linkage.h>
+#include <asm-generic/export.h>
 
 ENTRY(__lshrti3)
 	beqz	a2, .L1
 	li	a5,64
 	sub	a5,a5,a2
-	addi	sp,sp,-16
 	sext.w	a4,a5
 	blez	a5, .L2
 	sext.w	a2,a2
-	sll	a4,a1,a4
 	srl	a0,a0,a2
-	srl	a1,a1,a2
+	sll	a4,a1,a4
+	srl	a2,a1,a2
 	or	a0,a0,a4
-	sd	a1,8(sp)
-	sd	a0,0(sp)
-	ld	a0,0(sp)
-	ld	a1,8(sp)
-	addi	sp,sp,16
-	ret
+	mv	a1,a2
 .L1:
 	ret
 .L2:
-	negw	a4,a4
-	srl	a1,a1,a4
-	sd	a1,0(sp)
-	sd	zero,8(sp)
-	ld	a0,0(sp)
-	ld	a1,8(sp)
-	addi	sp,sp,16
+	negw	a0,a4
+	li	a2,0
+	srl	a0,a1,a0
+	mv	a1,a2
 	ret
 ENDPROC(__lshrti3)
+EXPORT_SYMBOL(__lshrti3)
+
+ENTRY(__ashrti3)
+	beqz	a2, .L3
+	li	a5,64
+	sub	a5,a5,a2
+	sext.w	a4,a5
+	blez	a5, .L4
+	sext.w	a2,a2
+	srl	a0,a0,a2
+	sll	a4,a1,a4
+	sra	a2,a1,a2
+	or	a0,a0,a4
+	mv	a1,a2
+.L3:
+	ret
+.L4:
+	negw	a0,a4
+	srai	a2,a1,0x3f
+	sra	a0,a1,a0
+	mv	a1,a2
+	ret
+ENDPROC(__ashrti3)
+EXPORT_SYMBOL(__ashrti3)
+
+ENTRY(__ashlti3)
+	beqz	a2, .L5
+	li	a5,64
+	sub	a5,a5,a2
+	sext.w	a4,a5
+	blez	a5, .L6
+	sext.w	a2,a2
+	sll	a1,a1,a2
+	srl	a4,a0,a4
+	sll	a2,a0,a2
+	or	a1,a1,a4
+	mv	a0,a2
+.L5:
+	ret
+.L6:
+	negw	a1,a4
+	li	a2,0
+	sll	a1,a0,a1
+	mv	a0,a2
+	ret
+ENDPROC(__ashlti3)
+EXPORT_SYMBOL(__ashlti3)
-- 
2.11.0

