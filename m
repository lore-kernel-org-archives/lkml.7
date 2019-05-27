Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C7FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA73920665
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ff8ILc4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfE0KWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:22:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6160 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbfE0KWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:22:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RAGdv9031349;
        Mon, 27 May 2019 12:21:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=ixDf88IcNb3TU6tNgq8bjWEyDdaEJ144CZTxviT3UTE=;
 b=ff8ILc4ioPMsKqkyweSlcBLsWP3MVx7APoWrr8IMFcUnhQbUOuM2cSK01jfzckrRQ1P3
 zPxU1nT7zO+zDGVsWWXKJFTD44GvrXet2j92zvpt0KVP6IL0QAnCbl5Amb26cx42FGLn
 PnlqIWbZ84Axixb93FC6KYocoPJ2V8J0yTda2eYpj2dsn1y0LZVIYqYknBlaWeJ0vI0c
 t/pm1I8WOT1U82e2h4eiizrCIWdso8nk3tmOCxkrl471FgxRc9gKBFos8alVZkxI10f8
 7FVl3dipDCqPhYVREzJd6YTFhU8UyVGdDuwpuhxNGoBAjXytNIT4M4SHcpZSNNJVDlNS kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sptu9jjhg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 May 2019 12:21:47 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 636BB31;
        Mon, 27 May 2019 10:21:46 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 347112804;
        Mon, 27 May 2019 10:21:46 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May
 2019 12:21:46 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May 2019 12:21:45
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] dw-mipi-dsi: add power on & off optional phy ops and update stm
Date:   Mon, 27 May 2019 12:21:37 +0200
Message-ID: <1558952499-15418-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix a bug concerning an access issue to display controler (ltdc)
registers.
If the physical layer of the DSI is started too early then the fifo DSI are full
very quickly which implies ltdc register's access hang up. To avoid this
problem, it is necessary to start the DSI physical layer only when the bridge
is enable.

Yannick Fertré (2):
  drm/bridge/synopsys: dsi: add power on/off optional phy ops
  drm/stm: dsi: add power on/off phy ops

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |  8 ++++++++
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         | 21 ++++++++++++++++++++-
 include/drm/bridge/dw_mipi_dsi.h              |  2 ++
 3 files changed, 30 insertions(+), 1 deletion(-)

--
2.7.4

