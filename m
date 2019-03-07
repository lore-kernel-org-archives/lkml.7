Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68503C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BC320854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfCGQjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:39:25 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9643 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbfCGQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:39:17 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27GaOuR030347;
        Thu, 7 Mar 2019 17:39:07 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r315ut652-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 17:39:07 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6D9531;
        Thu,  7 Mar 2019 16:39:06 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A0CAA548E;
        Thu,  7 Mar 2019 16:39:06 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 17:39:06 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 17:39:06 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 0/6] mmc: mmci: add get_datactrl_cfg callback
Date:   Thu, 7 Mar 2019 17:38:56 +0100
Message-ID: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds get_datactrl_cfg callback in mmci_host_ops
to allow to get datactrl configuration specific at variant.

change V2:
-This V2 has been rebased on
"mmc: mmci: Cleanup some variant related code" series
-add helpers functions to define default datactrl value,
each variant could use these helpers to define datactrl
and adds their specific bits.
-use static in qcom and stm32
-regroup mmci_(ux500v2)variant_init in header file
to avoid checkpatch warning:
"WARNING: externs should be avoided in .c files"
-remove unused variant properties:
 "datactrl_dpsm_enable"
 "blksz_datactrl16"
 "blksz_datactrl4"

Ludovic Barre (6):
  mmc: mmci: add get_datactrl_cfg callback
  mmc: mmci: add helper functions to define datactrl value for variants
  mmc: mmci: define get_dctrl_cfg for legacy variant
  mmc: mmci: qcom: define get_dctrl_cfg
  mmc: mmci: stm32: define get_dctrl_cfg
  mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback

 drivers/mmc/host/mmci.c             | 100 ++++++++++++++++++++++--------------
 drivers/mmc/host/mmci.h             |  21 +++++---
 drivers/mmc/host/mmci_qcom_dml.c    |  13 +++++
 drivers/mmc/host/mmci_stm32_sdmmc.c |  19 +++++++
 4 files changed, 108 insertions(+), 45 deletions(-)

-- 
2.7.4

