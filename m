Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE4AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020712184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ACbjs4Wc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDKJaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:30:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36017 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDKJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:30:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so5756357wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8dYomQmJC2FXNHRRJ6Yp9fgEaSxfPM4cxH7R/AXC6U=;
        b=ACbjs4Wc08WQTgUFxdom/fR0Sk/Ucg8dFfOfcilxN5vidsbTK0jTQGR3atfci/nMXY
         YS6Hzzf3BuH1H8ixSbm+YVrKWJZsCDlR3rKz4DdN1iQkjFDjC/0MAK1WjZRmQIh7+8x8
         3ry6Thv6id6VACqiWsn3pRCkA8VemRrT/x8GtWYO3ElRWkQ3I85T2uoKisRCZKvvaCJ3
         Q26aXI3o9C6N/iV1KG0Y1+Gy7gOmpjpCy7mm8IJHdTniKFp3buL67JAtJkV4bZyGEe6k
         hvfsjRkdj8adwvm3JbWluQPerRO9hsCoMCyTq9FwsgLQuyBRcJoUhGaWIIdb9Hx69J/w
         GjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8dYomQmJC2FXNHRRJ6Yp9fgEaSxfPM4cxH7R/AXC6U=;
        b=JddWd2KNIPrn5UjncGY6uv5G2CDxdicGXJbnAyerPCKnicUS6C+umBRWgCp+bf+/OW
         xtEXDWQv4a7oiYnrW8Lp0IOIw4l25EgInbhSLDwQJQuC0FYHBtZQb/+jVBt6Jpjsby0z
         VZG2rNL4tSkOHIvC2vjxrh/EzXpJApIomX27pRrDAyiXMVIrz4oMpPq1RYrUfZACKfYB
         GSxPb2MSNk+DOlMxKoGRdqaR5s2M8xI+wV4SY0yq/SsFhC7Fo4VzkshxR7c8FoTe0PpH
         E5ZFj8Lw4PbGiDuvm82IHARo3Q0t8semI/yVDykSO1paRyfXy9KrbmlsHd72p3kLR3AR
         UsyA==
X-Gm-Message-State: APjAAAUw4WsarTGEMHNjHTyupMSrjkw/k35XUbUEFKw9fTQLw1/F7WYd
        vwSWwlWvEV8EqSbUQ+BQzO7iOQ==
X-Google-Smtp-Source: APXvYqxMWNjFDrAv6mR3Crr6SAPIB7767MX6xvZeCXz9AEnOOxTBImpMolVOYyb2WngxYnFM3flKvg==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr5828012wml.108.1554975028502;
        Thu, 11 Apr 2019 02:30:28 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a9sm37517228wrt.29.2019.04.11.02.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:30:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/6] ARM: davinci: ohci-da8xx: model the vbus GPIO as a fixed regulator
Date:   Thu, 11 Apr 2019 11:30:18 +0200
Message-Id: <20190411093024.23555-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Historically the power supply management in this driver has been handled
in two separate places in parallel. Device-tree users simply defined an
appropriate regulator, while two boards with no DT support (da830-evm and
omapl138-hawk) passed functions defined in their respective board files
over platform data. These functions simply used legacy GPIO calls to
watch the oc GPIO for interrupts and disable the vbus GPIO when the irq
fires.

Commit d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
updated these GPIO calls to the modern API and moved them inside the
driver.

This however is not the optimal solution for the vbus GPIO as it
duplicates code. Instead we should model the GPIO as a fixed regulator
that can be controlled with a GPIO.

This series adds fixed regulators for all users of vbus GPIO, adds
overcurrent protection using the existing vbus regulator in the USB
driver and removes the vbus GPIO calls once they're no longer used.

Tested on da830-evm with the module both built-in and loadable.

v1 -> v2:
- add patch 1/6 that fixes an existing problem with missing array
  sentinels in GPIO lookups
- add patch 2/6 that removes an unnecessary use count variable from the
  driver
- reorder the changes: add support for overcurrent protection using the
  existing vbus regulator first, then setup fixed regulators in board
  files and finally remove the vbus GPIO from the ohci driver

v2 -> v3:
- change the device id of the fixed regulator to 0 since it's the first
  one
- drop the interrupt-context handler and only use the thread
- drop Alan's Ack from patch 3/6 as it's changed significantly
- rebase on top of v5.1-rc4

v3 -> v4:
- in patch 2/6: switch to using a simple if/else

Bartosz Golaszewski (6):
  ARM: davinci: add missing sentinels to GPIO lookup tables
  usb: ohci-da8xx: let the regulator framework keep track of use count
  usb: ohci-da8xx: disable the regulator if the overcurrent irq fired
  ARM: davinci: omapl138-hawk: add a fixed regulator for ohci-da8xx
  ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
  usb: ohci-da8xx: drop the vbus GPIO

 arch/arm/mach-davinci/board-da830-evm.c     | 51 +++++++++++++++++++--
 arch/arm/mach-davinci/board-da850-evm.c     |  1 +
 arch/arm/mach-davinci/board-dm355-evm.c     |  1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |  1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c | 50 ++++++++++++++++++--
 drivers/usb/host/ohci-da8xx.c               | 46 ++++++++-----------
 6 files changed, 116 insertions(+), 34 deletions(-)

-- 
2.21.0

