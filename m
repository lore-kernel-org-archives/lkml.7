Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CB9C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBA520851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558641067;
	bh=X82DCfnwJygqNt/nKZWX1ft7kNfJxTjDL6mOycoRrSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a7YeVp12ULo4znZ05U30LNznoTFq/Ye6K9IlWFEdKJkaljZ83ewNjiZ8IRH0K1qTG
	 Q3az7PQGfuSyzXLMuFweV8Jyl+n+JyQ8IGC7uxl/H3WC+Kent8Q6B1Ll7V2VNbIdeB
	 78VhaFBUfSA4b0aGPLhprm3iJ/WMqw1ckK5yTdYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbfEWTvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732014AbfEWTJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:09:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA8D217D7;
        Thu, 23 May 2019 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638544;
        bh=X82DCfnwJygqNt/nKZWX1ft7kNfJxTjDL6mOycoRrSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5mI2k+2cg4/AW2V+uOo0VLOKIXAkdFk5g5fMnVhaJi4dQ7rVKXzNgW3Moa2VgH5T
         pHGsI0Z8RtHhQyXPSp1XxnwNbiy6xMWHnAw1kfTYibcluMBKvXF0Mcfbik39nsHslw
         weFe7vdHREx6u/W3vZ2uzRrifNNnjI6wJc7AErls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.9 10/53] parisc: Rename LEVEL to PA_ASM_LEVEL to avoid name clash with DRBD code
Date:   Thu, 23 May 2019 21:05:34 +0200
Message-Id: <20190523181712.553142093@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 1829dda0e87f4462782ca81be474c7890efe31ce upstream.

LEVEL is a very common word, and now after many years it suddenly
clashed with another LEVEL define in the DRBD code.
Rename it to PA_ASM_LEVEL instead.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/assembly.h |    6 +++---
 arch/parisc/kernel/head.S          |    4 ++--
 arch/parisc/kernel/syscall.S       |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/parisc/include/asm/assembly.h
+++ b/arch/parisc/include/asm/assembly.h
@@ -59,14 +59,14 @@
 #define LDCW		ldcw,co
 #define BL		b,l
 # ifdef CONFIG_64BIT
-#  define LEVEL		2.0w
+#  define PA_ASM_LEVEL	2.0w
 # else
-#  define LEVEL		2.0
+#  define PA_ASM_LEVEL	2.0
 # endif
 #else
 #define LDCW		ldcw
 #define BL		bl
-#define LEVEL		1.1
+#define PA_ASM_LEVEL	1.1
 #endif
 
 #ifdef __ASSEMBLY__
--- a/arch/parisc/kernel/head.S
+++ b/arch/parisc/kernel/head.S
@@ -22,7 +22,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	.level	LEVEL
+	.level	PA_ASM_LEVEL
 
 	__INITDATA
 ENTRY(boot_args)
@@ -254,7 +254,7 @@ stext_pdc_ret:
 	ldo		R%PA(fault_vector_11)(%r10),%r10
 
 $is_pa20:
-	.level		LEVEL /* restore 1.1 || 2.0w */
+	.level		PA_ASM_LEVEL /* restore 1.1 || 2.0w */
 #endif /*!CONFIG_64BIT*/
 	load32		PA(fault_vector_20),%r10
 
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -48,7 +48,7 @@ registers).
 	 */
 #define KILL_INSN	break	0,0
 
-	.level          LEVEL
+	.level          PA_ASM_LEVEL
 
 	.text
 


