Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91359C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD5F2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hZGvZF6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfJHJ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:56:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13734 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730408AbfJHJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:56:30 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x989q3T5002806;
        Tue, 8 Oct 2019 11:56:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=lalHdG7UJQKEamzJtgMq1V9aYOha/nksgz4VLZDsBvA=;
 b=hZGvZF6Um9r+0Rf/q9onqdXuiWZDQ2Ld3rqIJKGOtmpQesJIL5DDvfLnAilxtw5eUtgN
 nrRhwvD8WdgDBnuC/mdPvdSSAozRuGCO8tN19UbUAPOVN9GwkZ2kD/4TOBH4nXKfN95q
 UQiLt/Sunt0IS5Nin8Nd7L3uQevCATpcMXrwknjWnxakxKM1W84eWViOnP9e7Rh3X9lX
 m2Z6c9JxzvlndWH+gLyf25CvFGLjj0mnV3qfTY+7Uv50+zXVpV7EO61dewq5+oH8r0TE
 0VF+NrChDfFuOKRDv9CCqDeY2llT494APGo/FwBex9caC3UkjHC4SY9IzrkwQxxgSOwG bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vegagyygt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 11:56:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 312A410002A;
        Tue,  8 Oct 2019 11:56:19 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 21C6D2B40AD;
        Tue,  8 Oct 2019 11:56:19 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 11:56:19 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 11:56:18 +0200
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
Subject: [PATCH V7 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Date:   Tue, 8 Oct 2019 11:56:01 +0200
Message-ID: <20191008095604.20675-1-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds busy detect for stm32 sdmmc variant.
Some adaptations are required:
-On sdmmc the data timer is started on data transfert
and busy state, so we must add hardware busy timeout support.
-Add busy_complete callback at mmci_host_ops to allow to define
a specific busy completion by variant.
-Add sdmmc busy_complete callback.

V7:
-Patch 1/3: rephrasing like proposed (thx ulf)
-If busy timeout is undefined => increase to 10s
-Keep busy_detect.
-Patch 3/3: rephrasing comment header
-Avoid twice read of status register
-Avoid writing in MMCIMASK0 & MMCICLEAR if not modified

V6:
-mmci_start_command: set datatimer only on rsp_busy flag
(remove host->mrq->data).
-move max_busy_timeout in set_ios callback.
-typo fix: err_msk, clks on one lines.

V5:
-Replaces !cmd->data to !host->mrq->data to avoid overwrite
 of datatimer register by the first command (cmd23, without data) of
 SBC request.

V4:
-Re-work with busy_complete callback
-In series, move "mmc: mmci: add hardware busy timeout feature" in
first to simplify busy_complete prototype with err_msk parameter.

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
  mmc: mmci: add hardware busy timeout feature
  mmc: mmci: add busy_complete callback
  mmc: mmci: sdmmc: add busy_complete callback

 drivers/mmc/host/mmci.c             | 178 +++++++++++++++++-----------
 drivers/mmc/host/mmci.h             |   5 +
 drivers/mmc/host/mmci_stm32_sdmmc.c |  42 +++++++
 3 files changed, 159 insertions(+), 66 deletions(-)

-- 
2.17.1

