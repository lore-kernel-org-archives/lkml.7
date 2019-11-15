Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181ACC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EA72073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798894;
	bh=ut1+Z4T/5Z9rTbpmjFLA5dA/iRmev3xPMcs834dkk6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XW6E0JnQMr6hFrg08+U4qb+RUzheJpVJialRBzoX2tg260R5Or+glz9zyQ2cltV8E
	 59cx3dV2qyYP8398vectpbIRe4wo7Sv5RJ6xpXFDT/993AXvlxIEhFhb16etcqMKy0
	 yrSCz6+CflvY8KUoSRghYZPUlBzQ6g3mYPQkqxds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKOGVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfKOGV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:21:29 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEED720740;
        Fri, 15 Nov 2019 06:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798888;
        bh=ut1+Z4T/5Z9rTbpmjFLA5dA/iRmev3xPMcs834dkk6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2BmpeJZvV/M1O7pzz0tXGI3PEY5WYFIYCF1r7Uk+n9EzSJtosoFY3gnDK7dhU0bz
         fWG98Tn2F4vdEuWKA7KX4eMGpIB61gB8Zf6Qn0kXN7mFdeZLt03zu1TGl8tbhnfsR4
         SVpiQnKroyBc3kMZytNTumucNSUKjcVbVZNCx7aw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bpetkov@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 18/20] x86/tsx: Add config options to set tsx=on|off|auto
Date:   Fri, 15 Nov 2019 14:20:47 +0800
Message-Id: <20191115062015.179463426@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062006.854443935@linuxfoundation.org>
References: <20191115062006.854443935@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

commit db616173d787395787ecc93eef075fa975227b10 upstream.

There is a general consensus that TSX usage is not largely spread while
the history shows there is a non trivial space for side channel attacks
possible. Therefore the tsx is disabled by default even on platforms
that might have a safe implementation of TSX according to the current
knowledge. This is a fair trade off to make.

There are, however, workloads that really do benefit from using TSX and
updating to a newer kernel with TSX disabled might introduce a
noticeable regressions. This would be especially a problem for Linux
distributions which will provide TAA mitigations.

Introduce config options X86_INTEL_TSX_MODE_OFF, X86_INTEL_TSX_MODE_ON
and X86_INTEL_TSX_MODE_AUTO to control the TSX feature. The config
setting can be overridden by the tsx cmdline options.

 [ bp: Text cleanups from Josh. ]

Suggested-by: Borislav Petkov <bpetkov@suse.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
[bwh: Backported to 4.4: adjust doc filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Kconfig          |   45 +++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/tsx.c |   22 ++++++++++++++++------
 2 files changed, 61 insertions(+), 6 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1695,6 +1695,51 @@ config X86_INTEL_MPX
 
 	  If unsure, say N.
 
+choice
+	prompt "TSX enable mode"
+	depends on CPU_SUP_INTEL
+	default X86_INTEL_TSX_MODE_OFF
+	help
+	  Intel's TSX (Transactional Synchronization Extensions) feature
+	  allows to optimize locking protocols through lock elision which
+	  can lead to a noticeable performance boost.
+
+	  On the other hand it has been shown that TSX can be exploited
+	  to form side channel attacks (e.g. TAA) and chances are there
+	  will be more of those attacks discovered in the future.
+
+	  Therefore TSX is not enabled by default (aka tsx=off). An admin
+	  might override this decision by tsx=on the command line parameter.
+	  Even with TSX enabled, the kernel will attempt to enable the best
+	  possible TAA mitigation setting depending on the microcode available
+	  for the particular machine.
+
+	  This option allows to set the default tsx mode between tsx=on, =off
+	  and =auto. See Documentation/kernel-parameters.txt for more
+	  details.
+
+	  Say off if not sure, auto if TSX is in use but it should be used on safe
+	  platforms or on if TSX is in use and the security aspect of tsx is not
+	  relevant.
+
+config X86_INTEL_TSX_MODE_OFF
+	bool "off"
+	help
+	  TSX is disabled if possible - equals to tsx=off command line parameter.
+
+config X86_INTEL_TSX_MODE_ON
+	bool "on"
+	help
+	  TSX is always enabled on TSX capable HW - equals the tsx=on command
+	  line parameter.
+
+config X86_INTEL_TSX_MODE_AUTO
+	bool "auto"
+	help
+	  TSX is enabled on TSX capable HW that is believed to be safe against
+	  side channel attacks- equals the tsx=auto command line parameter.
+endchoice
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -73,6 +73,14 @@ static bool __init tsx_ctrl_is_supported
 	return !!(ia32_cap & ARCH_CAP_TSX_CTRL_MSR);
 }
 
+static enum tsx_ctrl_states x86_get_tsx_auto_mode(void)
+{
+	if (boot_cpu_has_bug(X86_BUG_TAA))
+		return TSX_CTRL_DISABLE;
+
+	return TSX_CTRL_ENABLE;
+}
+
 void __init tsx_init(void)
 {
 	char arg[5] = {};
@@ -88,17 +96,19 @@ void __init tsx_init(void)
 		} else if (!strcmp(arg, "off")) {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
 		} else if (!strcmp(arg, "auto")) {
-			if (boot_cpu_has_bug(X86_BUG_TAA))
-				tsx_ctrl_state = TSX_CTRL_DISABLE;
-			else
-				tsx_ctrl_state = TSX_CTRL_ENABLE;
+			tsx_ctrl_state = x86_get_tsx_auto_mode();
 		} else {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
 			pr_err("tsx: invalid option, defaulting to off\n");
 		}
 	} else {
-		/* tsx= not provided, defaulting to off */
-		tsx_ctrl_state = TSX_CTRL_DISABLE;
+		/* tsx= not provided */
+		if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO))
+			tsx_ctrl_state = x86_get_tsx_auto_mode();
+		else if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF))
+			tsx_ctrl_state = TSX_CTRL_DISABLE;
+		else
+			tsx_ctrl_state = TSX_CTRL_ENABLE;
 	}
 
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE) {


