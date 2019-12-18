Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2001C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDE024672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ubfyudS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLROtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:49:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20802 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbfLROtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:49:03 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIEmIfB006137;
        Wed, 18 Dec 2019 15:48:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=pBtt1AdthJKUtdU0V2EIePL1CkP6ErraDD6TNWmPZg4=;
 b=ubfyudS6c4uk+dwYiYUoeyNJfdO75TSjfRsdDKacTyPtYamxcCRam0IzVDa2TEu34BYR
 jCqo30x4qhHZEQMR6BXBp28ofOYfyyeqx+m5bZ/M8Kg22GMiPLfcJ79mgK9sddQYlmge
 ruSThzP9M1Tjw7IbEa0BJdSwnKX+VH/oRhEBaal0HA3xnLfJK3D+gMfeyju6DmVJ7njc
 dQpdvLpIBdpuP+SmmTtliYOeiUwvy3XDZpIJkDYYwYcQ70KYZGpMnrkjJWONekl2CzzM
 hg1WTys20F6K+O6JIUwHzXJ3JfsVR2GuU8ObTZhvLFcFVuNqAnJkzR/7OsURztU33oh6 hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp374y8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:48:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7383410002A;
        Wed, 18 Dec 2019 15:48:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5CABF207547;
        Wed, 18 Dec 2019 15:48:46 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Dec 2019 15:48:45
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/3]  Convert STM32 dma to json-schema 
Date:   Wed, 18 Dec 2019 15:48:41 +0100
Message-ID: <20191218144844.7481-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

version 2: Only contains rebased dtsi file on top of stm32-next after
DT diversity patches

This series convert STM32 dma, mdma and dmamux bindings to json-schema.
Yaml bindings use dma-controller and dma-router schemas where nodes names
are verified which lead to fix stm32f746, stm32f743 and stm32mp157 device
tree files. 


Benjamin Gaignard (3):
  ARM: dts: stm32: fix dma controller node name on stm32f746
  ARM: dts: stm32: fix dma controller node name on stm32f743
  ARM: dts: stm32: fix dma controller node name on stm32mp157c

 arch/arm/boot/dts/stm32f746.dtsi  | 4 ++--
 arch/arm/boot/dts/stm32h743.dtsi  | 6 +++---
 arch/arm/boot/dts/stm32mp151.dtsi | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.15.0

