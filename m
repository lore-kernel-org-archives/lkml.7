Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D3C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7476C208C0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkgJiig7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfFFQvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:51:05 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:44266 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFFQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:51:05 -0400
Received: by mail-ed1-f47.google.com with SMTP id k8so2212773edr.11;
        Thu, 06 Jun 2019 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ncc57E0ICTOedQO6jvnV3SE09S/hfpxFEuUTqpJlJQM=;
        b=tkgJiig7/xy6iCceQujv8B2oWwcfxdGlFRMDFJIdTEFwXDdOJsVv7BqqBqSyriKt2G
         vFoO66hIpC4vKZYzfYhaH3MpqgSmaHHj9/mslJNPy43bVlguz29tbb8OKn3XEUcgZkqD
         dFmauda+f5XERIs1hcufBC1V11oZHVlbaEhLRztrUtuWF73zFWkik/+qDvhat7BY6auL
         SzxvuPlLP8/wgTiyn6dQeTeoHownxJjdjcTBYiZ/hJ2hanqzOFwqRXbi54FE7uRgay8p
         dWHTPrb4y3iXw753GmDyzXDKYibOZXey6ikHjiAnP9NzoNWOMKTjiKDZh9LcaEqnZCEt
         7Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ncc57E0ICTOedQO6jvnV3SE09S/hfpxFEuUTqpJlJQM=;
        b=UFcGK1AXzOvhwym8TS2gVdFtjZstDprkgwDjIMHJ5wveMakQhmltNVA6KMlMeS77v4
         PRvF4iyUAIx7J1ofiKKYbkLZGxHGFnzfQshLJrRZ1RknCXcL2iSSFvFEaBxAjE9P5LJX
         hUX5WxGLgNb6jH7ro2wCVhVoyKVGtwWGK7fDkOZdBiaW+Vt1A1Hbpl5EWYFTcWLFwS7n
         T6pHxOyrZUtV89NTAtmjPhtrsf43zY00Yqet1OCHyMUP+wRP5wUf0XJ/BspMJ96NfzTZ
         +/YAQfnj5yTiEP+668sXfN+z1CvSFXuF4avftXCkdiLM8NqAFtEiblzLJIFJ+l6b23wO
         S8Jw==
X-Gm-Message-State: APjAAAUKZ8bcCNnIKp3e9mR0Drx9gDOa1og2vM+FscuHyXwm5tT/P9ta
        yzoXU3v32FIi95e7rJXFNTI=
X-Google-Smtp-Source: APXvYqxZlX8tua/YbrpZmEARCkpuaja15W9JBNIoF3Dlv3lOSHYB72QwP6DhY8Hm1QxGhjO+OOqyfQ==
X-Received: by 2002:a50:ac12:: with SMTP id v18mr26410474edc.232.1559839863109;
        Thu, 06 Jun 2019 09:51:03 -0700 (PDT)
Received: from localhost (ip1f10d6e1.dynamic.kabel-deutschland.de. [31.16.214.225])
        by smtp.gmail.com with ESMTPSA id x30sm588568edc.53.2019.06.06.09.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 09:51:02 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     oliver.graute@gmail.com, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 0/2] Variscite DART-6UL SoM support
Date:   Thu,  6 Jun 2019 18:47:00 +0200
Message-Id: <1559839624-12286-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need feedback to the following patches which adds support for a DART-6UL Board

Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits

Oliver Graute (2):
  ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
  ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard

 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 458 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts    | 209 ++++++++++
 3 files changed, 668 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

-- 
2.7.4

