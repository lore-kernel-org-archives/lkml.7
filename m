Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9322C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8262089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="D4yrvom4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfFUOsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:48:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53632 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFUOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:48:30 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LEaLlN015682;
        Fri, 21 Jun 2019 16:48:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Cwjx+P0CLYAdoYvZhhXI5cxvFwVJTxiGieG4J4UmpYM=;
 b=D4yrvom4rj/3v+ROxpc8HD5FCEK1xn5s7k5AoHJvDpDfMzChQN1t2oYo+ijPW8wjWZtt
 cwrU3ENjtAV5ilpUTGdqG4o81CI4Kdza1PBvtfvNPqH1SNayDubffSVMG5/t3nJHRsyW
 vyDeauZqheg6mkEblmNSJ+9FQkmDumOB1BZnE3f/AqyZC6V7jbmQ3o+H8Pd2G0K0w/FI
 FwaCcTjpzJn+ylT4ITt9eu3aQ0x//9suO9SxoGwdZpGOiII+oSCT64KCRamutk8IbYVl
 e2K4PPeYBUmjM45XJSTeI2DIJT7ZOQeI/e8HLqyI2qBEKVqW7FD7ffbrMbKHb7Jcltms CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813qtbw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Jun 2019 16:48:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7807D31;
        Fri, 21 Jun 2019 14:48:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A4E92BC9;
        Fri, 21 Jun 2019 14:48:13 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Jun 2019 16:48:12
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>
CC:     <bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH] mtd: rawnand: stm32_fmc2: increase DMA completion timeouts
Date:   Fri, 21 Jun 2019 16:48:00 +0200
Message-ID: <1561128480-14531-1-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is overloaded, DMA data transfer completion occurs after
100ms. Increase the timeouts to let it the time to complete.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 4aabea2..c7f7c6f 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -981,7 +981,7 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 
 	/* Wait DMA data transfer completion */
 	if (!wait_for_completion_timeout(&fmc2->dma_data_complete,
-					 msecs_to_jiffies(100))) {
+					 msecs_to_jiffies(500))) {
 		dev_err(fmc2->dev, "data DMA timeout\n");
 		dmaengine_terminate_all(dma_ch);
 		ret = -ETIMEDOUT;
@@ -990,7 +990,7 @@ static int stm32_fmc2_xfer(struct nand_chip *chip, const u8 *buf,
 	/* Wait DMA ECC transfer completion */
 	if (!write_data && !raw) {
 		if (!wait_for_completion_timeout(&fmc2->dma_ecc_complete,
-						 msecs_to_jiffies(100))) {
+						 msecs_to_jiffies(500))) {
 			dev_err(fmc2->dev, "ECC DMA timeout\n");
 			dmaengine_terminate_all(fmc2->dma_ecc_ch);
 			ret = -ETIMEDOUT;
-- 
1.9.1

