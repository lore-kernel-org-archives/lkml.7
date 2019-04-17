Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD05C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8440B2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Uo99+FLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfDQOGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:06:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36895 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfDQOGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:06:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE60SV3932994
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:06:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE60SV3932994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555509961;
        bh=qoshsAZLNH4gKnGwx9bBAKf4J+PoLXsrjIUxCuGfzjo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Uo99+FLdSGWu6d1suhUDkjPFG3shuQCaOnGmW656/9pXnVKj7OEhiQQ+D0PMM+d4s
         Ydh2qUksOZtuhm9GlSZjK861ZSqjy9fitOKN729mLJ0CiyUIYq5E9D1/bvI2I44MXw
         eroLodVbxKSQRi9jkfKIBP1yc1Bn2h5ubfcE94QBiRVTvfEXSuG8NvDxOD5AiiIW4n
         c7+/i/AeBNwgx1pLUGS2C3yy/4gZZRXovcTo3f5B2F86ulfcGaGqbd7rYTRTmpnIf0
         lVAA/8+txXZeaY7j/2Y9kDDefS3TmozqG3GojEKbTHQ7mOgNVa1iopg+JRM6MDU/Z2
         tCrdMc6WmGOEA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE60oW3932991;
        Wed, 17 Apr 2019 07:06:00 -0700
Date:   Wed, 17 Apr 2019 07:06:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6f36bd8d2e8c221eaaf4ce5b0ebbb11c00b0ac98@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, jpoimboe@redhat.com, cai@lca.pw,
        kirill.shutemov@linux.intel.com, mingo@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        bhe@redhat.com, sean.j.christopherson@intel.com, luto@kernel.org,
        tglx@linutronix.de
Reply-To: jpoimboe@redhat.com, cai@lca.pw, mingo@kernel.org,
          kirill.shutemov@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
          bp@suse.de, sean.j.christopherson@intel.com, bhe@redhat.com,
          tglx@linutronix.de, luto@kernel.org,
          linux-kernel@vger.kernel.org, x86@kernel.org
In-Reply-To: <20190414160144.139284839@linutronix.de>
References: <20190414160144.139284839@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/64: Remove stale CURRENT_MASK
Git-Commit-ID: 6f36bd8d2e8c221eaaf4ce5b0ebbb11c00b0ac98
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6f36bd8d2e8c221eaaf4ce5b0ebbb11c00b0ac98
Gitweb:     https://git.kernel.org/tip/6f36bd8d2e8c221eaaf4ce5b0ebbb11c00b0ac98
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:43 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:38:36 +0200

x86/64: Remove stale CURRENT_MASK

Nothing uses that and before people get the wrong ideas, get rid of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.139284839@linutronix.de
---
 arch/x86/include/asm/page_64_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 8f657286d599..bcd8c0518604 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -14,7 +14,6 @@
 
 #define THREAD_SIZE_ORDER	(2 + KASAN_STACK_ORDER)
 #define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
-#define CURRENT_MASK (~(THREAD_SIZE - 1))
 
 #define EXCEPTION_STACK_ORDER (0 + KASAN_STACK_ORDER)
 #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
