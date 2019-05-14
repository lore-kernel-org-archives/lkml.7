Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253D0C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E842821473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="a3a6okLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfENJgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:36:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42602 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbfENJgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:36:22 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4E9VWJp023931;
        Tue, 14 May 2019 11:36:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=fsbBwl7Tthpbz/eCjykcV7x4Wlt53zxDBpGU6jlFytg=;
 b=a3a6okLrnFYL1FMWRzsSHkfi57tsWIaN+rfwa3c4BaWjsfDIezfk2tyB2jRASM/9Y01v
 vuKAII6QgFvrnA2QCM6j9fyewgn7rSNz+e5m370sE2DVWoOxxRS7cUwkCoVKw8ejV5MP
 F/jKRW24TB8CojqDIRAeHQIHZPQPWhkQt/GItKTEiJqPvw76YOntFLWC9ZgdM/u+VpS7
 NOcqdLLPCBVvQo6V/afXIfbSk+A32wbiT5qzTyHhD/r6zSdP51m6Ozk8HUQ3nnojgibE
 OTmeKk5bMvVS//dSu1MJ93cYb4/FJz/X53eCe4VO+98u0M2E//CDglHxm/u8DyDBBbNG cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sdn9fr6bn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 14 May 2019 11:36:11 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B94733A;
        Tue, 14 May 2019 09:36:10 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B727179A;
        Tue, 14 May 2019 09:36:10 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May
 2019 11:36:10 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May 2019 11:36:09
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
Subject: [PATCH v4 0/2] Add supply property for DSI controller
Date:   Tue, 14 May 2019 11:35:54 +0200
Message-ID: <1557826556-10079-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI controller needs a new property that powers its physical layer.
Binding has been updated to document this property.
Device tree of stm32mp157c soc.
Move reg18 & reg11 to stm32mp157c device tree file.
Remove property phy-dsi-supply property to stm32mp157c-dk2.dts file.

Changes in v2:
- rename patch drm/stm: dsi: add support of an optional regulator
- rework dw_mipi_dsi-stm probe sequence

Changes in v3:
- remove device-tree patches
- replace the optional regulator by a regulator

Changes in v4:
- update patch commit
- return always error code

Yannick Fertré (2):
  dt-bindings: display: stm32: add supply property to DSI controller
  drm/stm: dsi: add regulator support

 .../devicetree/bindings/display/st,stm32-ltdc.txt  |  3 ++
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              | 60 ++++++++++++++++++----
 2 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.7.4

