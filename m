Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB34CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A5720874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="j7zBi87r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfJ3N5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:57:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbfJ3N5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:57:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9UDqLfC032051;
        Wed, 30 Oct 2019 14:57:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=eH7mwtf1v4gBy1/YWM1SPqmdubzRlFaFMR+UtH0lgC8=;
 b=j7zBi87rylKqaJglCnoq5i6DN3YP+/mR6z07XXagMi0XDRM44KxJ5+Sb83qZHC+5yYZx
 iRd45/jsISq6IJy3j5ZKm38/7/LOMY+CRDQ5kdjSJ9KCPHqvVD3pGjVKQ/yrSpCg3YwU
 +s5aL9MpRVZ92mO4hVMSiYfZwDbQnZAX/21SxyqMYqCJBsjwddLUOyBNAIZsNISKvAC5
 6ETNFNPIiGfywFpLppHCsNUg8j7EDf7IHUcsgLlT2q7Fe3xMBevtG0fKbwJ+rpJdq19X
 Qtf7Agr6IUOHsVe++qHwjefrRRJbtxju65BDdqV+txXiKHzjg+YNVTMAYo2mx8/BOVem RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vxwf442u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 14:57:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8775910002A;
        Wed, 30 Oct 2019 14:57:05 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 592C72C07FB;
        Wed, 30 Oct 2019 14:57:05 +0100 (CET)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct
 2019 14:57:05 +0100
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct 2019 14:57:04
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH v2 0/2] mailbox: stm32-ipcc: rework wakeup
Date:   Wed, 30 Oct 2019 14:56:59 +0100
Message-ID: <1572443821-28112-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_06:2019-10-30,2019-10-30 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dedicated wakeup IRQ as wakeup can be handled by the RX IRQ.

Changes since v1:
- typo fix
- add Rob's Acked-by for bindings

Fabien Dessenne (2):
  dt-bindings: mailbox: stm32-ipcc: Updates for wakeup management
  mailbox: stm32-ipcc: Update wakeup management

 .../devicetree/bindings/mailbox/stm32-ipcc.txt     |  4 +--
 drivers/mailbox/stm32-ipcc.c                       | 36 +++++-----------------
 2 files changed, 9 insertions(+), 31 deletions(-)

-- 
2.7.4

