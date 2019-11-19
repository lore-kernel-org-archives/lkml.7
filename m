Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20385C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC08F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142587;
	bh=JKIZoRZ7nmPBq/9//pG2xcnSF0372UaTNuRC9ECEowg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3xfO5iT0oVFCticcU6ZjF+L9bWmv1nmpqXSrXYWReKFGBH7MaBCxqNhoroI/eo5i
	 6BUtFA3KxUbgr0dPTuJHb6HAmEMWX7m1VTuAzYaPgM0ARV0A3KrHUfCwvvhi9Gx29p
	 VMlBJE1ZZ6tZH3Vx58QicQ+PUdlWVVGAqcqMQrfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbfKSFtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:49:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbfKSFtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:49:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C941920721;
        Tue, 19 Nov 2019 05:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142582;
        bh=JKIZoRZ7nmPBq/9//pG2xcnSF0372UaTNuRC9ECEowg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2V7qcvaZOrgRIiFRJvuF177vYVe8Jj3X2QAAiv0G7l2OzFpbeEFo3yhDY0zKkNXH
         c3X/hTIcybuJMp6cO3Kovdxu6PrQLezWahaQZ7RltSNnHQ4Vn7LVPFxcFEPeV/9loX
         o1i8vO0Y7PIxSsZTegvRd5U71W6017OqjnhEm/0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 090/239] IB/hfi1: Missing return value in error path for user sdma
Date:   Tue, 19 Nov 2019 06:18:10 +0100
Message-Id: <20191119051319.378077036@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

[ Upstream commit 2bf4b33f83dfe521c4c7c407b6b150aeec04d69c ]

If the set_txreq_header_agh() function returns an error, the exit path
is chosen.

In this path, the code fails to set the return value.  This will cause
the caller to not realize an error has occurred.

Set the return value correctly in the error path.

Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 75275f9e363de..4854a4a453b5f 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -856,8 +856,10 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, unsigned maxpkts)
 
 				changes = set_txreq_header_ahg(req, tx,
 							       datalen);
-				if (changes < 0)
+				if (changes < 0) {
+					ret = changes;
 					goto free_tx;
+				}
 			}
 		} else {
 			ret = sdma_txinit(&tx->txreq, 0, sizeof(req->hdr) +
-- 
2.20.1



