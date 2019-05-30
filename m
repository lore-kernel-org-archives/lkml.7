Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC02C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E017224F8F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188883;
	bh=B1REWhhUT/QzQkBeseofxK6UAlJ9OwSyGnb7velQKW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V43uWdkSOYEFsdUlbxVOuJC2T3NMzFQLx5aVtwc9JdgC2sKHeZ1A/KqSFslPg7Bim
	 PE0xE+DKUhXdt4P+dCLogm4vpU58+/VUqZzpmOpRjy1dtujbnYAAH4LYxpTQ5wZ14k
	 PSyoHkmiJj9EbRunKiL/aGZbeORExohfR5SnRE98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfE3EBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731455AbfE3DSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:11 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B66F824764;
        Thu, 30 May 2019 03:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186290;
        bh=B1REWhhUT/QzQkBeseofxK6UAlJ9OwSyGnb7velQKW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5mFBGMzsD0+zA06tiLivczBXL7At07Y1/EfAFnwrWBE86Y5mgNNrMY/zoqPlDb2m
         B5Q5I90oyBg8UMFMIvICbzIe9adZSWrM9J/rn41R/iQP0QA82RYygJfSoJPoL5fN4E
         jYr41BzFPYsFzcebb9CvJRai33yFpBTR6yKLM7WM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 248/276] igb: Exclude device from suspend direct complete optimization
Date:   Wed, 29 May 2019 20:06:46 -0700
Message-Id: <20190530030540.657718120@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5b6e13216be29ced7350d9c354a1af8fe0ad9a3e ]

igb sets different WoL settings in system suspend callback and runtime
suspend callback.

The suspend direct complete optimization leaves igb in runtime suspended
state with wrong WoL setting during system suspend.

To fix this, we need to disable suspend direct complete optimization to
let igb always use suspend callback to set correct WoL during system
suspend.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index aa39a068858e9..5aa083d9a6c9a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3468,6 +3468,9 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			break;
 		}
 	}
+
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+
 	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 
-- 
2.20.1



