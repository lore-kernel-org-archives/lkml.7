Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5541206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCmAWBs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfJIKMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:12:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43738 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:12:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so2094881wrq.10;
        Wed, 09 Oct 2019 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjxBl8JVTeBkw1ybmm6ARk+VPLt4aw30+c3whil0xws=;
        b=YCmAWBs2tTCDWa3IVF98HVbrBj0n2irMFOeOmY8ma0B7vRBaxACcxOarB45PnzXIvS
         fCscdaA2+EKkTAPFm6GPUP6dOPEw7J8qEBxChVDcTVcqA8h+unmVPavGhOSdO8IF+wBO
         2fEVt+NcARrSuugwc0OUeuJpBDS6PJfHEYfh951L4XVhMDjOV1mSH8lePwaXJFCrPV7W
         uDJ0zHgu2Tqx9KFa9SYZndCj1wIgnn+hJfHIJlPad1ZOgG7djpBsOTbNLunEX4uI4/vq
         SCMdgnAhil4M1FDevWjTnuDLWxZyfX5X1QC8D7TQb0sdXoKyN7grzvFXK8l4JvWGkue0
         ReTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjxBl8JVTeBkw1ybmm6ARk+VPLt4aw30+c3whil0xws=;
        b=hlLZVngtlhn2+kVceHG34ubfedTe2AyZ2u3JwbHvWKtHDWfcFiOK3uKClzGqEI68GQ
         VONpRBeOArF/8T6ukvlfOJgHDCzCFWngh5lSM39IxWl8uHwIVxJKvTdwcaTQEY3JZlAU
         IFuNO4BVoeQBGp8taVbt7L+aTOaV1pjWvTQhJBnG0xJXGKbgXBHsTqd69/EsL7Flm/CJ
         TyUP9Njp64hMGjROPhWM45FThFRahhqVIzUmNmYJs+14TLJ3Trk2lw/Byt2LeZbROpH8
         quzAFrUwJrEMdeSv2SmW1eyU0VJwFlX7NbT+6F61NLlTx8tUC13YS4072QiNXqZHvaI+
         glEg==
X-Gm-Message-State: APjAAAWi2HRHl6OP2+GasKyghYApuD4pFXR9obWLvg/kZfLNVToDuCgN
        8GGMewLp3HlGRx1WBVui5U0vURLD
X-Google-Smtp-Source: APXvYqyjKNrShLJVNytjycENdygWBA7Vr7MqYDPSxVbOURW7IqnNzmR4aK5VX66v5LuE52kOTswNxQ==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr2175095wrt.181.1570615956423;
        Wed, 09 Oct 2019 03:12:36 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.46])
        by smtp.googlemail.com with ESMTPSA id c9sm1734065wrt.7.2019.10.09.03.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:12:35 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        Michael Chen <micchen@altera.com>, devel@driverdev.osuosl.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v2 0/2] dmaengine: avalon: Support Avalon-MM DMA Interface for PCIe
Date:   Wed,  9 Oct 2019 12:12:29 +0200
Message-Id: <cover.1570558807.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is against v5.4-rc2

Changes since v1:
- "avalon-dma" converted to "dmaengine" model;
- "avalon-drv" renamed to "avalon-test";

The Avalon-MM DMA Interface for PCIe is a design used in hard IPs for
Intel Arria, Cyclone or Stratix FPGAs. It transfers data between on-chip
memory and system memory.

Patch 1. This patch introduces "avalon-dma" driver that conforms to
"dmaengine" model.

Patch 2. The existing "dmatest" is not meant for DMA_SLAVE type of
transfers needed by "avalon-dma". Instead, custom "avalon-test" driver
was used to debug and stress "avalon-dma". If it could be useful for a
wider audience, I can make it optional part of "avalon-dma" sources or
leave it as separate driver. Marking patch 2 as RFC for now.

Testing was done using a custom FPGA build with Arria 10 FPGA streaming
data to target device RAM:

  +----------+    +----------+    +----------+        +----------+
  | Nios CPU |<-->|   RAM    |<-->|  Avalon  |<-PCIe->| Host CPU |
  +----------+    +----------+    +----------+        +----------+

