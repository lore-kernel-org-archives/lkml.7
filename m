Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B71721773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="wy5dIWn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfDQUDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:03:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:03:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HK2lgt4055733
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 13:02:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HK2lgt4055733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555531369;
        bh=g7lc63TjSl1sl8n9flTds5NVjZx74nLGvYK482qxHd8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wy5dIWn7kQpH5/yAqEwR9h9gEb4ZMP3czipE5k6hlIuStXbAv9lm6pyKm27xl3Opt
         euDs9FZoCdOckeTIPpmRCHIJ3ioaolVt6gSt0epIhfrfBUX/qfxzHNlbzNNhrq1SqI
         vyzxnag2iaXsZxl5hEnWEyWwWV/JyuhCu2ibfR0UJA4PmjofSteUUtx/L6gXP/dmh5
         Zsz6FowFsBm0TpClNJZjbdv+M6sWGP2gdWiU7zxdnnH8q3s/sRIFlcSo/R/IqLxTiD
         kgmixxxaX9tsmycJ5cxoenkV6YfRKyy7ktBCIYfU02cuDVoVmheyPCpbQ8HH0UlXaf
         4pHDzW4ngjl9A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HK2lkb4055730;
        Wed, 17 Apr 2019 13:02:47 -0700
Date:   Wed, 17 Apr 2019 13:02:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-782e69efb3dfed6e8360bc612e8c7827a901a8f9@git.kernel.org>
Cc:     rdunlap@infradead.org, mingo@kernel.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        longman@redhat.com, jpoimboe@redhat.com, heiko.carstens@de.ibm.com,
        benh@kernel.crashing.org, tglx@linutronix.de, jikos@kernel.org,
        will.deacon@arm.com, torvalds@linux-foundation.org,
        aarcange@redhat.com, mpe@ellerman.id.au,
        gregkh@linuxfoundation.org, luto@kernel.org, peterz@infradead.org,
        pauld@redhat.com, jkosina@suse.cz, paulus@samba.org,
        steven.price@arm.com, catalin.marinas@arm.com,
        tyhicks@canonical.com, hpa@zytor.com, jcm@redhat.com
Reply-To: mingo@kernel.org, rdunlap@infradead.org, schwidefsky@de.ibm.com,
          linux-kernel@vger.kernel.org, bp@alien8.de, longman@redhat.com,
          benh@kernel.crashing.org, heiko.carstens@de.ibm.com,
          jpoimboe@redhat.com, torvalds@linux-foundation.org,
          mpe@ellerman.id.au, aarcange@redhat.com, jikos@kernel.org,
          will.deacon@arm.com, tglx@linutronix.de, pauld@redhat.com,
          peterz@infradead.org, gregkh@linuxfoundation.org,
          luto@kernel.org, tyhicks@canonical.com, hpa@zytor.com,
          steven.price@arm.com, catalin.marinas@arm.com, paulus@samba.org,
          jkosina@suse.cz, jcm@redhat.com
In-Reply-To: <245a606e1a42a558a310220312d9b6adb9159df6.1555085500.git.jpoimboe@redhat.com>
References: <245a606e1a42a558a310220312d9b6adb9159df6.1555085500.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/speculation] powerpc/speculation: Support 'mitigations='
 cmdline option
Git-Commit-ID: 782e69efb3dfed6e8360bc612e8c7827a901a8f9
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

Commit-ID:  782e69efb3dfed6e8360bc612e8c7827a901a8f9
Gitweb:     https://git.kernel.org/tip/782e69efb3dfed6e8360bc612e8c7827a901a8f9
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Fri, 12 Apr 2019 15:39:30 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Apr 2019 21:37:29 +0200

powerpc/speculation: Support 'mitigations=' cmdline option

Configure powerpc CPU runtime speculation bug mitigations in accordance
with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
v1, Spectre v2, and Speculative Store Bypass.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz> (on x86)
Reviewed-by: Jiri Kosina <jkosina@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/245a606e1a42a558a310220312d9b6adb9159df6.1555085500.git.jpoimboe@redhat.com

---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
 arch/powerpc/kernel/security.c                  | 6 +++---
 arch/powerpc/kernel/setup_64.c                  | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 779ddeb2929c..ac7150a25a7a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2514,7 +2514,7 @@
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
-			[X86] Control optional mitigations for CPU
+			[X86,PPC] Control optional mitigations for CPU
 			vulnerabilities.  This is a set of curated,
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
@@ -2523,10 +2523,11 @@
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
 				expose users to several CPU vulnerabilities.
-				Equivalent to: nopti [X86]
-					       nospectre_v2 [X86]
+				Equivalent to: nopti [X86,PPC]
+					       nospectre_v1 [PPC]
+					       nospectre_v2 [X86,PPC]
 					       spectre_v2_user=off [X86]
-					       spec_store_bypass_disable=off [X86]
+					       spec_store_bypass_disable=off [X86,PPC]
 					       l1tf=off [X86]
 
 			auto (default)
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 9b8631533e02..cdf3e73000e9 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -57,7 +57,7 @@ void setup_barrier_nospec(void)
 	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
 		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
 
-	if (!no_nospec)
+	if (!no_nospec && !cpu_mitigations_off())
 		enable_barrier_nospec(enable);
 }
 
@@ -116,7 +116,7 @@ static int __init handle_nospectre_v2(char *p)
 early_param("nospectre_v2", handle_nospectre_v2);
 void setup_spectre_v2(void)
 {
-	if (no_spectrev2)
+	if (no_spectrev2 || cpu_mitigations_off())
 		do_btb_flush_fixups();
 	else
 		btb_flush_enabled = true;
@@ -307,7 +307,7 @@ void setup_stf_barrier(void)
 
 	stf_enabled_flush_types = type;
 
-	if (!no_stf_barrier)
+	if (!no_stf_barrier && !cpu_mitigations_off())
 		stf_barrier_enable(enable);
 }
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 236c1151a3a7..c7ec27ba8926 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -958,7 +958,7 @@ void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 
 	enabled_flush_types = types;
 
-	if (!no_rfi_flush)
+	if (!no_rfi_flush && !cpu_mitigations_off())
 		rfi_flush_enable(enable);
 }
 
