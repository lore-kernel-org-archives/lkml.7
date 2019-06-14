Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E511AC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B903021744
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYZQPf/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfFNOcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:32:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfFNOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:32:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so2594565wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6dx8IthmYeODXJTWDgDHbvYQeG+IBbtQF3N5rPmWJ8=;
        b=BYZQPf/Yo04AR0YRFuqcQK1wnLxFr/EWz5ugW60RjynlaZuPIHKCeay4KBUD3mBuvC
         t/JFWA+V+zcfNhuL0zU7jiaqrVdSbA2I7ckTgPTkfKTcJw5vCAS0FZD+KoNnMIu8W1yt
         OnFUsQgNkHbbKypghiWT7eg+kxL97LqI5wQtiLRPUCxQhS0aVn7tNUzhMkcjZNuNVff8
         tTKY6O2dzy5ot1aTWGHWz3wI/6bVSmh2I007uGsLcOhqzCRQG2MJKiKrESkKHvXdPwuj
         515JxYXc0jMhL8hcy+vbuASScIR334IgOE8W61jAuaRKJHovsLJLvz0uufEeNqhxJeH6
         60Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6dx8IthmYeODXJTWDgDHbvYQeG+IBbtQF3N5rPmWJ8=;
        b=q3z0AWvW7m5ZJevpx+4aZh/VgE8sBk2kp7Qh+yidjIccmJ3zTi4mIQsONK3/FTMBj/
         HPpSdHshc6CfROrXJZu//L+q2qxTrN4GTpIr/NEsldT4/g8IYe/1PDxKfnFwzl1JAKf+
         OI0G4VBITbvaExkOH5emrc/sPyL8OQSIi+D6iDFIbRx9xLrfoNq3slmbDv2stg/KVnOt
         3Vz3vdZ3aAV0ZxsxifbZBnUY+YcJrdZA7oiUszVogg/5udV63b7oNcKAgmTCy29rWPNR
         cZ0VSItEKo082Pop09COJaxqiWTn6+mhYk/dWT4UHWdCLdGbL2PayjBhyOhmfshut+pT
         fDtg==
X-Gm-Message-State: APjAAAUjo22llB8b1y2MLRZI7aQQK8QjAFa02Yv1JTDbZabFXm1FH20P
        7ATNQ9N54GC0yEv+WcHkYD/duELx0H+PzQ==
X-Google-Smtp-Source: APXvYqxY8GExMj+SNXiq2vYQ12iCTjSlR0bp8e+21s5Ja252dt4UE6Wsl+RtM6hYLKDqBmJbV8YzJA==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr8044567wmb.66.1560522743015;
        Fri, 14 Jun 2019 07:32:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t6sm4738007wmb.29.2019.06.14.07.32.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:32:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] nvmem: patches for 5.3
Date:   Fri, 14 Jun 2019 15:32:15 +0100
Message-Id: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are few nvmem patches for 5.3 which includes
- new i.MX8 SCU On-Chip OTP Controller support
- Few SPDX Licence header updates.
- sun4i and sunxi dt bindings in yaml

Can you please pick them up for 5.3.

thanks,
srini


Fabio Estevam (1):
  nvmem: Broaden the selection of NVMEM_SNVS_LPGPR

Maxime Ripard (1):
  dt-bindings: nvmem: Convert Allwinner SID to a schema

Neil Armstrong (2):
  nvmem: meson-efuse: update with SPDX Licence identifier
  nvmem: meson-mx-efuse: update with SPDX Licence identifier

Peng Fan (2):
  dt-bindings: fsl: scu: add ocotp binding
  nvmem: imx: add i.MX8 nvmem driver

 .../bindings/arm/freescale/fsl,scu.txt        |  22 +++
 .../nvmem/allwinner,sun4i-a10-sid.yaml        |  51 ++++++
 .../bindings/nvmem/allwinner,sunxi-sid.txt    |  29 ----
 drivers/nvmem/Kconfig                         |   9 +-
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/imx-ocotp-scu.c                 | 161 ++++++++++++++++++
 drivers/nvmem/meson-efuse.c                   |  10 +-
 drivers/nvmem/meson-mx-efuse.c                |  10 +-
 8 files changed, 246 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
 create mode 100644 drivers/nvmem/imx-ocotp-scu.c

-- 
2.21.0

