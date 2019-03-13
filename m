Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490ADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6882177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZJczzNFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfCMLA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:00:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41580 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfCMLA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:00:29 -0400
Received: from zn.tnic (p200300EC2F09800068B14EF7B7C84BA6.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:68b1:4ef7:b7c8:4ba6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E11661EC0573;
        Wed, 13 Mar 2019 12:00:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1552474828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=pYgHrcc/lia8xpfDfbtWZI/alqlHBq3NPU+RjoRkxh8=;
        b=ZJczzNFL2j+o8WfL/V+7u+yvvyVvX1XWWT/dtXi7Wk2k8NSnjLrTVCbUmnglSgO63e3hAR
        t2O9yxPEll7hpgAgc4ny6Z/55gowRx+BawlbD0WbXQRgQr0GI5x+jShQxbhBztnE3n41iT
        07K6M8LpxLgFcG39qrklE6QEFD9+sx4=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: [PATCH] x86/microcode: Announce reload operation's completion
Date:   Wed, 13 Mar 2019 12:00:22 +0100
Message-Id: <20190313110022.8229-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

By popular demand, issue a single line to dmesg after the reload
operation completes to let the user know that a reload has at least been
attempted.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/microcode/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 97f9ada9ceda..5260185cbf7b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -608,6 +608,8 @@ static int microcode_reload_late(void)
 	if (ret > 0)
 		microcode_check();
 
+	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
+
 	return ret;
 }
 
-- 
2.21.0

