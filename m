Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9922071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418757;
	bh=XESE49B7JaR8FrDEYV3PLGiw2gqRw1Ybupwh3oORyp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CyuRbwobOmqwt71bHL5y0DBJK/GwQ0wXWGmGhNhp2ZuKXvDdz5hn+aLKVs5U0ptkv
	 xqhBmwjAwB0z+lIsj+tftdt1GiWhpb2IskihkKpk6dtPyfKUF2w8vKi2qmF1BV03hu
	 OZTm486R5mb/Rh8WAAe7rRDiCBu5kV2+wS4RgNuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfKVKcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:32:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfKVKce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3AC20726;
        Fri, 22 Nov 2019 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418753;
        bh=XESE49B7JaR8FrDEYV3PLGiw2gqRw1Ybupwh3oORyp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDjdXz0sEn3AVAMRxkHD527JFpe6CS0KeAXlh9ygU5Iaoa40zWf6T1Jca1DgbVzz0
         x2kjw4GxLIqy3vCuSQqzgyGRM6nq+sPUlwTC0EOtS9unRFx7od01ovclXbhZdfNk06
         js8i1pgxpRKw7UYvJbDainxba5XjPqIbyBS3IVcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Deepak Ukey <deepak.ukey@microchip.com>,
        Viswas G <Viswas.G@microchip.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 041/159] scsi: pm80xx: Corrected dma_unmap_sg() parameter
Date:   Fri, 22 Nov 2019 11:27:12 +0100
Message-Id: <20191122100735.266370230@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepak Ukey <deepak.ukey@microchip.com>

[ Upstream commit 76cb25b058034d37244be6aca97a2ad52a5fbcad ]

For the function dma_unmap_sg(), the <nents> parameter should be number of
elements in the scatter list prior to the mapping, not after the mapping.

Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Acked-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 949198c01ced6..ef1687f798cc1 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -463,7 +463,7 @@ err_out:
 	dev_printk(KERN_ERR, pm8001_ha->dev, "pm8001 exec failed[%d]!\n", rc);
 	if (!sas_protocol_ata(t->task_proto))
 		if (n_elem)
-			dma_unmap_sg(pm8001_ha->dev, t->scatter, n_elem,
+			dma_unmap_sg(pm8001_ha->dev, t->scatter, t->num_scatter,
 				t->data_dir);
 out_done:
 	spin_unlock_irqrestore(&pm8001_ha->lock, flags);
-- 
2.20.1



