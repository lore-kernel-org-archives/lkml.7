Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C11C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B9E20863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639235;
	bh=uK2l6iJbIsZEh6rp+uQugI8F0dbT2f9ZUREWDTQJb4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GSFDiCU/df22ESBNrqGAc8TE/gNW/6ZDGp1UjuWU+TPzNANo87lHk1vDPsfAQQtce
	 S8MtWPNRTBjBoMF7E8KjfYomRydWVFZKNTUFE8zbv8kEMyFVY6a/4PlgMFm50S7JW+
	 gO0ZmbqiIZpN+qmwfmRffB3ZmvNhL+kaSdYg2r2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbfEWTUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390056AbfEWTUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:20:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44FE0205ED;
        Thu, 23 May 2019 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639231;
        bh=uK2l6iJbIsZEh6rp+uQugI8F0dbT2f9ZUREWDTQJb4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzvOL3zQ4PAhPlZRWfXWuUqK3JupFIRssVh1lpXb0cLihMZewSfw2mhyG7btMMij/
         BhyyzerVSrM4v6Z6qu0i0TpQ+vkQrmsY03inaXnTKhKj/LQtQ7q8bLPbYZsXggZ2mh
         FXhSsVYucJm7AqTS6rVRTSaPYnZc1lprNwpNIuBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.0 028/139] parisc: Rename LEVEL to PA_ASM_LEVEL to avoid name clash with DRBD code
Date:   Thu, 23 May 2019 21:05:16 +0200
Message-Id: <20190523181724.351008243@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
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
 


