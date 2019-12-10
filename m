Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382ABC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017355;
	bh=iWr8FhlVMl2xbZR/aLjzGNvGy6OCfZbeoGEI9tL1hcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zzf49efBS+g++T3Wyoh+4iOr286ZdIKMZayW6K5ZAyKpeLHabw/FKZJ1mQox+T3/2
	 7FA7j643U8qSMONb/1jfFlCmbBrQ/50DVbpqTNpuS/LL7AjE2Zdk0uWv1Blvi3XANw
	 1M7w7UzMKIsHAv1glsQgBQ6UA2+O0rPsYpDGV3Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfLJWfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbfLJWe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:34:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8208E2465B;
        Tue, 10 Dec 2019 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017268;
        bh=iWr8FhlVMl2xbZR/aLjzGNvGy6OCfZbeoGEI9tL1hcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMAQjC5z6eHI3W2sPJsOUPLwynB5Tf5zvNUGYUOrKDJFScP8eWuXQYKvER709nUTV
         jZYZLCkDsQ2NWJHcYm83H0HeLch3UtY4E3m8TZSQYsb6ZxKENozSPWGhnpXUopXJuW
         a1ZpR0hV+j/Y1ey+qqLdNUUyhoHqePBPT/yAAM0Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lianbo Jiang <lijiang@redhat.com>,
        kbuild test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>, bhe@redhat.com,
        d.hatayama@fujitsu.com, dhowells@redhat.com, dyoung@redhat.com,
        ebiederm@xmission.com, horms@verge.net.au,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?J=C3=BCrgen=20Gross?= <jgross@suse.com>,
        kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, vgoyal@redhat.com,
        x86-ml <x86@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 60/71] x86/crash: Add a forward declaration of struct kimage
Date:   Tue, 10 Dec 2019 17:33:05 -0500
Message-Id: <20191210223316.14988-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223316.14988-1-sashal@kernel.org>
References: <20191210223316.14988-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lianbo Jiang <lijiang@redhat.com>

[ Upstream commit 112eee5d06007dae561f14458bde7f2a4879ef4e ]

Add a forward declaration of struct kimage to the crash.h header because
future changes will invoke a crash-specific function from the realmode
init path and the compiler will complain otherwise like this:

  In file included from arch/x86/realmode/init.c:11:
  ./arch/x86/include/asm/crash.h:5:32: warning: ‘struct kimage’ declared inside\
   parameter list will not be visible outside of this definition or declaration
      5 | int crash_load_segments(struct kimage *image);
        |                                ^~~~~~
  ./arch/x86/include/asm/crash.h:6:37: warning: ‘struct kimage’ declared inside\
   parameter list will not be visible outside of this definition or declaration
      6 | int crash_copy_backup_region(struct kimage *image);
        |                                     ^~~~~~
  ./arch/x86/include/asm/crash.h:7:39: warning: ‘struct kimage’ declared inside\
   parameter list will not be visible outside of this definition or declaration
      7 | int crash_setup_memmap_entries(struct kimage *image,
        |

 [ bp: Rewrite the commit message. ]

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bhe@redhat.com
Cc: d.hatayama@fujitsu.com
Cc: dhowells@redhat.com
Cc: dyoung@redhat.com
Cc: ebiederm@xmission.com
Cc: horms@verge.net.au
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jürgen Gross <jgross@suse.com>
Cc: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: vgoyal@redhat.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191108090027.11082-4-lijiang@redhat.com
Link: https://lkml.kernel.org/r/201910310233.EJRtTMWP%25lkp@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/crash.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index f498411f2500b..1b15304dd0980 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_CRASH_H
 #define _ASM_X86_CRASH_H
 
+struct kimage;
+
 int crash_load_segments(struct kimage *image);
 int crash_copy_backup_region(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
-- 
2.20.1

