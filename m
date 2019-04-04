Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FB4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA12A205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370808;
	bh=bkwBtvMY+iicoZeAoJf7go1v85M5qBMtic2+dRwT2X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ootC1H7umM1pWegRs5Ey7q8KKiUt0/t0/imAZ+T39YuhJpWjdmyr6vr6wsDe9fogk
	 Arid50TLvvAM2oWfl9rRnl/H8MaUQt9hM1/jEnzx4SBDtcXtjImQrki9AEFfMEFGQL
	 q7PifWXwhwUG2n+s+KNwnd3PE7D/gaLt7nvqRV4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfDDJkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731716AbfDDJDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F28F21741;
        Thu,  4 Apr 2019 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368581;
        bh=bkwBtvMY+iicoZeAoJf7go1v85M5qBMtic2+dRwT2X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5HFAyC1y5XUJPLxWGJnp14VXECtF1eHStDo3kDElg5NPbfsUCnNcEejaTp392B0K
         9evrV4rOfHx0v1gbVEmnhR7PCqUbJ4gCBvCzMomFpVnSLyIjJASQSdkIrBizWnyFgV
         gmrbG7ljyeGeN8vdsOgl9u8fZRuNFxSCOWCD5XCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/187] s390/ism: ignore some errors during deregistration
Date:   Thu,  4 Apr 2019 10:46:53 +0200
Message-Id: <20190404084606.621372211@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0ff06c44efeede4acd068847d3bf8cf894b6c664 ]

Prior to dma unmap/free operations the ism driver tries to ensure
that the memory is no longer accessed by the HW. When errors
during deregistration of memory regions from the HW occur the ism
driver will not unmap/free this memory.

When we receive notification from the hypervisor that a PCI function
has been detached we can no longer access the device and would never
unmap/free these memory regions which led to complaints by the DMA
debug API.

Treat this kind of errors during the deregistration of memory regions
from the HW as success since it is already ensured that the memory
is no longer accessed by HW.

Reported-by: Karsten Graul <kgraul@linux.ibm.com>
Reported-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ism_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 8684bcec8ff4..00cc96341411 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -141,10 +141,13 @@ static int register_ieq(struct ism_dev *ism)
 
 static int unregister_sba(struct ism_dev *ism)
 {
+	int ret;
+
 	if (!ism->sba)
 		return 0;
 
-	if (ism_cmd_simple(ism, ISM_UNREG_SBA))
+	ret = ism_cmd_simple(ism, ISM_UNREG_SBA);
+	if (ret && ret != ISM_ERROR)
 		return -EIO;
 
 	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
@@ -158,10 +161,13 @@ static int unregister_sba(struct ism_dev *ism)
 
 static int unregister_ieq(struct ism_dev *ism)
 {
+	int ret;
+
 	if (!ism->ieq)
 		return 0;
 
-	if (ism_cmd_simple(ism, ISM_UNREG_IEQ))
+	ret = ism_cmd_simple(ism, ISM_UNREG_IEQ);
+	if (ret && ret != ISM_ERROR)
 		return -EIO;
 
 	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
@@ -288,7 +294,7 @@ static int ism_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	cmd.request.dmb_tok = dmb->dmb_tok;
 
 	ret = ism_cmd(ism, &cmd);
-	if (ret)
+	if (ret && ret != ISM_ERROR)
 		goto out;
 
 	ism_free_dmb(ism, dmb);
-- 
2.19.1



