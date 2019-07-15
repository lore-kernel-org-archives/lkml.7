Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258C3C742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06230214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfGOAhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbfGOAhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 900015AFD9;
        Mon, 15 Jul 2019 00:37:35 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 876D45D9D2;
        Mon, 15 Jul 2019 00:37:34 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 07/22] x86/uaccess: Remove ELF function annotation from copy_user_handle_tail()
Date:   Sun, 14 Jul 2019 19:37:02 -0500
Message-Id: <6166ec9ce99e5af2721793eaf4a769aaa881e14d.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 15 Jul 2019 00:37:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an objtool improvement, it's complaining about the CLAC in
copy_user_handle_tail():

  arch/x86/lib/copy_user_64.o: warning: objtool: .altinstr_replacement+0x12: redundant UACCESS disable
  arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x6: (alt)
  arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x2: (alt)
  arch/x86/lib/copy_user_64.o: warning: objtool:   copy_user_handle_tail()+0x0: <=== (func)

copy_user_handle_tail() is incorrectly marked as a callable function, so
objtool is rightfully concerned about the CLAC with no corresponding
STAC.

Remove the ELF function annotation.  The copy_user_handle_tail() code
path is already verified by objtool because it's jumped to by other
callable asm code (which does the corresponding STAC).

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/lib/copy_user_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 378a1f70ae7d..4fe1601dbc5d 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -239,7 +239,7 @@ copy_user_handle_tail:
 	ret
 
 	_ASM_EXTABLE_UA(1b, 2b)
-ENDPROC(copy_user_handle_tail)
+END(copy_user_handle_tail)
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
-- 
2.20.1

