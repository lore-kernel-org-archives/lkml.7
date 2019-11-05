Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F8AC17461
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EFA21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IyYB0QNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbfKEMwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:52:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23472 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388488AbfKEMwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:52:46 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5Cq6Ga024537;
        Tue, 5 Nov 2019 13:52:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=EX94p2HyA3Y7EyZnwdjULwer7EInjO1VlhUrZLUYn9g=;
 b=IyYB0QNUCyGMqFUhUJSjt7NG3fgwbPN21qY0Oy6tt8zA3hfrybP5wllZb6mEOF3mSJd7
 aF9YJSwFasM+m2eWuQytRyTUxjLvrvbR/UiWMrksTlz62xSgb5Zya+wYHia/xro7CtuI
 jJTk5jA1pRZWTTA4bDNW1YFX2CVgWCPYppNPCK3gkwBlpVOBOwB2gGBioemzZf+yRqTQ
 EkfChjuJNM+w6EaGYEmeHLxV9DylEQ/St96V9hmZGAikB3zqUUk0CnsavwhZmjY/HpbF
 4IyAS7A13l/kMJETjG/VnqsS2e3Z/43iqeTeCvLJsII+h1jXLjQfbBNOcBohEQTi89SM sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w0ytcr0bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 13:52:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A9B3510002A;
        Tue,  5 Nov 2019 13:52:33 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 942672BC5E5;
        Tue,  5 Nov 2019 13:52:33 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019
 13:52:33 +0100
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019 13:52:32 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 0/4] Update PWM support on stm32mp157 boards
Date:   Tue, 5 Nov 2019 13:52:17 +0100
Message-ID: <1572958341-12404-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_04:2019-11-05,2019-11-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series update PWM support on stm32mp157c-ev1 and stm32mp157a-dk1
boards, e.g. add pinmuxing and use them in board device-tree.
- Add PWM sleep pins that can be used on stm32mp157c-ev1 board
- Add PWM pins that can be used on stm32mp157a-dk1 board
- Add PWM pinctrl sleep state on stm32mp157c-ev1 board
- Add PWM support on stm32mp157a-dk1 board

Fabrice Gasnier (4):
  ARM: dts: stm32: add pwm sleep pin muxing for stm32mp157c-ed1
  ARM: dts: stm32: add pwm pin muxing for stm32mp157a-dk1
  ARM: dts: stm32: add pwm sleep pins to stm32mp157c-ev1
  ARM: dts: stm32: add support for PWM on stm32mp157a-dk1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 99 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157a-dk1.dts     | 85 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     |  9 ++-
 3 files changed, 190 insertions(+), 3 deletions(-)

-- 
2.7.4

