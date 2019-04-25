Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFEAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAAD218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Pu21MlFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfDYJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:17:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23252 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727601AbfDYJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:17:48 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P91VQh023646;
        Thu, 25 Apr 2019 11:17:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=k4yR7VZM67gzmw0WF67AGYszdkbhmOSkmRC0DSPxSLc=;
 b=Pu21MlFOMDxzensjMS7tCXCVYpX/reguFNFgOE0tovFZFtmoIpUL5tJwSmXlInHRq/We
 TnEVfhlHoIF9o5OiuQXul7MCF53ep7YZAVFgydAiW0/OO0QlrxgK5xYkbBhe35+E9C8D
 7NNgeaQXxGEONLDB2UzVtOs5F6WOuaF6ngKqQAuXE0I8TN+2TXFc2pYbbrMJZDiD1j/u
 5khTdvBvFNV9Cy+nHj32fuvKwpE80H2c9a6bMQYI240mHN+HR819AP9Y1WaF4Q/1EQvy
 DWYJPjmze53SLiP0SKGqTxIutyqhFd8QBT/jm5kJWSs+rlEY0GtpZs6Vz6JCAs3otjhf wA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6s2m23-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 11:17:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0018838;
        Thu, 25 Apr 2019 09:17:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC2851615;
        Thu, 25 Apr 2019 09:17:29 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 25 Apr
 2019 11:17:29 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 11:17:28
 +0200
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
Subject: [PATCH v2 0/6] hwspinlock: allow sharing of hwspinlocks
Date:   Thu, 25 Apr 2019 11:17:17 +0200
Message-ID: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_08:,,
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

Changes since v1:
* Removed useless 'status = "okay"' from stm32mp157c.dtsi

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
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  9 +++
 drivers/hwspinlock/hwspinlock_core.c               | 82 +++++++++++++++++-----
 drivers/hwspinlock/hwspinlock_internal.h           |  2 +
 7 files changed, 107 insertions(+), 31 deletions(-)

-- 
2.7.4

