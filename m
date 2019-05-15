Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B66C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC7A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922146;
	bh=4EHyQbotPrUSXlPyTLr2VIFgsen15mjmpuTjtyKmiLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f8SzJ7FeEomyuCDO7b5xiCt9QrSXwwKFoOH1uWU8VBBv+LrRVpGiRi31dKROc9Ukj
	 KYcas3YHl5c5hkGZ/RwU0jHqzyzjSYetNnyifvbhH5jA6wyde2d2fgKJ5HOoYqHxEi
	 8lIF3Fn5J9XnkCREwdjW4dPGFU8EvOJzNmQ45LMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfEOMJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbfEOLIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:08:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA07720644;
        Wed, 15 May 2019 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918484;
        bh=4EHyQbotPrUSXlPyTLr2VIFgsen15mjmpuTjtyKmiLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QT2Z2/CcslKxbYHh8Tyo4TJvpSyA6QSbnuhjja7pIwt8Zu9a3MKiW8HQ2A/ISqar1
         uU9yw0Cq8KB6YMSLvvFF41XFrqalOLQFnh5YRKlSKrRaO5Np5I2alZxphOWs7uHqRi
         DypVBce3rbZPMb5MtvBU0yLJPdbs2nESZc8+89ds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 148/266] scsi: csiostor: fix missing data copy in csio_scsi_err_handler()
Date:   Wed, 15 May 2019 12:54:15 +0200
Message-Id: <20190515090727.920774738@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5c2442fd78998af60e13aba506d103f7f43f8701 ]

If scsi cmd sglist is not suitable for DDP then csiostor driver uses
preallocated buffers for DDP, because of this data copy is required from
DDP buffer to scsi cmd sglist before calling ->scsi_done().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/csiostor/csio_scsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index c2a6f9f294271..ddbdaade654d6 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -1713,8 +1713,11 @@ csio_scsi_err_handler(struct csio_hw *hw, struct csio_ioreq *req)
 	}
 
 out:
-	if (req->nsge > 0)
+	if (req->nsge > 0) {
 		scsi_dma_unmap(cmnd);
+		if (req->dcopy && (host_status == DID_OK))
+			host_status = csio_scsi_copy_to_sgl(hw, req);
+	}
 
 	cmnd->result = (((host_status) << 16) | scsi_status);
 	cmnd->scsi_done(cmnd);
-- 
2.20.1



