Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6540C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C89820896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ue87XHvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbfFMPMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:12:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12784 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732289AbfFMNuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:50:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DDkNs6010989;
        Thu, 13 Jun 2019 15:50:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=5gqbigQzuPm78gX6OwWptVfTPVoyB0SK+37QgGiOQ8o=;
 b=Ue87XHvD5ZKIXu6PdZuN239KmgTduC8gejRAYkFkvfwojL9J57hHlgZBKo5PsLmrW3j0
 pcORKZuIIkSE0HQeNcsaAH2k0JakIIGhef2Xb8qblyKU+Qor45JuCUMdhp/Unv0NsPKI
 xZKYTst+hHzM5S/TIMAbAS+QDqLVpG7nQ8zZsyPI4Bi/mOM7XmyBoz9EzDiySOBJVoO/
 XWGY/IGjQ4hJaaibCL6PDrWS8B+Qp6yyRNN/qWG8dw6VKQN6EdbodfP14L7oWk27gsAT
 aNOVid0gtvqUN7ppYoRfS22IvyFBF/GdZY+1CLzDnrgrbGAWlHgj956WjWKY3yPVMnmP dQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t2f8ecgqn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 13 Jun 2019 15:50:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B91BE34;
        Thu, 13 Jun 2019 13:50:05 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94B2F2BC0;
        Thu, 13 Jun 2019 13:50:05 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 15:50:05 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun 2019 15:50:04
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
Subject: [PATCH v3 00/10] STM32 usart power improvements
Date:   Thu, 13 Jun 2019 15:49:50 +0200
Message-ID: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series delivers power improvements for stm32-usart driver.

Changes in v3:
Move pinctrl/consumer.h include from "add support for no_console_suspend"
patch to "select pinctrl state" patch in order to solve a compilation 
issue.

Bich Hemon (3):
  dt-bindings: serial: add optional pinctrl states
  ARM: dts: stm32: Update pin states for uart4 on stm32mp157c-ed1
  ARM: dts: stm32: Update UART4 pin states on stm32mp157a-dk1

Erwan Le Ray (7):
  dt-bindings: serial: stm32: add wakeup option
  serial: stm32: select pinctrl state in each suspend/resume function
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

