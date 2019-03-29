Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1BE2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="StbL9jxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfC2Jdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:33:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44144 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2Jdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:33:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so1676921wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpELJtW4fCVe+Ycfj/JyzEGzxyVdJh7lCZRF0JRDAmo=;
        b=StbL9jxfAYy2Dxev994vRr2jrp0QWEaYx4Q38Af7iiA6tnp8/u4/eJIcMCja5VxTcw
         M25dq5tUiv0KyBxRY2noBeBD6ua5st5yuLJAzGFnfF6gP8mOrkkDD5k6qXd6T5ORXyiF
         W6k3eAWsrrvg9mtq1tmmyd5J6MgKfH6R/CdDbSnoQNW/t6Awo/lMcuZOOOcyvpFq9E3O
         9NnDacgcmIyBjlEH3tMIswPNtalwAgpv3QAMC92sH+1/eOsYxdRmkxw6vy18/gndwfXr
         LcYs5/Hl+4OotlZmudghUor9a++XZetTH8HTbDAdt9Tk7dMQ5z58Gn+lu1KuEfUqiPJW
         C/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpELJtW4fCVe+Ycfj/JyzEGzxyVdJh7lCZRF0JRDAmo=;
        b=YSBVIjfsuzsoPB/RU18leg1syujqQAuCNpxDSRaNao42MoE9A69wFCjZgKtpKldi7U
         0cH/oNvbXx5q/tbhj1p2p6jlw3LVpQt4oELneP8WOW5/jx3rFDV0ffKSGh/cvOWNgAdM
         wba1f9iNt7Z09429anpkovSUfu4tw+tdYeJLQx8mS9Ocim6lO8cAR5+5DoGE2TSZghJn
         xcl27UKrvel+2pvd0d816GIVnVmwJn8HtlV7wXy9/hN1B58HLEX+SSILn4oYJK0LFXqN
         xJ4rmsczhk5qrTZKaiEOhXnLc3O+T7po3kC88LJp8gDGmSYYi2pEmNzebYxXeRpsY7da
         AZTQ==
X-Gm-Message-State: APjAAAV0vD4UWSK/PoqfZL7/pabMKt7snQjabIoe/etFU9W7b06VpZVc
        fXOtBEqHs+gRPXr4JKMcU9cMhA==
X-Google-Smtp-Source: APXvYqwGe72+R/HJYLG4Bw9as9N3h4jGK5k9CIf2Cpdx+/xB0L0e7eEQ5bI83VsTjllybDqiHtY4/g==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr29266263wrn.120.1553852021903;
        Fri, 29 Mar 2019 02:33:41 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id s12sm1957125wmj.42.2019.03.29.02.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:33:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/6] ARM: davinci: ohci-da8xx: model the vbus GPIO as a fixed regulator
Date:   Fri, 29 Mar 2019 10:33:28 +0100
Message-Id: <20190329093334.3885-1-brgl@bgdev.pl>
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

v1 -> v2:
- add patch 1/6 that fixes an existing problem with missing array
  sentinels in GPIO lookups
- add patch 2/6 that removes an unnecessary use count variable from the
  driver
- reorder the changes: add support for overcurrent protection using the
  existing vbus regulator first, then setup fixed regulators in board
  files and finally remove the vbus GPIO from the ohci driver

Bartosz Golaszewski (6):
  ARM: davinci: add missing sentinels to GPIO lookup tables
  usb: ohci-da8xx: let the regulator framework keep track of use count
  usb: ohci-da8xx: disable the regulator if the overcurrent irq fired
  ARM: davinci: omapl138-hawk: add a fixed regulator for ohci-da8xx
  ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
  usb: ohci-da8xx: drop the vbus GPIO

 arch/arm/mach-davinci/board-da830-evm.c     | 51 ++++++++++++++++++--
 arch/arm/mach-davinci/board-da850-evm.c     |  1 +
 arch/arm/mach-davinci/board-dm355-evm.c     |  1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |  1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c | 50 ++++++++++++++++++--
 drivers/usb/host/ohci-da8xx.c               | 52 ++++++++++-----------
 6 files changed, 122 insertions(+), 34 deletions(-)

-- 
2.21.0

