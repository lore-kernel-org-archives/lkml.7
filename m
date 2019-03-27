Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92250C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7F12075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbfC0JFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:05:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52280 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbfC0JFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:05:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2R91fdE013759;
        Wed, 27 Mar 2019 10:05:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rf4yc1uw8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Mar 2019 10:05:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F5DB42;
        Wed, 27 Mar 2019 09:05:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A0DE2B66;
        Wed, 27 Mar 2019 09:05:40 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Mar
 2019 10:05:40 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 27 Mar
 2019 10:05:39 +0100
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
Subject: [PATCH V4 0/5] mmc: mmci: add get_datactrl_cfg callback
Date:   Wed, 27 Mar 2019 10:05:27 +0100
Message-ID: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds get_datactrl_cfg callback in mmci_host_ops
to allow to get datactrl configuration specific at variant.

change V4:
-keep mmci and ux500v2 variant init in the c file.

change V3:
-keep the common functions in mmci_start_data. define
function used by some variants like an helper
(example mmci_dctrl_blks used by mmci and sdmmc).
-To be consistent rename callback for ux500v2 

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

Ludovic Barre (5):
  mmc: mmci: add get_datactrl_cfg callback and helper functions
  mmc: mmci: define get_dctrl_cfg for legacy variant
  mmc: mmci: qcom: define get_dctrl_cfg
  mmc: mmci: stm32: define get_dctrl_cfg
  mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback

 drivers/mmc/host/mmci.c             | 56 +++++++++++++++++--------------------
 drivers/mmc/host/mmci.h             | 18 +++++++-----
 drivers/mmc/host/mmci_qcom_dml.c    |  6 ++++
 drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++
 4 files changed, 61 insertions(+), 37 deletions(-)

-- 
2.7.4

