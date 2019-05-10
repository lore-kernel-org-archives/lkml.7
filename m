Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F99C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A02F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="mEL2JpCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEJOUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:20:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42043 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbfEJOUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:20:46 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AE1A8q018315;
        Fri, 10 May 2019 16:20:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=SFxogR9JPF6xdKCGoAamjmYfeUtysrEoecdQ7E/pxnY=;
 b=mEL2JpCF2XTXzAYSgFKO3ZZSG1AtAHEA3xHUV3AAztHXrLVyy5gNUe/YZG6XVi3GBobL
 /CMniv9lTNLF/SoWjiCKqKaVpamyr/RM15PGCeglVxiSMum0h8TaGN0DnwFfMBPKokMp
 JDHGqRXK0GfXCWc5y+jZSx6hFQOmtMcQa+HJoIDkbxL63gHT+ZDhnb4V+byBXEfT+USI
 fKMCPAvj32RSQO6WFgDpUpMKUq8IggydLO1icYXcjqzmt2LEwdkRuuhedAbCClmLNZM1
 nnWOR9f2ltj3T2piC8A7gYI5q5UfftWaRFI/usmAh5Cc5iPSFRx7kwqjdKECk7wWtGk9 pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2scbkaj2fs-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:20:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D418C31;
        Fri, 10 May 2019 14:20:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81557113A;
        Fri, 10 May 2019 14:20:29 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May
 2019 16:20:29 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May 2019 16:20:28
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
Subject: [PATCH v2 0/5] Add supply property for DSI controller
Date:   Fri, 10 May 2019 16:20:18 +0200
Message-ID: <1557498023-10766-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
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


Changes in v2:
- rename patch drm/stm: dsi: add support of an optional regulator
- rework dw_mipi_dsi-stm probe sequence

Yannick Fertré (5):
  dt-bindings: display: stm32: add supply property to DSI controller
  drm/stm: dsi: add support of an optional regulator
  ARM: dts: stm32: add phy-dsi-supply property on stm32mp157c
  ARM: dts: stm32: move fixe regulators reg11 & reg18
  ARM: dts: stm32: remove phy-dsi-supply property on stm32mp157c-dk2
    board

 .../devicetree/bindings/display/st,stm32-ltdc.txt    |  3 +++
 arch/arm/boot/dts/stm32mp157c-dk2.dts                |  9 ---------
 arch/arm/boot/dts/stm32mp157c-ed1.dts                | 16 ----------------
 arch/arm/boot/dts/stm32mp157c.dtsi                   | 17 +++++++++++++++++
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              | 45 +++++++++++++++++++---
 5 files changed, 40 insertions(+), 25 deletions(-)

--
2.7.4

