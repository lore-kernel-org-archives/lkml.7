Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254ABCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE2D20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VVUvr1Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfJ3N5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:57:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56261 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbfJ3N5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:57:22 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9UDq1OP024877;
        Wed, 30 Oct 2019 14:57:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=QKo/9fN+f54Fn31rBbADW5d5ju6BrmDtlBQ2YwVrR3g=;
 b=VVUvr1IwdcgscCQrI6Q6WRD4Q1YV/SLJe+EcU2DUUqYaqVAiknDvPBWJsu0d9n/2lKF3
 GvSeG9XWi6YzMWuhcBi7pTCNooXCSnw24L3398YdjADZYLP08hYactHkzoDsYUyemOvB
 KuA+Ikr8l+IgfmXjLIsCQ4erPuPbrI4frzwbthnVREofrM9uBtMWQr+OSdi8rwnD2DFX
 YnQowJW8JXC/YvYDK8sFAZpio7AP2k8tMBKVHBIhL0cFRtTRg4N2amBmNacFnledbeGp
 QTujANE40xdY9ODHeQH0o7T6DEYwmMbvviMD98XjRYkgkpHv5RsD32oUrKYA37clmY3y sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vxwhe41w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 14:57:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3A5D10002A;
        Wed, 30 Oct 2019 14:57:06 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C392F2C07FB;
        Wed, 30 Oct 2019 14:57:06 +0100 (CET)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct
 2019 14:57:06 +0100
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct 2019 14:57:06
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH v2 1/2] dt-bindings: mailbox: stm32-ipcc: Updates for wakeup management
Date:   Wed, 30 Oct 2019 14:57:00 +0100
Message-ID: <1572443821-28112-2-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572443821-28112-1-git-send-email-fabien.dessenne@st.com>
References: <1572443821-28112-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_06:2019-10-30,2019-10-30 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wakeup specific IRQ management is no more needed to wake up the stm32
platform.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt b/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
index 1d2b7fe..139c06a 100644
--- a/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
+++ b/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
@@ -14,9 +14,9 @@ Required properties:
                    property. Must contain the following entries:
                    - "rx"
                    - "tx"
-                   - "wakeup"
 - interrupts:   Interrupt specifiers for "rx channel occupied", "tx channel
-                free" and "system wakeup".
+                free". If "wakeup-source" is set the rx interrupt is the
+                one used to wake up the system.
 - #mbox-cells:  Number of cells required for the mailbox specifier. Must be 1.
                 The data contained in the mbox specifier of the "mboxes"
                 property in the client node is the mailbox channel index.
-- 
2.7.4

