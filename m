Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED8EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6792070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582574;
	bh=2pKmOtflfT9brReXwJoAp345D4tnX/wbnaIzm+07Wdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kAhRcTg/jbev1R97uQBRLLXU1+Jq4F4yagjGtb0ycpSBYQx3hJA9Ta8h5h8T9W4lt
	 BbH26jx3ZG4w+ajeSn9wJtspsj53PGFr6YQ1jcz8JUUSuchbmyHgaOto48AkaF6OJu
	 PwFnEo3QvvmVXqJnAixNXRblAV6mljRhbVkV3cTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfCZGia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732051AbfCZGiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:38:24 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE2520863;
        Tue, 26 Mar 2019 06:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582303;
        bh=2pKmOtflfT9brReXwJoAp345D4tnX/wbnaIzm+07Wdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFGSJvyMreHpg+WLJFfOVqOCnZsaNrCwFHtI80mXE410Cny/RF0utIrRK4zjK1e63
         sx8vLS6euUDH+cBbzmO1QSeQheLO+anzupEd/wzBAlnp4NComfBfPjVq2KsyOgrVcP
         otu73pN+cBgmzsmWVU7em+m1xcEDglZNAXJBvdcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yasha Cherikovsky <yasha.che3@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 5.0 15/52] MIPS: Ensure ELF appended dtb is relocated
Date:   Tue, 26 Mar 2019 15:30:02 +0900
Message-Id: <20190326042701.678153787@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yasha Cherikovsky <yasha.che3@gmail.com>

commit 3f0a53bc6482fb09770982a8447981260ea258dc upstream.

This fixes booting with the combination of CONFIG_RELOCATABLE=y
and CONFIG_MIPS_ELF_APPENDED_DTB=y.

Sections that appear after the relocation table are not relocated
on system boot (except .bss, which has special handling).

With CONFIG_MIPS_ELF_APPENDED_DTB, the dtb is part of the
vmlinux ELF, so it must be relocated together with everything else.

Fixes: 069fd766271d ("MIPS: Reserve space for relocation table")
Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/vmlinux.lds.S |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -140,6 +140,13 @@ SECTIONS
 	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 #endif
 
+#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
+	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
+		*(.appended_dtb)
+		KEEP(*(.appended_dtb))
+	}
+#endif
+
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(4);
 
@@ -164,11 +171,6 @@ SECTIONS
 	__appended_dtb = .;
 	/* leave space for appended DTB */
 	. += 0x100000;
-#elif defined(CONFIG_MIPS_ELF_APPENDED_DTB)
-	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
-		*(.appended_dtb)
-		KEEP(*(.appended_dtb))
-	}
 #endif
 	/*
 	 * Align to 64K in attempt to eliminate holes before the


