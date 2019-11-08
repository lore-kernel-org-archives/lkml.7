Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2783DC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D3721D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213367;
	bh=n5yr41YAv3AwtUDx9GH1S0juy9nxJL2b9z1AYymp6yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RXFQeTgEljD/xY76+L0VMWZvJ5btslW/CMfV7aiCyObTvHFkQSH9dnVJn9f5UbLPQ
	 +7onigrQjtMJd0l+xp8AAu04GOIlskosnFVIfXW9Kly/dGGLe5hDkzXKPS4ziFldNb
	 qNogLs2l/h5U6aK3/ogBhx4a1RptFLHsVA+wsDJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390149AbfKHLmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390101AbfKHLml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24867222C4;
        Fri,  8 Nov 2019 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213360;
        bh=n5yr41YAv3AwtUDx9GH1S0juy9nxJL2b9z1AYymp6yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=on382SVEvUA6NovKoHdFLBk4E6fHNg/t0xORFKLEkv5zJTuLJK1nw3mgVuh6iprZn
         M4k++La/H9UI3R7RnFVlzq/tpfHGo7zmrwF3Fa/m2mA1pPdWHrg3f5RkXvn41kzUBE
         n9ppGuLF5bURojgnuZXtc5BjjaqKF65OOJE6JUBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hari Vyas <hari.vyas@broadcom.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 189/205] arm64: fix for bad_mode() handler to always result in panic
Date:   Fri,  8 Nov 2019 06:37:36 -0500
Message-Id: <20191108113752.12502-189-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Vyas <hari.vyas@broadcom.com>

[ Upstream commit e4ba15debcfd27f60d43da940a58108783bff2a6 ]

The bad_mode() handler is called if we encounter an uunknown exception,
with the expectation that the subsequent call to panic() will halt the
system. Unfortunately, if the exception calling bad_mode() is taken from
EL0, then the call to die() can end up killing the current user task and
calling schedule() instead of falling through to panic().

Remove the die() call altogether, since we really want to bring down the
machine in this "impossible" case.

Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index a0099be4311ae..c8dc3a3640e7e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -611,7 +611,6 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 		handler[reason], smp_processor_id(), esr,
 		esr_get_class_string(esr));
 
-	die("Oops - bad mode", regs, 0);
 	local_daif_mask();
 	panic("bad mode");
 }
-- 
2.20.1

