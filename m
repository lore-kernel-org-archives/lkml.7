Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0DAFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB30F2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MX+pb3As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405139AbfJPMON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:14:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731285AbfJPMON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:14:13 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GCBKXh016165;
        Wed, 16 Oct 2019 14:13:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Ez0GavI0R2gyUyK3i2b9o2TNl6w+iegZF0LD+Nt0+s0=;
 b=MX+pb3AsQ6p30uX/kZiGuk4jtLPNLRaFrJgnN46h7Rl5eleOK8D2NqliskyPVcx58rmu
 v743d868MOmr5mrsJzXqfG7KN81s3oMO199Y4vXr5C3ilKnex4Wd3Bny2nvZdM2bYuln
 5bnuOhKX2NaA3YWfaHEoR1IA4vbh8NASw9WYKkTky+EK3huFlnG01u7NtIkVql3PjJOO
 D/6u1JH4gUK2oy0bLiYMb1b5iWxcaB1eF34VZYVTD+mikfmAMaFlNbYUqwzjGkui7sST
 U/U01H/myp+obbjG+4u9XImgxiQEYoMXMCmk0mZRyFRaCR4fkPhtxjumNBNBb3agMcdW OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vk3y9xf8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 14:13:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 499F4100034;
        Wed, 16 Oct 2019 14:13:58 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 31DDD20A92D;
        Wed, 16 Oct 2019 14:13:58 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 16 Oct
 2019 14:13:58 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 16 Oct 2019 14:13:57
 +0200
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
Subject: [PATCH 0/2] mailbox: stm32-ipcc: rework wakeup
Date:   Wed, 16 Oct 2019 14:13:47 +0200
Message-ID: <1571228029-31652-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dedicated wakeup IRQ as wakeup can be handled by the RX IRQ.

Fabien Dessenne (2):
  dt-bindings: mailbox: stm32-ipcc: Updates for wakeup management
  mailbox: stm32-ipcc: Update wakeup management

 .../devicetree/bindings/mailbox/stm32-ipcc.txt     |  4 +--
 drivers/mailbox/stm32-ipcc.c                       | 36 +++++-----------------
 2 files changed, 9 insertions(+), 31 deletions(-)

-- 
2.7.4

