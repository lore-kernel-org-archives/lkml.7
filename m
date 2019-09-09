Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA9C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962CE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AHN0OFHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404918AbfIINwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:52:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:63494 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729606AbfIINwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:52:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x89DkL4W007480;
        Mon, 9 Sep 2019 15:52:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=UpIhYzvB1cHNRjNJgObglIgwi0MbjP++qgONMCCM+/Q=;
 b=AHN0OFHL8lD1novtWs55nS5F9wrAx3jA8Cs59l1OSdWvPARJCbxc4yjtX7edDaKZcpDd
 xzLs7nmZO6UsGK5KXfC2msZ2+kLF20KMjCDB5iqecS3Oz0LHHNN53mvODbxtC7nI9bqF
 ig4lEQcUWJrr/a4e4xFTHNOg806qjMGIrg4zQUk6F6nMQ7H7pf/E61REPUHJ2kyaHIUi
 cTlvwLayxlqNOS1g0LVSzg47UUB535jyqm8lYlzJqAWzgeBKpNelnlBKMtoz/IsHKCe5
 fBAg2tFFJ4ufK4r1qJxJBlIK0Z7OimROGGvKrsoAYNya1xrCdTOyzroLKflngzHFRH0q gg== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uv212dwkt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Sep 2019 15:52:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 647564B;
        Mon,  9 Sep 2019 13:52:10 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D9F82AE7A2;
        Mon,  9 Sep 2019 15:52:10 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019
 15:52:10 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019 15:52:09
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <benjamin.gaignard@linaro.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm: include: fix W=1 warnings in struct drm_dsc_config
Date:   Mon, 9 Sep 2019 15:52:04 +0200
Message-ID: <20190909135205.10277-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_06:2019-09-09,2019-09-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change scale_increment_interval and nfl_bpg_offset fields to
u32 to avoid W=1 warnings because we are testing them against
65535.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 include/drm/drm_dsc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_dsc.h b/include/drm/drm_dsc.h
index 887954cbfc60..e495024e901c 100644
--- a/include/drm/drm_dsc.h
+++ b/include/drm/drm_dsc.h
@@ -207,11 +207,13 @@ struct drm_dsc_config {
 	 * Number of group times between incrementing the scale factor value
 	 * used at the beginning of a slice.
 	 */
-	u16 scale_increment_interval;
+	u32 scale_increment_interval;
+
 	/**
 	 * @nfl_bpg_offset: Non first line BPG offset to be used
 	 */
-	u16 nfl_bpg_offset;
+
+	u32 nfl_bpg_offset;
 	/**
 	 * @slice_bpg_offset: BPG offset used to enforce slice bit
 	 */
-- 
2.15.0

