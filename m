Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B16EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364B420820
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404049AbfHHKkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:40:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:47480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403783AbfHHKjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 031CBAFBA;
        Thu,  8 Aug 2019 10:39:02 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 08/28] x86/uaccess: annotate local function
Date:   Thu,  8 Aug 2019 12:38:34 +0200
Message-Id: <20190808103854.6192-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_user_handle_tail is a self-standing local function, annotate it as
such using SYM_FUNC_START_LOCAL.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/lib/copy_user_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 4fe1601dbc5d..d163c9566abe 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -230,8 +230,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-ALIGN;
-copy_user_handle_tail:
+SYM_CODE_START_LOCAL(copy_user_handle_tail)
 	movl %edx,%ecx
 1:	rep movsb
 2:	mov %ecx,%eax
@@ -239,7 +238,7 @@ copy_user_handle_tail:
 	ret
 
 	_ASM_EXTABLE_UA(1b, 2b)
-END(copy_user_handle_tail)
+SYM_CODE_END(copy_user_handle_tail)
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
-- 
2.22.0

