Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BBFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77BE2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bheU7pr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfDJMMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:12:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36086 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729613AbfDJMMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:12:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ABLkjM023359;
        Wed, 10 Apr 2019 13:31:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=fhLtlL/NlC86mS/NsbhVuU1oLUbCI8C1Mjsye0xYcb8=;
 b=bheU7pr5faXw9PBBSRPAYFP5OQQdRlsqYs9fXO9TPguvGQKir8aFBbNs3RJoovvyItC0
 3JjkKwCPVawPsey1ZIImi1IDlT63vdjBUyfUhT/04gJlXs35Nib9w38/tcHMDLJgNUU/
 wknqiCMxavpyhH/GzsjbMl3aCb6OA3aDDYYjhfkUII1AHP+9yPaPr8ZNRK8AK1unWJ/0
 sn5vXolgpvdZcgkxaYVig3RYkGC9Seq+8IFWOPpkt9epSGGcjev4rQCXkk4NraLltO1p
 Xh85/KtzEPg16aUjVSwAcdHoxpaYLLjuewtD+wBQvP8+GBBIFqoAQ8mKXMheft6Z9wdG qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcp6j3q-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 13:31:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 91A3A38;
        Wed, 10 Apr 2019 11:31:42 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2418715BC;
        Wed, 10 Apr 2019 11:31:42 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr 2019 13:31:42
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 0/5] Add pin package management on STM32P157
Date:   Wed, 10 Apr 2019 13:30:19 +0200
Message-ID: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series adds support of chip packages for STM32MP157 SOC.
Available packages are:

STM32MP_PKG_AA: LFBGA448 (18*18), 176 IOs
STM32MP_PKG_AB: LFBGA354 (16*16), 98 IOs
STM32MP_PKG_AC: TFBGA361 (12*12), 148 IOs
STM32MP_PKG_AD: TFBGA257 (10*10), 98 IOs

As ball-out is different between each package, this series covers those
differences by creating dedicated pinctrl dtsi files. Each dtsi pinctrl
package file describes the package ball-out through gpio-ranges. A new
dt property is also added ("st,package") to provide to stm32 pinctrl driver
the package to use and so the available pins.

stm32mp157a-dk1 / dk2 boards embed a STM32MP_PKG_AC (TFBGA361 (12*12))
package.
stm32mp157c-ed1 / ev1 boards embed a STM32MP_PKG_AA (LFBGA448 (18*18))
package.

Regards

Alex

Alexandre Torgue (5):
  dt-bindings: pinctrl: stm32: add new entry for package information
  pinctrl: stm32: introduce package support
  pinctrl: stm32: add package information for stm32mp157c
  pinctrl: stm32: align stm32mp157 pin names
  ARM: dts: stm32: use dedicated files to manage stm32mp157 packages

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |    2 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |   12 +
 arch/arm/boot/dts/stm32mp157a-dk1.dts              |    2 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |    2 +-
 arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi       |   90 ++
 arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi       |   62 ++
 arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi       |   78 ++
 arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi       |   62 ++
 drivers/pinctrl/stm32/pinctrl-stm32.c              |   68 +-
 drivers/pinctrl/stm32/pinctrl-stm32.h              |   14 +
 drivers/pinctrl/stm32/pinctrl-stm32mp157.c         | 1089 +++++++++++---------
 include/dt-bindings/pinctrl/stm32-pinfunc.h        |    6 +
 12 files changed, 1014 insertions(+), 473 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi

-- 
2.7.4

