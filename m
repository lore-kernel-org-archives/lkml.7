Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9EAC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AEF218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mVMDiEPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDMCBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 22:01:21 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38885 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfDMCBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 22:01:21 -0400
Received: by mail-it1-f195.google.com with SMTP id f22so18856882ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 19:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hzpRKro/N1+KjPsI2arcM04yh6Mwp469LzcJDDeQVM=;
        b=mVMDiEPRK0liceAJb39tJZOJ7iuOEc4Wh3Eb1kJo7IGT1ZqtirUr8ka4ccKgcG4MJn
         xRXk2kZPHIcFzQRoU0UR7nutGms0kPxL/3CkYfMTWrzaHcw9ii2Tplt+xDFBApZc5dHX
         cLef80qZv+heFk8yVqakfBMTigeIaoG+AmG265eH8C/AaYMIuoWbHCV+rq9BuXDc3OsT
         AV9vjck/IoxRGS9QrDm2sBeyF0IOox7b8gy8wuD1QFYaderw8VsS3dXLswLvodIJVe+V
         q1sqtTksZWEi3muRji1hibls2sRKS48ICGSQ954jbyT9hpybY12JeGMjrzFEX74xKyqW
         QFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hzpRKro/N1+KjPsI2arcM04yh6Mwp469LzcJDDeQVM=;
        b=LYAm0rm68mF6XJysg0cD9z1oECxKVZNSMIhkMV9c3+vAf2Vhio1lVy5Khh6wraG8az
         1RAwJSsjEnkhYT0/mOOGh32Q0dBeaCf7JszGxAgkyJtDK8het2Lk4V/SHmV/ehOczKP4
         0FCdR/HD/5VuzNcusaiFnPtP5FJcMnxYWSu2ylkHaN0HlrLqu8OKD0JKXZNWD/xcRN8t
         Vtgc3BBsYwygAemzdYfYXSgaG1jj3sWHx8qxS2EKp09QizHV2t+mUdEUNjjcrS2iFBtB
         RqO/BeVtdDu+JVOqMSVaymFmJrSPA/Ewz8EvMjPYyemqTfSopvcAI2dAf0AEdZQAWTww
         fcHA==
X-Gm-Message-State: APjAAAWN2tlNa7ES20UudzlezWcZpCGjxBcBC6FvLjtbO4SFhKdoDT82
        8h6OryU5P7wCnczdmhjvj2JaChz4tSU=
X-Google-Smtp-Source: APXvYqwGbE8R8O1lyvCcVbMC1YOrPxSXhpmyliWHHsd2K+CctAuU+QvsGB/1igpfeN4hAAeYuSsxFg==
X-Received: by 2002:a05:660c:18b:: with SMTP id v11mr16406208itj.147.1555120879991;
        Fri, 12 Apr 2019 19:01:19 -0700 (PDT)
Received: from viisi.lan (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id v187sm7198473ita.0.2019.04.12.19.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 19:01:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v5 0/2]  tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date:   Fri, 12 Apr 2019 19:01:09 -0700
Message-Id: <20190413020111.23400-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a serial driver, with console support, for the
UART IP block present on the SiFive FU540 SoC.  The programming
model is straightforward, but unique.

Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
open-source FSBL (with appropriate patches to the DT data).

This fifth version fixes a bug in the set_termios handler,
found by Andreas Schwab <schwab@suse.de>.

The patches in this series can also be found, with the PRCI patches,
DT patches, and DT prerequisite patch, at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4


- Paul

Paul Walmsley (2):
  dt-bindings: serial: add documentation for the SiFive UART driver
  tty: serial: add driver for the SiFive UART

 .../bindings/serial/sifive-serial.txt         |   33 +
 drivers/tty/serial/Kconfig                    |   24 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/sifive.c                   | 1056 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 5 files changed, 1117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
 create mode 100644 drivers/tty/serial/sifive.c

-- 
2.20.1

