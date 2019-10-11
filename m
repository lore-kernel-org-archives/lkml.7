Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD20AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944D221E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uIUnsRMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfJKNPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:15:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53445 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728245AbfJKNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:15:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BD6lxu021879;
        Fri, 11 Oct 2019 15:15:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=2OJ63JRDHcE35+LH+1/BTSgThb8JET2V1q7cuqnG+F0=;
 b=uIUnsRMlUIA++sDY+nCBcDNNH3YlJtiiOVOt88abPsuDz0wB4V8cMuAvWxiNr8gvmhxi
 9JbYbEt9W5/ZPNOT5MwG5dr9hDJkuTKzTpt5epXeDRv8YKRFeKYGgZ4EqcvsYdPQTWKA
 d9rIqaKqB49S0Vd4TVRJgdYwnK5t6OssiS0n5SCbScCRiOVcA+pjbv7GL8tHnbh+fdlA
 fm902q1QSvLjSFtbW6QB4WSxefLFgvsr+9O5sj+iAMp2zSquHsnmStl4CZiOPxALkr5H
 bZ+UgYGGNN7bVY+JlUxN52NlvhotyLvTAKd5pEEiFb2PUqHMNIvVqKv9a17svKRncnpr +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxw9yag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 15:15:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA71310002A;
        Fri, 11 Oct 2019 15:15:29 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5F6B2BEC72;
        Fri, 11 Oct 2019 15:15:29 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct
 2019 15:15:29 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct
 2019 15:15:29 +0200
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
Subject: [PATCH 0/2] mmc: add unstuck function if host is in deadlock state
Date:   Fri, 11 Oct 2019 15:15:00 +0200
Message-ID: <20191011131502.29579-1-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

As discussed in this thread: https://patchwork.kernel.org/patch/10786421/
After a request, the host could be in deadlock state, and waiting
for a specific action to unstuck the hardware block before
resending a new command. This series adds mmc_hw_unstuck
callback (structure mmc_host_ops) before resending a new command
(call in mmc_blk_mq_rw_recovery, mmc_wait_for_req_done).

Ludovic Barre (2):
  mmc: add unstuck function if host is in deadlock state
  mmc: mmci: add unstuck feature

 drivers/mmc/core/block.c | 11 +++++++++++
 drivers/mmc/core/core.c  | 35 +++++++++++++++++++++++++++++++++--
 drivers/mmc/host/mmci.c  | 23 +++++++++++++++++++++--
 include/linux/mmc/core.h |  1 +
 include/linux/mmc/host.h |  7 +++++++
 5 files changed, 73 insertions(+), 4 deletions(-)

-- 
2.17.1

