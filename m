Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41189C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DE82075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="trxa8V8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfCMTds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:33:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50363 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCMTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:33:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id x7so517639wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4yaqBufTiQj9h4Ld9rc8jXJTirNVJFhxGZsk/fyw48g=;
        b=trxa8V8PkQ01GLm/fmoz+i9eOWQLGmoCezFMGXKFlBu/TwSoa4YQRCtRRix5VyE8DS
         kDdUuUAXCgCyUyhsC0MUljIud1MJtI7cprVBpOZIOmGxwT7RQwyUwoDYvSAS/sBWWgJm
         fTXm19WqpqCdIcTYTrk7IptnxtcPqnlvnvuP6hgge+QhBl2GkUuGsIWRTCKVD3QgPRiT
         +6i19RGiYatf5l4dN0kUKFxj3XRaB8YewH/S3/6k/o0N3YInPowkjYr9ZLDR8HpbRn9Z
         S6Kd+ICCAI9JoEBbh73ubn7iaqXzfh7dX9NNWdvmzX2FNrHVT8GkcqScnhJk+J3t2fpz
         4iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4yaqBufTiQj9h4Ld9rc8jXJTirNVJFhxGZsk/fyw48g=;
        b=O3MyOHYJKEWfKvlp7k3+EfxPxnxIxGlDIRqjUVME4sGkmJZXswHNeXvzWmA5IGCL6Y
         7L/ndLek6N3yqywJfh5XeujbYVTyw/adOk6gghOiC53PjdaJ8rQ6pbPG3EFZcnXOxdl3
         ZVISDjvBAiglfcAfp3cuVW57KCIjwF3CKWx4iVEwW9hq3AsqYB+4k6vGrNTT9YKjsYOV
         5qKoJhqn4R38uRUO4UTPFkjkiG7M0Bi10uov7MwvZG4vzFXdUUiz6134fi7RgrBYwWIw
         CjvKGc2kiPFYL/aWhR9lIrN2QUbrUS673DI9FuAbOFU79pgKaK9NBu4/e5HCHYpTuZ52
         QeWA==
X-Gm-Message-State: APjAAAVjX97o35buZPYFtiIPa2mb+AX02OyU8azIrg6R0fJLv4roGLol
        wHPce3yKagIzNg2sbX1bdLkkww==
X-Google-Smtp-Source: APXvYqyitGuPIll6gKgcOC3wjTOdjtpn+dycd771bfS0kL+Y9TAKHwBJsDFaVw4aIqjtsuY2GtHDxA==
X-Received: by 2002:a1c:f709:: with SMTP id v9mr3393752wmh.134.1552505623556;
        Wed, 13 Mar 2019 12:33:43 -0700 (PDT)
Received: from localhost.localdomain (205.66.21.93.rev.sfr.net. [93.21.66.205])
        by smtp.gmail.com with ESMTPSA id z198sm3017497wmc.10.2019.03.13.12.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:33:42 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     linux-pm@vger.kernel.org, georgi.djakov@linaro.org
Cc:     mturquette@baylibre.com, ptitiano@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com,
        ccaione@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 0/3] Add support of busfreq
Date:   Wed, 13 Mar 2019 20:34:05 +0100
Message-Id: <20190313193408.23740-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements busfreq, a framework used in MXP's
tree to scale the interconnect and dram frequencies.
In the vendor tree, device's driver request for a
performance level, which is used to scale the frequencies.
This series implements it using the interconnect framework.
Devices' driver request for bandwidth which is use by busfreq
to determine a performance level, and then scale the frequency.

Busfreq is quite generic. It could be used for any i.MX SoC.
A busfreq platform driver just have to define a list of
interconnect nodes, and some OPPs.

This series is sent as RFC mostly because the current support
of i.MX SoC won't benefit of busfreq framework, because the
clocks' driver don't support interconnect / dram frequency
scaling.
As exemple, this series implements busfreq for i.MX8MM whose
upstreaming is in progress. Because this relies on ATF to
do the frequency scaling, it won't be hard make it work.

As exemple, this series implements busfreq for 
Alexandre Bailon (3):
  drivers: interconnect: Add a driver for i.MX SoC
  drivers: interconnect: imx: Add support of i.MX8MM
  dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings

 .../bindings/interconnect/imx8mm.txt          |  24 +
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/imx/Kconfig              |  17 +
 drivers/interconnect/imx/Makefile             |   2 +
 drivers/interconnect/imx/busfreq-imx8mm.c     | 132 ++++
 drivers/interconnect/imx/busfreq.c            | 570 ++++++++++++++++++
 drivers/interconnect/imx/busfreq.h            | 123 ++++
 include/dt-bindings/interconnect/imx8mm.h     |  37 ++
 9 files changed, 907 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx8mm.txt
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
 create mode 100644 drivers/interconnect/imx/busfreq.c
 create mode 100644 drivers/interconnect/imx/busfreq.h
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h

-- 
2.19.2
