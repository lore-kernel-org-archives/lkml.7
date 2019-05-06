Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04038C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7628206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Pa0zYFao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfEFMyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:54:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39702 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFMyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:54:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so6343998plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id;
        bh=mCH1PNSxZO8UcLFwRskob8mKkP1s690Icm959QBwtxU=;
        b=Pa0zYFaooyEYnq8TNhjhsXUlNZTUn09rsJ8MbLtbutJ3aBNJVK6GoB0Ieeo+ivQPKH
         c29gKxZLq9jfmaUkDPJXGoeQHFZ+BqEepzvbmCpuhplKrHOfsUx5dtQ2hoWnuP3KSMmi
         3MQrQ34bAG4govn9tRpYpXMp4e+AIB/LMZZy1ddaiJJL3MkeNGe/nFKNsR+1CxPEQgz4
         M1D8ORQk6cXBjqrBe0oduIqsMaZvCY0bSEx1GxZ4JiISvRxvYjeJnlcfs/i8rRRkSG6j
         nlv88TJUpQauJaa04VxyQrfrXjIRfJHUolR7Wt1P1ld8gBk+MTDanS7ULH4jCR6an06c
         GhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=mCH1PNSxZO8UcLFwRskob8mKkP1s690Icm959QBwtxU=;
        b=A3YA1mdQsD0h3UGgNwNoLl10UKb6AhYD0Kj+W8W0zLoyLISOeCDb29WCMjQv7Fpk4c
         olzA3qlwucMk315zVMoP4GMeH3Yr43nBFoQ4N+erH0EZzmhRg7uSHlIT/ZBZQFG0z2Rq
         bZDQUH7BgY0ORfpF8rx4lUWEqzyTtDEoSXkifx9211j5N2geiQso0Bt87VXzFjiiNN0L
         tewS1+egtVDay8M11s2Fw2k/cZnHzDZvuKRGXW/aCbRjaYCUndNp7xklGN4OZm4k1K+f
         TSOjR6N1as7V9LTqNL2hq513zzsQ1t7ebp/TyzS9nm0oMUp0tyueX2vLEPSMgjn/8MEd
         6RSw==
X-Gm-Message-State: APjAAAUwCtNQpzfuLI9sEbI0Zb8U6MjfO16GIo9+YE/3Us2g4s0wd4ws
        ydqo92yCoKtLg8VlqRCzkxmDnA==
X-Google-Smtp-Source: APXvYqzA7OlsB9Sxuwz64C70xfdtuDDDGNwfRbcLFQfRJu2C+ztVPX59gkK/uUwSuBXaxJYg8WdB9g==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr31847462plb.308.1557147264714;
        Mon, 06 May 2019 05:54:24 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p81sm18031132pfa.26.2019.05.06.05.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 05:54:24 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com,
        paul.walmsley@sifive.com, sagar.kadam@sifive.com,
        peter@korsgaard.com, andrew@lunn.ch, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 v1 0/3] Add dt bindings to support I2C on sifive devices and a fix for polling mode i2c transfers.
Date:   Mon,  6 May 2019 18:23:57 +0530
Message-Id: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is based on mainline v5.1 and is intended to add DT-bindings for Opencore based I2C device 
support in FU540 SoC, available on HiFive unleashed board (Rev A00), and also provide a workaround to 
make I2C polling mode interface work with FU540 chipsets.

The polling mode workaround patch fixes the CPU stall issue, when-ever i2c transfer are initiated 

This workaround checks if it's a FU540 chipset based on device tree information, and check's for open
core's IF(interrupt flag) and TIP flags to break from the polling loop upon completion of transfer.

To test the patch, a PMOD-AD2 sensor is connected to HiFive Unleashed board over J1 connector, and 
appropriate device node is added into board specific device tree as per the information provided in 
dt-bindings in Documentation/devicetree/bindings/i2c/i2c-sifive.txt.
Without this workaround, the CPU stall's infinitely.

Busybox i2c utilities used to verify workaround : i2cdetect, i2cdump, i2cset, i2cget


Sagar Shrikant Kadam (3):
  dt-bindings: i2c: add documentation for adding SiFive I2C driver
  i2c-ocore: sifive: add support for i2c device on FU540-c000 SoC.
  i2c-ocores: sifive: add polling mode workaround for FU540-C000 SoC.

 .../devicetree/bindings/i2c/i2c-sifive.txt         | 29 +++++++++++++++++++
 drivers/i2c/busses/i2c-ocores.c                    | 33 +++++++++++++++++++---
 2 files changed, 58 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sifive.txt

-- 
1.9.1

