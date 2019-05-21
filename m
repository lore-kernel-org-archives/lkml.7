Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59E6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1732173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Lmt7Iilg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfEUKAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:00:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbfEUKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:00:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L9aWVY004730;
        Tue, 21 May 2019 11:59:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=vq/nSg27gm3FHERhSOAoi49hkfDWTgsfrmKdS0NWRuQ=;
 b=Lmt7Iilg41yXC1xW3J70M6+DiPxFhJIzaHq5DuDyeK0+xzcm2shiV77gRGtJCd1astgT
 E38pT13GIuDb4oPf2GEieYc7/O/l9QWk6UjtTunUeI+c9mSrzhGngYjuoyB2STtxrEWf
 UnmilkGCtXt7IqKDEKpolRyQS5nfrJKmxROrk6sVPYQIl13An785VlTtxTP0CWoL531q
 QNT58mkXktrLM5JWgspDNSJvaMkZE4nWXPOWZVSTXScd1DpG3uYWjbG8cYjz3sBIdnI6
 E7Rf63ObG/UgtRBcXs7uaRgBE3myi3oB50AlABFwwY02ROhqiZRJ/ilGPX6+fhwroE3o Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sj8xg8jk8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 11:59:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31B3F31;
        Tue, 21 May 2019 09:59:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF2DE256F;
        Tue, 21 May 2019 09:59:28 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May
 2019 11:59:28 +0200
Received: from localhost (10.201.20.5) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May 2019 11:59:28 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH] ARM: multi_v7_defconfig: enable STMFX pinctrl support
Date:   Tue, 21 May 2019 11:59:27 +0200
Message-ID: <1558432767-23139-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support for STMFX pinctrl.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c75051b..7f6f5bf 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -408,6 +408,7 @@ CONFIG_SPI_SPIDEV=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_RZA2=y
+CONFIG_PINCTRL_STMFX=y
 CONFIG_PINCTRL_PALMAS=y
 CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
-- 
2.7.4

