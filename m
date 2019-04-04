Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACD6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206EB214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368719;
	bh=sjclc+myQo8/mM02qaV+Ao0IEMd/hTxtmOFXGu6BWkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KqUMZs85rediSUDEHRWFC/xTYXnGXaV9W3HzDf2dx33dSpP4s63djsKbXnFagcWz7
	 eGV7WJk8jmlcgRMh62QEwt81IFQ4MtFxDilp4USB/h/T1JFhb7iqjJMY1xFrSdonqW
	 0ZTg+THlxaiHV1XZRxk2FUc6YuSWVP4u52J5wKhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfDDJFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfDDJFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C512177E;
        Thu,  4 Apr 2019 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368714;
        bh=sjclc+myQo8/mM02qaV+Ao0IEMd/hTxtmOFXGu6BWkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HEMGTSMOBwayrZtYQ/mFYRj/EVcqckb6EBnjF/HIVn/L9XvbXZPVkXVx3QnlVpgu
         x1x9MD8vdnIYWmJuR2X46+k8RTx9v6lwfH0YBXh+Fu6wYnPUQ5xymiYGKCbweqEbg8
         DCGrq1I8SoU6frFqkJ6bfBjfvRGQ1k1fnfAlgWEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 126/187] e1000e: Exclude device from suspend direct complete optimization
Date:   Thu,  4 Apr 2019 10:47:43 +0200
Message-Id: <20190404084609.163803684@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 59f58708c5047289589cbf6ee95146b76cf57d1e ]

e1000e sets different WoL settings in system suspend callback and
runtime suspend callback.

The suspend direct complete optimization leaves e1000e in runtime
suspended state with wrong WoL setting during system suspend.

To fix this, we need to disable suspend direct complete optimization to
let e1000e always use suspend callback to set correct WoL during system
suspend.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 23edc1364487..8b11682ebba2 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7327,6 +7327,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
-- 
2.19.1



