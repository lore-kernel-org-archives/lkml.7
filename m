Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF65CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8808D20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6komROc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502882AbfJXOm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:42:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38943 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502826AbfJXOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:42:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so15294407pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NOOJOsxqHyn9AIr6ypTkEVIyD6HHzZy3a7yfdgUD6yA=;
        b=h6komROc6h8RGeYYNYnFEouCCElzVFdunOny/OFPlTSBbE5B9R5V8n3vP3rMEXKNLh
         HcgLDIcHgnpiHBDdMc49NZVTwIrypxTd91Vbx2VC3XfN5emIFzMByQfhxcXi1CjlHxKI
         gp9XINyTt2x2EhOqnng6aYHiOy1L6GIIUySNMpQzQpujU+WCaZbBz2tEAcblutRs3jfR
         R/YEQWcd6ifqfLES2J7fhvU1g+ShU07BNi6dOyUe0u4wdzNg+p2T2eQQbdAbOi0fwobS
         10oIsmYkgKrqi4mnE33LkzRtAqfOhvSQLmj/aAqHwvoz7yGXbTFTZWyJred3CsaGL5if
         gFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NOOJOsxqHyn9AIr6ypTkEVIyD6HHzZy3a7yfdgUD6yA=;
        b=sE6mSO4jdmGAwGDv0/HHti51im0qCQEpwDRlJJyA4flDCQqrP35ntYKu+JD6nj9I22
         oi0F1GwMJ3rPruUJoOGF5SnEVP2yxJWoBdj7LWwwnrMWd/2g8FgUboaHDhxw70Xj6qWm
         bk5w1nlLT9TFuhuZav2Dw9QBIpfZM0+9lFx73fTADjLYJ2lnjnNC0MLV+qufBdG6cH6Y
         XQKFysPG+b8uPlLrX3PhIzzCRn+uBHv7aXS1NxvgZd2Ah3wCb6XEiN5981K35d3iJVKX
         yPgwUCc7ppjwB/RUbwvb3pLVuS+e/uXcRF3xxiqA5u9Dqpfwuno8AqWt5RSRyzWslrfL
         YEJg==
X-Gm-Message-State: APjAAAUCUi6R/Reycl0s5HdMvEiFtP+pVH26NVHKfZ4iza7HavjGX/XC
        xzWkEsprgGj8fzKGZ1Ygc28W
X-Google-Smtp-Source: APXvYqz/X3rMwuLvNMllP5jTvRzrOorlDB389gW90QS3BAVNtJFKjwn6dyAElAfQ6shN3bCZKMLEAA==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr7494628pjt.38.1571928175650;
        Thu, 24 Oct 2019 07:42:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:997:a0de:81a:ea25:468a:5918])
        by smtp.gmail.com with ESMTPSA id 193sm29059810pfc.59.2019.10.24.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 07:42:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add support for Thor96 board
Date:   Thu, 24 Oct 2019 20:12:32 +0530
Message-Id: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds support for Thor96 board from Einfochips. This board is
one of the 96Boards Consumer Edition platform powered by the NXP i.MX8MQ
SoC.

Following are the features supported currently:

1. uSD
2. WiFi/BT
3. Ethernet
4. EEPROM (M24256)
5. NOR Flash (W25Q256JW)
6. 2xUSB3.0 ports and 1xUSB2.0 port at HS expansion

More information about this board can be found in Arrow website:
https://www.arrow.com/en/products/i.imx8-thor96/arrow-development-tools

Link to 96Boards CE Specification: https://linaro.co/ce-specification

Expecting patch 3 to go through MTD tree and 1,2 to go through freescale
tree.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: arm: Add devicetree binding for Thor96 Board
  arm64: dts: freescale: Add devicetree support for Thor96 board
  mtd: spi-nor: Add support for w25q256jw

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mq-thor96.dts      | 581 ++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                 |   2 +
 4 files changed, 585 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts

-- 
2.17.1

