Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFF5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A457208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142117;
	bh=ENwu7Bk/AGxxd6bkRW4LmZu93geDO4izsdATKSHOnRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HywtEUGsP/A18byWvu8o02ydhzHe/QE+6NkvZ3p75gCy2f1B81vXJTJRyRyDqeBqa
	 VaVzKfSwqN9PE3/aypdWrvzIoCGu+RNWpuWEtXPiI76DynoJfnIuwqd7J79ges0/8s
	 DroChceDX+SJ1lFubMwmYT265YQ42gAzlzbJuiWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfKSFlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfKSFlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:41:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80A121783;
        Tue, 19 Nov 2019 05:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142112;
        bh=ENwu7Bk/AGxxd6bkRW4LmZu93geDO4izsdATKSHOnRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYPszns+ZJOPxF3Thj18+mS6WAFVw2+W8hPmWz9FtYRBCN0X5lVG3T+a8Bk9w3TsC
         vJZo6MT8Bwn+/gxXMz2di/GF9cOJZbIG8SmnJiLYW/MP5kHZZDaQrqPy1JEXP9VWnn
         JZJYcD5egIuN00Ejrh9n15r11vn3iTOIfcs8fV/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 391/422] iwlwifi: dbg: dont crash if the firmware crashes in the middle of a debug dump
Date:   Tue, 19 Nov 2019 06:19:48 +0100
Message-Id: <20191119051424.455274854@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 79f25b10c9da3dbc953e47033d0494e51580ac3b ]

We can dump data from the firmware either when it crashes,
or when the firmware is alive.
Not all the data is available if the firmware is running
(like the Tx / Rx FIFOs which are available only when the
firmware is halted), so we first check that the firmware
is alive to compute the required size for the dump and then
fill the buffer with the data.

When we allocate the buffer, we test the STATUS_FW_ERROR
bit to check if the firmware is alive or not. This bit
can be changed during the course of the dump since it is
modified in the interrupt handler.

We hit a case where we allocate the buffer while the
firmware is sill working, and while we start to fill the
buffer, the firmware crashes. Then we test STATUS_FW_ERROR
again and decide to fill the buffer with data like the
FIFOs even if no room was allocated for this data in the
buffer. This means that we overflow the buffer that was
allocated leading to memory corruption.

To fix this, test the STATUS_FW_ERROR bit only once and
rely on local variables to check if we should dump fifos
or other firmware components.

Fixes: 04fd2c28226f ("iwlwifi: mvm: add rxf and txf to dump data")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 8070b2d4c46fe..3443cbdbab4ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -824,7 +824,7 @@ void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt)
 	}
 
 	/* We only dump the FIFOs if the FW is in error state */
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status)) {
+	if (fifo_data_len) {
 		iwl_fw_dump_fifos(fwrt, &dump_data);
 		if (radio_len)
 			iwl_read_radio_regs(fwrt, &dump_data);
-- 
2.20.1



