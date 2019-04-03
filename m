Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16011C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D686A20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UwIJZmXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfDCBSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:18:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46897 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDCBSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:18:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so7141386pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BAYMi99pGN6qjAoy0BnGZIuk8GTCDM2r1F3Rvia8PnE=;
        b=UwIJZmXEM0fXzU1sJ6fM/6cgBIAF7MOt4KwsqW62WBhtnrN5N0ruwr5PoqH1mdAQOI
         Mq9dd55x32KJu/Oixm8ZSiS56STuuvMiL6VTwQl7snB/mg6Xn8746I+w8H1HYFDx116Z
         wjIq2CIa6hFQDQMl8tOfiGXztOZasAgWFANGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BAYMi99pGN6qjAoy0BnGZIuk8GTCDM2r1F3Rvia8PnE=;
        b=nXpi6g820O4gLgBh9tIq5ZXL8TWNE5tzVBJXSfvwz5jx/Z3yrVLe89X3FvRbZC9BsD
         +CkOkHu3uPuR4g7LeIiwrkIY5bQXuKSItwMBZLcVX0JXTQYWMJywZfFgU9z8PHddiXTq
         GptgQbFnITJ4aHoZi6/goVu9JaatjJ5L2HFa4qrAttqXWRf4Mhjtr0Gl23NUbNdqZfe+
         kzkeGZG0FuvMPVPgr1HABd/oLgSmQZrMqku8yLbFYxlAH+aCaOyQoO9Y4m5Hfm2IQyQ2
         kgpiDqRZWKovEuZHqf7/nUZuoZxhvrIuWFFSgxgywTZgdG5VidN5G7DgnIfrYJSZyRA1
         ja9Q==
X-Gm-Message-State: APjAAAUfissQgAENf0yW1JlR3b6eA0jDSX7PBuu8hRHeNjxvUpGLfxNz
        GjZrpnFPmeYP4YcItQbKmNKyog==
X-Google-Smtp-Source: APXvYqzUfXN1kLFisivs17cJIyhvdBnchR4NRWDI0GWsa1sKB4ysdXkJJjR/9e4J2/JVhwIaYsGagg==
X-Received: by 2002:a17:902:9043:: with SMTP id w3mr73857346plz.101.1554254324262;
        Tue, 02 Apr 2019 18:18:44 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 4sm19589046pfn.159.2019.04.02.18.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:18:43 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v6 0/9] iProc I2C slave mode and NIC mode
Date:   Tue,  2 Apr 2019 18:18:21 -0700
Message-Id: <20190403011830.3254-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the following support to the iProc I2C driver:
- Increase maximum read transfer size to 255 bytes
- I2C slave mode
- Polling mode
- NIC I2C mode

This patch series is based on kernel v5.1-rc3 and available at:
https://github.com/Broadcom/arm64-linux.git
branch: i2c-slave-v6

Changes from v5:
 - Address various comments from Wolfram
 - Rebase to v5.1-rc3

Changes from v4:
 - Add more detailed explanations in the device tree binding document
   changes, to address Rob's review comments

Changes from v3:
 - Various minor fixes on commit messages and commits
 - Rebased to v5.0-rc3

Changes from v2:
 - Address Ray's review comments.

Changes from v1:
 - Rebased to Linux v5.0.0-rc2

Michael Cheng (1):
  i2c: iproc: Add support for more master error status

Ray Jui (1):
  dt-bindings: i2c: iproc: make 'interrupts' optional

Rayagonda Kokatanur (5):
  i2c: iproc: add polling support
  i2c: iproc: use wrapper for read/write access
  dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
  i2c: iproc: add NIC I2C support
  arm64: dts: Stingray: Add NIC i2c device node

Shreesha Rajashekar (2):
  i2c: iproc: Extend I2C read up to 255 bytes
  i2c: iproc: Add slave mode support

 .../bindings/i2c/brcm,iproc-i2c.txt           |  17 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
 drivers/i2c/busses/Kconfig                    |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
 4 files changed, 662 insertions(+), 132 deletions(-)

-- 
2.17.1

