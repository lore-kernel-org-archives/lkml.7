Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170B3C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95D820815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596370;
	bh=5RpzVDfEqU6N+flh0xCkhbrpD3LejRIpqDfYAkBGBtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wAIqO39tDGk1ZKqqcDeojEVZYy+DdonHTicza4IsegFgKIN85uzjMNmyNg2ZQf6dz
	 eqk6UNWgqZPGG+tss8shH6dazeZUWWYSR/Zzg1r/RidQj+8inmmcukhc4z7uI0V5A8
	 NQBJ1DG7STLasG6DLGfIeyO1TGIWb4i7S7UcXz6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfF0Ak1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfF0Ak0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:40:26 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C4D205ED;
        Thu, 27 Jun 2019 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596025;
        bh=5RpzVDfEqU6N+flh0xCkhbrpD3LejRIpqDfYAkBGBtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO+wiHwD/ic04qilL9hRp8TPRTSuHBZQJKmRpuJMGSNhe8A/SQomzeImzvT/sXBTp
         9VPzqZUNrssoUGeKx5KOsfl16HhWdZojFz19X/V4xI0RudqJwLwFn3UlTfnc1tJr2S
         uwLWPDrvgsMiAK9uaB25T+1ROtyK31C/k/2mNFQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 17/35] ibmvnic: Refresh device multicast list after reset
Date:   Wed, 26 Jun 2019 20:39:05 -0400
Message-Id: <20190627003925.21330-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003925.21330-1-sashal@kernel.org>
References: <20190627003925.21330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit be32a24372cf162e825332da1a7ccef058d4f20b ]

It was observed that multicast packets were no longer received after
a device reset.  The fix is to resend the current multicast list to
the backing device after recovery.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index c914b338691b..956fbb164e6f 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1489,6 +1489,9 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 		return 0;
 	}
 
+	/* refresh device's multicast list */
+	ibmvnic_set_multi(netdev);
+
 	/* kick napi */
 	for (i = 0; i < adapter->req_rx_queues; i++)
 		napi_schedule(&adapter->napi[i]);
-- 
2.20.1

