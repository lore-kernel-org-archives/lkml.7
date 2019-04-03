Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC30C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4555C2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfDCIQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:16:58 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2200 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbfDCIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:16:57 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3386Oai029713;
        Wed, 3 Apr 2019 10:16:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgmx2hdt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 10:16:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8123841;
        Wed,  3 Apr 2019 08:16:39 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39D6F1477;
        Wed,  3 Apr 2019 08:16:39 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Apr 2019
 10:16:39 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 10:16:38
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/5] Add supply property for DSI controller
Date:   Wed, 3 Apr 2019 10:16:24 +0200
Message-ID: <1554279389-27377-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI controller needs a new property that powers its physical layer.
Binding has been updated to documented this property.
Device tree of stm32mp157c soc.
Move reg18 & reg11 to stm32mp157c device tree file.
Remove property phy-dsi-supply property to stm32mp157c-dk2.dts file.

Yannick Fertré (5):
  dt-bindings: display: stm32: add supply property to DSI controller
  drm/stm: dw_mipi_dsi-stm: add support of an optional regulator
  ARM: dts: stm32: add phy-dsi-supply property on stm32mp157c
  ARM: dts: stm32: move fixe regulators reg11 & reg18
  ARM: dts: stm32: remove phy-dsi-supply property on stm32mp157c-dk2
    board

 .../devicetree/bindings/display/st,stm32-ltdc.txt    |  3 +++
 arch/arm/boot/dts/stm32mp157c-dk2.dts                |  9 ---------
 arch/arm/boot/dts/stm32mp157c-ed1.dts                | 16 ----------------
 arch/arm/boot/dts/stm32mp157c.dtsi                   | 17 +++++++++++++++++
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c                | 20 ++++++++++++++++++++
 5 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.7.4

