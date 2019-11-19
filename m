Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D8CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50F021783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Nnm32lW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfKSM7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:59:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18698 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbfKSM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:59:32 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJCvR67009914;
        Tue, 19 Nov 2019 13:58:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=rsSDknKY44vezIAKr7/Ad6OiIvlz/nvS9k1eIRtRQbw=;
 b=Nnm32lW0E2QDBNXrlell4IP2gWD9DxTitsICS6K5n83wb6owQqSeC/sLP6l/Dc9pVKXm
 V1d4P0xUyiHPuQea5a0s3BpmJkHjDRx6YBsq2JBC4OkQhzEweIHOW/V+cztCp/D9Rvc/
 h1PSzd8LzESsLisNMqFKEyjZtq9eVlVSYl2VQhNw1aZORN94PlQjvE3wXAA8X3ubiYzV
 8wbH/EzoSkVvHME+NCUdcyLUIZcs4aR8iEoCalkZgEs66M/JXsEc6tCsq753Tq2NAjHh
 coSt6ZVwfCb3fjVlplaMRNe5aS13Ztyu9MCON4L8uQ8JsKkoHdndsjgsXPhZUgnsNPmb UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9us7c2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 13:58:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 385CD100034;
        Tue, 19 Nov 2019 13:58:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0C8AA2BAB69;
        Tue, 19 Nov 2019 13:58:15 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Nov 2019 13:58:14
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH] drm/crtc-helper: drm_connector_get_single_encoder prototype is missing
Date:   Tue, 19 Nov 2019 13:58:05 +0100
Message-ID: <20191119125805.4266-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_03:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include drm_crtc_helper_internal.h to provide drm_connector_get_single_encoder
prototype.

Fixes: a92462d6bf493 ("drm/connector: Share with non-atomic drivers the function to get the single encoder")

Cc: José Roberto de Souza <jose.souza@intel.com>

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/drm_crtc_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 499b05aaccfc..93a4eec429e8 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -48,6 +48,8 @@
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
+#include "drm_crtc_helper_internal.h"
+
 /**
  * DOC: overview
  *
-- 
2.15.0

