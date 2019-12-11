Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD3BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F542073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079164;
	bh=YvYqXYp9Z9hNJUglhfUxcAd83Jy/uAfY7ZfkgrAxNek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7tErQ6yOtGcistFkD9+OrNRpTRXrkBqRngO94AObY7UbS+OBaoZQGTIxLfhpdqDu
	 f8c87YDj1swywOHG31Tcpb9W8wXFltEEZI0ammNPJH5mVPKeglorRZv375+uTxEvyw
	 w6lun4mzhhp5e4nKiF0x9asWA3DJZFQ21rYpa94M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfLKPp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733207AbfLKP07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:26:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B65D22B48;
        Wed, 11 Dec 2019 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078018;
        bh=YvYqXYp9Z9hNJUglhfUxcAd83Jy/uAfY7ZfkgrAxNek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0s2YggVeKsJZ+7Tv/ZqKkqenm2FiFihiBWkBvKSHane+Q42c8du4DjImhPftJyip
         S0tVZTw4morD511kyazeUCQReDWJapYwl6d/mzS5VbfRaWaaUkYCuz8mU/DEp7hskq
         Pd5FmR06t6hFfPBiYIb3UPnM1MQFTJgovZpTIW1k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 13/79] powerpc/pseries: Mark accumulate_stolen_time() as notrace
Date:   Wed, 11 Dec 2019 10:25:37 -0500
Message-Id: <20191211152643.23056-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152643.23056-1-sashal@kernel.org>
References: <20191211152643.23056-1-sashal@kernel.org>
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
index 7707990c4c169..02ae92c224800 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -235,7 +235,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
  * Accumulate stolen time by scanning the dispatch trace log.
  * Called on entry from user mode.
  */
-void accumulate_stolen_time(void)
+void notrace accumulate_stolen_time(void)
 {
 	u64 sst, ust;
 	unsigned long save_irq_soft_mask = irq_soft_mask_return();
-- 
2.20.1

