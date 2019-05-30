Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90BBC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7EC240F2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190146;
	bh=8Tir1141JjLcigccpWzUNXfjFuNnn/QHv3gE1I82T9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PnRXqg7429DiifmGX28Y7+gRsPdAYm8IYicExqsC8t/RQ1024hAnAZrBC0o2BXwpv
	 uV5jmyGJQyRlO0SSSWggTFQV553hpxE56hMLb+Sg7kNTZBTHgXi9MlqWDwhZlI+oPP
	 iSFguKsuD2NIkn4cTA+uplt/GRgYBfcPSJFJ06Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfE3DPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbfE3DMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:24 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631D823C5A;
        Thu, 30 May 2019 03:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185944;
        bh=8Tir1141JjLcigccpWzUNXfjFuNnn/QHv3gE1I82T9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/a6XQ/MTI4LqxmAOFJbWRJxwByyjaPBTxyH2BQLRqFhR6edFnyQm/70jK18MwyNc
         LOUx0FwSJqzx2K0s9boREZEy9+0RPt9EGUQwirU5ztlvl/qVTyPaGcjCYdhx/CY419
         OMfO+nFwIaOZ80wkFtwKv4t/r+oGj0Ur3y299c84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 352/405] scsi: ufs: fix a missing check of devm_reset_control_get
Date:   Wed, 29 May 2019 20:05:50 -0700
Message-Id: <20190530030558.473851295@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 63a06181d7ce169d09843645c50fea1901bc9f0a ]

devm_reset_control_get could fail, so the fix checks its return value and
passes the error code upstream in case it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs-hisi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 0e855b5afe82a..2f592df921d97 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -587,6 +587,10 @@ static int ufs_hisi_init_common(struct ufs_hba *hba)
 	ufshcd_set_variant(hba, host);
 
 	host->rst  = devm_reset_control_get(dev, "rst");
+	if (IS_ERR(host->rst)) {
+		dev_err(dev, "%s: failed to get reset control\n", __func__);
+		return PTR_ERR(host->rst);
+	}
 
 	ufs_hisi_set_pm_lvl(hba);
 
-- 
2.20.1



