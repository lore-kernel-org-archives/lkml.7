Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507B8C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A335218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NPPjohpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfGCKJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:09:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39005 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbfGCKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:09:00 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63A78vA000403;
        Wed, 3 Jul 2019 12:08:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=yQLPGIAaYXazeAIq/YODkM7dpT27pO1tgwGE1je5OLc=;
 b=NPPjohpl4RNSBC7RN6FWvoNHRNykLuIpwfpJ0wKleYHtrYmiXHHp0rL6nIsIxhOj3XPt
 wvPP4xrcOtebmS/LHq/xKBBj3uWO+R5t46SeolR0ZCGwjUWIuw3JPOrO0bFbZYopEf0k
 p8xbGCliCA2pNjMK9n/tho7/8x8ZPcKK3SCQ5jvOwJSI59jBcgGzBouElFPgzuAMJofr
 kBgxG5LdWfl0A2EHqjQAhIrAFMWuI6szWjnngs2IMYLp2ZneuA83AIFmnEkwbCuKqTOS
 EgI11ymbmakYjj6o31+aVu02Vlwx1QZ1/QaaOMJ9LBXCQgPC9HKB6VmwBJaGUkM2DtXB hQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tdwrv2j5b-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Jul 2019 12:08:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4D1231;
        Wed,  3 Jul 2019 10:08:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B01B92681;
        Wed,  3 Jul 2019 10:08:23 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 12:08:23 +0200
Received: from localhost (10.48.0.167) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019 12:08:23 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] STM32 ADC analog switches supply control
Date:   Wed, 3 Jul 2019 12:08:13 +0200
Message-ID: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.167]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for SYSCFG bits that control ADC analog switches
supply on STM32MP1 and STM32H7.

The ADC inputs are multiplexed with analog switches which have reduced
performances when their supply is below 2.7V. Analog switches supply
can be controlled using SYSCFG bits, to reach full ADC performance.

---
Changes in v2:
- Rework since: "Add missing vdda-supply to STM32 ADC" series [1].
- Booster is handled by a regulator driver, see
  "regulator: add support for the STM32 ADC booster" series [2].
- Only enable vdd regulator when needed
- Fix typos

[1] https://lkml.org/lkml/2019/6/19/411
[2] https://lkml.org/lkml/2019/6/28/188

Fabrice Gasnier (3):
  dt-bindings: iio: adc: stm32: add analog switches supply control
  iio: adc: stm32-adc: add analog switches supply control
  ARM: dts: stm32: add syscfg to ADC on stm32mp157c

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   6 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   1 +
 drivers/iio/adc/stm32-adc-core.c                   | 193 ++++++++++++++++++++-
 3 files changed, 199 insertions(+), 1 deletion(-)

-- 
2.7.4

