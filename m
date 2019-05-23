Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B927C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640721;
	bh=2C2QQ3bMoLYNqfonrJ8jPSLJoDzjfVJiXseepizVle8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HBcqFy1j2TDZKQZVN30HROY61Q6tQlm3GN5+cOZeMEvqKKEdkZBTea44g4L8hjJ1Y
	 R7c6IrTHA3UsPmlvrSgibydAqMHzoZC2jx5eX6aA8kNyceTHKycetHkJtTZg41ysyj
	 ytJGVBNvaMf0OjHqIYip9UVC5hXIGPc+PuZdMS3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbfEWTPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389033AbfEWTPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:15:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EEE2133D;
        Thu, 23 May 2019 19:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638938;
        bh=2C2QQ3bMoLYNqfonrJ8jPSLJoDzjfVJiXseepizVle8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvcybsdbzd24+XzSwNYYnqAl3bQUPnRcIqanGSgDS9ri3UZ81gj8t5G+eCq4ACHd0
         1hGWiiGQKorZfgTRjBM4oP/dCBPBLPP/NLX3T3SFha6cACPvq9Ylo6f5zsX44d+czr
         25RO59/4Vdj5H1YF/ITeMQvwLhZaFWvBCVS1Dlv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.19 019/114] parisc: Use PA_ASM_LEVEL in boot code
Date:   Thu, 23 May 2019 21:05:18 +0200
Message-Id: <20190523181733.601953217@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit bdca5d64ee92abeacd6dada0bc6f6f8e6350dd67 upstream.

The LEVEL define clashed with the DRBD code.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/boot/compressed/head.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/parisc/boot/compressed/head.S
+++ b/arch/parisc/boot/compressed/head.S
@@ -22,7 +22,7 @@
 	__HEAD
 
 ENTRY(startup)
-	 .level LEVEL
+	 .level PA_ASM_LEVEL
 
 #define PSW_W_SM	0x200
 #define PSW_W_BIT       36
@@ -63,7 +63,7 @@ $bss_loop:
 	load32	BOOTADDR(decompress_kernel),%r3
 
 #ifdef CONFIG_64BIT
-	.level LEVEL
+	.level PA_ASM_LEVEL
 	ssm	PSW_W_SM, %r0		/* set W-bit */
 	depdi	0, 31, 32, %r3
 #endif
@@ -72,7 +72,7 @@ $bss_loop:
 
 startup_continue:
 #ifdef CONFIG_64BIT
-	.level LEVEL
+	.level PA_ASM_LEVEL
 	rsm	PSW_W_SM, %r0		/* clear W-bit */
 #endif
 


