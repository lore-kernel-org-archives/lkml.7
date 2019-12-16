Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9B0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D5B206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFqMAtMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLPLlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:41:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40316 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfLPLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:41:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id s35so2855707pjb.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=85EH2q2sl+6OikeKU4WoMo18jccrQb7LxSHamjwtKZ8=;
        b=uFqMAtMmxojh6T3z4PhSih4AMaGF+bS54mlSYxEYxvz609503/bD0rFhwuraEI32vk
         n/zeIFbdk3EVB5AxA98XTASC7BswQdZX7accFqXHZ43dI9tiKPBoAxHxXH8oO3pivoAf
         +fG5B0X61F4AdzRSAHn76VbePFn90rddxF4RrtDPg2T019vHk79AEacTL7XkzVOcLqWi
         +fFLXOPy7F1cCnDscmvQIKlHrOZU5Mudao1GqNi36bCnFFGgnEozv+Lwgy69S3MeLdSN
         RP1BUSXVLW00JKoeJmVQ2BuM/eDfLiNcPD3zgrMhkFlLp3cnqBUYPujy1Olx5I1QNVjr
         gAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=85EH2q2sl+6OikeKU4WoMo18jccrQb7LxSHamjwtKZ8=;
        b=SJtEfA+C30k4M5kEmfxgjBGwA9hxo2CKdlEc07GZKmoVcl6CZcS36eJ0HWZCpUcnxX
         MyjJT85AS8L5oZ+VO8e61t4du0vFCAjYR2lCZJQfpHwBonqFxkp8y5wjtzTQ2EklbZvn
         TwU9bskRZ8tpDRRXGZ4q89evTlwAmY7GbFUKA5p0nycjNNhv3ShVrLyzQn0+cyMFxJoU
         J/qStwj+OEbmtm1b2ZtaQ0bL9WzkETLKAziq28AtQNgCbni7uXGC2MhuU/6VpA/UUoBv
         rBKsD4O1z/V1DKFQgLFugotMKSGet4+qCvxIlzu34yibvapynXeIi34XeGe9yHS4fgtP
         d/YQ==
X-Gm-Message-State: APjAAAUnsYcfocCEFRnkdzRzm4ZfcABu6CDtqZjt80U6wsOjSDTgJh03
        Kcb4lPVOrklvlbAOWpVu+fE=
X-Google-Smtp-Source: APXvYqyj5vhLSxC3nGhApTlzLqKjVHESs+vgLB5q/UGisvnCV9LbjeIXBFy63vzHXpx1q2GhkdGkzQ==
X-Received: by 2002:a17:902:b614:: with SMTP id b20mr15416880pls.20.1576496459630;
        Mon, 16 Dec 2019 03:40:59 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p124sm22432269pfb.52.2019.12.16.03.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2019 03:40:58 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v1 0/6] Add Unisoc's drm kms module
Date:   Mon, 16 Dec 2019 19:40:13 +0800
Message-Id: <1576496419-12409-1-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This patch is our Unisoc's new drm display driver, This driver
provides support for the Direct Rendering Infrastructure (DRI)
in XFree86 4.1.0 and higher

ChangeList:
v1:
1. upstream modeset and atomic at first commit
2. remove some unused code
3. use alpha and blend_mode properties
4. add yaml support
5. remove auto-adaptive panel driver
6. remove CMA keywords from gem driver

Best,
Kevin Tang

Kevin Tang (6):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver

 .../devicetree/bindings/display/sprd/dphy.yaml     |   78 ++
 .../devicetree/bindings/display/sprd/dpu.yaml      |   85 ++
 .../devicetree/bindings/display/sprd/drm.yaml      |   38 +
 .../devicetree/bindings/display/sprd/dsi.yaml      |  101 ++
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/sprd/Kconfig                       |   14 +
 drivers/gpu/drm/sprd/Makefile                      |   16 +
 drivers/gpu/drm/sprd/disp_lib.c                    |   93 ++
 drivers/gpu/drm/sprd/disp_lib.h                    |   34 +
 drivers/gpu/drm/sprd/dphy/Makefile                 |    7 +
 drivers/gpu/drm/sprd/dphy/pll/Makefile             |    3 +
 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c  |  640 +++++++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c          |  254 ++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_hal.h          |  329 +++++
 drivers/gpu/drm/sprd/dpu/Makefile                  |    8 +
 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                |  798 +++++++++++
 drivers/gpu/drm/sprd/dsi/Makefile                  |    7 +
 drivers/gpu/drm/sprd/dsi/core/Makefile             |    3 +
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c      | 1186 ++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h      | 1417 ++++++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c  |  392 ++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c            |  544 ++++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h            |   28 +
 drivers/gpu/drm/sprd/dsi/sprd_dsi_hal.h            | 1102 +++++++++++++++
 drivers/gpu/drm/sprd/sprd_dphy.c                   |  218 +++
 drivers/gpu/drm/sprd/sprd_dphy.h                   |  106 ++
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  671 +++++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  138 ++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  286 ++++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   18 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    |  606 +++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  195 +++
 drivers/gpu/drm/sprd/sprd_gem.c                    |  178 +++
 drivers/gpu/drm/sprd/sprd_gem.h                    |   30 +
 35 files changed, 9626 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dphy.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dsi.yaml
 create mode 100644 drivers/gpu/drm/sprd/Kconfig
 create mode 100644 drivers/gpu/drm/sprd/Makefile
 create mode 100644 drivers/gpu/drm/sprd/disp_lib.c
 create mode 100644 drivers/gpu/drm/sprd/disp_lib.h
 create mode 100644 drivers/gpu/drm/sprd/dphy/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dphy/pll/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c
 create mode 100644 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c
 create mode 100644 drivers/gpu/drm/sprd/dphy/sprd_dphy_hal.h
 create mode 100644 drivers/gpu/drm/sprd/dpu/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h
 create mode 100644 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c
 create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h
 create mode 100644 drivers/gpu/drm/sprd/dsi/sprd_dsi_hal.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_gem.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_gem.h

-- 
2.7.4

