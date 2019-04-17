Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBBEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD59521773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+X2d3Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfDQIp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:45:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46039 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQIp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:45:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so11690559plb.12;
        Wed, 17 Apr 2019 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXm1tl+PXllECBsTpRqh8sEx+FmO1JNYbg26ZXkKdfM=;
        b=S+X2d3DvB3a7GIYc7bx3P0WjFPbLUqLCF9aXIZwFJMdnXfAxic20KzW0e06MMgq3CS
         IBPm5ZJz1XNCBeVF1I7nWM7VPIr/8ZoX6prUJWqFnezbPSLfIDrbRIUwAFzLaz7pDIlJ
         p8ZOiCc3gSRf9+JeVCSGysvPOC/gQxj/3Xu+O+8gToc9Qx6sPxniSpjOfXywONmpmpWX
         CHTYAtbDkD0aBr2tNVE5VqM5Vb8SXR79Ueyx1N23j5NeTOuvc3Qe/W9l37xaM/553zhI
         66pbqukaTjW9ADCqgTx4kUIWqRlRg63CtHG5AWONL6oxM3dZjAUUxhbpk2vMfA5XtYRm
         TdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXm1tl+PXllECBsTpRqh8sEx+FmO1JNYbg26ZXkKdfM=;
        b=WPwd00jukk6lON2zfX3zuzX4RboYeyw2BfHbVPhhG+34VZnzg430UHwvcRr0Axhu91
         T2/4jl7TQuGft4PBVLDSs8eGqLRI2BTsXMAyOYwo3Bu0o8yTOuQsStHj5roJysca4kpJ
         STxgdGPDlnGwnhvDifdRnvs+/UEsvfugpIQO3RCijSvLysB1V13QTTO+gNO7I3JVvgdV
         MNlwlRBdv5EGR6Bvk9v+tdWMc9zxMdgLksDqh4UmYmjm8sju/qt30DuKoNWOYB7JjA6h
         V7AuQLM00NIsoIxBbme6dAn+iwXGMHfNwKQ2+xe5klGzX4AeRhvJ0R3HwsLe3yrNqW6l
         xVhA==
X-Gm-Message-State: APjAAAU5xzFnEtJRP9m8LLpqxPlvsTSGOZh1+wLAs8W9pOUpAKIYUnUf
        4Uxd0EpyzgnrrAsPdqEmd1mmitsxlOs=
X-Google-Smtp-Source: APXvYqyGIth8p7IjsXWGlmAKTu5PEuUKcuDslu4THzs7PdXPG4v++Y/dTCxBWf2cKttqcS+WhvQmxw==
X-Received: by 2002:a17:902:22f:: with SMTP id 44mr84336141plc.175.1555490724835;
        Wed, 17 Apr 2019 01:45:24 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g64sm124142972pfg.13.2019.04.17.01.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 01:45:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Health <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Driver for UCS1002
Date:   Wed, 17 Apr 2019 01:44:54 -0700
Message-Id: <20190417084457.28747-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This small series adds a driver for UCS1002 Programmable USB Port
Power Controller with Charger Emulation. See [page] for product page
and [datasheet] for device dataseet. Hopefully each individual patch
is self explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

[page] https://www.microchip.com/wwwproducts/en/UCS1002-2
[datasheet] https://ww1.microchip.com/downloads/en/DeviceDoc/UCS1002-2%20Data%20Sheet.pdf

Andrey Smirnov (3):
  power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
  power: supply: Add driver for Microchip UCS1002
  dt-bindings: power: supply: Add bindings for Microchip UCS1002

 .../power/supply/microchip,ucs1002.txt        |  26 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/power_supply_sysfs.c     |   2 +-
 drivers/power/supply/ucs1002_power.c          | 639 ++++++++++++++++++
 include/linux/power_supply.h                  |   1 +
 6 files changed, 677 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
 create mode 100644 drivers/power/supply/ucs1002_power.c

-- 
2.20.1

