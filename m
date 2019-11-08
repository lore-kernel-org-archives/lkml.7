Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F00FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB25218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239179;
	bh=twVd6gimzzXNR7792MxM7650o7i7ihkf9ZJDkoVp7nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kkuF7PQg1g01fwDnjgTH07jZ+jgXYba6wemAaYKuGuQp2uyOm1XAZJg9ZhZ0CmOBe
	 EHc9IUK6cPrX2yKQFA2EonBkrcwryB3SJqA1WT//oKZ/GSLMGozMyjkZzI9SQhSMYf
	 r//wBUb3QFUl+lejGC8TfYJ6Wwa1VBGFcvoemGqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfKHSw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:52:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbfKHSwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:52:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE92214DB;
        Fri,  8 Nov 2019 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239173;
        bh=twVd6gimzzXNR7792MxM7650o7i7ihkf9ZJDkoVp7nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHNfyk9TIcHvO+DJ6+ywEJwFDDfqNUxnSERVlaxB38kIHrxeExaMnMl8Wdgv5UfUu
         UC0BCxNJCyN0bTXUJcJoY1ttIH5lMy/ECDlpftCT8gqdWgPtHM/LsDdRJdHROIPSo/
         0PAocykETJFveSyecoCdmyIWUT8YuOthHASs3t3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Nicolas Pitre <nico@linaro.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 24/75] ARM: 8051/1: put_user: fix possible data corruption in put_user
Date:   Fri,  8 Nov 2019 19:49:41 +0100
Message-Id: <20191108174730.941839128@linuxfoundation.org>
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

From: Andrey Ryabinin <a.ryabinin@samsung.com>

Commit 537094b64b229bf3ad146042f83e74cf6abe59df upstream.

According to arm procedure call standart r2 register is call-cloberred.
So after the result of x expression was put into r2 any following
function call in p may overwrite r2. To fix this, the result of p
expression must be saved to the temporary variable before the
assigment x expression to __r2.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
Reviewed-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/uaccess.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -251,7 +251,7 @@ extern int __put_user_8(void *, unsigned
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
 		const typeof(*(p)) __user *__tmp_p = (p);		\
-		register typeof(*(p)) __r2 asm("r2") = (x);	\
+		register const typeof(*(p)) __r2 asm("r2") = (x);	\
 		register const typeof(*(p)) __user *__p asm("r0") = __tmp_p; \
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\


