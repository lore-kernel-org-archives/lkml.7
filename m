Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A80AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07D821850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367968;
	bh=spGOOxlpPuQd6ElQ6tqT2QrUNGZ0KTXgEvmTlRoVSY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ns3tRHOuJ4f4+xOXez5nRnezjMpMF2xqZfG/2AlTzMqD2Pu450GMtSw+mTafgL4dJ
	 x3awDVX+ivd5vpd7u8XT1EqOkC0zDQadru7EXYQNPNFAAdXDmwlvdv6QPPezAqHJ9R
	 jEOgEUlMnW+Adn2AXTVdjwQLw6tk3Fj31TLAYeQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfDDIwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfDDIwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F28B217D9;
        Thu,  4 Apr 2019 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367961;
        bh=spGOOxlpPuQd6ElQ6tqT2QrUNGZ0KTXgEvmTlRoVSY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9RTJzaIMkhi8DkKJlG03GPPNfBpO0cqRzAlvCWVDOpJj72l9LntO2SnZAkim7oLG
         aasRtbwzTtz8iOW3sEb4+mkfQgHrVzyHVL1Yg5DNQ69I1fgag9jklFX/Q9Jmqyg0t6
         LbyCFjJbOWfqhsE8pkutNDuYbt4uPOnbB/0f+xYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Hongyan <hongyan.song@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 77/91] HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR busy_clear bit
Date:   Thu,  4 Apr 2019 10:48:01 +0200
Message-Id: <20190404084539.911248795@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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
index 0c9ac4d5d850..41d44536aa15 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -92,7 +92,10 @@ static bool check_generated_interrupt(struct ishtp_device *dev)
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
@@ -795,11 +798,11 @@ int ish_hw_start(struct ishtp_device *dev)
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



