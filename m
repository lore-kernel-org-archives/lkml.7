Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8FDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2422176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="atV9f1e9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfK1Mvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:51:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37393 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1Mvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:51:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so12314wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 04:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0QefnKGlT6lTSYC6pwMuJFWL2vfoXdiJLSgkpnVlPc=;
        b=atV9f1e9MlP4646ZOATifVtNxEccamHGqWPkFMyWjYF3Yj2XCQMM0gWxrlVloPwlkA
         EeeftgyUKORLg8t4KU2V55JK6IitH9Xltgwg8S2cHAuWmqPKnPAd8UPHmAYcJfuuZPyZ
         YXiPbU3jBfJekIhwllBeT7DiX6sQF9TENslkPwEbYryq8GSXnEcuW++xozmPpYX9+44O
         rBzIp+/kMojbT5cE0pXF/Z4YcILqG71Wz3ikuNAEf4hQ4l/hcN/CPzTxb13worv9qcow
         etySmG5kesMxDVdDf/nzbIbrD3RMKzM2A59UxV8BQOpHGQ+2UdnaSilHyd6wWW1dDrSn
         nl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0QefnKGlT6lTSYC6pwMuJFWL2vfoXdiJLSgkpnVlPc=;
        b=lgqt3GAtfJIjpwjDVWTqjYexd9X9/HCCpl0hOG/AhjWA1ZHsus0LneKd41ynmQJ9Ny
         R8yNEKXR6UBhdgf/yNGWhREt4zbQjFEWeyGzK9LhirLyAKImUPAlhYSu2sqc9i/gmLpE
         aIMnZT6BK8Ix024txCUgo7+89X/ZAd+N2I5t+PBaV9ctpdplRqqvbvYJaxKjbwkdnoaz
         aB4h4CoPj+LQ+hBwSYfGCrSpXXykeg8Xoq3gXUAYw8c4VO0bbsScA11lV9QHj9sDWUV5
         UWqKlDKAWw7hOzwJL4sjNFyeJVEUACMNJ1dRFdY1eepZqDoW5LS+2DojjsNj7w3ebayY
         SQtg==
X-Gm-Message-State: APjAAAUC26mYA5CMWubFp03w1IV7xZpNueP0itKr6hC57pLhyHydP3NC
        SAK+KJxPyZUfx2ovpDzW85c7wtacpOJfnQ==
X-Google-Smtp-Source: APXvYqwyijdoT7UodIVzE2i0LIUCgzvL6bHXTjIHhiHC2daULjiyZ6Vnk3mGwNDm9/NV0LrFWfo6vw==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr10558548wrv.376.1574945488448;
        Thu, 28 Nov 2019 04:51:28 -0800 (PST)
Received: from rudolphp.sr1.9esec.dev (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id j11sm22959607wrq.26.2019.11.28.04.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:51:27 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/2] firmware: google: Expose coreboot tables and CBMEM
Date:   Thu, 28 Nov 2019 13:50:49 +0100
Message-Id: <20191128125100.14291-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

As user land tools currently use /dev/mem to access coreboot tables and
CBMEM, provide a better way by using read-only sysfs attributes.

Unconditionally expose all tables and buffers making future changes in
coreboot possible without modifying a kernel driver.

Changes in v2:
 - Add ABI documentation
 - Add 0x prefix on hex values
 - Remove wrong ioremap hint as found by CI

Changes in v3:
 - Use BIN_ATTR_RO

Patrick Rudolph (2):
  firmware: google: Expose CBMEM over sysfs
  firmware: google: Expose coreboot tables over sysfs

Patrick Rudolph (2):
  firmware: google: Expose CBMEM over sysfs
  firmware: google: Expose coreboot tables over sysfs

 Documentation/ABI/stable/sysfs-bus-coreboot |  73 +++++++++
 drivers/firmware/google/Kconfig             |   9 ++
 drivers/firmware/google/Makefile            |   1 +
 drivers/firmware/google/cbmem-coreboot.c    | 159 ++++++++++++++++++++
 drivers/firmware/google/coreboot_table.c    |  57 +++++++
 drivers/firmware/google/coreboot_table.h    |  13 ++
 6 files changed, 312 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-coreboot
 create mode 100644 drivers/firmware/google/cbmem-coreboot.c

-- 
2.21.0

