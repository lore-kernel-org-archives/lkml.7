Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27594C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18CF21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WWtCrMZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfKHQiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:38:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46604 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbfKHQiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:38:00 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA8GMQZi012507;
        Fri, 8 Nov 2019 17:37:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=9lW6n8rFOgqzJMfjsHiMgS0ryYK11DszppfOslpW2ug=;
 b=WWtCrMZiAzJ2PyStqJMJLmZU7b3AE3X1w3ARQJit4KN+/jMv6n6FVrWM2H7SLocRuyF9
 xTAKZUhKLseSHeQKrflhFXi+TTMPb/3vWnNm7mu/65LZmB5m4sgaGxg3mq2OlFjXvkC1
 kmS19lSHSBpSU/W6OB0gbbNBINzPA6OBFtNcBp2jGRkLRMeF6vW2aLeK9Hm8C4PACsN2
 NaV+Io86QC3FPiE0EzWvM5O0QJ3EfRyYBSUKjeefOOsOxBkYcx/90uOVCs8JwZ5VXrHH
 OaL3WA3udoxxzLTabKflxRFBiwtbIylvgAaP8VZPU1LZnW5ncE/lSvQbpztxDaC2de3p Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w41vh4nuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 17:37:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1302710002A;
        Fri,  8 Nov 2019 17:37:46 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D804E2C38AC;
        Fri,  8 Nov 2019 17:37:46 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 8 Nov 2019
 17:37:46 +0100
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 8 Nov 2019 17:37:46 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 0/2] Add support for ADC on stm32mp157c-ed1
Date:   Fri, 8 Nov 2019 17:37:37 +0100
Message-ID: <1573231059-395-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_05:2019-11-08,2019-11-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for digital-to-analog converter on
stm32mp157c-ed1 board:
- define pins that can be used for ADC
- configure ADC channels to use these

Fabrice Gasnier (2):
  ARM: dts: stm32: add ADC pins used for stm32mp157c-ed1
  ARM: dts: stm32: add ADC support to stm32mp157c-ed1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  6 ++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts     | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.7.4

