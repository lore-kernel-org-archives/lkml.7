Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC78C2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13162214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUT4K4VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfLECTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:19:43 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33753 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLECTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:19:42 -0500
Received: by mail-yw1-f66.google.com with SMTP id 192so639655ywy.0;
        Wed, 04 Dec 2019 18:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0wipGAlhtFBkJDMjyVi53Belp9dZbF8qy8E6IHBmAc=;
        b=kUT4K4VJ3i15DzpOkpq7fK7DgnWrHPwjdAGZyO4qBy5SBblwpIll3K/BimeM7GBf6S
         h5JNbWRPQXOoa69Dgpc/c28ZfdA2zZcMDn0ptcRrinbBAdxWFeqjSD39G8OEV6MxyfPo
         PhBieSaCbbvXKPLJ6qAQIXFDisK10uuc/bcHHVArpwGNERDLN3/DEsxnEDPPk6bkLhK5
         4elI7/lcLdf3xETQ+vSuio0Mj+v6HasE/Gc7/cO6p7ELWxy3WnuQltkRDKEdOnv9sY+q
         0wznrP/qzbKz5EgEONJ1NCajYAtvI2dS0XRUVEfYWxtywhIHwozZSWqL/NjgHP6dkISy
         hyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0wipGAlhtFBkJDMjyVi53Belp9dZbF8qy8E6IHBmAc=;
        b=X+eSXH8jWdof+vZ4ygDkRGJyoAy1lvG7DhDjAH7z+6wxU4+7jea+Ou9SuYdbMKp5fD
         Ebtgi48ElFVdRqLhuBrz9QUgLIdLL2IfmOIo21MyG39Uwg0pbA4zU8GP2AUrI7vYKZwS
         w5lN0F4ncQtaN/0/79i11oYOIhcyCEHiik562jlxUw5/JVouYJWmA3KPqhxv8CkQUAcX
         5n0tbc1Cbqoy1km3o81rUssjNRoYSO7MokcldnIT0HB7dp+KHjeuOe+fuoPqetHLXhG0
         jfFlPlybECBgakp5Gn+nQ5oe+9RsnNn16ZAbudlpfridtQsdDKGE++lD8c6NImv0Tf9Z
         No8g==
X-Gm-Message-State: APjAAAUci4Hc+qVuenoJ/jg14R+pNPuBoUL/D7I/BKd3wAwduDHoIJRm
        8dUqH66n08GoDhAigDd7IjA=
X-Google-Smtp-Source: APXvYqwmA0tNypyxHFhWWBSeQmaZKBrbjW0ry33aUyY5ro4GqrUJGZqXbgcg/CTdfAPjgNHekXLwLQ==
X-Received: by 2002:a0d:d5d5:: with SMTP id x204mr3846561ywd.283.1575512380930;
        Wed, 04 Dec 2019 18:19:40 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l6sm4188449ywa.39.2019.12.04.18.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:19:40 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] soc: imx: Enable additional functionality of i.MX8M
Date:   Wed,  4 Dec 2019 20:19:16 -0600
Message-Id: <20191205021924.25188-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPCv2 controller on the i.MX8M Mini is compatible with the driver
used for the i.MX8MQ except for the register locations and names.
The GPCv2 controller is used to enable additional periperals currently
unavailable on the i.MX8M Mini.  In order to make them function,
the GPCv2 needs to be adapted so the drivers can associate their
power domain to the GPCv2 to enable them.

This series makes one include file slightly more generic,
adds the iMX8M Mini entries, updates the bindings, adds them
to the device tree, then associates the new power domain to
both the OTG and PCIe controllers.

Adam Ford (7):
  soc: imx: gpcv2: Rename imx8mq-power.h to imx8m-power.h
  soc: imx: gpcv2: Update imx8m-power.h to include iMX8M Mini
  soc: imx: gpcv2: add support for i.MX8M Mini SoC
  dt-bindings: imx-gpcv2: Update bindings to support i.MX8M Mini
  arm64: dts: imx8mm: add GPC power domains
  ARM64: dts: imx8mm: Fix clocks and power domain for USB OTG
  arm64: dts: imx8mm: Add PCIe support

 .../bindings/power/fsl,imx-gpcv2.txt          |   6 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 129 ++++++++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |   2 +-
 drivers/soc/imx/gpcv2.c                       | 246 +++++++++++++++++-
 .../power/{imx8mq-power.h => imx8m-power.h}   |  14 +
 5 files changed, 389 insertions(+), 8 deletions(-)
 rename include/dt-bindings/power/{imx8mq-power.h => imx8m-power.h} (57%)

-- 
2.20.1

