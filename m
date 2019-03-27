Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9AA2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713125;
	bh=GOV6nbHMCX8SKjA60wm3S+woQhq15R9iwDYHoXyCcm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QK7rQgr38HrYtWA8Aq+p8pAEL9I0OuIvO3rQSsKJohc94ZV3F70yIYAxqLYyRXD+M
	 aQEQGzU8N43xE9de/k13q/4ayqaKMEcPcGoI+hpdZYm+W60OFCnNzBUfE9AsU4hfPT
	 pWAV6qhosiq3avIILbDXHKtL/UquMk0JbIOiVZg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbfC0S6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389336AbfC0SPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA44721738;
        Wed, 27 Mar 2019 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710536;
        bh=GOV6nbHMCX8SKjA60wm3S+woQhq15R9iwDYHoXyCcm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6QzuNIlZmJLSOzbzYt2+k/nRtHTqYbLtR7Sxt4mVpGZjpU9HMp5Eroxwjd3zwIGW
         6fq62M1fat91oade8360n6gVRPiCmeyq6PzceZ/wtdZSQlgkD/MjAApmuD+BUP5YOM
         M4u8Hil9WTYgNJUUjJyhsIL0my0VK452ezcrcnM0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Song Hongyan <hongyan.song@intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 162/192] HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR busy_clear bit
Date:   Wed, 27 Mar 2019 14:09:54 -0400
Message-Id: <20190327181025.13507-162-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Hongyan <hongyan.song@intel.com>

[ Upstream commit 2edefc056e4f0e6ec9508dd1aca2c18fa320efef ]

Host driver should handle interrupt mask register earlier than wake up ish FW
else there will be conditions when FW interrupt comes, host PIMR register still
not set ready, so move the interrupt mask setting before ish_wakeup.

Clear PISR busy_clear bit in ish_irq_handler. If not clear, there will be
conditions host driver received a busy_clear interrupt (before the busy_clear
mask bit is ready), it will return IRQ_NONE after check_generated_interrupt,
the interrupt will never be cleared, causing the DEVICE not sending following
IRQ.

Since PISR clear should not be called for the CHV device we do this change.
After the change, both ISH2HOST interrupt and busy_clear interrupt will be
considered as interrupt from ISH, busy_clear interrupt will return IRQ_HANDLED
from IPC_IS_BUSY check.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index bfbca7ec54ce..e00b9dbe220f 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -91,7 +91,10 @@ static bool check_generated_interrupt(struct ishtp_device *dev)
 			IPC_INT_FROM_ISH_TO_HOST_CHV_AB(pisr_val);
 	} else {
 		pisr_val = ish_reg_read(dev, IPC_REG_PISR_BXT);
-		interrupt_generated = IPC_INT_FROM_ISH_TO_HOST_BXT(pisr_val);
+		interrupt_generated = !!pisr_val;
+		/* only busy-clear bit is RW, others are RO */
+		if (pisr_val)
+			ish_reg_write(dev, IPC_REG_PISR_BXT, pisr_val);
 	}
 
 	return interrupt_generated;
@@ -843,11 +846,11 @@ int ish_hw_start(struct ishtp_device *dev)
 {
 	ish_set_host_rdy(dev);
 
+	set_host_ready(dev);
+
 	/* After that we can enable ISH DMA operation and wakeup ISHFW */
 	ish_wakeup(dev);
 
-	set_host_ready(dev);
-
 	/* wait for FW-initiated reset flow */
 	if (!dev->recvd_hw_ready)
 		wait_event_interruptible_timeout(dev->wait_hw_ready,
-- 
2.19.1

