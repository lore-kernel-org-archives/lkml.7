Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D449CA9EC5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4859F21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="UvDQ0UxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfJ2MrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:47:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42920 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726048AbfJ2MrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:47:12 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TCg9Eu004076;
        Tue, 29 Oct 2019 13:46:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=PCCjXX8CusN1LvKZ5WG/65Gg+OP0fFkvR4ovWeCP35E=;
 b=UvDQ0UxL7RFjoFqGtof5EcYaJ8mKZySVehljZXxjvRLUaeUd1gfDYvuRpUzWJg2pH2yV
 V1OrBGltg2bWpfWI+PyNYLj2HgHxioZnDASNXkeEQBa3/18oBVYDCm7qqvlUTuvy+stj
 inlGzmHsWZ5iefxsHbcErp2bYqzd03uHxmzEpFx8JxZI5tgEAuLCp8gYFxLXs+8cwJ9K
 AI/WeY3hOaVqAbxqEt8WXbsE5piPuL8c33tT6zSPCxSbT3LSHUgGsVEmuv6nLXhm883K
 ipXM7m/7mtXPnAl/WRRlwWAFx31ZqIis8I7yLTe1McgPCVfvW4DtESJbej54reLfnECV Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vvd1gqd8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 13:46:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50C8010002A;
        Tue, 29 Oct 2019 13:46:59 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 236FD2BE234;
        Tue, 29 Oct 2019 13:46:59 +0100 (CET)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 29 Oct
 2019 13:46:59 +0100
Received: from localhost (10.201.22.141) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 29 Oct 2019 13:46:57
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
Subject: [PATCH 0/2] STMFX pinctrl definition updates
Date:   Tue, 29 Oct 2019 13:46:49 +0100
Message-ID: <20191029124651.12625-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.22.141]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a502b343eb ("pinctrl: stmfx: update pinconf settings"), pin
confuguration has been fixed in STMFX pinctrl driver. Moreover, gpiolib now
fully handles "push-pull" configuration.
This series cleans up stm32mp157c-ev1 stmfx pins use.

Amelie Delaunay (2):
  ARM: dts: stm32: remove OV5640 pinctrl definition on stm32mp157c-ev1
  ARM: dts: stm32: change joystick pinctrl definition on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157c-ev1.dts | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

-- 
2.17.1

