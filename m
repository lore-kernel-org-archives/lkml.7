Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8146FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4984D206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii/ucN1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLJIgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:36:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46878 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLJIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:36:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id z21so7093818pjq.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fsnlSubZghOrO7JimNuHIfleyU8iOvTlpKskXRjns4=;
        b=ii/ucN1rxj6JCmjxSTHN0ekVilVInrhHQyAguU/mv0gKySpU4EjFHUaHdJuuyNk9JB
         Vq+dOrrAV7d9WfTjY9U9elkS4HYOCUJ3ZalqlnkA0ef92RlCeY/GQYodU7L2NN3TClyH
         /EFpbokRIHQkuzlttz2O6XpRD26LC8mkKrPAvSPr+H8T4GGOpVFbCAnWe8JCqi8ie6ol
         dcFWtfU2TLobl0bPIs0LcI8pDnBNRpR3yUUFg+XNGZaQfYmAwPMkUqciQ2rF2y5OPlbM
         9fLRzLs0edzrKB+VWw2OrxqgnWcMPJk1tfW8yqekQsa8bCu6YI9eTvsaTIpQ9Jj5TO71
         VRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fsnlSubZghOrO7JimNuHIfleyU8iOvTlpKskXRjns4=;
        b=GQeo8xOJnp1uOPhC5QO7IIJP3R4S4h6jNf63v77Q7Lxuw9mv9gvTZUm/j6YWu168r1
         Rr37vnEIaE/wKNV+4l9WbHHHkc/DMfHjjcGERPFpULsTtrCd0nvpCU18HF7+NWzjkNVj
         QCfx/PiyXFVYV6JylmElIuEb58sqZ823kg6YWeC0/XnV3cYFB+8BS4PtyydEp2WBkiA2
         sbBs5NfQrmsWUdgLEhpOv5ULLqCvsVdgk8sOYGYoR9lcXvgi/1tRIQnrJTQUc9OAnBEO
         CDKyZRlAlrZ37oJHtME/ip+fUk/32Efe2v8Y9Pr0Is0JvNxZ5Dgr+niBvVVhWUESKFmS
         tAOw==
X-Gm-Message-State: APjAAAV+e6sjweCGTkSu4g8h+ZjO3Qx1FcMjIVmdgTB7aPwSixndc79p
        f748CTTH4ILHLp0LXBZP9lz0Pqja
X-Google-Smtp-Source: APXvYqyoXXioJ5BYD/aK5SM6EJtUev7BGsYxelZ31rR/MTOuLvS4HpjqFdMISdNatw3dVNJe4v9dNA==
X-Received: by 2002:a17:90a:a48c:: with SMTP id z12mr4193037pjp.38.1575967004921;
        Tue, 10 Dec 2019 00:36:44 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y128sm2246632pfg.17.2019.12.10.00.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 00:36:44 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC 0/8] Add Unisoc's drm kms module
Date:   Tue, 10 Dec 2019 16:36:27 +0800
Message-Id: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This patch is our Unisoc's new drm display driver, This driver
provides support for the Direct Rendering Infrastructure (DRI)
in XFree86 4.1.0 and higher.

This patch include display controller, mipi dsi and mipi dphy support
for Unisoc's display subsystem.

Best,
Kevin Tang

Kevin Tang (8):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver
  dt-bindings: display: add Unisoc's generic mipi panel bindings
  drm/sprd: add Unisoc's drm generic mipi panel driver

 .../devicetree/bindings/display/sprd/dphy.txt      |   49 +
 .../devicetree/bindings/display/sprd/dpu.txt       |   55 +
 .../devicetree/bindings/display/sprd/drm.txt       |   18 +
 .../devicetree/bindings/display/sprd/dsi.txt       |   68 +
 .../devicetree/bindings/display/sprd/panel.txt     |  110 ++
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/sprd/Kconfig                       |   14 +
 drivers/gpu/drm/sprd/Makefile                      |   17 +
 drivers/gpu/drm/sprd/disp_lib.c                    |  290 ++++
 drivers/gpu/drm/sprd/disp_lib.h                    |   40 +
 drivers/gpu/drm/sprd/dphy/Makefile                 |    7 +
 drivers/gpu/drm/sprd/dphy/pll/Makefile             |    3 +
 drivers/gpu/drm/sprd/dphy/pll/megacores_sharkle.c  |  640 +++++++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_api.c          |  254 ++++
 drivers/gpu/drm/sprd/dphy/sprd_dphy_hal.h          |  329 +++++
 drivers/gpu/drm/sprd/dpu/Makefile                  |    8 +
 drivers/gpu/drm/sprd/dpu/dpu_r2p0.c                | 1464 ++++++++++++++++++++
 drivers/gpu/drm/sprd/dsi/Makefile                  |    7 +
 drivers/gpu/drm/sprd/dsi/core/Makefile             |    3 +
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.c      | 1186 ++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0.h      | 1417 +++++++++++++++++++
 drivers/gpu/drm/sprd/dsi/core/dsi_ctrl_r1p0_ppi.c  |  392 ++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.c            |  544 ++++++++
 drivers/gpu/drm/sprd/dsi/sprd_dsi_api.h            |   28 +
 drivers/gpu/drm/sprd/dsi/sprd_dsi_hal.h            | 1102 +++++++++++++++
 drivers/gpu/drm/sprd/sprd_dphy.c                   |  235 ++++
 drivers/gpu/drm/sprd/sprd_dphy.h                   |  121 ++
 drivers/gpu/drm/sprd/sprd_dpu.c                    | 1152 +++++++++++++++
 drivers/gpu/drm/sprd/sprd_dpu.h                    |  217 +++
 drivers/gpu/drm/sprd/sprd_drm.c                    |  287 ++++
 drivers/gpu/drm/sprd/sprd_drm.h                    |   19 +
 drivers/gpu/drm/sprd/sprd_dsi.c                    |  722 ++++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h                    |  210 +++
 drivers/gpu/drm/sprd/sprd_gem.c                    |  178 +++
 drivers/gpu/drm/sprd/sprd_gem.h                    |   30 +
 drivers/gpu/drm/sprd/sprd_panel.c                  |  778 +++++++++++
 drivers/gpu/drm/sprd/sprd_panel.h                  |  114 ++
 38 files changed, 12111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dphy.txt
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.txt
 create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.txt
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/sprd/panel.txt
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
 create mode 100644 drivers/gpu/drm/sprd/sprd_panel.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_panel.h

-- 
2.7.4

