Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A156C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7F9208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jMoOlj3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfF0WRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:17:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0WRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:17:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RMGj8G472980
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 15:16:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RMGj8G472980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561673805;
        bh=VFPlr7z446ew55w9RrWZ1FYQcMz8mUVYmeBMeGKrGqU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=jMoOlj3q2n+hhV4eg4/pdyrOT3L/z8e4WkCmbilmkMfnmUQIWyx2iEQZjeiMYgqa2
         JHcRJ4lkb4/hZXmot+S4eNqIXlrUPIlz53sNEBoMPINvQjvirSOyAvVLgnn265vZcb
         OQ/PTtB3fyV7GSASxVOp3UgU1LA6KfDyRe4VB8TlEHhQasyKIg37knQdCK2313lx/n
         5ST9TjuqvOzMoizFacGQdAGsW7/9u/aYiUbvt3GMBiV17S342h3AaKcUt3VN867dDV
         scRgkAwEhx8xNDxll4a9j2xW4atcEePI8Ys1AhJnJVpWEAM7Kid7K4BfjDq/cWZdij
         ZQShZzNAKF1kA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RMGihe472971;
        Thu, 27 Jun 2019 15:16:44 -0700
Date:   Thu, 27 Jun 2019 15:16:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-625b7b7f79c66626fb2b7687fc1a58309a57edd5@git.kernel.org>
Cc:     hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, bp@alien8.de, fweimer@redhat.com,
        kernel-hardening@lists.openwall.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jannh@google.com
Reply-To: jannh@google.com, bp@alien8.de, keescook@chromium.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, kernel-hardening@lists.openwall.com,
          fweimer@redhat.com, peterz@infradead.org, hpa@zytor.com,
          luto@kernel.org
In-Reply-To: <30539f8072d2376b9c9efcc07e6ed0d6bf20e882.1561610354.git.luto@kernel.org>
References: <30539f8072d2376b9c9efcc07e6ed0d6bf20e882.1561610354.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/vsyscall: Change the default vsyscall mode to
 xonly
Git-Commit-ID: 625b7b7f79c66626fb2b7687fc1a58309a57edd5
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

Commit-ID:  625b7b7f79c66626fb2b7687fc1a58309a57edd5
Gitweb:     https://git.kernel.org/tip/625b7b7f79c66626fb2b7687fc1a58309a57edd5
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 26 Jun 2019 21:45:07 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:04:39 +0200

x86/vsyscall: Change the default vsyscall mode to xonly

The use case for full emulation over xonly is very esoteric, e.g. magic
instrumentation tools.

Change the default to the safer xonly mode.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/30539f8072d2376b9c9efcc07e6ed0d6bf20e882.1561610354.git.luto@kernel.org

---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0182d2c67590..32028edc1b0e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2285,7 +2285,7 @@ config COMPAT_VDSO
 choice
 	prompt "vsyscall table for legacy applications"
 	depends on X86_64
-	default LEGACY_VSYSCALL_EMULATE
+	default LEGACY_VSYSCALL_XONLY
 	help
 	  Legacy user code that does not know how to find the vDSO expects
 	  to be able to issue three syscalls by calling fixed addresses in
