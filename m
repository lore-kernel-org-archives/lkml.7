Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3EE2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfDBFJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfDBFJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 820D259443;
        Tue,  2 Apr 2019 05:09:39 +0000 (UTC)
Received: from 192-168-1-108.tpgi.com.com (vpn2-54-38.bne.redhat.com [10.64.54.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 319297FA10;
        Tue,  2 Apr 2019 05:09:36 +0000 (UTC)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net, siva.kallam@broadcom.com
Cc:     prashant@broadcom.com, mchan@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: [net-next] tg3: allow ethtool -p to work for NICs in down state
Date:   Tue,  2 Apr 2019 16:07:56 +1100
Message-Id: <20190402050756.20507-1-jmaxwell37@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 02 Apr 2019 05:09:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make tg3 behave like other drivers and let "ethtool -p" identify the
NIC even when it's in the DOWN state. Before this patch it would get an 
error as follows if the NIC was down:

# ip link set down dev em4
# ethtool -p em4
Cannot identify NIC: Resource temporarily unavailable

With this patch ethtool identify works regardless of whether the NIC is up
or down as it does for other drivers.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 328373e0578f..3e458394f149 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12763,9 +12763,6 @@ static int tg3_set_phys_id(struct net_device *dev,
 {
 	struct tg3 *tp = netdev_priv(dev);
 
-	if (!netif_running(tp->dev))
-		return -EAGAIN;
-
 	switch (state) {
 	case ETHTOOL_ID_ACTIVE:
 		return 1;	/* cycle on/off once per second */
-- 
2.13.6

