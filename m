Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB96C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2588627A83
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Xgg2ZonO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfFCPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:55:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45171 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729289AbfFCPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:55:41 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53Ffkex011067;
        Mon, 3 Jun 2019 17:55:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ZCdO21K/HCc+rGX1H596yCycvup/VxX5uy2+Ur8pj+A=;
 b=Xgg2ZonOC8ICExILsYQjJB8StuOl0e2H710XlD5MZSS3zImj1hi5WdbVYJ5ZI8jnT8PT
 zj6EQFf4cwf/mdnQRtkP6UcGj16VHkGEmqiJAVuWrOvYTAmcpJVPAAVY3/IvAJvWjN3e
 /oB818VDB5uGOlAdvlPlzvZYGUEXPM0VnoNjel+A46HIXyLrvJIvAn/+G1feRJzmFOJS
 8T2FGfn3yn8narTH7t2KEYTP+Ft+RdTj2O8NLEtX7FQp7X/3gy/zad7mgfR721FKOFnd
 6blcLZAmaJjbgLhjpsRJLZquSpxBBshJLXdNCn1GsQCgWA+ehSEz1n8xFE7fPlMd0s8p 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sunmc2xs0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Jun 2019 17:55:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67D3131;
        Mon,  3 Jun 2019 15:55:28 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 425804E66;
        Mon,  3 Jun 2019 15:55:28 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 17:55:28 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 17:55:27 +0200
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
Subject: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Date:   Mon, 3 Jun 2019 17:55:22 +0200
Message-ID: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds busy detect for stm32 sdmmc variant.
Some adaptations are required:
-Clear busy status bit if busy_detect_flag and busy_detect_mask are
 different.
-Add hardware busy timeout with MMCIDATATIMER register.

V3:
-rebase on latest mmc next
-replace re-read by status parameter. 

V2:
-mmci_cmd_irq cleanup in separate patch.
-simplify the busy_detect_flag exclude
-replace sdmmc specific comment in
"mmc: mmci: avoid fake busy polling in mmci_irq"
to focus on common behavior

Ludovic Barre (3):
  mmc: mmci: fix read status for busy detect
  mmc: mmci: add hardware busy timeout feature
  mmc: mmci: add busy detect for stm32 sdmmc variant

 drivers/mmc/host/mmci.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/mmci.h |  3 +++
 2 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.7.4

