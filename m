Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C8C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D9A22527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077481;
	bh=PKJi6fOqhx0VNQmmOc8HPexNq9do5Ie8qJg8EUqtoeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o7JYPluu5H5AOd36PhXyKyEGbF3bhhoYdiQQVFxTdoQJKd1PTlq3yDzKa6VEJOcXb
	 /Oa/uQdTCZwRVCh7QrD8HDRkWGKyz4gvppEb9mtxn3HwE1cNlhG37Wkz21ppfswT24
	 w1f3CnkbL/QVMRwR7lYml3emJm3AueAP8CAxkSsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfLKPSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:18:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731904AbfLKPR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:17:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9BEA22527;
        Wed, 11 Dec 2019 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077476;
        bh=PKJi6fOqhx0VNQmmOc8HPexNq9do5Ie8qJg8EUqtoeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLMfqd4zIGzdFasF07QvuC/c0C/N/cowTGWEoh+ZlhlQlJKK5P0PJM6/0d8tAfjAN
         5JrJQ0rufICOKj1Y91+uonPN0Ww31sehW8XYS9MhnRJGkbeLaW/2efDHQ8t8qmCJPe
         hOSR4iGD++jmmW/bY9JkCKka0eGw8D+pXdXBeotI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/243] scsi: zfcp: update kernel message for invalid FCP_CMND length, its not the CDB
Date:   Wed, 11 Dec 2019 16:03:35 +0100
Message-Id: <20191211150342.671554543@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Maier <maier@linux.ibm.com>

[ Upstream commit 724e144387f4d7e7668d3da913d0efc44a9b4664 ]

The CDB is just a part inside of FCP_CMND, see zfcp_fc_scsi_to_fcp().
While at it, fix the device driver reaction: adapter not LUN shutdown.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/scsi/zfcp_fsf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index df888506e363e..91aa4bfcf8d61 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2104,11 +2104,8 @@ static void zfcp_fsf_fcp_handler_common(struct zfcp_fsf_req *req,
 		break;
 	case FSF_CMND_LENGTH_NOT_VALID:
 		dev_err(&req->adapter->ccw_device->dev,
-			"Incorrect CDB length %d, LUN 0x%016Lx on "
-			"port 0x%016Lx closed\n",
-			req->qtcb->bottom.io.fcp_cmnd_length,
-			(unsigned long long)zfcp_scsi_dev_lun(sdev),
-			(unsigned long long)zfcp_sdev->port->wwpn);
+			"Incorrect FCP_CMND length %d, FCP device closed\n",
+			req->qtcb->bottom.io.fcp_cmnd_length);
 		zfcp_erp_adapter_shutdown(req->adapter, 0, "fssfch4");
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
-- 
2.20.1



