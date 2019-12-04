Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95714C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3AD20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482413;
	bh=F8bm6cUbhQzAHQ+PL99yZE/aTt2ybXW/03/U7caOBbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mC+fpy4cwMreIsM1onPGfP0oPmkWAFvgAXKcwSD1z9pxUnMN6fHiK49g0Y7AP1dMl
	 NGyIjFfILN1ByVWUuBcXLeOi9L7DasPicWdAm0X5CSmU1cXX1Y44MEOZHf873gXSR5
	 Pg2N/VgFVSOawP3xze4l6wbJR45q6BsvFLGDZodk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfLDSAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbfLDSAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:07 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E352081B;
        Wed,  4 Dec 2019 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482406;
        bh=F8bm6cUbhQzAHQ+PL99yZE/aTt2ybXW/03/U7caOBbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vkTMN6v8BxD5xY0yrBIvshFeHsUoLqnOSIiB9F6Tn99F4XWeT3kXUooSIy7fXKnx+
         J6avvxy+B6CWZaalaHXj4g5u2RvK8lpbwtjvDR43AM0lmBr+TXfoMXYzlgZZTJ2zUF
         cwu/Hve6C5hopSfHjm/QRNcbq+P0zJaVlCdnFC1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Luo <luojian5@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 74/92] scsi: libsas: Check SMP PHY control function result
Date:   Wed,  4 Dec 2019 18:50:14 +0100
Message-Id: <20191204174334.726112310@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit 01929a65dfa13e18d89264ab1378854a91857e59 ]

Currently the SMP PHY control execution result is checked, however the
function result for the command is not.

As such, we may be missing all potential errors, like SMP FUNCTION FAILED,
INVALID REQUEST FRAME LENGTH, etc., meaning the PHY control request has
failed.

In some scenarios we need to ensure the function result is accepted, so add
a check for this.

Tested-by: Jian Luo <luojian5@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libsas/sas_expander.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index b7e4493d3dc16..7e8274938a3ee 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -603,7 +603,14 @@ int sas_smp_phy_control(struct domain_device *dev, int phy_id,
 	}
 
 	res = smp_execute_task(dev, pc_req, PC_REQ_SIZE, pc_resp,PC_RESP_SIZE);
-
+	if (res) {
+		pr_err("ex %016llx phy%02d PHY control failed: %d\n",
+		       SAS_ADDR(dev->sas_addr), phy_id, res);
+	} else if (pc_resp[2] != SMP_RESP_FUNC_ACC) {
+		pr_err("ex %016llx phy%02d PHY control failed: function result 0x%x\n",
+		       SAS_ADDR(dev->sas_addr), phy_id, pc_resp[2]);
+		res = pc_resp[2];
+	}
 	kfree(pc_resp);
 	kfree(pc_req);
 	return res;
-- 
2.20.1



