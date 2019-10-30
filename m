Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32CCCA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8826C208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A80fnsT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfJ3JBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:01:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44614 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3JBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:01:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id q26so1106268pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kpSRFHljLQ0J6Aa39FyB0oJMuowSc24OXLDuKR7Ck/s=;
        b=A80fnsT/E7nj2Ov92k3bVojidqaYptmKqqmVzQ9eDtAXYzdCIZUun6ojfahw9juGV5
         CLchvGnjYY3XhTcSBYDrHxHiI9GY3ND5l5AlXK6mjtbM4+YIIe1dDnqZ10R38umWZdSe
         Wqx9SLSZI925uZtYX9fv+4af5LzMAylUcUB5nolBnO0w7TbQ4JcugrpS/PZwEkOguN5N
         kGv36A+VJTiE+CS2M+2QZ8633UQ1LeKHeq2I0yM+WXr36WYPECSfVwwA0vKK7IeiLALz
         DCdzmj+/wxKmS/u2iwMy9ui21OXRuYerjN1TJihod0mbqiA8eI+FRy9YuiE1Ddmdd/9u
         Tl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kpSRFHljLQ0J6Aa39FyB0oJMuowSc24OXLDuKR7Ck/s=;
        b=acCxleCWoeHYusgXR0/JkXLXkGY1/Usn4lATdmJ96jHZwX7pEk56z5d+pB8JT1BRJk
         SyEkjIGjW7O+czqk5DU+5Gt6QfmlgxnGGzdcyzS9gX0Qi91W/9FS2RcoLeMTVdKzAJE2
         XtoqjK/8CCIUXYY8Ow/feXSatIaol60m6vi0svUShQPb1e/+/FaeWMElePAHqL6cDhRm
         medl/1r69wFz0ncubSyDq09LWY/qqRqEb3xS2gSAjiymtMNUbw3MVMPKOuah82Z6O16l
         MH/384YVdcD2lfw44sPc274BG0KE3gw+TR02xbmKdT48mzRywZAPMjsORyAt5jfFVBDx
         Jmcg==
X-Gm-Message-State: APjAAAWThwNF0etNhM05oog/B7srbeSiT1zuppewNRAa6GVa/IxmA3OW
        7PuBXaIUsGnQPREchVJYJWsX
X-Google-Smtp-Source: APXvYqxFNDmc/qWrzrj9GwR1BCqms0oXxFmPJfU70XQNMQp+JjQOACLC2ny3hrW0lsC9IOYN91metA==
X-Received: by 2002:a63:fe15:: with SMTP id p21mr31736118pgh.26.1572426108054;
        Wed, 30 Oct 2019 02:01:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:618e:77d9:c9fa:423a:3851:8df4])
        by smtp.gmail.com with ESMTPSA id g24sm2070351pfi.81.2019.10.30.02.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 02:01:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/4] Add support for Thor96 board
Date:   Wed, 30 Oct 2019 14:31:20 +0530
Message-Id: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
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

Expecting patch 1 to go through LED/Rob's tree, 4 through MTD tree
and 2,3 through Freescale tree.

Thanks,
Mani

Changes in v2:

* Added patch for documenting commonly used LED triggers
* Added Reviewed-by tags for bindings patch
* Changed, fsl,uart-has-rtscts to uart-has-rtscts in dts
* Modified the commit message of MTD patch

Manivannan Sadhasivam (4):
  dt-bindings: leds: Document commonly used LED triggers
  dt-bindings: arm: Add devicetree binding for Thor96 Board
  arm64: dts: freescale: Add devicetree support for Thor96 board
  mtd: spi-nor: Add support for w25q256jw

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/leds/common.txt       |  17 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mq-thor96.dts      | 581 ++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                 |   2 +
 5 files changed, 602 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts

-- 
2.17.1

