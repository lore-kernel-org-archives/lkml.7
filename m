Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5A0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AE8218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366650;
	bh=ZC0ayv0ydAdqCXKrU3ZRnCY2Zk7ZR/Z+idjQeIM7mEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tL2fvJdqTa2gLwXVwcjSekHW3H3TgxF1J0YFkxxslU9FxL+juoM6nPNOFkvO65eim
	 MFU8NIoWc187xMa8tEDsYr1ckqCP9ypKpMtYCSgka8of44GYX3couD8YBosX4R1BG7
	 VdbL4K/b772agrrbLakGPafDW9dNQQeIvIJsIYds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbfB1PKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732666AbfB1PKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA31E218AE;
        Thu, 28 Feb 2019 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366643;
        bh=ZC0ayv0ydAdqCXKrU3ZRnCY2Zk7ZR/Z+idjQeIM7mEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVHLIkKCwokHn46WO6qvhv36ux8ZDELuO2CWFHeJh1aMwaS8UwqtHg9We6qJ5HM+2
         18m0jeTYQQlFAPe9GGcDatCMymlNxhwtAxhMVWPNHI4koDJV6J0LrmzntZ02Cvs3E3
         K4g7kC639c0wiwwEqhVoCNPRgda82IeTagQA07iM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 69/81] Revert "scsi: libfc: Add WARN_ON() when deleting rports"
Date:   Thu, 28 Feb 2019 10:08:01 -0500
Message-Id: <20190228150813.10256-69-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit d8f6382a7d026989029e2e50c515df954488459b ]

This reverts commit bbc0f8bd88abefb0f27998f40a073634a3a2db89.

It added a warning whose intent was to check whether the rport was still
linked into the peer list. It doesn't work as intended and gives false
positive warnings for two reasons:

1) If the rport is never linked into the peer list it will not be
considered empty since the list_head is never initialized.

2) If the rport is deleted from the peer list using list_del_rcu(), then
the list_head is in an undefined state and it is not considered empty.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_rport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 1e1c0f1b9e69d..8ed2113f5a1e2 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -184,7 +184,6 @@ void fc_rport_destroy(struct kref *kref)
 	struct fc_rport_priv *rdata;
 
 	rdata = container_of(kref, struct fc_rport_priv, kref);
-	WARN_ON(!list_empty(&rdata->peers));
 	kfree_rcu(rdata, rcu);
 }
 EXPORT_SYMBOL(fc_rport_destroy);
-- 
2.19.1

