Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43967CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240292086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfJaOLH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:11:07 -0400
Received: from maillog.nuvoton.com ([202.39.227.15]:44194 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:11:01 -0400
Received: from NTHCCAS02.nuvoton.com (nthccas02.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 6D2B61C80E11;
        Thu, 31 Oct 2019 21:56:23 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS02.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 31 Oct 2019
 21:56:22 +0800
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 31 Oct
 2019 15:56:18 +0200
Received: from taln70.nuvoton.co.il (10.191.1.70) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server id 15.0.1130.7 via Frontend
 Transport; Thu, 31 Oct 2019 15:56:18 +0200
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln70.nuvoton.co.il (Postfix) with ESMTP id 02C6D1B6;
        Thu, 31 Oct 2019 15:56:19 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 0332960275; Thu, 31 Oct 2019 15:56:19 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <yuenn@google.com>, <venture@google.com>,
        <benjaminfair@google.com>, <avifishman70@gmail.com>,
        <joel@jms.id.au>
CC:     <openbmc@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 1/3] dt-binding: reset: add NPCM reset controller documentation
Date:   Thu, 31 Oct 2019 15:56:15 +0200
Message-ID: <20191031135617.249303-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191031135617.249303-1-tmaimon77@gmail.com>
References: <20191031135617.249303-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM reset controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/reset/nuvoton,npcm-reset.txt     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
new file mode 100644
index 000000000000..6e802703af60
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
@@ -0,0 +1,32 @@
+Nuvoton NPCM Reset controller
+
+Required properties:
+- compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
+- reg : specifies physical base address and size of the register.
+- #reset-cells: must be set to 2
+
+Optional property:
+- nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
+  NPCM7xx contain four software reset that represent numbers 1 to 4.
+
+  If 'nuvoton,sw-reset-number' is not specfied software reset is disabled.
+
+Example:
+       rstc: rstc@f0801000 {
+               compatible = "nuvoton,npcm750-reset";
+               reg = <0xf0801000 0x70>;
+               #reset-cells = <2>;
+               nuvoton,sw-reset-number = <2>;
+       };
+
+Specifying reset lines connected to IP NPCM7XX modules
+======================================================
+example:
+
+        spi0: spi@..... {
+                ...
+                resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>;
+                ...
+        };
+
+The index could be found in <dt-bindings/reset/nuvoton,npcm7xx-reset.h>.
--
2.22.0



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
