Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD25C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AA2208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932314;
	bh=DfOg6QLdAfp3DMZeD0O4pe0XXbH4LfNoN5nUvnEji4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQl2fB7iGjqAviLk5XJbch3xn5SKHwBPZCZ4aDcTBapQUMmeXx1OmE6Hp+3CQMoEg
	 K2Y7DdjCCIhCoHOZa5Oy5tAuJOYP5iUugsChUqzLMi8pZ0+xwyn5+zwBbfWzbmFb8g
	 MPRGfHBoaHhNbV/20oJUwkaNIr9u6M9c7ZzH73v4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392109AbfISWOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732690AbfISWOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:14:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90AC21907;
        Thu, 19 Sep 2019 22:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931244;
        bh=DfOg6QLdAfp3DMZeD0O4pe0XXbH4LfNoN5nUvnEji4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/BWyih7ftImghd5o9P7kQzZ8WW0x2ZdhJATNnSjcBq2PwB3jam0Y9O66IFmHFlNl
         xfC6sjXDn2GDVGuxJd884L72XzwVqc3+DF8bPHBoAZEPC3UvQo2Vp7pr8YDqhoHqg3
         8JWdjwcZXBQJ7aEgdfUzsUi3yEF/bAh1N//otCug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 56/79] ibmvnic: Do not process reset during or after device removal
Date:   Fri, 20 Sep 2019 00:03:41 +0200
Message-Id: <20190919214812.341879223@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit 36f1031c51a2538e5558fb44c6d6b88f98d3c0f2 ]

Currently, the ibmvnic driver will not schedule device resets
if the device is being removed, but does not check the device
state before the reset is actually processed. This leads to a race
where a reset is scheduled with a valid device state but is
processed after the driver has been removed, resulting in an oops.

Fix this by checking the device state before processing a queued
reset event.

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 255de7d68cd33..5a57be66a4872 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1998,6 +1998,10 @@ static void __ibmvnic_reset(struct work_struct *work)
 
 	rwi = get_next_rwi(adapter);
 	while (rwi) {
+		if (adapter->state == VNIC_REMOVING ||
+		    adapter->state == VNIC_REMOVED)
+			goto out;
+
 		if (adapter->force_reset_recovery) {
 			adapter->force_reset_recovery = false;
 			rc = do_hard_reset(adapter, rwi, reset_state);
@@ -2022,7 +2026,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 		netdev_dbg(adapter->netdev, "Reset failed\n");
 		free_all_rwi(adapter);
 	}
-
+out:
 	adapter->resetting = false;
 	if (we_lock_rtnl)
 		rtnl_unlock();
-- 
2.20.1



