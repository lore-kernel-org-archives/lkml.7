Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD42C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D952087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfCYRCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:02:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44040 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729127AbfCYRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:02:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PGw2Is018055;
        Mon, 25 Mar 2019 18:01:56 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddhacy7n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Mar 2019 18:01:56 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C6C231;
        Mon, 25 Mar 2019 17:01:55 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3624E111F;
        Mon, 25 Mar 2019 17:01:55 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 25 Mar
 2019 18:01:55 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 25 Mar
 2019 18:01:55 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 0/2] spi: stm32-qspi: add dma support
Date:   Mon, 25 Mar 2019 18:01:38 +0100
Message-ID: <1553533300-29999-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds dma support for the stm32-qspi.
In read mode, the memory map is preferred vs dma
(due to better throughput). If the dma transfer fails the buffer is
sent by polling.

V2:
-fixe build error in patch 1/2 (move qspi->phys_base in patch 2)

Ludovic Barre (2):
  spi: stm32-qspi: add spi_master_put in release function
  spi: stm32-qspi: add dma support

 drivers/spi/spi-stm32-qspi.c | 182 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 163 insertions(+), 19 deletions(-)

-- 
2.7.4

