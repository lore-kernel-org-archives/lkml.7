Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A225C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D47B2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xMZPk79N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF1IId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:08:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60932 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbfF1IIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:08:31 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5S86bL9020381;
        Fri, 28 Jun 2019 10:08:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=OkJkWdO3ZoRZHiMztQUd9Pc0c3rpuXyKwA33SFtPdis=;
 b=xMZPk79Nw36AwFGsijRPGGVDagkAqM4WO+0RiHwIGMHiIqaZjqsAKo3y9N5X0uPR2Ogs
 FdXLh7nt5Xivm/T0Ugd3M1eBy6XCczmS+cSngYs+FFM3A+X9nw2gSAgLf6/3DInv7Phs
 c2QI/TTpDnVM3wH/bBu/wTIYUU+0h5aoQe8DBDV/Aaotb52iQObeqNUSEZitstXzvjIj
 amzsL6YfcM4T8MjYoeoQwFBfv5rTQxRpCnqT9JunHoZ+N3jaKkzl30YNkY5RU/1NYs8y
 CqX2qjsJw+bmoYwo96rtICsd2SPkyxGs9tJ8V/kYoM/RcceIjknW3gYM+RzuuRc5PBOj fA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t9d2gvcwq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Jun 2019 10:08:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7149431;
        Fri, 28 Jun 2019 08:08:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 51A6616AF;
        Fri, 28 Jun 2019 08:08:14 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Jun 2019 10:08:13
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/4] regulator: add support for the STM32 ADC booster
Date:   Fri, 28 Jun 2019 10:08:05 +0200
Message-ID: <1561709289-11174-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 3.3V booster regulator embedded in stm32h7 and stm32mp1
devices, that can be used to supply ADC analog input switches.
It's useful to reach full ADC performance when their supply is below 2.7V
(vdda by default).

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

