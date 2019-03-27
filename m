Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB98C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E85206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714379;
	bh=areckDL7+7qfUjsx0coqFEdyZWyf+52Qeoj0AAYKDEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pOkT3fElVECtFvPrYvS2GHk4XFl3VABCQSdbnfOatHlApmvoWyEJlL4BcdHW1SIbU
	 n/gPo700Z4HQZGlNzrj4CJQQDlle52AVseIW7GTEUjsdWpebqQ3Nb2SJ2tuLzvid4X
	 Qg09c+rBGcscoaHxWmQ9X+1Z/WehaWBSxZcas7BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbfC0TTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387685AbfC0SHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEEE12177E;
        Wed, 27 Mar 2019 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710060;
        bh=areckDL7+7qfUjsx0coqFEdyZWyf+52Qeoj0AAYKDEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CuMPKLm8SncRsNWxg822f6LTpIXRnigffJW1aJ4zZCtvM+o4lRnlDGKISH2ivQ0X
         w7Fa1X2lyCXTAbTXzSuYlBL6MoNxk9yXIWCC8JR3whV57sxY7FwU3+nIMjOrCaqi+C
         eqWtM8I05eEV8JdWHo8fJNdhg7vAF5v5hx6QyDfU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 178/262] e1000e: Exclude device from suspend direct complete optimization
Date:   Wed, 27 Mar 2019 14:00:33 -0400
Message-Id: <20190327180158.10245-178-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

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
index ca48a75be4f2..7acc61e4f645 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7348,6 +7348,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
-- 
2.19.1

