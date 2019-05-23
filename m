Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6081C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8433020879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639667;
	bh=uK2l6iJbIsZEh6rp+uQugI8F0dbT2f9ZUREWDTQJb4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WnDfBkFtUNF0VxoTxtImvDHAfHUh7CIDI2m7YmiTVELr8HjJNdk6Wag1HiVDgg7T3
	 UpRNDHSE37i8gksPrla/ubYT6P1+AuMBWRlUtqngbmArS2oDU7lfSX8xl/AwREiHL6
	 FGNC0cLtFwYSciajdk+GC++Hkdx3esozbmNQd/II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbfEWT1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391251AbfEWT1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:27:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73CB820879;
        Thu, 23 May 2019 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639661;
        bh=uK2l6iJbIsZEh6rp+uQugI8F0dbT2f9ZUREWDTQJb4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMgtO1uZupqiRuJIk1dzRVIXbJgwuGcdxsl7Pb6ytYSfJlGebpLcvss0r21jfz5OB
         1+Iev5ujdZfyTjg+4tRS3DulTIsCdKNc1pIMO82LZOWcm1493cqqZNW0AQVBKiHuAZ
         4OLvQuZqm0DfS92Vsvj+neaKXc8ljn9LXrsV8KEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.1 032/122] parisc: Rename LEVEL to PA_ASM_LEVEL to avoid name clash with DRBD code
Date:   Thu, 23 May 2019 21:05:54 +0200
Message-Id: <20190523181709.137298315@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
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
@@ -61,14 +61,14 @@
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
@@ -258,7 +258,7 @@ stext_pdc_ret:
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
 


