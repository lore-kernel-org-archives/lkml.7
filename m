Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1409C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9F9214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfGOAip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbfGOAhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C791230832E3;
        Mon, 15 Jul 2019 00:37:36 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC1AD5D9D2;
        Mon, 15 Jul 2019 00:37:35 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 08/22] x86/uaccess: Don't leak AC flag into fentry from mcsafe_handle_tail()
Date:   Sun, 14 Jul 2019 19:37:03 -0500
Message-Id: <8353611be174db8d510c890e081bb5e1133b73e3.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 15 Jul 2019 00:37:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding mcsafe_handle_tail() to the objtool uaccess safe list,
objtool reports:

  arch/x86/lib/usercopy_64.o: warning: objtool: mcsafe_handle_tail()+0x0: call to __fentry__() with UACCESS enabled

With SMAP, this function is called with AC=1, so it needs to be careful
about which functions it calls.  Disable the ftrace entry hook, which
can potentially pull in a lot of extra code.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/lib/usercopy_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index e0e006f1624e..fff28c6f73a2 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL(clear_user);
  * but reuse __memcpy_mcsafe in case a new read error is encountered.
  * clac() is handled in _copy_to_iter_mcsafe().
  */
-__visible unsigned long
+__visible notrace unsigned long
 mcsafe_handle_tail(char *to, char *from, unsigned len)
 {
 	for (; len; --len, to++, from++) {
-- 
2.20.1

