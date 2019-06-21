Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03847C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C761A208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="k2RLRaZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFUOu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:50:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32192 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfFUOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:50:55 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LEbCh7025330;
        Fri, 21 Jun 2019 16:50:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=HJ0CqY8bW91EX2SWPcZ15rMKds2BBP88CmgxAnUANf4=;
 b=k2RLRaZLXke5j7JsPj6TviyqvKK/1JGgzJJgk7D9i5hDYpiUCU0KM/MYd92FL/CPCVIx
 PhBoQRMc92hhBJ8vAquwmJHnX2eFd5XeE65QPa2CrUMQzNOpndLzG5iMlGJZfpLgpRbY
 8tOK11PkZ5GXkr1eLs2D+XYMHzoiQB5ycRyVetVhLMMptA/oJkS+xGFg/GmtmbzZ7yxK
 8tRSipbt9EMY1eb8AVgiYHqvhkHWKiYK1I1g3Q1t7LHBHQRP7tNuQVl69Y4JmkpkMZEd
 6pfM0ipmCgYiJanmnOpdaiiHcpVdXW5Uo+N3KDB/26i0h2K3Vy+UFkMqtbNB5W0/Ac9k HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7wxssnyu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Jun 2019 16:50:36 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 569C53A;
        Fri, 21 Jun 2019 14:50:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B1232BD7;
        Fri, 21 Jun 2019 14:50:36 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Jun 2019 16:50:35
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <linux@armlinux.org.uk>,
        <olof@lixom.net>, <arnd@arndb.de>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH 0/4] ARM: dts: stm32: enable FMC2 NAND controller on stm32mp157c-ev1
Date:   Fri, 21 Jun 2019 16:49:46 +0200
Message-ID: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds and enables FMC2 NAND controller used on
stm32mp157c-ev1.

Christophe Kerello (4):
  ARM: dts: stm32: add FMC2 NAND controller support on stm32mp157c
  ARM: dts: stm32: add FMC2 NAND controller pins muxing on
    stm32mp157c-ev1
  ARM: dts: stm32: enable FMC2 NAND controller on stm32mp157c-ev1
  ARM: multi_v7_defconfig: add FMC2 NAND  controller support

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 44 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 16 +++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 19 +++++++++++++
 arch/arm/configs/multi_v7_defconfig       |  1 +
 4 files changed, 80 insertions(+)

-- 
1.9.1

