Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E67C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01992173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="idirxlLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfKFKJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:09:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29238 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731322AbfKFKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:09:54 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6A7GcF003655;
        Wed, 6 Nov 2019 11:09:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=yLZQUtSjGSzVnw3BQOy5OFmY0CJnDZp/NP+2DESObLk=;
 b=idirxlLFT+vl2IaaPyGgU0OET9Yr/TDjr9KawtKmQq6iuKpbsbkGS30z4BzQmtpy3Tr4
 QmBdUCyjzpiS2Ik0RAcJXqwcSEQtCT8ei72WPPZ+sImt2p18GiwOtxRFWrMfz7FrCJAq
 4Lz4NOyG7Rlw6CvpVquJsFAQkITksbob04LQii9VNo1KK7QX0K5xyrhXZkcHFLXayKDV
 gQgyBWSAKJVRP6R+Nc17MANoynKaIHhmqkW+9FaoWW/kCT6YCXiEhzoroD8ZpAXhS89U
 kstsnOyXveFL25nQs0T70wElrKjitdX/IeNkyHdqF2DSGj9yeib+MNXZnrdJKsQosf0e rQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w1054vs3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 11:09:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8DC01100034;
        Wed,  6 Nov 2019 11:09:41 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 776892AD337;
        Wed,  6 Nov 2019 11:09:41 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019
 11:09:41 +0100
Received: from localhost (10.48.1.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 6 Nov 2019 11:09:40 +0100
From:   Yann Gautier <yann.gautier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yann Gautier <yann.gautier@st.com>
Subject: [PATCH 0/4] Update sdmmc nodes for STM32MP1
Date:   Wed, 6 Nov 2019 11:09:34 +0100
Message-ID: <20191106100938.11368-1-yann.gautier@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32MP1 SoC embeds 3 instances of the SDMMC internal peripheral.
The sdmmc2 and sdmmc3 nodes are added in the SoC DT file, as well as
the required pins configuration.
The boards DT files are also updated:
- An eMMC is connected on SDMMC2 on STM32MP157C-ED1 and EV1 boards
- SDMMC3  can be used on the GPIO expansion pins on EV1 and DK1/DK2
boards.

Yann Gautier (4):
  ARM: dts: stm32: update slew-rate properties for sdmmc1 on stm32mp157
  ARM: dts: stm32: add sdmmc2 & 3 nodes for STM32MP157 SoC
  ARM: dts: stm32: enable sdmmc2 node for stm32mp157c-ed1 board
  ARM: dts: stm32: add sdmmc3 node for STM32MP1 boards

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 200 +++++++++++++++++++++-
 arch/arm/boot/dts/stm32mp157a-dk1.dts     |  12 ++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     |  16 ++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     |  12 ++
 arch/arm/boot/dts/stm32mp157c.dtsi        |  33 +++-
 5 files changed, 263 insertions(+), 10 deletions(-)

-- 
2.17.1

