Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB57C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399242190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="qJqdhptx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfJKOFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:05:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38649 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbfJKOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:05:49 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BE1H2g025329;
        Fri, 11 Oct 2019 16:05:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Qn5aFd2HVDlFPaJf/8ibkjRYXsR+9F43fhoUK4LTDXA=;
 b=qJqdhptxsX3P0Tl0evvQOsp27AcjVoX8Uo+oZUqEZ9Nan3xCeAK2WjbJ3lMzFIL0bRRI
 1qpXTzoRGrCWGyCFdradef3SEjbJ78ga0fHtyqQSzb99X8MKumdhG//XeFfnW3zfJGWH
 LdD9XVa8BYb+ROEQUlz7Q9MG+bD/T8UIWdON+yiAdnXN3tnsaB5Is+oEVMXSHPYFOqI1
 48ALFfjFjIbXV0byrHbQEx3ZUFVt+XEvpEJPtfFI1RUp3Lu9THl0hLUEK/Un7XUZ6BCn
 /a5P3hYA9ieSfh0jZb6u1aHZpT7cFHoZLUiBoasxBFGyRLdFWxmRgUBSFPtdhfp+XNBZ HQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxwa7dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 16:05:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58D3F10002A;
        Fri, 11 Oct 2019 16:05:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4CC882AB8AF;
        Fri, 11 Oct 2019 16:05:37 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 11 Oct 2019 16:05:36
 +0200
From:   Pascal Paillet <p.paillet@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>
Subject: [PATCH 0/4] update regulator configuration for stm32mp157 boards
Date:   Fri, 11 Oct 2019 16:05:29 +0200
Message-ID: <20191011140533.32619-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch-set is to
- add support of PWR blok regulators on the stm32mp157 boards
- undapte various regulator configurations

Pascal Paillet (4):
  ARM: dts: stm32: add PWR regulators support on stm32mp157
  ARM: dts: stm32: change default minimal buck1 value on stm32mp157
  ARM: dts: stm32: Fix active discharge usage on stm32mp157
  ARM: dts: stm32: disable active-discharge for vbus_otg on
    stm32mp157a-avenger96

 arch/arm/boot/dts/stm32mp157a-avenger96.dts |  8 +++++--
 arch/arm/boot/dts/stm32mp157a-dk1.dts       |  9 ++++++--
 arch/arm/boot/dts/stm32mp157c-dk2.dts       |  8 -------
 arch/arm/boot/dts/stm32mp157c-ed1.dts       | 25 ++++++---------------
 arch/arm/boot/dts/stm32mp157c.dtsi          | 23 +++++++++++++++++++
 5 files changed, 43 insertions(+), 30 deletions(-)

-- 
2.17.1

