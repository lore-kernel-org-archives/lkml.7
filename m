Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4991CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC68217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VM2lY3l6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfKDKzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:55:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10484 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727500AbfKDKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:55:46 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4AtIoX011716;
        Mon, 4 Nov 2019 11:55:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=EEEFNYvMlCmEOwjqHkRBm4xFsgzUd+bwPAuMghh0Las=;
 b=VM2lY3l68Z7bkEekKCLbyUHaxfESYvRc/3tyOTpmITpLWTkN09ENlkUvWgIQ509dZZKC
 f6GlI8TPskWIO2jGFcYUuHwNO+VP83TUTk2mGUAuBaZGQW1am4rp33h4Qq4XqGuUdkMQ
 VnilK2evfAJaAadOiV6Gkmq0Nv4xnW8z4uWp965JMezWc1rshiZBlXd3EmMO/IhV7psz
 OuHn9H+JMt4dWqYnH5VuHckYk/Wt8PzmetmsmQ9qFODSEaFXWEu7J0pX202MTLn4zVPx
 ZgzbZzQnMyB1Nrcg7nUEYdm6o6NgzQdRunqUyX0hL5aYL34GlJSx4mSmmJ/WVE5fNuSP jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w0ytchn2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 11:55:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7AE18100038;
        Mon,  4 Nov 2019 11:55:35 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 645B42BDA95;
        Mon,  4 Nov 2019 11:55:35 +0100 (CET)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019
 11:55:35 +0100
Received: from localhost (10.201.22.141) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019 11:55:34
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 0/2] STMFX pinctrl definition updates
Date:   Mon, 4 Nov 2019 11:55:27 +0100
Message-ID: <20191104105529.8049-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.22.141]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a502b343ebd0 ("pinctrl: stmfx: update pinconf settings"), pin
configuration has been fixed in STMFX pinctrl driver. Moreover, gpiolib now
fully handles "push-pull" configuration.
This series cleans up stm32mp157c-ev1 stmfx ov5640 pins use and fixes stmfx
joystick pins use otherwise joystick doesn't work.

Amelie Delaunay (2):
  ARM: dts: stm32: remove OV5640 pinctrl definition on stm32mp157c-ev1
  ARM: dts: stm32: change joystick pinctrl definition on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157c-ev1.dts | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

-- 
2.17.1

