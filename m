Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC94C41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D345721881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfIBMfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:35:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbfIBMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:35:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4lXi-0004Tx-GT; Mon, 02 Sep 2019 14:34:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DC3561C0793;
        Mon,  2 Sep 2019 14:34:45 +0200 (CEST)
Date:   Mon, 02 Sep 2019 12:34:45 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/uaccess: Don't leak the AC flags into
 __get_user() argument evaluation
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, broonie@kernel.org,
        sfr@canb.auug.org.au, akpm@linux-foundation.org, mhocko@suse.cz,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190829082445.GM2369@hirez.programming.kicks-ass.net>
References: <20190829082445.GM2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <156742768563.30370.14506895450404848829.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9b8bd476e78e89c9ea26c3b435ad0201c3d7dbf5
Gitweb:        https://git.kernel.org/tip/9b8bd476e78e89c9ea26c3b435ad0201c3d7dbf5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 29 Aug 2019 10:24:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Sep 2019 14:22:38 +02:00

x86/uaccess: Don't leak the AC flags into __get_user() argument evaluation

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
---
 arch/x86/include/asm/uaccess.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 9c44353..35c225e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -444,8 +444,10 @@ __pu_label:							\
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
