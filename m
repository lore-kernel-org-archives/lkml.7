Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23326C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1512217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IAfNqiDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfDEHx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:53:58 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1301 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbfDEHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:53:58 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x357pFZi020168;
        Fri, 5 Apr 2019 09:53:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=lbFXNbrTmYJ4EO4PrGpTvQms2nT/2iI3fELTIKxLlJ4=;
 b=IAfNqiDXC6NGZ3ruAgLGXEjyhdsiruTl3yZw2VaMGQ/oWa63FVZ9c70uJqOnwCKKqmqs
 HjH1AfYFP5nOcIJvm5Y0AUjRnRgtPkuuGkrCDqO6Ki8mYRcRBnr9EY2gKjVwS+Fihr5l
 EWL3+dCKSG+JL8Me3HaUoWzvIBF+YGE4Ja940D8mbLR0/9ORX9Qj5+oLJQy7wnStXCd9
 95kiPNv615i/aIhvD4al2FAbQiQZ8hokzXX3k+W8xpUKJDuY1tHOFbv5qhCcn5WhDlMf
 K3XuCaBSO85M90ilKe+N/DqCsFM4guolAv6RpW7ehuR4GVGiWoNSR1BI5t6KW2qJJKW1 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgevfrf1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 09:53:49 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E898A34;
        Fri,  5 Apr 2019 07:53:48 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E2981E06;
        Fri,  5 Apr 2019 07:53:48 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Apr 2019 09:53:47
 +0200
From:   Gabriel Fernandez <gabriel.fernandez@st.com>
To:     michael turquette <mturquette@baylibre.com>,
        stephen boyd <sboyd@kernel.org>,
        rob herring <robh+dt@kernel.org>,
        mark rutland <mark.rutland@arm.com>,
        maxime coquelin <mcoquelin.stm32@gmail.com>,
        alexandre torgue <alexandre.torgue@st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH 0/2] clk: stm32: STM32F769 clocks
Date:   Fri, 5 Apr 2019 09:53:30 +0200
Message-ID: <20190405075332.28530-1-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32F769 board is a derived of STM32F746 board.
Concerning clocks, main differences are:
- new source clock for SAI1 and SAI2 (HSI or HSE)
- Add DFSDM & DSI clock



Gabriel Fernandez (2):
  clk: stm32: Introduce clocks of STM32F769 board
  ARM: dts: stm32: Enable STM32F769 clock driver

 .../bindings/clock/st,stm32-rcc.txt           |   6 +
 arch/arm/boot/dts/stm32f769-disco.dts         |   4 +
 drivers/clk/clk-stm32f4.c                     | 307 +++++++++++++++++-
 include/dt-bindings/clock/stm32fx-clock.h     |   7 +-
 4 files changed, 314 insertions(+), 10 deletions(-)

-- 
2.17.1

