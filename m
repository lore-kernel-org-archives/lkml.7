Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DCCC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2D6214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353767;
	bh=NBNBvP45RE2ewafMBBNQHhDvHIX7XZ6vY2f8zsAHmcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IFqkUFGfyn1rnoTW89Ud/pKnp4nNndUPDruMfFVoKzcxKpLO6/PEc6HlNYChJjcQI
	 ScYrVePxHFTPkbRajLKB3m7jipsiOeAy+lgTIEmSGlI8X3Gcg7AycgaJylYAa+irN6
	 Q3j4/xxBoKkPQImh/tyP0KFSGMaQSxI0dBe57iUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfKJCmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfKJCmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:42:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD06621848;
        Sun, 10 Nov 2019 02:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353762;
        bh=NBNBvP45RE2ewafMBBNQHhDvHIX7XZ6vY2f8zsAHmcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCjQ2fOqYtN3eTmBl+n8EyzaMWt4uH1y4dlLFwFYCR/eLZsWMPessgxWnhI7+OW7s
         iSgBuONtecP/LVh5kixyWRSTPIW+PhhsJr7lAPkPHFF/KJvd1SEerB81uh2vEgB19d
         blYlD3h3JIpZrOy2j7rgMBstll0SbZ28jk2ObUQE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 074/191] x86/mce-inject: Reset injection struct after injection
Date:   Sat,  9 Nov 2019 21:38:16 -0500
Message-Id: <20191110024013.29782-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit 7401a633c34adc7aefd3edfec60074cb0475a3e8 ]

Clear the MCE struct which is used for collecting the injection details
after injection.

Also, populate it with more details from the machine.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20180905081954.10391-1-bp@alien8.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce-inject.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index ff1c00b695aed..1ceccc4a5472c 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -106,6 +106,9 @@ static void setup_inj_struct(struct mce *m)
 	memset(m, 0, sizeof(struct mce));
 
 	m->cpuvendor = boot_cpu_data.x86_vendor;
+	m->time	     = ktime_get_real_seconds();
+	m->cpuid     = cpuid_eax(1);
+	m->microcode = boot_cpu_data.microcode;
 }
 
 /* Update fake mce registers on current CPU. */
@@ -580,6 +583,9 @@ static int inj_bank_set(void *data, u64 val)
 	m->bank = val;
 	do_inject();
 
+	/* Reset injection struct */
+	setup_inj_struct(&i_mce);
+
 	return 0;
 }
 
-- 
2.20.1

