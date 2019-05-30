Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2531DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F084D25D61
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191859;
	bh=6BUgCBzcEPwyo3oPx1Kxuy9ngUFXJPA8mXuxIvEZG+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=093/fuaZHCyACTGFYrVa0icGhZ9CO82fdsy0ksks5uC53cdrAbBJeMdPqEYq/ZP2u
	 7VnEatRIluWHVTgd70dBfZMcCFrKo99yW752r7MZoMf6TeA+mXg+yReBrHRftW2Q+c
	 TWjK07CMp9+ToGnEBnqGJQ39bPk4VuOSO4UEkj9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbfE3Eu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728319AbfE3DLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:01 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B83244E8;
        Thu, 30 May 2019 03:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185860;
        bh=6BUgCBzcEPwyo3oPx1Kxuy9ngUFXJPA8mXuxIvEZG+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0D+mPOo5PAJOwSRTsMGuLKreu23AKTCFMWhZ2/fwgFfgBByFx84kkmlPTsvwInzu
         QRoapLpYk1te4gAS4AN2Wkv8R79VG/o5bClM75g8wMG3y3JYk8FAkTCydyE38om8Uw
         80OLloPCkJWJPsGuTfmGhpnNBopjaOtCWvu9Lnjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, luto@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 139/405] x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation
Date:   Wed, 29 May 2019 20:02:17 -0700
Message-Id: <20190530030548.128594940@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6ae865615fc43d014da2fd1f1bba7e81ee622d1b ]

The __put_user() macro evaluates it's @ptr argument inside the
__uaccess_begin() / __uaccess_end() region. While this would normally
not be expected to be an issue, an UBSAN bug (it ignored -fwrapv,
fixed in GCC 8+) would transform the @ptr evaluation for:

  drivers/gpu/drm/i915/i915_gem_execbuffer.c: if (unlikely(__put_user(offset, &urelocs[r-stack].presumed_offset))) {

into a signed-overflow-UB check and trigger the objtool AC validation.

Finish this commit:

  2a418cf3f5f1 ("x86/uaccess: Don't leak the AC flag into __put_user() value evaluation")

and explicitly evaluate all 3 arguments early.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@kernel.org
Fixes: 2a418cf3f5f1 ("x86/uaccess: Don't leak the AC flag into __put_user() value evaluation")
Link: http://lkml.kernel.org/r/20190424072208.695962771@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1954dd5552a2e..3822cc8ac9d6d 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -427,10 +427,11 @@ do {									\
 ({								\
 	__label__ __pu_label;					\
 	int __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) __pu_val;				\
-	__pu_val = x;						\
+	__typeof__(*(ptr)) __pu_val = (x);			\
+	__typeof__(ptr) __pu_ptr = (ptr);			\
+	__typeof__(size) __pu_size = (size);			\
 	__uaccess_begin();					\
-	__put_user_size(__pu_val, (ptr), (size), __pu_label);	\
+	__put_user_size(__pu_val, __pu_ptr, __pu_size, __pu_label);	\
 	__pu_err = 0;						\
 __pu_label:							\
 	__uaccess_end();					\
-- 
2.20.1



