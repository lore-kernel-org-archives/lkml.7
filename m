Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C59C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC2F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCMPvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:51:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18511 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfCMPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:51:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DFk4QD027588;
        Wed, 13 Mar 2019 16:51:02 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r71mb959h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Mar 2019 16:51:02 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA69738;
        Wed, 13 Mar 2019 15:51:00 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A3DF853F0;
        Wed, 13 Mar 2019 15:51:00 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 13 Mar
 2019 16:51:00 +0100
Received: from localhost (10.201.23.25) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 13 Mar 2019 16:51:00
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/6] hwspinlock: allow sharing of hwspinlocks
Date:   Wed, 13 Mar 2019 16:50:31 +0100
Message-ID: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation does not allow two different devices to use
a common hwspinlock. This patch set proposes to have, as an option, some
hwspinlocks shared between several users.

Below is an example that explain the need for this:
	exti: interrupt-controller@5000d000 {
		compatible = "st,stm32mp1-exti", "syscon";
		interrupt-controller;
		#interrupt-cells = <2>;
		reg = <0x5000d000 0x400>;
		hwlocks = <&hsem 1>;
	};
The two drivers (stm32mp1-exti and syscon) refer to the same hwlock.
With the current hwspinlock implementation, only the first driver succeeds
in requesting (hwspin_lock_request_specific) the hwlock. The second request
fails.


The proposed approach does not modify the API, but extends the DT 'hwlocks'
property with a second optional parameter (the first one identifies an
hwlock) that specifies whether an hwlock is requested for exclusive usage
(current behavior) or can be shared between several users.
Examples:
	hwlocks = <&hsem 8>;	Ref to hwlock #8 for exclusive usage
	hwlocks = <&hsem 8 0>;	Ref to hwlock #8 for exclusive (0) usage
	hwlocks = <&hsem 8 1>;	Ref to hwlock #8 for shared (1) usage

As a constraint, the #hwlock-cells value must be 1 or 2.
In the current implementation, this can have theorically any value but:
- all of the exisiting drivers use the same value : 1.
- the framework supports only one value : 1 (see implementation of
  of_hwspin_lock_simple_xlate())
Hence, it shall not be a problem to restrict this value to 1 or 2 since
it won't break any driver.

Fabien Dessenne (6):
  dt-bindings: hwlock: add support of shared locks
  hwspinlock: allow sharing of hwspinlocks
  dt-bindings: hwlock: update STM32 #hwlock-cells value
  ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
  ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
  ARM: dts: stm32: hwlocks for GPIO for stm32mp157

 .../devicetree/bindings/hwlock/hwlock.txt          | 27 +++++--
 .../bindings/hwlock/st,stm32-hwspinlock.txt        |  6 +-
 Documentation/hwspinlock.txt                       | 10 ++-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  2 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 | 10 +++
 drivers/hwspinlock/hwspinlock_core.c               | 82 +++++++++++++++++-----
 drivers/hwspinlock/hwspinlock_internal.h           |  2 +
 7 files changed, 108 insertions(+), 31 deletions(-)

-- 
2.7.4

