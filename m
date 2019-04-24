Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A67C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC745218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117019;
	bh=mnjv9IN1XySjhGBk7+hKmZDXSppSPWoUXqTpe2yI3fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lQnyieQxgv5qNVblmM0kQzQSrxMvIqDI6knu4VU3XokyDBsUYRUHm/s7aSh3+nV5h
	 4WTs09blzsis5f1xS8NjyWB3Pi55gaEWImv4A9A6WJlpQx+CgEjYHLajQ5W+B5F3hk
	 b8T4iyHz3zIOH7zuqEO0GfqRC4V0MRFHbh/AIvho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfDXOni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbfDXOkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:40:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC98C21905;
        Wed, 24 Apr 2019 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116807;
        bh=mnjv9IN1XySjhGBk7+hKmZDXSppSPWoUXqTpe2yI3fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgnrfE0zLiyfrcBq95KR70AmCw/82Z+V3SCZ+UZW5x4P/nDC27sG6X233sCchs2MU
         j3jcDnhEDk3wR9jz8Nf33QsenHv9WFkYEWXEVhrgwv5+xUArmc4aNd3OP4AzHndAay
         8+cwOUOeIway1w9m9I/tbMi6WawxQclTffLktcCc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 24/52] net: stmmac: don't log oversized frames
Date:   Wed, 24 Apr 2019 10:38:42 -0400
Message-Id: <20190424143911.28890-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 057a0c5642a2ff2db7c421cdcde34294a23bf37b ]

This is log is harmful as it can trigger multiple times per packet. Delete
it.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index c55a9815b394..b7dd4e3c760d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -91,8 +91,6 @@ static int ndesc_get_rx_status(void *data, struct stmmac_extra_stats *x,
 		return dma_own;
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
-		pr_warn("%s: Oversized frame spanned multiple buffers\n",
-			__func__);
 		stats->rx_length_errors++;
 		return discard_frame;
 	}
-- 
2.19.1

