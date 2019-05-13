Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51557C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201382084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bSJl0sDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfEMOoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:44:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37183 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728133AbfEMOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:44:12 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEaZH3013863;
        Mon, 13 May 2019 16:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=H7Q5/LExNO59bdn3+PatXfQylruOtLqJEDuHGFHk764=;
 b=bSJl0sDa++4vqFNqa9vdeF1fwx4x8cw4yukMVXb/JKd8yt9Bod9ExrcdTLJTaWHETQru
 wxG0SWcF/7/0wDc59hEV71nMYggiAPJSC0kmZxzl93vK9AydXW5eN3fck6u1q+jN9jEe
 FVs7c8UuilNXacCP8YlysODN9PXQWNa2R+HHo+HHXpE6C3hl2l1zLIFNyiZPM8HDz/eN
 HwyLpYP1Tp3wz8GwDpdy/YlNEPQrQk8EVTfSEE0i8Mnk5OlAqm1nEYVvkwfB9Mo57xIa
 oi6TX0CM55AjV/ApKhRuuu8v8S7fqBJERlvzty26qrmcKPGcQIkl3AfBYl0eJJyFk00q MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sdm5tugns-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 May 2019 16:44:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8241B34;
        Mon, 13 May 2019 14:44:03 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 48C5D2899;
        Mon, 13 May 2019 14:44:03 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 May
 2019 16:44:02 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 May 2019 16:44:01
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add supply property for DSI controller
Date:   Mon, 13 May 2019 16:42:17 +0200
Message-ID: <1557758539-28748-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_07:,,
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

Changes in v3:
- remove device-tree patches
- replace the optional regulator by a regulator

Yannick Fertré (2):
  dt-bindings: display: stm32: add supply property to DSI controller
  drm/stm: dsi: add support of an regulator

 .../devicetree/bindings/display/st,stm32-ltdc.txt  |  3 ++
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              | 53 ++++++++++++++++++----
 2 files changed, 48 insertions(+), 8 deletions(-)

--
2.7.4

