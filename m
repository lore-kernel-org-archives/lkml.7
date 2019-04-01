Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530CD208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139720;
	bh=qRDDXMXmCLL8J92yYyx2nw4ZSYO2atkuldXWYdxycSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ymkZvVYOqlkdDpTGs6QC52Yj2aRxUkBYemUOr7GJAMdkFULBvLbIdH95/PwfS/Iyp
	 IDy7Ve8uQkuQb/dvGVM3+JOpNZQCEmgXT8im4vzXG88Xb6bFjHP0x46JkSWOcpNaYW
	 816xrRV8+cxylz0GSnNcoO+cNRcTKMQwDU9tkld4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbfDAR2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbfDAR2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6AB20856;
        Mon,  1 Apr 2019 17:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139715;
        bh=qRDDXMXmCLL8J92yYyx2nw4ZSYO2atkuldXWYdxycSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2tRmrjo3b4iP99MIqYV8blCD/BN+VPdWYlW9vWUmDTEQr8vVc+cPOsN/l3Uv3wr1U
         dcZqFF0Nn0wW/G4PrSO+V7EGv4f8qasmC0JllmS7JU0xau/eO6T8XMKRvFdSL7eddw
         psI7xhgtqAU0h4ZOmNxySL2qLlOFZhZREIKCagqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Micheal Kelley <michael.h.kelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 4.9 50/56] x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y
Date:   Mon,  1 Apr 2019 19:03:06 +0200
Message-Id: <20190401170106.619699662@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit bebd024e4815b1a170fcd21ead9c2222b23ce9e6 upstream.

The SMT disable 'nosmt' command line argument is not working properly when
CONFIG_HOTPLUG_CPU is disabled. The teardown of the sibling CPUs which are
required to be brought up due to the MCE issues, cannot work. The CPUs are
then kept in a half dead state.

As the 'nosmt' functionality has become popular due to the speculative
hardware vulnerabilities, the half torn down state is not a proper solution
to the problem.

Enforce CONFIG_HOTPLUG_CPU=y when SMP is enabled so the full operation is
possible.

Reported-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Konrad Wilk <konrad.wilk@oracle.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Micheal Kelley <michael.h.kelley@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190326163811.598166056@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Kconfig |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2051,14 +2051,8 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	   If unsure, leave at the default value.
 
 config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs"
+	def_bool y
 	depends on SMP
-	---help---
-	  Say Y here to allow turning CPUs off and on. CPUs can be
-	  controlled through /sys/devices/system/cpu.
-	  ( Note: power management support will enable this option
-	    automatically on SMP systems. )
-	  Say N if you want to disable CPU hotplug.
 
 config BOOTPARAM_HOTPLUG_CPU0
 	bool "Set default setting of cpu0_hotpluggable"


