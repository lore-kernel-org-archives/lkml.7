Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0C2C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02BE2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BIb7ORKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfFRMIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:08:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42322 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:08:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5IC8C6C121232;
        Tue, 18 Jun 2019 07:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560859692;
        bh=uKcw8oU4+FhGXSqf3gZugB8yITGfh5/LWvrWJ4CfFJ4=;
        h=From:To:CC:Subject:Date;
        b=BIb7ORKEkQHF3vcndibQSbDMsPFF46M94XWaPZhfSn1L+E+ee2wUPRv7rf9MmQ+s3
         Bqa9jRvzUcU7jFZm0vRYn27zM5yNCW9uY8mL4Q/SR4m0nRakJZhCFJbFJQ75tQyWDe
         dNqtb1Pa9BhHnY+YeLMEDJX5xypKUCuW8evR0P0Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5IC8CMq068759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Jun 2019 07:08:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 18
 Jun 2019 07:08:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 18 Jun 2019 07:08:12 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5IC89GY080327;
        Tue, 18 Jun 2019 07:08:09 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>,
        <j-keerthy@ti.com>, <nm@ti.com>
Subject: [PATCH 00/10] crypto: k3: Add sa2ul driver
Date:   Tue, 18 Jun 2019 17:38:33 +0530
Message-ID: <20190618120843.18777-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds Crypto hardware accelerator support for SA2UL.
SA2UL stands for security accelerator ultra lite.

The Security Accelerator (SA2_UL) subsystem provides hardware
cryptographic acceleration for the following use cases:
• Encryption and authentication for secure boot
• Encryption and authentication of content in applications
  requiring DRM (digital rights management) and
  content/asset protection
The device includes one instantiation of SA2_UL named SA2_UL0

SA2UL needs on tx channel and a pair of rx dma channels.

This series has dependency on UDMA series. Hence is based on top of:

https://patchwork.kernel.org/project/linux-dmaengine/list/?series=114105

The above series adds couple of dmaengine APIs that are used
by the sa2ul driver. Hence there is a hard dependency on the
above series.

Keerthy (10):
  dt-bindings: crypto: k3: Add sa2ul bindings documentation
  crypto: sa2ul: Add crypto driver
  crypto: sa2ul: Add AES ECB Mode support
  crypto: sa2ul: Add aead support for hmac(sha1)cbc(aes) algorithm
  crypto: sha256_generic: Export the Transform function
  crypto: sa2ul: Add hmac(sha256)cbc(aes) AEAD Algo support
  crypto: sa2ul: Add hmac(sha1) HMAC algorithm support
  crypto: sa2ul: Add hmac(sha256) HMAC algorithm support
  sa2ul: Add 3DES ECB & CBC Mode support
  arm64: dts: k3-am6: Add crypto accelarator node

 .../devicetree/bindings/crypto/sa2ul.txt      |   47 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |   33 +
 crypto/sha256_generic.c                       |    3 +-
 drivers/crypto/Kconfig                        |   17 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/sa2ul.c                        | 2232 +++++++++++++++++
 drivers/crypto/sa2ul.h                        |  384 +++
 include/crypto/sha.h                          |    1 +
 8 files changed, 2717 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/sa2ul.txt
 create mode 100644 drivers/crypto/sa2ul.c
 create mode 100644 drivers/crypto/sa2ul.h

-- 
2.17.1

