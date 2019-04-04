Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A08CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CD72075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369294;
	bh=WSjNaUvFBqL8oHuXn2lqlIXSLtjOB0Qst8WT4nDSROY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0EeBi/CK/vIxKdji0buBa1TFUm3KzyXf9JpuCEUWL92wTI9uQCAHRGqN0X04Km7+A
	 mmRWcIcuVlxEJav5AjXS6xujnmM6t15vQj5qcXtd+LZiLKYTFrUBySf3S6ejb+qDhs
	 Kcb4RNNLqwNt6hYa7h7M6BcugipC0hGqaTcQExDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbfDDJOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387764AbfDDJOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F2621734;
        Thu,  4 Apr 2019 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369290;
        bh=WSjNaUvFBqL8oHuXn2lqlIXSLtjOB0Qst8WT4nDSROY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZWLsn/P1NYbcfVCN9JqcDYPvc5tHzAX29lLxNiOqnSoSM47WFeakxDNpUexIFfVm
         SuNBogpMYFzvX2yIBHaFS6O3ojY/tzUp2zj9noTRuyU6hGuC5pWqMHr3LCFggtoGjO
         wc4E3ze3QWsDydbj+j82y64UIv8NJT90tRvm1QVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 168/246] e1000e: Exclude device from suspend direct complete optimization
Date:   Thu,  4 Apr 2019 10:47:48 +0200
Message-Id: <20190404084625.056932653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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



