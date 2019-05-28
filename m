Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A72C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0AF208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nQBZtA+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfE1J7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:59:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36452 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfE1J7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:59:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4S9xALB078199;
        Tue, 28 May 2019 04:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559037550;
        bh=lEWv6fxEN6pv6+31FQbd7NKbfJpMZxThJ3wketcwHXI=;
        h=From:To:CC:Subject:Date;
        b=nQBZtA+rHsLdYfonkENsvCyZaxri+jCiW3auQbPqOP2uLmSTNNHS2dxbpQ8MzmrOZ
         l0LtAF3+/IURWfdr1q5szMKMO/JN2qOjI41amJSCxmBdFyUKDpHR+a+qhlO+Ip4uP3
         9rSoKGyNHAp5tSPUW2Rq+hFdUrvr9VvCEF0GUvLA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4S9xAEd123954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 04:59:10 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 04:59:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 04:59:09 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4S9x7u7117581;
        Tue, 28 May 2019 04:59:08 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v3 0/3] Fix issues with phy configurations in am65x MMC driver
Date:   Tue, 28 May 2019 15:29:25 +0530
Message-ID: <20190528095928.26452-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches fix issues with phy configurations for
sdhci_am654 driver.

v3:
Changed order of patches so that the first one can be applied easily to
stable tree.

v2:
1. Split patch 1 into 2 separate patches.
2. Improved patch descriptions.

Faiz Abbas (3):
  mmc: sdhci_am654: Fix SLOTTYPE write
  mmc: sdhci_am654: Improve whitespace utilisation with regmap_*() calls
  mmc: sdhci_am654: Print error message if the DLL fails to lock

 drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

-- 
2.19.2

