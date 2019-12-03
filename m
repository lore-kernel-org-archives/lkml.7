Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDE2C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1F320863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413789;
	bh=HtPp8zOK5oiK3coHwNOGOpHkANIkVBWdeaQA0EEL6+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u1BNcGlr6N+rjznT97CZjdvvDXItgeeJndw7ejg8fLranxjhfTIGCxdh63VAWc48R
	 wnHifUGyo7FTiRbmx/TV1Zj+6/DJF8lPVUdxizy6/zF9S/Kpv7BI2MPSl9TJJNMhBW
	 VdQkYXFi+aKNGru/nQo3aL2Aji8eobVLQ0FLSfGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfLCW42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfLCW40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:56:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16891214AF;
        Tue,  3 Dec 2019 22:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413785;
        bh=HtPp8zOK5oiK3coHwNOGOpHkANIkVBWdeaQA0EEL6+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=outDsUzGTYMv0XytU2Cd2TEzdY5+wKzm4IiH8qTjQ7d5jNXrZU8RW1+eVWl+tagHl
         IUPizMQtdd6mWAKybJWeg/RWYT953hsWn9rGAFpiG91M1Em1efpsUrvceqxTer6Dsd
         N+PRLkEECUATgKVKveNW+pVpoSWSwylepvGoGZIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Luo <luojian5@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 254/321] scsi: libsas: Check SMP PHY control function result
Date:   Tue,  3 Dec 2019 23:35:20 +0100
Message-Id: <20191203223440.349454536@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
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
index f9d4a24c14b5a..3e74fe9257617 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -614,7 +614,14 @@ int sas_smp_phy_control(struct domain_device *dev, int phy_id,
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



