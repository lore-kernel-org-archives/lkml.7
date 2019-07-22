Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88755C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583A221901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pVx177ZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfGVQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:06:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62576 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730423AbfGVQGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:06:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MG65hm016172;
        Mon, 22 Jul 2019 18:06:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=tUyFF2dLFUND6HSCHRKN4a+J8+L0QNOSCuz5edjnQdI=;
 b=pVx177ZLmPbDmrPaz6AKQXlRGdiOL2ctfNMtl4BiexOt4zilvs7BIDxCJ9Je/mc5xavj
 YVcLd1nqYnoce0RRHqe4bwpGRxaQ30NyAg9OFc0Nk+GJuDYmREeeH3amg70dt/5zK1R8
 p6trXidCt/SvztRTcJUI/nq6reKG2KUcMIyepuX5jO85rOaG/4EdaDYQ6VYzo1XgVwkG
 PGRyU0QnYt1s0d56InkKqqHXUuOS0xKUBL74Fb0gI5xaNm0X746TGeXN9ItMycjjKq+8
 rM4tVMBhw+PK/MCGYq7g2lsDOZmZ8t2zQLnhoDsGUPbipQ4xBE5NlQLoK4Slx4HvspAv 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ture1chdq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 22 Jul 2019 18:06:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2982631;
        Mon, 22 Jul 2019 16:06:02 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C274452BB;
        Mon, 22 Jul 2019 16:06:02 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 18:06:02 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul 2019 18:06:02
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <olivier.moysan@st.com>, <jsarha@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/3] drm/bridge: sii902x: fix audio mclk management
Date:   Mon, 22 Jul 2019 18:05:57 +0200
Message-ID: <1563811560-29589-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix audio master clock use for Silab sii902x HDMI transceiver.
Make audio master clock optional, as this clock is not mandatory.

Changes in v2:
- Rely on clk framework to manage undefined mclk case.
- Use devm_clk_get_optional instead of devm_clk_get.

Olivier Moysan (3):
  drm/bridge: sii902x: fix missing reference to mclk clock
  dt-bindings: display: sii902x: Change audio mclk binding
  drm/bridge: sii902x: make audio mclk optional

 .../devicetree/bindings/display/bridge/sii902x.txt     |  5 ++---
 drivers/gpu/drm/bridge/sii902x.c                       | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.7.4

