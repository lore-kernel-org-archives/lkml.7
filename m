Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C5C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F6D20883
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HwMexQJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCCUGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:06:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfCCUGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:06:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so1422386pfn.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVPzDY72470tY0FltbkT7D/GyDpYLW7HTjjFEtM8nfA=;
        b=HwMexQJxIOwa8zkMS2QDbrMpR9E2sNWUNx2C8NyyK+039QnATyUB2hWqqm/Ni0bUZn
         XR3P2JwyHL+DoDiwM/pzGUPrRB1BIQa9nktdFqnsUPiQ8W7BHTsXQy3oqHwj91ENErMg
         VRIbKg/gGeWZz8XYUEw7HD1NrhC04xg53fcBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVPzDY72470tY0FltbkT7D/GyDpYLW7HTjjFEtM8nfA=;
        b=BNcLjubRWFaWWZ238mP1R856Wp27JVVx7d2XSyd1NvUVFRv78F8MgSz+icei8wq/Zu
         DRPUlS3xNH5ha5uewlVeMobmC+/9cJK2/cZ773l7hE0/jQeZPU4LiPQTMOTvVGJLDsBM
         yK9ExpXgg/GXfwPkZTkbjeaislIfYzY3nmshE6u/5v6K/ybpWb+kqL8cedny1YDnzWH9
         0NDW1/0BmRvKcPomsDlCnHX4iI0EZWRz5iigrzkMC1j5aXiITG15M4DaECexzNZuaGZ1
         +hrn+mgVMUZNZPd4YIAk/lw1s52mq7RF22sGUIcihKAthJsUXixNiOLWNRMMySytDL0C
         aP1A==
X-Gm-Message-State: APjAAAUaYHTBlI2l83mrvrDrtSeR0zNCScJlwkDuyTBb1aK2038hYPnP
        GXq4uV5O0L0feBNUt+DiOoczpw==
X-Google-Smtp-Source: APXvYqw7DmdjDDBE5NRI0cioDMcebr1Tnf6zHClf5sfgGsvye2AfkwHtgkgMqhXTLtzJMIILFGYGhA==
X-Received: by 2002:a17:902:1026:: with SMTP id b35mr16268631pla.252.1551643602904;
        Sun, 03 Mar 2019 12:06:42 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id j14sm5654021pfn.77.2019.03.03.12.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:06:42 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/4] drm/panel: Add Novatek NT35596 panel driver
Date:   Mon,  4 Mar 2019 01:36:14 +0530
Message-Id: <20190303200618.17581-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set support Microtech MTF050FHDI-03 MIPI DSI panel, which
has Novatek NT35596 controller IC.

Since there is no proper programming guide for NT35596 IC, the driver 
init sequence is referenced from [1] but analyzed based on datasheet.

NT35596 support several regulators on the chip, among those ony 4
regulators like VCI, VDDI/DVDD, AVDD, AVEE are used during power-on
sequence. Right now driver added code for 3-regulator based power-on
sequence since MTF050FHDI-03 panel support. This power-on sequence may
be moved to panel_desc in future, if there is any new panel would come
up with other type of sequence.

[1] https://android.googlesource.com/kernel/msm/+/android-msm-shamu-3.10-lollipop-mr1/arch/arm/boot/dts/qcom/dsi-panel-nt35596-1080p-video.dtsi

Any inputs?
Jagan.

Jagan Teki (4):
  dt-bindings: Add vendor prefix for novatek
  dt-bindings: Add vendor prefix for microtech
  dt-bindings: display: Add Novatek NT35596 panel documentation
  drm/panel: Add Novatek NT35596 panel driver

 .../display/panel/novatek,nt35596.txt         |  32 +
 .../devicetree/bindings/vendor-prefixes.txt   |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt35596.c | 860 ++++++++++++++++++
 6 files changed, 914 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt35596.c

-- 
2.18.0.321.gffc6fa0e3

