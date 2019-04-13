Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82FBC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99802084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfDMU5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:57:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfDMU5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:57:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKtlh22266455
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:55:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKtkdu2266452;
        Sat, 13 Apr 2019 13:55:46 -0700
Date:   Sat, 13 Apr 2019 13:55:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-0556cbdc2fbcb3068e5b924a8b3d5386ae0dd27d@git.kernel.org>
Cc:     riel@surriel.com, bigeasy@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, rkrcmar@redhat.com,
        luto@kernel.org, dave.hansen@intel.com, x86@kernel.org,
        mingo@redhat.com, kvm@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, Jason@zx2c4.com, bp@suse.de, pbonzini@redhat.com
Reply-To: x86@kernel.org, mingo@redhat.com, kvm@vger.kernel.org,
          tglx@linutronix.de, Jason@zx2c4.com, bp@suse.de,
          mingo@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, riel@surriel.com,
          bigeasy@linutronix.de, hpa@zytor.com, rkrcmar@redhat.com,
          dave.hansen@intel.com, luto@kernel.org
In-Reply-To: <20190403164156.19645-15-bigeasy@linutronix.de>
References: <20190403164156.19645-15-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/pkeys: Don't check if PKRU is zero before writing
 it
Git-Commit-ID: 0556cbdc2fbcb3068e5b924a8b3d5386ae0dd27d
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

Commit-ID:  0556cbdc2fbcb3068e5b924a8b3d5386ae0dd27d
Gitweb:     https://git.kernel.org/tip/0556cbdc2fbcb3068e5b924a8b3d5386ae0dd27d
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:43 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 15:41:05 +0200

x86/pkeys: Don't check if PKRU is zero before writing it

write_pkru() checks if the current value is the same as the expected
value. So instead of just checking if the current and new value is zero
(and skip the write in such a case) we can benefit from that.

Remove the zero check of PKRU, __write_pkru() provides such a check now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-15-bigeasy@linutronix.de
---
 arch/x86/mm/pkeys.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 05bb9a44eb1c..50f65fc1b9a3 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -142,13 +142,6 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
 void copy_init_pkru_to_fpregs(void)
 {
 	u32 init_pkru_value_snapshot = READ_ONCE(init_pkru_value);
-	/*
-	 * Any write to PKRU takes it out of the XSAVE 'init
-	 * state' which increases context switch cost.  Avoid
-	 * writing 0 when PKRU was already 0.
-	 */
-	if (!init_pkru_value_snapshot && !read_pkru())
-		return;
 	/*
 	 * Override the PKRU state that came from 'init_fpstate'
 	 * with the baseline from the process.
