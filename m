Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C399C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D7F21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613417;
	bh=d/hVih3hULDbHZ5rGWhVY9LL8fwt2SWTxV6oJ2ouMKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YEJaNdJBktBllsLh/i9tclXkyL9NeoMAXmRuEGRjyiuJNQUJJlGkW/0YPvrIvEAB3
	 W8skiwbrgGr0BorCRuox/gLFZlWze6KXzsOsGRcVKFQmVGKypuGpuGQfh5F9pPph/v
	 l5ZKw8oorbxZGn/QLd0XPjhElnHqohrzOH4sfgqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfIDQKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbfIDQBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:01:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8316F22CF7;
        Wed,  4 Sep 2019 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612859;
        bh=d/hVih3hULDbHZ5rGWhVY9LL8fwt2SWTxV6oJ2ouMKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RY1fz6n8tgi79/ZxNqcXoBXZ6T+HNkNIuD/KwfY4ZsD0ajiVpSu1Pasoi0Pwrleu8
         lcemus1bPw9syqX0Z+ohBWecWGskMQxKIr3M9Ky2U9nG8jfrKru9Tm+s10Ea2qOqky
         Xez79ADKTKwBwGDgH/ABYlRcDUG+evko7zVlkYeY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 38/52] x86/build: Add -Wnoaddress-of-packed-member to REALMODE_CFLAGS, to silence GCC9 build warning
Date:   Wed,  4 Sep 2019 11:59:50 -0400
Message-Id: <20190904160004.3671-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160004.3671-1-sashal@kernel.org>
References: <20190904160004.3671-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 42e0e95474fc6076b5cd68cab8fa0340a1797a72 ]

One of the very few warnings I have in the current build comes from
arch/x86/boot/edd.c, where I get the following with a gcc9 build:

   arch/x86/boot/edd.c: In function ‘query_edd’:
   arch/x86/boot/edd.c:148:11: warning: taking address of packed member of ‘struct boot_params’ may result in an unaligned pointer value [-Waddress-of-packed-member]
     148 |  mbrptr = boot_params.edd_mbr_sig_buffer;
         |           ^~~~~~~~~~~

This warning triggers because we throw away all the CFLAGS and then make
a new set for REALMODE_CFLAGS, so the -Wno-address-of-packed-member we
added in the following commit is not present:

  6f303d60534c ("gcc-9: silence 'address-of-packed-member' warning")

The simplest solution for now is to adjust the warning for this version
of CFLAGS as well, but it would definitely make sense to examine whether
REALMODE_CFLAGS could be derived from CFLAGS, so that it picks up changes
in the compiler flags environment automatically.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index ce0d0424a53d6..4833dd7e2cc03 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -38,6 +38,7 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
 export REALMODE_CFLAGS
 
-- 
2.20.1

