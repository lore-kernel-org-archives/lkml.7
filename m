Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE06AC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32002253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THT8z/1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgACTEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:04:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38676 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgACTEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:04:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so43381111wrh.5;
        Fri, 03 Jan 2020 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x8j7vi7SOHTwwrftrycS7Qh+VkSUlsK2qUXxAAHOzo8=;
        b=THT8z/1tlsQpVmn/eYr7avv2CAAyuruPJsXyN7t2Eqfqr+Uq0TWlpDlTOv02j30ld3
         +mVVE7TMg8nVgf3hPxXplY4N5oxiXBCMmVh6hDmWLyei4TYcp+S5oYqIyGu+Jsx6yngA
         gZkxzC16PcX+aArbURgD/43sTkn3Va33RSDPOSJxRXksR+NI7lENXJwOklcXFPQsVN+Q
         INN0gvXDWpsXyh6xBfDvcPRBHFDDq+1fgRlFHL+APar6VuEbLvSZcSvOTfriMez6Pr+k
         Cqgn5JDLIxZgk6dRnhTIty0skDGOzneAKk3+NmwpHVo+aD5ul1HtD9rv4akMxqWkzwGN
         0ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x8j7vi7SOHTwwrftrycS7Qh+VkSUlsK2qUXxAAHOzo8=;
        b=tUWx1RVR9mDDYYXzAWoWE4huI7tshneS4GvVbLezqKGCLo5ezVcyzCY47YG1t8tXdo
         ilQHc60T4iRC+kJEXpzYgSsOUKgu70gv2Os6XOLGVe51RNFSWzRbZAevJY1eYpQwkWte
         PCJKucXC135ieOm+MKPAyGxRjrEkwAIYyEJftPSsn6zAHAzFRWYTDVKk97L1TklBRdn5
         0pS/klVdV/Ute0ltCCouI4wWgWnC41LlNPXF6rWOs2SfviIek2RJ+WZgBheKn8LYBCfS
         9XXw/Ml6uvByTyIQ8HS6vaDejTWgaDtHz8SZsFm6517du6q/XqRhLD3Y5sGbMgNBiIcP
         qUDQ==
X-Gm-Message-State: APjAAAWCwTWh/vXTgzmbT9hhZjq0TDghtkX8dEmC0DRs4tQlkTShvMIb
        u1k0pXlLQseSr45FU3+FzfuboxEg
X-Google-Smtp-Source: APXvYqzJ/Urng5Dt4cBTvlh2jMrpYHRyg23bV7gEwizghoGD/ENaRPr/5vl5bWgEkTVgPJQIK7GwPw==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr89016216wrn.152.1578078277878;
        Fri, 03 Jan 2020 11:04:37 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f16sm60822416wrm.65.2020.01.03.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 11:04:37 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH v3 0/2] reset: Add Broadcom STB RESCAL reset controller
Date:   Fri,  3 Jan 2020 11:04:27 -0800
Message-Id: <20200103190429.1847-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

This patch series adds support for the BCM7216 RESCAL reset controller
which is necessary to initialize SATA and PCIe0/1 on that chip.

Please let us know if you have any comments. Thanks!

Changes in v3:

- indented "base" variable with a space
- return ret directly out of readl_poll_timeout()
- removed additional register read after write, not necessary
- removed call to platform_set_drvdata, unnecessary either
- corrected Jim's email in Signed-off-by in patch #2

Changes in v2:

- binding document is in YAML format per Rob's suggestion
- indented bit definitions the same way for all definitions
- moved reset logic to the .reset() callback
- removed the XOR operation which is not necessary after clarifying with
  Jim that this was not necessary
- use readl_poll_timeout()

Jim Quinlan (2):
  dt-bindings: reset: Document BCM7216 RESCAL reset controller
  reset: Add Broadcom STB RESCAL reset controller

 .../reset/brcm,bcm7216-pcie-sata-rescal.yaml  |  37 ++++++
 drivers/reset/Kconfig                         |   7 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-brcmstb-rescal.c          | 107 ++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
 create mode 100644 drivers/reset/reset-brcmstb-rescal.c

-- 
2.17.1

