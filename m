Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDB3C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CB720868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfGOAia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:38:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfGOAhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04FCC3082B07;
        Mon, 15 Jul 2019 00:37:41 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECEFE5D968;
        Mon, 15 Jul 2019 00:37:39 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 11/22] objtool: Add mcsafe_handle_tail() to the uaccess safe list
Date:   Sun, 14 Jul 2019 19:37:06 -0500
Message-Id: <b8639b62fc0658e1daabc82b3f9d3fc6b112397c.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 15 Jul 2019 00:37:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an objtool improvement, it's reporting that __memcpy_mcsafe() is
calling mcsafe_handle_tail() with AC=1:

  arch/x86/lib/memcpy_64.o: warning: objtool: .fixup+0x13: call to mcsafe_handle_tail() with UACCESS enabled
  arch/x86/lib/memcpy_64.o: warning: objtool:   __memcpy_mcsafe()+0x34: (alt)
  arch/x86/lib/memcpy_64.o: warning: objtool:   __memcpy_mcsafe()+0xb: (branch)
  arch/x86/lib/memcpy_64.o: warning: objtool:   __memcpy_mcsafe()+0x0: <=== (func)

mcsafe_handle_tail() is basically an extension of __memcpy_mcsafe(), so
AC=1 is supposed to be set.  Add mcsafe_handle_tail() to the uaccess
safe list.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 27818a93f0b1..fd8827114c74 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -490,6 +490,7 @@ static const char *uaccess_safe_builtin[] = {
 	/* misc */
 	"csum_partial_copy_generic",
 	"__memcpy_mcsafe",
+	"mcsafe_handle_tail",
 	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
 	NULL
 };
-- 
2.20.1

