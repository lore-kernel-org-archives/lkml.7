Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4321E2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141496;
	bh=L7Kn8ME2rALrj6a5xYdGuHo51ynSRtcwWJymCie5a6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W7D9hX11lT39tG0GPhGioIIZY5bDRymsZoFK7kp0vqDsLetyAhwMJYJXpg+liT8I3
	 lNDDeuQYv3m1JG3eyncQ9baX9nzX92zM4VXyWwmQBuSH6n++7ZnXKt/bwJOwrVSBew
	 3zRF/8RB+nU9v6oTr8uZDRtACJmt4xNxTJgkRnq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfDARSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfDARSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6AF221905;
        Mon,  1 Apr 2019 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139126;
        bh=L7Kn8ME2rALrj6a5xYdGuHo51ynSRtcwWJymCie5a6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjQdsa5wdGtwGxGxQcih7YfMBju3NUPZSU+FkJevOrnmWJvRO0TfXYimRItMLOMns
         ZdP4SsV0uLreHCkiPMWF6DiDL4odJCJgv9R4xLAhEz7RKzPDt4y2/DnG4WBpSjR38V
         quG/cVu9o7ZQ5cr+yXn5swcn89kR05ZbY1VP/3i4=
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
Subject: [PATCH 4.19 122/134] x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y
Date:   Mon,  1 Apr 2019 19:02:38 +0200
Message-Id: <20190401170055.714299941@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2199,14 +2199,8 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
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


