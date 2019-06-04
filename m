Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CBCC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D56624C49
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wiKlCJWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfFDIzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:55:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52684 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbfFDIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:55:45 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548tKLL021280;
        Tue, 4 Jun 2019 10:55:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=aeRZHet8+3ng2HzHWI6D57uf7dMIn0WG1kjDInB0Y8s=;
 b=wiKlCJWMv8lNPSmBz84bvLgrRRzwH7Tdnn57y/e+lH3rwW6YNBFk715p8vQlrG0EeHAj
 P9hJBWBssMTTmBjE7FS8g58EUH4icp+Z5fzOZD3IU4CMNjqInVPxOxp8tWA9P/IpoLyT
 1yxYYI211XVh1IvWTEAhfAOv2ofLBPYfw+S0h03B/93sDS0ecOW0KAWl9hu9pnddQ/1Y
 fUcuMqIe7LitRBXZ836EwKcWGUnoVesQm0SPZPn9rJRV+SJVWiHu75dcERTR6Vfh/v3z
 g6NshufKOarSyR0AszxMPlGgJNcZeChWbEZUQK4xXxQIXmQYtsAzRnwaDcueef4o9Cn5 yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sundryngq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Jun 2019 10:55:28 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34DFA163;
        Tue,  4 Jun 2019 08:55:24 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 066B92507;
        Tue,  4 Jun 2019 08:55:24 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019
 10:55:23 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019 10:55:23
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        "Fabrice Gasnier" <fabrice.gasnier@st.com>
Subject: [PATCH 00/10] STM32 usart power improvements
Date:   Tue, 4 Jun 2019 10:55:09 +0200
Message-ID: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series delivers power improvements for stm32-usart driver.

Bich Hemon (4):
  dt-bindings: serial: add optional pinctrl states
  serial: stm32: select pinctrl state in each suspend/resume function
  ARM: dts: stm32: Update pin states for uart4 on stm32mp157c-ed1
  ARM: dts: stm32: Update UART4 pin states on stm32mp157a-dk1

Erwan Le Ray (6):
  dt-bindings: serial: stm32: add wakeup option
  serial: stm32: add pm_runtime support
  serial: stm32: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
  serial: stm32: add support for no_console_suspend
  ARM: dts: stm32: update uart4 pin configurations for low power
  ARM: dts: stm32: add wakeup capability on each usart/uart on
    stm32mp157c

 .../devicetree/bindings/serial/st,stm32-usart.txt  | 19 ++++-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          | 17 +++++
 arch/arm/boot/dts/stm32mp157a-dk1.dts              |  5 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |  5 +-
 arch/arm/boot/dts/stm32mp157c.dtsi                 | 40 ++++++++--
 drivers/tty/serial/stm32-usart.c                   | 88 ++++++++++++++++++++--
 drivers/tty/serial/stm32-usart.h                   |  1 +
 7 files changed, 155 insertions(+), 20 deletions(-)

-- 
1.9.1

