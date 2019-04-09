Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F0720643
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="detqpy/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDII3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:29:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDII3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:29:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so19626029wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oDHFDpA+LDAaFrEgc9NLsZxvCSbtmYUT07CTCE02Foc=;
        b=detqpy/lFCxRKBEtg/rbfa4pFoXMjmaZqVapKPvZQHv07lV1eutRqeK7OxiNldd3uu
         n6l0XywIpgXn7K2n6pUZhkMgxdEgimGcTseLs2e8TlKH3zC2jugfMuPPoSSqCiHS8/zF
         cqH/dVpHlRnImOWKB5g/ae/tzWMzYmaxTUNpDdFS2QTl7yAbXiLr8iJmD0aT5VwCZF7r
         1vCi1/61UxuDoriTtb2AJF37bKe6K4b4eqx1u7GXPJYYr/WjBIZTas8vCgC8S69vfEvu
         j4ku1DQU1oaHeuw//ce8oNyPnq+bsZP9ukBi9jWlimCPd0EYwCopVSt6yf8xGLa2j7n5
         hkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oDHFDpA+LDAaFrEgc9NLsZxvCSbtmYUT07CTCE02Foc=;
        b=UIryR2EtjSRQKC+8lVfquJeqsSlMFeLs3AU1+kYbQP5mLf+ygveEYWdcykQr9H9Sc2
         liKZuFwf8nWFXKYohZGXCe+2Muv0HS+TFYekTEKBbeNkCl7QrmDjHA8/gQarScB0OPet
         O/LHMaU9QxmksL1rubgNRfTM8XeAnYyEU6Dhgzy3/DAl/hQfXy/sjsDf64T5o0sT+0PT
         SN1XixQbYHfH4/R2xgEgWWgWNlqkF3AY+Ivm2BRYJrufk7iqnhuJHNnPcI+6bRMkKFAx
         0ZJ0mgwOepvKWR+k24Dq7rVk/ng9zffkiHQyGksVJEN7gk/fMmv4TI9Qa3dDlX1ssclZ
         g3DA==
X-Gm-Message-State: APjAAAXDd30x2SfQPddLRX5FsW7Vc96qi5mwfP3q+6M/UlXvS7iDouG3
        7zIf/pmmslnzRSAd7dzgGbLLlA==
X-Google-Smtp-Source: APXvYqwCpN8co4hFEFy3tLbJi0y3Wsz1ehUVA7yESuheTK1WxaISMtk9iED7jiKaRU713M2sj+5QfA==
X-Received: by 2002:adf:f285:: with SMTP id k5mr6966327wro.110.1554798540359;
        Tue, 09 Apr 2019 01:29:00 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c20sm59968651wre.28.2019.04.09.01.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:28:59 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/6] ARM: davinci: ohci-da8xx: model the vbus GPIO as a fixed regulator
Date:   Tue,  9 Apr 2019 10:28:49 +0200
Message-Id: <20190409082855.15373-1-brgl@bgdev.pl>
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

