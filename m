Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4FBFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6EA2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PLXp6KeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405151AbfJPMOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:14:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49585 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405032AbfJPMOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:14:15 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GC6ftG026522;
        Wed, 16 Oct 2019 14:14:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=pnor4yyg9faPFc0SOMUAqiQzsJEo1AMmtpZ8aOYAexk=;
 b=PLXp6KeEnEEZpeubqTAjybZLixix3NcwVlAWk+1Va8wxBnW6oa26xxl4qaIZhe32SNjC
 nOOd4ItPFPNCzwKP0tPaER+GRIl2J/c4M1PqURREqWkiIZudCCysdsyKf9DtYdO/PCqb
 EJYVJ8QdCzbrBtVk7rcs0DRR1YnDn5XZhFP+iZX0zEr5b5GmTiKUCqZEfurqwfPJCWJK
 xdlHxPKXiK4IWaB5al4rlTysIeHBx//9VWjGF4ai/+KvEU61rp4WLac3NqouXCxfHOZk
 OshuPdPsBGc0gzRWxvvu1LttCPkPqEQeB8c0rnNBcEzRuNglX5hNeGN4jQTvoGfOmzRB VQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vk4kx60er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 14:13:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 680D710002A;
        Wed, 16 Oct 2019 14:13:59 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5526420A92D;
        Wed, 16 Oct 2019 14:13:59 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 16 Oct
 2019 14:13:59 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 16 Oct 2019 14:13:58
 +0200
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
Subject: [PATCH 1/2] dt-bindings: mailbox: stm32-ipcc: Updates for wakeup management
Date:   Wed, 16 Oct 2019 14:13:48 +0200
Message-ID: <1571228029-31652-2-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571228029-31652-1-git-send-email-fabien.dessenne@st.com>
References: <1571228029-31652-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wakeup specific IRQ management is no more needed to wake up the stm32
plaform.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
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

