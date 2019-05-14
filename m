Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98841C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EBC20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKzn3k5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfENKli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:41:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55357 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:41:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so2303422wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Eb2g/Gd8rqWbiIQQI1Pc54fC1sFwjpsg8qdBE5kpowU=;
        b=oKzn3k5mHco+6JoK01TjcY0DpfVD0zW701YfvR2BzUFSNNUPcYdbtMzsjrxBkPTgVI
         Nf3qaYxQURJ/WBszuS/S65gqatcG8k8PH9svkg0ZqsraBUWVEsbrzXaCtiE0zTNYsyD7
         9VjIRNUoQhkYijMedIvLRKQjiZAy24wvqgq8oC2Oph0lncNc/BtqDXXA8SsrT0SrSAhb
         1sOZUgWGB0RjpYQK26tbBJUc96nuEzw81RuPk81oViJCIs79kT70eAZLxfxsy6t4hXBX
         WybWjWTMdDLCFfGp3isGiQRRHiTKxUFsDpK1ciLC8Nyp+aaqbU5Mdw3nuhifAkqW96ZO
         eRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Eb2g/Gd8rqWbiIQQI1Pc54fC1sFwjpsg8qdBE5kpowU=;
        b=BkpM0P5zhIJzGz1KfjO9qEUUE+Fkx8Kur+zPO3kGn0E9bDXIE5/ngAs1YLmwBSbU1k
         sLmJ/tC79X/7Sfs4n5nkfpNCqLK8YXu3wswb6hGvGmCXq2T2ETViaC1y7FRYA8ttE8ps
         Fjn1gnf6CaIAhjq8zMOtl6tzVgr8AZV2Kfz+Xd4x3nraDKnAJpzCh3sgtRKYoel02QeX
         gN/Yal9ULjqRcJT3kM2mj0ywoZgZj0Knp5yL3rQ/0ZeYZfleBpLZcAYqBLNBd2zVYhIQ
         q2y6JhXzIOGS/zxUylPNgOnrZZGaTkLKjt0FoV0pTWvNw6lLEACztP1JnNNCgRLrs7+H
         mS5g==
X-Gm-Message-State: APjAAAVVN5PFjQ/dbIvAf3OuT8C3r43HcyJ+kt7gpmlRx5C7kbNl9pru
        6BtvFGOGg0658Ag7poG8Q6/G4Q==
X-Google-Smtp-Source: APXvYqzEVJX7s0m3SP4pwS9SMq9Ps+DjhgnEnZS7CasDvZlvEl+21YpzUE7mhicTX4jP7nQQ+jFOYg==
X-Received: by 2002:a1c:700f:: with SMTP id l15mr19209811wmc.150.1557830495359;
        Tue, 14 May 2019 03:41:35 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id s10sm14674958wrt.66.2019.05.14.03.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 03:41:34 -0700 (PDT)
Date:   Tue, 14 May 2019 11:41:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.2
Message-ID: <20190514104133.GN4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.2

for you to fetch changes up to 8fbce8efe15cd2ca7a4947bc814f890dbe4e43d7:

  backlight: lm3630a: Add firmware node support (2019-05-14 08:16:01 +0100)

----------------------------------------------------------------
 - Fix-ups
   - Remove unused BACKLIGHT_LCD_SUPPORT symbol; Kconfig
   - Remove unused BACKLIGHT_CLASS_DEVICE dependencies; Kconfig
   - Add DT support; lm3630a_bl

 - Bug Fixes
   - Fix error path issues; lm3630a_bl

----------------------------------------------------------------
Alexander Shiyan (2):
      video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol
      video: lcd: Remove useless BACKLIGHT_CLASS_DEVICE dependencies

Brian Masney (3):
      backlight: lm3630a: Return 0 on success in update_status functions
      dt-bindings: backlight: Add lm3630a bindings
      backlight: lm3630a: Add firmware node support

 .../bindings/leds/backlight/lm3630a-backlight.yaml | 129 +++++++++++++++++
 arch/unicore32/Kconfig                             |   1 -
 drivers/gpu/drm/Kconfig                            |   2 -
 drivers/gpu/drm/bridge/Kconfig                     |   1 -
 drivers/gpu/drm/fsl-dcu/Kconfig                    |   1 -
 drivers/gpu/drm/i915/Kconfig                       |   1 -
 drivers/gpu/drm/nouveau/Kconfig                    |   2 -
 drivers/gpu/drm/shmobile/Kconfig                   |   1 -
 drivers/gpu/drm/tilcdc/Kconfig                     |   1 -
 drivers/staging/olpc_dcon/Kconfig                  |   1 -
 drivers/usb/misc/Kconfig                           |   1 -
 drivers/video/backlight/Kconfig                    |  35 ++---
 drivers/video/backlight/lm3630a_bl.c               | 153 ++++++++++++++++++++-
 drivers/video/fbdev/Kconfig                        |   5 -
 include/linux/platform_data/lm3630a_bl.h           |   4 +
 15 files changed, 293 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
