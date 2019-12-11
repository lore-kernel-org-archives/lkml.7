Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505EBC2D0C7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEDB2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078417;
	bh=H042mJv8ZqhBukEqzRcdzPQ5+UvCTUOQpacnn5zgq8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ew+s+Qp1StLTxFwotMscOB0ArAMSLQ9rjyhegAFXSdjp1NvDivr92ihw19uoZgh5N
	 Q7gqKF6POkQnVr1FBJfYgX3LLz4NoDW7HkBmcjvt61PnbSUdEQoyBIR0HV/mgc3t/A
	 61H9HvUrZRJM8hhm5cjsyITY012H290h2CiuOsaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbfLKPdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbfLKP2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:28:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B38224679;
        Wed, 11 Dec 2019 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078121;
        bh=H042mJv8ZqhBukEqzRcdzPQ5+UvCTUOQpacnn5zgq8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZzj+QuPPiPblTeclmXcGdv0gJTC4Fz1Nb4n4jdI6KJlie7EImkwU5C69O8UoygNw
         29ZNW/JY8Zx/d/8hVZIseuNZcaDH+e2C4fz6fDVSpyPdtX5R+UOicKFwfxpcudblvw
         RieNyVi+19l4IHfSwNghGBdIU1R0jhDNfOJLO1V0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 09/58] powerpc/pseries: Mark accumulate_stolen_time() as notrace
Date:   Wed, 11 Dec 2019 10:27:42 -0500
Message-Id: <20191211152831.23507-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152831.23507-1-sashal@kernel.org>
References: <20191211152831.23507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit eb8e20f89093b64f48975c74ccb114e6775cee22 ]

accumulate_stolen_time() is called prior to interrupt state being
reconciled, which can trip the warning in arch_local_irq_restore():

  WARNING: CPU: 5 PID: 1017 at arch/powerpc/kernel/irq.c:258 .arch_local_irq_restore+0x9c/0x130
  ...
  NIP .arch_local_irq_restore+0x9c/0x130
  LR  .rb_start_commit+0x38/0x80
  Call Trace:
    .ring_buffer_lock_reserve+0xe4/0x620
    .trace_function+0x44/0x210
    .function_trace_call+0x148/0x170
    .ftrace_ops_no_ops+0x180/0x1d0
    ftrace_call+0x4/0x8
    .accumulate_stolen_time+0x1c/0xb0
    decrementer_common+0x124/0x160

For now just mark it as notrace. We may change the ordering to call it
after interrupt state has been reconciled, but that is a larger
change.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191024055932.27940-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7c7c5a16284d2..808f71f9fe615 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -241,7 +241,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
  * Accumulate stolen time by scanning the dispatch trace log.
  * Called on entry from user mode.
  */
-void accumulate_stolen_time(void)
+void notrace accumulate_stolen_time(void)
 {
 	u64 sst, ust;
 	u8 save_soft_enabled = local_paca->soft_enabled;
-- 
2.20.1

