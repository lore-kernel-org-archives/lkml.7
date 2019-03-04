Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF29B208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687802;
	bh=svo9nt25iSieDbHUNg6rNQv5Y7EE1j5EtblB58ZF1f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vmzBJnBkazp7PtS3I9i8N6yQUUcSHlAahLBieZGdpfP2JsPBs8vebvWK/pLrY74ZQ
	 M3k400vioAifRGpn/JgpBZe6YsqUWIQr1uOEXZXdG9u9VXGZk7m5yTTsR9zVeCJ4Mg
	 +vvBWfKKA2p0f4Cmd3ZlvtMn2POM6mlS84uJji1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCDIXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:23:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfCDIXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3DCE208E4;
        Mon,  4 Mar 2019 08:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687798;
        bh=svo9nt25iSieDbHUNg6rNQv5Y7EE1j5EtblB58ZF1f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unXJI5+ZUpndOn1xw4n1bhQxXoql+mKHA1dzoRFdqFXb0CHtPF6nLyqppbzlcLdc0
         4L9F5m+V3U1n9gFZ7pJa+xeVxdQTCEDQ8SJcHxHDHsnbo+Kaa8S6SjgtiVOyVtf8O3
         2iwNghjQlGWzRv+Gu5Z0Z3IVQc8H+2cm2r1zbK4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 23/32] ibmveth: Do not process frames after calling napi_reschedule
Date:   Mon,  4 Mar 2019 09:22:11 +0100
Message-Id: <20190304081603.972053420@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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
index 4996228fd7e61..955f658f3b65f 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1240,7 +1240,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	struct iphdr *iph;
 	u16 mss = 0;
 
-restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter))
 			break;
@@ -1338,7 +1337,6 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		    napi_reschedule(napi)) {
 			lpar_rc = h_vio_signal(adapter->vdev->unit_address,
 					       VIO_IRQ_DISABLE);
-			goto restart_poll;
 		}
 	}
 
-- 
2.19.1



