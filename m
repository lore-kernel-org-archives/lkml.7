Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B9C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DACE222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610277;
	bh=HHLg1L839bpQ+0BPLItkpmpRnGaLblgxjCk0OyZxXNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wL+ciVbfXcroYTjlvCnPo+x7PN1TAVTNboKndLe45eJYZ79nHNNrNdpOxN0NPhlf3
	 xymx5gH8yxBFTwtMf9lNBHhPUHu2qd1mp7XjJLksATbCLeEYFnI7QP5MqIubN4+IWm
	 fqOdHBKALk1Qwf2eg192z8MzLBQYqTayG54SfC9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfKMB5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbfKMB5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:57:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF712245C;
        Wed, 13 Nov 2019 01:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610270;
        bh=HHLg1L839bpQ+0BPLItkpmpRnGaLblgxjCk0OyZxXNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSa5fIjWcS4dHKOi0T8NopBr48aDR8t8uekYQUy9ZJZzkA0c6jvY9xixyEpvYFIeZ
         pdGbWjvby10gUTu26cThVZAHECySSuB9fVi0yWcOA+ER9w4hOmpXQuia63HEqKChTZ
         wxuXNbuGp7SDxZdsh6UG1D/NnrnHsUyTG7gOtTl0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 058/115] cpu/SMT: State SMT is disabled even with nosmt and without "=force"
Date:   Tue, 12 Nov 2019 20:55:25 -0500
Message-Id: <20191113015622.11592-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit d0e7d14455d41163126afecd0fcce935463cc512 ]

When booting with "nosmt=force" a message is issued into dmesg to
confirm that SMT has been force-disabled but such a message is not
issued when only "nosmt" is on the kernel command line.

Fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181004172227.10094-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d768e15bef83b..39ed368767f1f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -376,6 +376,7 @@ void __init cpu_smt_disable(bool force)
 		pr_info("SMT: Force disabled\n");
 		cpu_smt_control = CPU_SMT_FORCE_DISABLED;
 	} else {
+		pr_info("SMT: disabled\n");
 		cpu_smt_control = CPU_SMT_DISABLED;
 	}
 }
-- 
2.20.1

