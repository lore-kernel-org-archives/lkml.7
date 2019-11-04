Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB8ECA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC6621E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904399;
	bh=Eadezpx4hJatFGFqkr2djcRhSm0C6yPSUVhZaEGuvjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ui7V8QsSdbf0waPYRssX+lKrc9jr7k1P5/ojGGiymwcRUjVcGB7OOG43Q1vwOQNRs
	 bjXWDF5kjuwXvPp9oAMpDrxxqeki58OZP95E4HrJiE4ADkrYQCAlAF+K8BVTd3mj93
	 iHtg65YPxXDIBMvf8Ghfl+e/hVhuq8JBGSaWixWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfKDVxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387493AbfKDVxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:53:14 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF4C2053B;
        Mon,  4 Nov 2019 21:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904393;
        bh=Eadezpx4hJatFGFqkr2djcRhSm0C6yPSUVhZaEGuvjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccohMG/7H74cCFtb9b36jUnUb8abqsgYms/VWHPidJSgMntEMYSbbBYTXlrY9i3dC
         FDOrJ+Va0Bbqq4XqxsbR+Gxhpmjn5WcB0tB2Wmi3yf7zhDWyS7bgLWMsVrpn39edHz
         3f1zCIafYz7Fl5Cvat7GqSiINGNvyKJ8LUj1rw/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/95] RDMA/hfi1: Prevent memory leak in sdma_init
Date:   Mon,  4 Nov 2019 22:44:29 +0100
Message-Id: <20191104212057.291359966@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 34b3be18a04ecdc610aae4c48e5d1b799d8689f6 ]

In sdma_init if rhashtable_init fails the allocated memory for
tmp_sdma_rht should be released.

Fixes: 5a52a7acf7e2 ("IB/hfi1: NULL pointer dereference when freeing rhashtable")
Link: https://lore.kernel.org/r/20190925144543.10141-1-navid.emamdoost@gmail.com
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/sdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 6781bcdb10b31..741938409f8e3 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1529,8 +1529,11 @@ int sdma_init(struct hfi1_devdata *dd, u8 port)
 	}
 
 	ret = rhashtable_init(tmp_sdma_rht, &sdma_rht_params);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(tmp_sdma_rht);
 		goto bail;
+	}
+
 	dd->sdma_rht = tmp_sdma_rht;
 
 	dd_dev_info(dd, "SDMA num_sdma: %u\n", dd->num_sdma);
-- 
2.20.1



