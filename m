Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10BCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADF62068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402802;
	bh=krRnmuaqC7qVirxcwWinxCXHxJDjFmPmqqWCcCAM/RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gT6WxLbgfaVu3vcvCbCW5gJA/QIUrh0KlmI21gRTTgV64xHoTWJFzw3b+mMBRuCjV
	 oa0kyagTogtDILoBh8T9/+1mlxhRfNAXdqBcZ4xeuF1HcBsYPuN2S4UzGxVJYTBk97
	 3+S1CF5YEyqzDuFKsOyGU2w11ErKtISPKaItspt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfKVGGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:06:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfKVGCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:02:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919F420659;
        Fri, 22 Nov 2019 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402537;
        bh=krRnmuaqC7qVirxcwWinxCXHxJDjFmPmqqWCcCAM/RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbFlr3IOl+2660HadbmUVoFdUnwwhizY4pPznBXaTyNaQR4fjeTZ+Wcuvs8TBrZ2P
         GItvZC/xyVIHn/r2/qyaur6I/H9Ze8YiVVGyUiX7wwzkbLLnCqot6RU1AX59Nl5cl4
         RHNdMUQmfMXCWfYwFDff8bqKWEkiVJFYX8Dc/3cU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 44/91] scsi: csiostor: fix incorrect dma device in case of vport
Date:   Fri, 22 Nov 2019 01:00:42 -0500
Message-Id: <20191122060129.4239-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 9934613edcb40b92a216122876cd3b7e76d08390 ]

In case of ->vport_create() call scsi_add_host_with_dma() instead of
scsi_add_host() to pass correct dma device.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/csiostor/csio_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index dbe416ff46c27..776b992786881 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -648,7 +648,7 @@ csio_shost_init(struct csio_hw *hw, struct device *dev,
 	if (csio_lnode_init(ln, hw, pln))
 		goto err_shost_put;
 
-	if (scsi_add_host(shost, dev))
+	if (scsi_add_host_with_dma(shost, dev, &hw->pdev->dev))
 		goto err_lnode_exit;
 
 	return ln;
-- 
2.20.1

