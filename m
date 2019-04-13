Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF2EC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B291B2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfDMUz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:55:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfDMUz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:55:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKt58q2266365
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:55:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKt4NB2266361;
        Sat, 13 Apr 2019 13:55:04 -0700
Date:   Sat, 13 Apr 2019 13:55:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-577ff465f5a6a5a0866d75a033844810baca20a0@git.kernel.org>
Cc:     bp@suse.de, riel@surriel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, dave.hansen@intel.com, hpa@zytor.com,
        luto@kernel.org, Jason@zx2c4.com, pbonzini@redhat.com,
        mingo@kernel.org, rkrcmar@redhat.com, x86@kernel.org,
        kvm@vger.kernel.org, mingo@redhat.com
Reply-To: mingo@kernel.org, x86@kernel.org, rkrcmar@redhat.com,
          mingo@redhat.com, kvm@vger.kernel.org, Jason@zx2c4.com,
          pbonzini@redhat.com, linux-kernel@vger.kernel.org,
          jgross@suse.com, bigeasy@linutronix.de, tglx@linutronix.de,
          dave.hansen@intel.com, luto@kernel.org, hpa@zytor.com,
          bp@suse.de, riel@surriel.com
In-Reply-To: <20190403164156.19645-14-bigeasy@linutronix.de>
References: <20190403164156.19645-14-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Only write PKRU if it is different from
 current
Git-Commit-ID: 577ff465f5a6a5a0866d75a033844810baca20a0
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

Commit-ID:  577ff465f5a6a5a0866d75a033844810baca20a0
Gitweb:     https://git.kernel.org/tip/577ff465f5a6a5a0866d75a033844810baca20a0
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:42 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 15:41:05 +0200

x86/fpu: Only write PKRU if it is different from current

According to Dave Hansen, WRPKRU is more expensive than RDPKRU. It has
a higher cycle cost and it's also practically a (light) speculation
barrier.

As an optimisation read the current PKRU value and only write the new
one if it is different.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-14-bigeasy@linutronix.de
---
 arch/x86/include/asm/special_insns.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 34897e2b52c9..0a3c4cab39db 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -121,6 +121,13 @@ static inline void wrpkru(u32 pkru)
 
 static inline void __write_pkru(u32 pkru)
 {
+	/*
+	 * WRPKRU is relatively expensive compared to RDPKRU.
+	 * Avoid WRPKRU when it would not change the value.
+	 */
+	if (pkru == rdpkru())
+		return;
+
 	wrpkru(pkru);
 }
 
