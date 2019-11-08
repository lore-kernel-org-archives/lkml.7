Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA1FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2861520865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239293;
	bh=jGNPFgY3BP2+kzPhYnANC70HiwPf6Eo8P8wdIOPL58Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jHxDkizZ9wZqbEJfm2Lyo+ApY9WtNesQHM/pdWNDJwhuDIua/bNScaSdXNN2EnuWq
	 FeY9SVDmhdUCViiTHmPht3oCcu5MkdjPEtU0UBceftEqE+70+M3G5oiManP5jQvXvL
	 wPtZfAyN0h5dAAFD1IS6pInxYjNBePHje/6mhFFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbfKHSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:54:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733119AbfKHSyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:54:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D7C62178F;
        Fri,  8 Nov 2019 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239289;
        bh=jGNPFgY3BP2+kzPhYnANC70HiwPf6Eo8P8wdIOPL58Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FygAbKYWkawnMFZtsZUEE2lVJ8vnG3A5rlgTMhaU6ZBn6hUz6eFwJ0YqGBwJYl/IR
         ZdfKK+6ISwtFlE4getpiEYayIyH6j+f+c99mCTKnrSlSu25vKqgDtPoDQ0hTBJfkU6
         6H6CvPHupJDwf2DLKWBUCx/xDxUlys1/0tPRpzbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 64/75] ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
Date:   Fri,  8 Nov 2019 19:50:21 +0100
Message-Id: <20191108174805.004326669@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit e3aa6243434fd9a82e84bb79ab1abd14f2d9a5a7 upstream.

When Spectre mitigation is required, __put_user() needs to include
check_uaccess. This is already the case for put_user(), so just make
__put_user() an alias of put_user().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/uaccess.h |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -408,6 +408,14 @@ do {									\
 	__pu_err;							\
 })
 
+#ifdef CONFIG_CPU_SPECTRE
+/*
+ * When mitigating Spectre variant 1.1, all accessors need to include
+ * verification of the address space.
+ */
+#define __put_user(x, ptr) put_user(x, ptr)
+
+#else
 #define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
@@ -415,12 +423,6 @@ do {									\
 	__pu_err;							\
 })
 
-#define __put_user_error(x, ptr, err)					\
-({									\
-	__put_user_switch((x), (ptr), (err), __put_user_nocheck);	\
-	(void) 0;							\
-})
-
 #define __put_user_nocheck(x, __pu_ptr, __err, __size)			\
 	do {								\
 		unsigned long __pu_addr = (unsigned long)__pu_ptr;	\
@@ -500,6 +502,7 @@ do {									\
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")
 
+#endif /* !CONFIG_CPU_SPECTRE */
 
 #ifdef CONFIG_MMU
 extern unsigned long __must_check


