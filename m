Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3673C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8513D20678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888335;
	bh=6eykspN3cd2v1dC2FZs8AixH9I5Z7C5N1now7YBSKs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1UBis7ZGO+h0V+17bm2pJUAzgssc3wNjAf+dIH6aD/53ODQpNTW0sg678W6rZmviE
	 WCuOSnq1ISncNIJLZwPCNWNmClAL4esgqv8eGudCbIEIPPSwLDJvlmz0JAFnyCAcfV
	 cIUqsoZCCQWg1tnJjI5SJBL1K5BxIf4Cg2afLA78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfK0U6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731345AbfK0U6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:58:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3221C2084B;
        Wed, 27 Nov 2019 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888326;
        bh=6eykspN3cd2v1dC2FZs8AixH9I5Z7C5N1now7YBSKs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysvrSqtFHcfsvk9xX0lA+/bPkpwu5ZbpCEz/xNfqZzD9Y/Dg+2gx4TLtgk0785wxB
         gsAtRL7nEsGsKER3IWF/W3RQLvQvTSSRVQghPj7TyKE+TgkMn65acDkkX5vcaBc3Xn
         4njkECRTLew7Ryj2LUOIgDXG/KFG3mtXwKWmo9MI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/306] scsi: hisi_sas: Feed back linkrate(max/min) when re-attached
Date:   Wed, 27 Nov 2019 21:28:24 +0100
Message-Id: <20191127203118.734981846@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

[ Upstream commit 5a54691f874ab29ec82f08bc6936866a3ccdaa91 ]

At directly attached situation, if the user modifies the sysfs interface
of maximum_linkrate and minimum_linkrate to renegotiate the linkrate
between SAS controller and target, the value of both files mentioned
above should have change to user setting after renegotiate is over, but
it remains unchanged.

To fix this bug, maximum_linkrate and minimum_linkrate will be directly
fed back to relevant sas_phy structure.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index fd9d82c9033de..e9747379384b2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -906,6 +906,9 @@ static void hisi_sas_phy_set_linkrate(struct hisi_hba *hisi_hba, int phy_no,
 	_r.maximum_linkrate = max;
 	_r.minimum_linkrate = min;
 
+	sas_phy->phy->maximum_linkrate = max;
+	sas_phy->phy->minimum_linkrate = min;
+
 	hisi_hba->hw->phy_disable(hisi_hba, phy_no);
 	msleep(100);
 	hisi_hba->hw->phy_set_linkrate(hisi_hba, phy_no, &_r);
-- 
2.20.1



