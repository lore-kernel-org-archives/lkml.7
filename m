Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31122C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0362320823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688009;
	bh=PbYxFH3t60xcGPC6sqOksX5RHk0SR+jX6BvmV757Y0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F0BiiycBB4GntHBqisxU1K1Ik/Rjl8pgkjgvBdDMOTiuFm1WLk/UcoC3U30sj+uY5
	 8X5jSdaUPOQTFc6XZyzUMi7cquArKemisHuJnshR+cntfA1TmbZ1t3aRJ50WkzLPjL
	 SelQ2WAgfyVSXvsaIpOn/IQ84Ut4pwy3T5idctYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCDI0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfCDI0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:26:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D6E20823;
        Mon,  4 Mar 2019 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688003;
        bh=PbYxFH3t60xcGPC6sqOksX5RHk0SR+jX6BvmV757Y0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG5aztaSHX4iRpKQ2b840Qu4Vwz24gigWzDJLOshTi7ay4KIMVf10a3nIwuQMWNZp
         hvQdTQUd4ivR+HphOZep/8mKTDAbCeNzD3yAEyfIxGnQA5TnlAqA3LrvRtnVKp2z49
         56YsnYxhPqO2nsXBYjhPlSvBB8MQddXYuvcmAscA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 38/52] ibmveth: Do not process frames after calling napi_reschedule
Date:   Mon,  4 Mar 2019 09:22:36 +0100
Message-Id: <20190304081619.317276638@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e95d22c69b2c130ccce257b84daf283fd82d611e ]

The IBM virtual ethernet driver's polling function continues
to process frames after rescheduling NAPI, resulting in a warning
if it exhausted its budget. Do not restart polling after calling
napi_reschedule. Instead let frames be processed in the following
instance.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 6c05819d995ea..754dff4c1771e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1314,7 +1314,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	unsigned long lpar_rc;
 	u16 mss = 0;
 
-restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter))
 			break;
@@ -1402,7 +1401,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		    napi_reschedule(napi)) {
 			lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 					       VIO_IRQ_DISABLE);
-			goto restart_poll;
 		}
 	}
 
-- 
2.19.1



