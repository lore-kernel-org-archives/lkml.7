Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9A3C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D12214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dEdNnG1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389432AbfIMOfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:35:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13306 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388414AbfIMOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:35:13 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DEV1EQ017893;
        Fri, 13 Sep 2019 16:35:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=WcH/XeLRXrchzGM2oayh6FpZp9ixOv6Rjd72cfZUEDM=;
 b=dEdNnG1PFncizfoScByurpL+4XLDP78kKGX2VXj5XAwHuJItlL96iVQhZhLXsannVizP
 tyFEJpueQyblheGUGcSM8Xr7yB85XlCUlg0uoJJAH05Cprzm2aOZ3fy2ENaR7uNxtzx9
 sbxpyCI0T0CMVizoc1HWiw0SqH/yvCGXukCoFA/PgrZbxZNm0v32vUEU9HidLEhHLryD
 Ur3ghBBLiZCPpay1hXWNRI26JRn/GmWqqvsBWGRLzmUO0Bs0jt/nA1/5iF5+MKdQhBYx
 INkWAyqKg11YTeFrkP4ux+w/Mvpzg2/dIjAIY65SGCQq0HjT/3aUm+D9efC8t0neqqF3 pg== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2uytdx5n81-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Sep 2019 16:35:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2581F4B;
        Fri, 13 Sep 2019 14:34:57 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3853E2C86AE;
        Fri, 13 Sep 2019 16:34:57 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 13 Sep
 2019 16:34:57 +0200
Received: from localhost (10.48.1.232) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 13 Sep 2019 16:34:56 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 0/3] Add support for ADC on stm32mp157a-dk1
Date:   Fri, 13 Sep 2019 16:34:37 +0200
Message-ID: <1568385280-2633-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.232]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_07:2019-09-11,2019-09-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for ADC on stm32mp157a-dk1 board:
- enable vrefbuf regulator used as reference voltage
- define ADC pins for AIN connector and USB Type-C CC pins
- configure ADC1 and ADC2 to use these

Fabrice Gasnier (3):
  ARM: dts: stm32: Enable VREFBUF on stm32mp157a-dk1
  ARM: dts: stm32: add ADC pins used on stm32mp157a-dk1
  ARM: dts: stm32: enable ADC support on stm32mp157a-dk1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 16 +++++++++++++++
 arch/arm/boot/dts/stm32mp157a-dk1.dts     | 34 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

-- 
2.7.4

