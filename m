Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22360C352A9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5A8218DE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765426;
	bh=WrvyVyj4M4v/rne0mfh1sqmxz50lE70Md4srZcaKLdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f/g5xN9wt68wyZU9BDQrMYGpiQoY9q7540dXhz31+AfLz0K2Ey2b2C/VlKS6NRVWO
	 hzybxPGcwT1TuxSsaquh/J47cBvWhqmJbCXTQGMlGNzvaVmkKx3yq4fx3Adz5xZeR9
	 WHni9k6Eoz3EsFSjaospsHPFU09iKVhW7eWFaLP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfI2N5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbfI2N5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:57:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E81A21882;
        Sun, 29 Sep 2019 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765421;
        bh=WrvyVyj4M4v/rne0mfh1sqmxz50lE70Md4srZcaKLdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keRrnXXrCzHBetAKP8ZEmNTylfKk9BLHgKAsJ7v9ZV+VSghasA1zQMr8Z3fzNEgZQ
         X9Ezfj3N7zSMXkLpfRzPiJRLlsGku1yLyH/aBUQvxKjcquvGuq7Gig3NPIQ/h4aU6I
         +F7yHITM0pDHhD18NWMviF1zTmGGAQln8tcMaveA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juliet Kim <julietk@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 02/63] net/ibmvnic: free reset work of removed device from queue
Date:   Sun, 29 Sep 2019 15:53:35 +0200
Message-Id: <20190929135031.743944541@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juliet Kim <julietk@linux.vnet.ibm.com>

[ Upstream commit 1c2977c094998de032fee6e898c88b4a05483d08 ]

Commit 36f1031c51a2 ("ibmvnic: Do not process reset during or after
 device removal") made the change to exit reset if the driver has been
removed, but does not free reset work items of the adapter from queue.

Ensure all reset work items are freed when breaking out of the loop early.

Fixes: 36f1031c51a2 ("ibmnvic: Do not process reset during or after device removal”)
Signed-off-by: Juliet Kim <julietk@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a57be66a4872..f232943c818bf 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2000,7 +2000,10 @@ static void __ibmvnic_reset(struct work_struct *work)
 	while (rwi) {
 		if (adapter->state == VNIC_REMOVING ||
 		    adapter->state == VNIC_REMOVED)
-			goto out;
+			kfree(rwi);
+			rc = EBUSY;
+			break;
+		}
 
 		if (adapter->force_reset_recovery) {
 			adapter->force_reset_recovery = false;
@@ -2026,7 +2029,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 		netdev_dbg(adapter->netdev, "Reset failed\n");
 		free_all_rwi(adapter);
 	}
-out:
+
 	adapter->resetting = false;
 	if (we_lock_rtnl)
 		rtnl_unlock();
-- 
2.20.1



