Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56818C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B53B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lYFRMiAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfGAIPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:15:19 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18316 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727967AbfGAIPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:15:16 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x618CiNV016226;
        Mon, 1 Jul 2019 10:14:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=hFwLxNltwxLPb7ENYweaemIXvQCfpR8maLmH6iPD0zc=;
 b=lYFRMiACJlg8tAf3KRmNIm/mkd2Juy85VeyEwdJ5oG1eXZy+z6LNV5/iMZdUQVuxw0Vm
 V4sOxi8s41OX/D27ZLAkk9nHe71A6vbvd89cSO++VpwrZvGHtustTFL4rNcffIoekLxw
 l8Gm2OZK80o1s/OEQ79r4paEtrJbfnqdGdR6agMJ339v7irgX89Db+6jiLEfVW4VKCoO
 1qls3Zi/h9Swd0w7Yf9/5iBnVqlR3m7GS+wVSvL96S0tF6MZ9CS/M0QLhL0Il7zxuK7O
 FfA39gYW4L7RTfWyRs7nCkoHXWwth9q42y0vuqoe4TT+D1A+ebcuFe3pKFVruXUDoQsB Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tdwf0kn6f-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Jul 2019 10:14:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB55043;
        Mon,  1 Jul 2019 08:14:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 921D4191D;
        Mon,  1 Jul 2019 08:14:33 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jul 2019 10:14:33
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/4] regulator: add support for the STM32 ADC booster
Date:   Mon, 1 Jul 2019 10:14:21 +0200
Message-ID: <1561968865-22037-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 3.3V booster regulator embedded in stm32h7 and stm32mp1
devices, that can be used to supply ADC analog input switches.
It's useful to reach full ADC performance when their supply is below 2.7V
(vdda by default).

Changes in v2:
- rebase on top of for-next branch

Fabrice Gasnier (4):
  dt-bindings: regulator: add support for the stm32-booster
  regulator: add support for the stm32-booster
  ARM: multi_v7_defconfig: enable STM32 booster regulator
  ARM: dts: stm32: add booster for ADC analog switches on stm32mp157c

 .../bindings/regulator/st,stm32-booster.txt        |  18 +++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   6 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/regulator/Kconfig                          |  11 ++
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/stm32-booster.c                  | 132 +++++++++++++++++++++
 6 files changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
 create mode 100644 drivers/regulator/stm32-booster.c

-- 
2.7.4

