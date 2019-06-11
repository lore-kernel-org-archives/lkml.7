Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB0AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BF72089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vfqyNEAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbfFKMZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:25:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49129 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389224AbfFKMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:25:55 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BCLjBU023743;
        Tue, 11 Jun 2019 14:25:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=9gSGjqYoy+Fbf2xPESzbOyGUbO7HOvEvjLu/ZOx6/bE=;
 b=vfqyNEARQmrgEmlmrqcuJv1pPBpIuYiWyPUO4H+t3g7kW7GBkM+Aq9xLaoNVfJuL+/FB
 ruoP07PfJHd1IzS0Lx/NxijwEUgohe+fsAMp1MxiSLYBNsTUYTFojV0tkjxGjvahR7vH
 sIQarKE9Y86DZQWCdRC48035eIYq0niGvvanYAIxfenDSy3o0mfH0VL2/JwdB150onnZ
 8xUFJx70ld4Z1neM67d1d6R5N3S2cra6bQ56GMAMKCDhZQ2UH9lZE97gfyX0p5HjCUXD
 FMOnxu0ae9/5cInaw44RNuaXBpIFgGD1W6/3A6LGycJwNV2Is1j3zguC97rW7SMbrDfk 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t26rm9vbd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Jun 2019 14:25:41 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4E6D31;
        Tue, 11 Jun 2019 12:25:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 80D442A2C;
        Tue, 11 Jun 2019 12:25:40 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 14:25:40 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun 2019 14:25:37
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        "Fabrice Gasnier" <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: [PATCH v2 01/10] dt-bindings: serial: stm32: add wakeup option
Date:   Tue, 11 Jun 2019 14:25:21 +0200
Message-ID: <1560255930-22554-2-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
References: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note for enabling wakeup capabilities of usart

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 9d3efed..5ec80c1 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -19,6 +19,11 @@ Optional properties:
   linux,rs485-enabled-at-boot-time: see rs485.txt.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
+- wakeup-source: bool flag to indicate this device has wakeup capabilities
+- interrupt-names, if optional wake-up interrupt is used, should be:
+  - "event": the name for the interrupt line of the USART instance
+  - "wakeup" the name for the optional wake-up interrupt
+
 
 Examples:
 usart4: serial@40004c00 {
-- 
1.9.1

