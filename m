Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05B3C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1DF206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="c5frr6oN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfEQImf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:42:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49837 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728213AbfEQImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:42:31 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4H8cNMc032499;
        Fri, 17 May 2019 10:42:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=uSLvWJ3dEGW9QdGxFgJ/sUFT5ymEF6rJMqGW79HtTfo=;
 b=c5frr6oN8I07Ij66WW1SwP7W+JMkiOvn2oHcDxNbqFXNQFTKOzSA8ohbncXhKnF0Pqns
 sKt4RrIiz7GFMLawIFZkqABUaWFlB4WYl2EuVmVZqUHsDyMPFXOFLX37kOLr9BuRByEe
 rdoj0EAM40DNxUJhSijlHRYS6UKkHj6nRHjirZFhOF27NXNEhgyHHActJR1zaadetisD
 gtcTBBTjNaYjmjtD0ROTqeYHmMMGyL6GpjFzK5qWoz0tfV4lYcgJ+fcdPMmHSwK1woql
 Px0PNZ6r+XOuJFIjyQSItIOy0Y37nwnwF6C3c1cXN8zuAJPSq14ICeAFtsqi5Nj/SWXn tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sg0anjddj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 17 May 2019 10:42:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8179342;
        Fri, 17 May 2019 08:42:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1116B246F;
        Fri, 17 May 2019 08:42:12 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 17 May 2019 10:42:11
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [RESEND v2 0/3] Add Vivante GPU support on STM32MP157c
Date:   Fri, 17 May 2019 10:42:05 +0200
Message-ID: <1558082528-12889-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and enable Vivante GPU on stm32mp157c for ED1, DK1 and DK2 boards.
---
  Version history:
    v2:
       * move GPU reserved memeory out of bottom DDR to let free this area for
         U-Boot
    v1:
       * Initial
---
Pierre-Yves MORDRET (3):
  ARM: dts: stm32: Add Vivante GPU support on STM32MP157c
  ARM: dts: stm32: enable Vivante GPU support on stm32mp157c-ed1 board
  ARM: dts: stm32: enable Vivante GPU support on stm32mp157a-dk1 board

 arch/arm/boot/dts/stm32mp157a-dk1.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 10 ++++++++++
 3 files changed, 42 insertions(+)

-- 
2.7.4

