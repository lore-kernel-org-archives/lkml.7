Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E28C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7A12067B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384894;
	bh=vTl9zJpljgQsfufSouxqoZf5478I80hsMeKWww/XdhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J/a7ofo0uiKTP58uQt2UFWJrjHTO2rLm0vRl0+2zFlF4m+P+82LLyrZRl9OKYj3+K
	 d9rNDD0p2wrJy70wHSta/c/dmm8yHtTHjpMsPw2uFYWF95AsBf3cbWj6NdRszLKfW4
	 7/YewotA4gQjLfVQZ3gaJnapucBRqm9E25vf8aBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfJFR0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfJFR0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:26:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB362070B;
        Sun,  6 Oct 2019 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382810;
        bh=vTl9zJpljgQsfufSouxqoZf5478I80hsMeKWww/XdhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6rs/3JbU5Cy6V1Yw0SftxxmIiBaSnXfxN9RlYQTQ1bmglJxiQViFS5kDOhL8dmFM
         OAIc7FxbAthFkM+F42pFiim9qHlUJ3NU2lpKtTdkq07MWBRNK69mgkaFj4AKWAxVmZ
         HVYLfeL7GVf6DYK3KJ3jEEJbtzr7K7cze2Mn80uE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shahjada Abul Husain <shahjada@chelsio.com>,
        Vishal Kulkarni <vishal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 49/68] cxgb4:Fix out-of-bounds MSI-X info array access
Date:   Sun,  6 Oct 2019 19:21:25 +0200
Message-Id: <20191006171131.302140886@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishal Kulkarni <vishal@chelsio.com>

[ Upstream commit 6b517374f4ea5a3c6e307e1219ec5f35d42e6d00 ]

When fetching free MSI-X vectors for ULDs, check for the error code
before accessing MSI-X info array. Otherwise, an out-of-bounds access is
attempted, which results in kernel panic.

Fixes: 94cdb8bb993a ("cxgb4: Add support for dynamic allocation of resources for ULD")
Signed-off-by: Shahjada Abul Husain <shahjada@chelsio.com>
Signed-off-by: Vishal Kulkarni <vishal@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
@@ -137,13 +137,12 @@ static int uldrx_handler(struct sge_rspq
 static int alloc_uld_rxqs(struct adapter *adap,
 			  struct sge_uld_rxq_info *rxq_info, bool lro)
 {
-	struct sge *s = &adap->sge;
 	unsigned int nq = rxq_info->nrxq + rxq_info->nciq;
+	int i, err, msi_idx, que_idx = 0, bmap_idx = 0;
 	struct sge_ofld_rxq *q = rxq_info->uldrxq;
 	unsigned short *ids = rxq_info->rspq_id;
-	unsigned int bmap_idx = 0;
+	struct sge *s = &adap->sge;
 	unsigned int per_chan;
-	int i, err, msi_idx, que_idx = 0;
 
 	per_chan = rxq_info->nrxq / adap->params.nports;
 
@@ -161,6 +160,10 @@ static int alloc_uld_rxqs(struct adapter
 
 		if (msi_idx >= 0) {
 			bmap_idx = get_msix_idx_from_bmap(adap);
+			if (bmap_idx < 0) {
+				err = -ENOSPC;
+				goto freeout;
+			}
 			msi_idx = adap->msix_info_ulds[bmap_idx].idx;
 		}
 		err = t4_sge_alloc_rxq(adap, &q->rspq, false,


