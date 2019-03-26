Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F03C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDC820823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581900;
	bh=aChZIsApiOt2Ph7XS+iUWkQz7muClINzzHmHedw+IiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FYqxaud/Vp2txjC+SAO3M8yaKnBY5v3w5Tb0xfO1uI22ZiO2UxPK4zBd1Q0y2Ou+I
	 zd9MQlhgPYeTPuqh4AMLg4/5wq0yE8RmRUTJCay3BBawFJSI3oWfn5xJA+FhUdKShv
	 CwpLsv6yyXW14hUhJPNoGq+KgBHll9RZwjFVNfPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfCZGbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZGbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:31:35 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E879320857;
        Tue, 26 Mar 2019 06:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581894;
        bh=aChZIsApiOt2Ph7XS+iUWkQz7muClINzzHmHedw+IiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnTT065OqOI6uQxAvVr8qnDjRXj0BMP6nqGiuaU79znxNeXWkwo0jGvSTannPHan9
         z88XvzEXfUnzuLifmxOnuSN6Oq2a0/c6cx5Bcf0oKgo10GRXCuEkgwu+eHBIO/iaY5
         jy9MlYi57iVREO8c4q4PFazfaAAoHcWm9uHFlaxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yasha Cherikovsky <yasha.che3@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.9 07/30] MIPS: Ensure ELF appended dtb is relocated
Date:   Tue, 26 Mar 2019 15:29:46 +0900
Message-Id: <20190326042607.823262615@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -138,6 +138,13 @@ SECTIONS
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
 
@@ -162,11 +169,6 @@ SECTIONS
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


