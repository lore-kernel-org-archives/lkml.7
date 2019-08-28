Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F180DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7102173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8LX9/UQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfH1QTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:19:54 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45750 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfH1QTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:19:54 -0400
Received: by mail-wr1-f52.google.com with SMTP id q12so364500wrj.12;
        Wed, 28 Aug 2019 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h2Qh+gscHnR7JdUJaSMgnvl1LJ0NCwpowKI5j/ZvmWU=;
        b=u8LX9/UQhL4+ai6U3VRZ6sQHe2IRUYsLsY5NEl2FgJnKQFzBAS6YPo9qKbpyulP7sp
         W/YrUlGY0QG3TVRC5MvrX/e8BG3bcN7/8IctAReoGh/nVeEFDL2cFoS0/hG+SITtqDMd
         RpG9hUyPtrjEdqxRi7llub8A29dAuleGXaB86PxXgFqnH2XW/nQEFCtPctFicKBVUkhh
         6rSH5Q7fDYi+vEdkb9HC3C92dkICqvfVwLsVatPTHCEDUM9Xsp4ogIkgD+xDyhD+t6z1
         CVg1EcDY7gSFfc/8KBCxS3WDfQi/DPSiWYtdMFcNNThgVUwNbU7ueFmxncbrk/izCO1o
         PHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h2Qh+gscHnR7JdUJaSMgnvl1LJ0NCwpowKI5j/ZvmWU=;
        b=bPKPt1/d9/huWG4q+MMTnM3IqhtI6lr5WCr5hgbLEL1100DXueLECewiAz9PaGqOyf
         /kANF21vb6fuV1ddHQzFIyKWRlbGyN930aCOFfHDm0P65DKZ/+XZvdxHE08TEjaLZeTz
         ev15JmdQRv85OSAFqKq++fuLjEBjzpzfV4pPuElo/Voc9/JgkLkpVzIkAHNEDw4/SCcR
         XUqAZBHutFiTwCd/Va/wdmD/wac4p6w0umGRe77cW6qIfvOAH4VBcVpUQTPKxafDC35d
         DczVQuK7ndJB7KvQc1skFcH7sUr41qsVFUkL5lKBdE7h1lvGMayqv7wtyG0em2URHrC5
         hgCw==
X-Gm-Message-State: APjAAAX7/JiJBOIAtj0I2KeKhRlZvOiu4V9JedX7GCDwaplTG+G4OtH6
        Agu7mqAO9ORurkWiEx+MrLk=
X-Google-Smtp-Source: APXvYqzmHItt68j4CFSaYP1355hKziONiyL+VRfe/5ff4LpMcoPcSL6AqjJmEf4SwqIUWHYI1yJQdQ==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr6186501wrn.184.1567009191817;
        Wed, 28 Aug 2019 09:19:51 -0700 (PDT)
Received: from localhost ([31.16.217.87])
        by smtp.gmail.com with ESMTPSA id a141sm9494988wmd.0.2019.08.28.09.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 09:19:50 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@gmail.com, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 0/2] Variscite DART-6UL SoM support
Date:   Wed, 28 Aug 2019 18:19:16 +0200
Message-Id: <1567009160-21965-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need feedback to the following patches which adds support for a DART-6UL Board

Need feedback howto document propertys and compatible the right way

Need feedback why ethernet RX is deaf

Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits

Oliver Graute (2):
  ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
  ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard

 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 445 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts    | 196 +++++++++
 3 files changed, 642 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

-- 
2.7.4

