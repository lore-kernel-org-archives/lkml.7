Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97B4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D9520830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfDJUuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:50:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJUut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:50:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3AKogQv929668
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 13:50:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3AKoeJb929665;
        Wed, 10 Apr 2019 13:50:40 -0700
Date:   Wed, 10 Apr 2019 13:50:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-c02f48e070bde326f55bd94544ca82291f7396e3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@suse.de, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190405133010.24249-4-bp@alien8.de>
References: <20190405133010.24249-4-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode: Deprecate
 MICROCODE_OLD_INTERFACE
Git-Commit-ID: c02f48e070bde326f55bd94544ca82291f7396e3
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

Commit-ID:  c02f48e070bde326f55bd94544ca82291f7396e3
Gitweb:     https://git.kernel.org/tip/c02f48e070bde326f55bd94544ca82291f7396e3
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 5 Apr 2019 06:28:11 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 22:43:24 +0200

x86/microcode: Deprecate MICROCODE_OLD_INTERFACE

This is the ancient loading interface which requires special tools to be
used. The bigger problem with it is that it is as inadequate for proper
loading of microcode as the late microcode loading interface is because
it happens just as late.

iucode_tool's manpage already warns people that it is deprecated.

Deprecate it and turn it off by default along with a big fat warning in
the Kconfig help. It will go away sometime in the future.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190405133010.24249-4-bp@alien8.de
---
 arch/x86/Kconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..5a0a752f3ddd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1330,8 +1330,16 @@ config MICROCODE_AMD
 	  processors will be enabled.
 
 config MICROCODE_OLD_INTERFACE
-	def_bool y
+	bool "Ancient loading interface (DEPRECATED)"
+	default n
 	depends on MICROCODE
+	---help---
+	  DO NOT USE THIS! This is the ancient /dev/cpu/microcode interface
+	  which was used by userspace tools like iucode_tool and microcode.ctl.
+	  It is inadequate because it runs too late to be able to properly
+	  load microcode on a machine and it needs special tools. Instead, you
+	  should've switched to the early loading method with the initrd or
+	  builtin microcode by now: Documentation/x86/microcode.txt
 
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
