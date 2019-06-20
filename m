Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE7BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BCA215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054339;
	bh=aFBehdYRciLSJKafsb5y0VEz0EYr9uZ8mMN3bksJzoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w9EDBZySdSORWHqX8+DSE8ITXwQJpWPr1KfdJPwBbZzOrMLd6i7xzoeVgrJCBBo6E
	 7eyq3Y4BkNbvrB0CHiTv+fGPFCtfGiDrY0h7Ih0NAd6smDN/yOhRMICTnTrpE4Mtx4
	 uIT4ZZPhSkbpsNeQv/p+z/VFa8N3qJKvuLWYYK/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfFTSMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbfFTSMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:12:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D37A52070B;
        Thu, 20 Jun 2019 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054333;
        bh=aFBehdYRciLSJKafsb5y0VEz0EYr9uZ8mMN3bksJzoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dj6VKHDbIByJNTqkmC6eGrp8kkZuOw9Rtc9DeS4qlVRPTsQ6Ixc5CaNK+9+vo8Z4u
         v9JSKElc8/XoS0OLEA3OM7xzDIy4vdQ6rLZL/FQpX32LIf2cZaMs0ZY6243ZMOJCto
         EoLRX+iSmY3e3bhgdTO4ZNRWTSOwrezgnpMaWYkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 54/61] scsi: libcxgbi: add a check for NULL pointer in cxgbi_check_route()
Date:   Thu, 20 Jun 2019 19:57:49 +0200
Message-Id: <20190620174346.629683659@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cc555759117e8349088e0c5d19f2f2a500bafdbd ]

ip_dev_find() can return NULL so add a check for NULL pointer.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/cxgbi/libcxgbi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index f2c561ca731a..cd2c247d6d0c 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -641,6 +641,10 @@ cxgbi_check_route(struct sockaddr *dst_addr, int ifindex)
 
 	if (ndev->flags & IFF_LOOPBACK) {
 		ndev = ip_dev_find(&init_net, daddr->sin_addr.s_addr);
+		if (!ndev) {
+			err = -ENETUNREACH;
+			goto rel_neigh;
+		}
 		mtu = ndev->mtu;
 		pr_info("rt dev %s, loopback -> %s, mtu %u.\n",
 			n->dev->name, ndev->name, mtu);
-- 
2.20.1



