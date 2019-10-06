Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E3CECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8520673
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384673;
	bh=vTl9zJpljgQsfufSouxqoZf5478I80hsMeKWww/XdhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7Fhn9rcjcxPaWoCd0Jl0LzlYfVjTW1cS0bDgTp+5TRyZYYEZs+RTFlIDz++g6QEA
	 YeP162WOKr5XCTB8sfceaMuxLlc/Vv0FjB0BlmKhnqOkCuy9167bM3mBnuLvPObOk7
	 8RxEkesJrVwsi3cqvcrNnK/bpKI5qitK5pEFPJhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfJFRdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbfJFRc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:32:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 290E82080F;
        Sun,  6 Oct 2019 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383178;
        bh=vTl9zJpljgQsfufSouxqoZf5478I80hsMeKWww/XdhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ug57ZVKub4wFoRaIDI01AeIMhA4vPauOm5cj+ZqJiPKWFXWyf9+cGo6KpRpWo7IWy
         jIfU2v6TFH+B+CCNni3s8lUBhTww1274T1C0cErgSP4xBzk0EUDHl+ZdPRMkNXmUYe
         0STEwm6MOHXv50ylYtaUe/cdtFy6KFOPg64QllLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shahjada Abul Husain <shahjada@chelsio.com>,
        Vishal Kulkarni <vishal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 001/137] cxgb4:Fix out-of-bounds MSI-X info array access
Date:   Sun,  6 Oct 2019 19:19:45 +0200
Message-Id: <20191006171209.642515911@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
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


