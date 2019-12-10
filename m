Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AE5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FBB206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012848;
	bh=dM+Pngq4KjmW9vBg73ieV0QwQR7zMJuUxI9260U4jIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1jzbm3AX+woBoXvyEdXzSqI23hxmx8UUioS2K0XJdARKwTJFXjj1nC5drVSZ7pq7l
	 NHI1EXTFU6nFB5poSaUeSvcFqZwGuQzVUJsOCu/hF4CaOR7mPmEWNPqxgU556VLlFo
	 +ju4QmuvJs1Q5Cj7E7eQ0VfUUb/fzNrEEkRkyBkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfLJVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfLJVMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:12:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB06246B8;
        Tue, 10 Dec 2019 21:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012322;
        bh=dM+Pngq4KjmW9vBg73ieV0QwQR7zMJuUxI9260U4jIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igIFhtgg2GO295WbyVy9OVS+TfTc+tkl7XoavOKerzl7XfxvVYETAI2Klzhqgkej4
         Irl7QrFjm8LlWRfP/bKISb8KW1SbIDLmbAzMdQXTllutx5NVjpTH/8Lpnj5NPwFRmg
         aDYKMiLCkDGKx/lm4Wv8WpvX2hCZIEDG10t2j0vo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mitch Williams <mitch.a.williams@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 255/350] ice: delay less
Date:   Tue, 10 Dec 2019 16:06:00 -0500
Message-Id: <20191210210735.9077-216-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mitch Williams <mitch.a.williams@intel.com>

[ Upstream commit 88bb432a55de8ae62106305083a8bfbb23b01ad2 ]

Shorten the delay for SQ responses, but increase the number of loops.
Max delay time is unchanged, but some operations complete much more
quickly.

In the process, add a new define to make the delay count and delay time
more explicit. Add comments to make things more explicit.

This fixes a problem with VF resets failing on with many VFs.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 2353166c654ea..c68709c7ef81d 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -948,7 +948,7 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		if (ice_sq_done(hw, cq))
 			break;
 
-		mdelay(1);
+		udelay(ICE_CTL_Q_SQ_CMD_USEC);
 		total_delay++;
 	} while (total_delay < cq->sq_cmd_timeout);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 44945c2165d80..4df9da3591359 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -31,8 +31,9 @@ enum ice_ctl_q {
 	ICE_CTL_Q_MAILBOX,
 };
 
-/* Control Queue default settings */
-#define ICE_CTL_Q_SQ_CMD_TIMEOUT	250  /* msecs */
+/* Control Queue timeout settings - max delay 250ms */
+#define ICE_CTL_Q_SQ_CMD_TIMEOUT	2500  /* Count 2500 times */
+#define ICE_CTL_Q_SQ_CMD_USEC		100   /* Check every 100usec */
 
 struct ice_ctl_q_ring {
 	void *dma_head;			/* Virtual address to DMA head */
-- 
2.20.1

