Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C401C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD6A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117755;
	bh=84pcyOxzzxs+jT/KYCF7tTiVrlr0fAREYKelK3oYX0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XwSxZeZKlk4YdGmr93DaeMylZS3E8+Mi0gnGtbfWb0XH5kMNMuJr4T+QKIsZeYYdI
	 YKprSW4Voe5OS5byHja0AIUKPyex+Y/x61RkPy4OqUOfX03c/EXai/9E97bViFZrQt
	 7LkAjaSCNcNqqwP0Z+4OT/8+ZcEkaa0U2T2wQ+x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfDXOup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732659AbfDXOum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 425A1218FE;
        Wed, 24 Apr 2019 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117441;
        bh=84pcyOxzzxs+jT/KYCF7tTiVrlr0fAREYKelK3oYX0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pa7DrByawyCdXAG6+aDHOFaHuy4jAeXxdUrmMWT04/jtDopZa1eUIFC7vtFM449Iw
         Bwt7Mso4vi9qDD6wVP4At6rs3sQTcy7u9RrNTRjZmCzLlptYv1hSuZTw0WV89TDuqe
         Du+5KSPyWeNeJy3AvGdtMP+9YqX152NP2bEcnNCk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/28] net: stmmac: fix dropping of multi-descriptor RX frames
Date:   Wed, 24 Apr 2019 10:49:56 -0400
Message-Id: <20190424145012.30886-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 8ac0c24fe1c256af6644caf3d311029440ec2fbd ]

Packets without the last descriptor set should be dropped early. If we
receive a frame larger than the DMA buffer, the HW will continue using the
next descriptor. Driver mistakes these as individual frames, and sometimes
a truncated frame (without the LD set) may look like a valid packet.

This fixes a strange issue where the system replies to 4098-byte ping
although the MTU/DMA buffer size is set to 4096, and yet at the same
time it's logging an oversized packet.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 2c40cafa2619..77dc5842bd0b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -205,6 +205,11 @@ static int enh_desc_get_rx_status(void *data, struct stmmac_extra_stats *x,
 	if (unlikely(rdes0 & RDES0_OWN))
 		return dma_own;
 
+	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
+		stats->rx_length_errors++;
+		return discard_frame;
+	}
+
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
 		if (unlikely(rdes0 & RDES0_DESCRIPTOR_ERROR)) {
 			x->rx_desc++;
-- 
2.19.1

