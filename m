Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44BEC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6789B215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329637;
	bh=evJDpNFgWitice73TZUOiOrdM8KKYqPwGX8ucIHotyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dydTbZqWGJqA/bDdYR9Yoc52OCVQhSlqaBI3qxtvuiXV/19ROER0xMoXd7l3nfhtZ
	 StsQOx5V1AbCsjbUKBM8M3xgz7ZD6UEwAZj93q4UDNWnoGYIaIG7DgzZD912USnnhy
	 hoQ4LuopRKDmg7YeUcFzzzsoLeJ1DIfwcoR6Q0iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfD0BrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbfD0BnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65455208CB;
        Sat, 27 Apr 2019 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329385;
        bh=evJDpNFgWitice73TZUOiOrdM8KKYqPwGX8ucIHotyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GR9054zJl4rr2QU75HECCFiLIPRJbRxlUO/quDcER0jsD6CFQjprXel6EVwV39c72
         D5tUKQ5jDPmnkYcNZ6P/Z7jijjQajPIbjj3gu+sKcK8R7mYubEAbeGhWEOPN2KanMF
         xlQKkUCUMGCntbN3w6jv4w1dNerox4GYW2ZRDwQg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 22/32] scsi: csiostor: fix missing data copy in csio_scsi_err_handler()
Date:   Fri, 26 Apr 2019 21:42:13 -0400
Message-Id: <20190427014224.8274-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

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
index dab0d3f9bee1..e09c7f360dbd 100644
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
2.19.1

