Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD5CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D68420717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="j2JMjVGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390662AbfJ2QqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:46:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50512 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727763AbfJ2QqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:46:08 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TGguol026450;
        Tue, 29 Oct 2019 17:45:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=BgTIc7CMxAbrqUUG2tERc+pTVwcpfz1nuVzhlxORpJk=;
 b=j2JMjVGL5xSftDsXy0cxeHOnlpIfK5me+nfi5ql/seksyPlQaMJ2pVyEobkoakyg3JQK
 cdGUlaSMkN+yaDQZhN8uGmy3GxRRc3OD/bjzXlf/r49DmyBObNgUD7siP0E2gKGGGm/m
 OYdXwBDxIpXqUSKRx4hLOZlWDc2SDVwSFmmrJR588bohyZBcfInVNZPSrDLv5iGABpLX
 hjNzdTS4DbNxt36Rot1E92vqdjkQCinacG9EefGGeetFlEGr+ebHEM5c2ZNY0gfW+/Jg
 ZCp8cm39FzH8HOx6AGAMYXRsH1Jy6xaH1F5526jB9vusx21AyNTErtedXE31g1EX4ARZ ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbm0gwd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 17:45:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4192110002A;
        Tue, 29 Oct 2019 17:45:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 227462A748A;
        Tue, 29 Oct 2019 17:45:43 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 29 Oct 2019 17:45:42
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <david.hernandezsanchez@st.com>,
        <wsa+renesas@sang-engineering.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <p.paillet@st.com>
Subject: [PATCH 0/4] thermal: stm32: driver improvements
Date:   Tue, 29 Oct 2019 17:45:33 +0100
Message-ID: <20191029164537.1561-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_05:2019-10-28,2019-10-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patchset is to improve stm32 thermal driver:
* add support for multiple trip points. Currently the driver supports only
2 trip points.
* rework interrupt management to avoid receiving hundreds of
interrupts when the temperature is close to a low threshold.
* fix a mistake regarding the role of an engineering value.
* suppress passive trip point on stm32mp157c because it is useless.

Pascal Paillet (4):
  thermal: stm32: implement set_trips callback
  thermal: stm32: fix IRQ flood on low threshold
  thermal: stm32: fix engineering calibration value
  ARM: dts: stm32: remove thermal passive trip point on stm32mp157c

 arch/arm/boot/dts/stm32mp157c.dtsi |   6 -
 drivers/thermal/st/stm_thermal.c   | 441 +++++++++--------------------
 2 files changed, 138 insertions(+), 309 deletions(-)

-- 
2.17.1

