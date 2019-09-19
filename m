Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF6321A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931677;
	bh=O9VeM1BOlt+ur9Dx7odq4IYF9Sb2o2TtG1rbzNzzC/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWcYOywvi+pGUGDV+7ujoq8KHiHvtPP6SoKDhzDYKinoFQgun1snXRTagsyC2kzn8
	 Cxm/synH7g3BSmy6POJdCcF57lvEsHHdOZ+EPh2G6RQB+1bme/zyM7Brvun8w3w7vg
	 qEARvIpjdbDeb+bCKwJCdgnKMF8/Z1VEaFfRAJL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406695AbfISWVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391015AbfISWVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:21:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A6B21907;
        Thu, 19 Sep 2019 22:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931667;
        bh=O9VeM1BOlt+ur9Dx7odq4IYF9Sb2o2TtG1rbzNzzC/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tsgt//xf0KR3+9I0fgEz6JZHIyR3nvcpgm9vRMbCsNBdCmEjA9mAaemAq68FsKps8
         vnovU2IHvCQp3koiqYXDhOwB74PmOda5YOtv6ZCJpKasVclLFOx/kJyal1v+jkMdfZ
         Rk9UG3A0A2WDr966NE2uq+MpygDR5cxMIIOTXz6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, broonie@kernel.org,
        sfr@canb.auug.org.au, akpm@linux-foundation.org, mhocko@suse.cz,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 69/74] x86/uaccess: Dont leak the AC flags into __get_user() argument evaluation
Date:   Fri, 20 Sep 2019 00:04:22 +0200
Message-Id: <20190919214811.103313365@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 9b8bd476e78e89c9ea26c3b435ad0201c3d7dbf5 ]

Identical to __put_user(); the __get_user() argument evalution will too
leak UBSAN crud into the __uaccess_begin() / __uaccess_end() region.
While uncommon this was observed to happen for:

  drivers/xen/gntdev.c: if (__get_user(old_status, batch->status[i]))

where UBSAN added array bound checking.

This complements commit:

  6ae865615fc4 ("x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation")

Tested-by Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: broonie@kernel.org
Cc: sfr@canb.auug.org.au
Cc: akpm@linux-foundation.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: mhocko@suse.cz
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20190829082445.GM2369@hirez.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 2177c7551ff77..9db8d8758ed3b 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -438,8 +438,10 @@ do {									\
 ({									\
 	int __gu_err;							\
 	__inttype(*(ptr)) __gu_val;					\
+	__typeof__(ptr) __gu_ptr = (ptr);				\
+	__typeof__(size) __gu_size = (size);				\
 	__uaccess_begin_nospec();					\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
+	__get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_err, -EFAULT);	\
 	__uaccess_end();						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__builtin_expect(__gu_err, 0);					\
-- 
2.20.1



