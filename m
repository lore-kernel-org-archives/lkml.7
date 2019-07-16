Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF7CC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CF92173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iKJNL3NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbfGPVUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:20:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGPVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:20:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GLKcLO1229733
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 14:20:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GLKcLO1229733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563312039;
        bh=vGFXtmsP96Gp2XLk/C5tCjr464wpsFxgLhrJRdalNSc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iKJNL3NIXFxICOJjE7dzGUnmRklfDkUY7RVu9a7eOYy0VJTl29VemxK41miogIyRx
         u1NikscqR+6lgrtx/1bIE4qf9mn/f+TJZEbRzBgoSOTRbIvTWWMKdolXKRoguhcB+5
         FnRnQ9/e0NQpI8J3h2U1QCdaQZOLxEzCh3+WIPL00bCIF2PNTxUWKPrQetc9fMghDM
         vHjBs5YlXOvjJwsC9e+nBiUAgFfMiEcaL9kTLT/eXs4XddaKkFlSwf/UCk8xcOV/Uj
         qSqD4Dcqa92/mbG+uu3sdKO9+dEnggp3rINisnaaKj+5jdrgq1XEHOMcc6bkv0tREN
         aJk3epjM4SIoQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GLKcKV1229730;
        Tue, 16 Jul 2019 14:20:38 -0700
Date:   Tue, 16 Jul 2019 14:20:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-ec6335586953b0df32f83ef696002063090c7aef@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, cai@lca.pw, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, cai@lca.pw
In-Reply-To: <1562621805-24789-1-git-send-email-cai@lca.pw>
References: <1562621805-24789-1-git-send-email-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic: Silence -Wtype-limits compiler warnings
Git-Commit-ID: ec6335586953b0df32f83ef696002063090c7aef
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

Commit-ID:  ec6335586953b0df32f83ef696002063090c7aef
Gitweb:     https://git.kernel.org/tip/ec6335586953b0df32f83ef696002063090c7aef
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Mon, 8 Jul 2019 17:36:45 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 16 Jul 2019 23:13:48 +0200

x86/apic: Silence -Wtype-limits compiler warnings

There are many compiler warnings like this,

In file included from ./arch/x86/include/asm/smp.h:13,
                 from ./arch/x86/include/asm/mmzone_64.h:11,
                 from ./arch/x86/include/asm/mmzone.h:5,
                 from ./include/linux/mmzone.h:969,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from arch/x86/kernel/apic/io_apic.c:34:
arch/x86/kernel/apic/io_apic.c: In function 'check_timer':
./arch/x86/include/asm/apic.h:37:11: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]
   if ((v) <= apic_verbosity) \
           ^~
arch/x86/kernel/apic/io_apic.c:2160:2: note: in expansion of macro
'apic_printk'
  apic_printk(APIC_QUIET, KERN_INFO "..TIMER: vector=0x%02X "
  ^~~~~~~~~~~
./arch/x86/include/asm/apic.h:37:11: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]
   if ((v) <= apic_verbosity) \
           ^~
arch/x86/kernel/apic/io_apic.c:2207:4: note: in expansion of macro
'apic_printk'
    apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
    ^~~~~~~~~~~

APIC_QUIET is 0, so silence them by making apic_verbosity type int.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1562621805-24789-1-git-send-email-cai@lca.pw

---
 arch/x86/include/asm/apic.h | 2 +-
 arch/x86/kernel/apic/apic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 050e5f9ebf81..e647aa095867 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -49,7 +49,7 @@ static inline void generic_apic_probe(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-extern unsigned int apic_verbosity;
+extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern int disable_apic;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 1bd91cb7b320..f5291362da1a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -183,7 +183,7 @@ EXPORT_SYMBOL_GPL(local_apic_timer_c2_ok);
 /*
  * Debug level, exported for io_apic.c
  */
-unsigned int apic_verbosity;
+int apic_verbosity;
 
 int pic_mode;
 
