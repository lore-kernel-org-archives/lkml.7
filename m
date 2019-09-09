Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCF1C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B2D21D79
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568067416;
	bh=Yl59bSCmjGQO8ga6KfcvRC+PKgjgMXblO8qVnUO1YgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5H744MM0NyJ9qJfvjru37N2WedahwWNEPFeCZL38FivHFb5QiuNHfguYpxD+MWl5
	 dAb2IEBX0vB7F5JzPaKUzrkt1Xw7VbSG0VpBH1dP0gmovgIjBf+Svncc3qQf0Q7Qei
	 z7iA1Xc7K0LgGvkHcGO4F3OoAhqaB1bl7E6vDpZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406269AbfIIWQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406211AbfIIWQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:16:43 -0400
Received: from sasha-vm.mshome.net (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50FB32171F;
        Mon,  9 Sep 2019 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568067403;
        bh=Yl59bSCmjGQO8ga6KfcvRC+PKgjgMXblO8qVnUO1YgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zy2aIfhO+JyTCLlQ9S5H6JSWAkakszOef6jjvBd4K18C6ZpQLWZW0yiiMFp3vmpom
         QzOsQVZGL88qagLAxCb3Q4PZ9THkz9FdcBk56Byeof79X8ITmCJDc2UYOnQJSSiS6e
         J4gG8/TUVDMJcvfquryINVKE/5TY+6RELne/Oz1U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, broonie@kernel.org,
        sfr@canb.auug.org.au, akpm@linux-foundation.org, mhocko@suse.cz,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 3/8] x86/uaccess: Don't leak the AC flags into __get_user() argument evaluation
Date:   Mon,  9 Sep 2019 11:41:18 -0400
Message-Id: <20190909154124.31146-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909154124.31146-1-sashal@kernel.org>
References: <20190909154124.31146-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 4111edb3188e2..9718303410614 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -451,8 +451,10 @@ do {									\
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