The RAM was examined for data integrity by examining RAM contents
from host CPU (indirectly - checking data DMAed to the system) and
from Nios CPU that has direct access to the device RAM. A companion
tool using "avalon-test" driver was used to DMA files to the device:
https://github.com/a-gordeev/avalon-tool.git

CC: Michael Chen <micchen@altera.com>
CC: devel@driverdev.osuosl.org
CC: dmaengine@vger.kernel.org

Alexander Gordeev (2):
  dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe
  dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe test

 drivers/dma/Kconfig                     |   3 +
 drivers/dma/Makefile                    |   2 +
 drivers/dma/avalon-test/Kconfig         |  23 +
 drivers/dma/avalon-test/Makefile        |  14 +
 drivers/dma/avalon-test/avalon-dev.c    |  65 +++
 drivers/dma/avalon-test/avalon-dev.h    |  33 ++
 drivers/dma/avalon-test/avalon-ioctl.c  | 128 +++++
 drivers/dma/avalon-test/avalon-ioctl.h  |  12 +
 drivers/dma/avalon-test/avalon-mmap.c   |  93 ++++
 drivers/dma/avalon-test/avalon-mmap.h   |  12 +
 drivers/dma/avalon-test/avalon-sg-buf.c | 132 +++++
 drivers/dma/avalon-test/avalon-sg-buf.h |  26 +
 drivers/dma/avalon-test/avalon-util.c   |  54 ++
 drivers/dma/avalon-test/avalon-util.h   |  12 +
 drivers/dma/avalon-test/avalon-xfer.c   | 697 ++++++++++++++++++++++++
 drivers/dma/avalon-test/avalon-xfer.h   |  28 +
 drivers/dma/avalon/Kconfig              |  88 +++
 drivers/dma/avalon/Makefile             |   6 +
 drivers/dma/avalon/avalon-core.c        | 432 +++++++++++++++
 drivers/dma/avalon/avalon-core.h        |  90 +++
 drivers/dma/avalon/avalon-hw.c          | 212 +++++++
 drivers/dma/avalon/avalon-hw.h          |  86 +++
 drivers/dma/avalon/avalon-pci.c         | 150 +++++
 include/uapi/linux/avalon-ioctl.h       |  32 ++
 24 files changed, 2430 insertions(+)
 create mode 100644 drivers/dma/avalon-test/Kconfig
 create mode 100644 drivers/dma/avalon-test/Makefile
 create mode 100644 drivers/dma/avalon-test/avalon-dev.c
 create mode 100644 drivers/dma/avalon-test/avalon-dev.h
 create mode 100644 drivers/dma/avalon-test/avalon-ioctl.c
 create mode 100644 drivers/dma/avalon-test/avalon-ioctl.h
 create mode 100644 drivers/dma/avalon-test/avalon-mmap.c
 create mode 100644 drivers/dma/avalon-test/avalon-mmap.h
 create mode 100644 drivers/dma/avalon-test/avalon-sg-buf.c
 create mode 100644 drivers/dma/avalon-test/avalon-sg-buf.h
 create mode 100644 drivers/dma/avalon-test/avalon-util.c
 create mode 100644 drivers/dma/avalon-test/avalon-util.h
 create mode 100644 drivers/dma/avalon-test/avalon-xfer.c
 create mode 100644 drivers/dma/avalon-test/avalon-xfer.h
 create mode 100644 drivers/dma/avalon/Kconfig
 create mode 100644 drivers/dma/avalon/Makefile
 create mode 100644 drivers/dma/avalon/avalon-core.c
 create mode 100644 drivers/dma/avalon/avalon-core.h
 create mode 100644 drivers/dma/avalon/avalon-hw.c
 create mode 100644 drivers/dma/avalon/avalon-hw.h
 create mode 100644 drivers/dma/avalon/avalon-pci.c
 create mode 100644 include/uapi/linux/avalon-ioctl.h

-- 
2.23.0

