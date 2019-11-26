Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6052C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CED2068E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+ukCMQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfKZMbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:31:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38098 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfKZMbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:31:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id a14so16456266oid.5;
        Tue, 26 Nov 2019 04:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4a9Z6JaXzAPTzYcSnTLehjmQZTmoKW8W48PP5NKG6HE=;
        b=N+ukCMQdLPCfZ8KQ0napwH/kZ2eXxPJ89dC7sQPj76has+2dIuOXlfG7ohujzzj0gs
         0XbkicX8aDaICwsUvOpaq1DKoK2HMMpdAP9B0kvdNxYMZyZBLfGq6NGbOSl+8QQuM5kd
         W/KaNFW/ypTDsiFWb9+tJqg8wZsBD4N32ZrvxVqUoXDA2LHzOmSSO6TQBDB8fWlvqEgO
         OHs9FQov14fJHJyfdX/I7APNuAff1B+Mi1AJ2vlrMX3y7BIgabtbHK7Y0qSj9cMijLX5
         ZtVHZIBYS8Te5k3yFqZDbUaTAZytUyFfmN67jnuMcQltKqY233DjNgpU5CqtVt8JCNMp
         Xcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4a9Z6JaXzAPTzYcSnTLehjmQZTmoKW8W48PP5NKG6HE=;
        b=Zjtxt139nazeEiRvPpIIpCZl5XPrsN7unKQ0JnNZxNkEyLrf08kgmcLhxuZkHi63Vc
         O617qqJ99skdf46oi9e7j9cuBPk8FAC8u8E8hNCdZxhAF0mn5I/V+apQHbXZ4Vn1GATn
         LXn7764wLlItVz+0k3yXYQCYHPFur2XsZNplDEqERkMi6eETZJT7123hqtMuwD1Pq6o9
         ujBqu67TrxPbVGyFD4F9VLCggnjfD/x+E2q1pg+bZx7ZtncvcH/3AXNOhoFOq+/HctSG
         hW1Df9BD3ieQb54/Lm46u8rNbVsJzf6OxwXu89bbLxbfOjSlX1byPRKfsxChnji+5Ff7
         2CqA==
X-Gm-Message-State: APjAAAX0X76Zm979FE3cPJFv5kcOT4Ud/QwO0hCqtun7YWVxq0oMWOFc
        zOFvNCFSUQPA/ZWkETBgcsFJSvo8
X-Google-Smtp-Source: APXvYqzllppWSVGZtaT9lr/5UlwPmzabtyhU3ndAUKNNGiD4+WbJugCfxuAN8LEUmH6zyyHim4clog==
X-Received: by 2002:aca:4f50:: with SMTP id d77mr543070oib.147.1574771463250;
        Tue, 26 Nov 2019 04:31:03 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e193sm3636288oib.53.2019.11.26.04.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Nov 2019 04:31:02 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.5
Date:   Tue, 26 Nov 2019 04:31:01 -0800
Message-Id: <20191126123101.7353-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.5

Thanks,
Guenter
------

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.5

for you to fetch changes up to 4a1288f1c1cf5829f90c30f9d1af67f526ba4d85:

  dell-smm-hwmon: Add documentation (2019-11-22 20:47:43 -0800)

----------------------------------------------------------------
hwmon updates for v5.5

- Added support for Texas Instruments TMP512/513
- Added support for LTC2947
- Added support for BEL PFE1100 and PFE3000
- Various minor improvements and fixes

----------------------------------------------------------------
Colin Ian King (2):
      hwmon: abituguru: make array probe_order static, makes object smaller
      hwmon: (w83793d) remove redundant assignment to variable res

Dmitry Torokhov (1):
      hwmon: (applesmc) switch to using input device polling mode

Eddie James (4):
      hwmon: (pmbus/ibm-cffps) Switch LEDs to blocking brightness call
      hwmon: (pmbus/ibm-cffps) Fix LED blink behavior
      dt-bindings: hwmon: Document ibm,cffps compatible string
      hwmon: (pmbus/ibm-cffps) Add version detection capability

Eric Tremblay (2):
      dt-bindings: hwmon: Add TMP512/513
      hwmon: Add driver for Texas Instruments TMP512/513 sensor chips.

Giovanni Mascellani (2):
      hwmon: (dell-smm) Add support for disabling automatic BIOS fan control
      dell-smm-hwmon: Add documentation

Kyle Roeschley (1):
      hwmon: (tmp421) Allow reading at 2Hz instead of 0.5Hz

Markus Elfring (1):
      hwmon: (aspeed-pwm-tacho) Use devm_platform_ioremap_resource() in aspeed_pwm_tacho_probe()

Nicolin Chen (1):
      hwmon: (ina3221) Add summation feature support

Nuno Sá (2):
      hwmon: Add support for ltc2947
      dt-bindings: hwmon: Add ltc2947 documentation

Tao Ren (2):
      hwmon: (pmbus) add driver for BEL PFE1100 and PFE3000
      docs: hwmon: Document bel-pfe pmbus driver

 .../devicetree/bindings/hwmon/adi,ltc2947.yaml     |  104 ++
 .../devicetree/bindings/hwmon/ibm,cffps1.txt       |    3 +
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |   93 ++
 Documentation/hwmon/bel-pfe.rst                    |  112 ++
 Documentation/hwmon/dell-smm-hwmon.rst             |  164 +++
 Documentation/hwmon/ina3221.rst                    |   12 +
 Documentation/hwmon/index.rst                      |    4 +
 Documentation/hwmon/ltc2947.rst                    |  100 ++
 Documentation/hwmon/tmp513.rst                     |  103 ++
 MAINTAINERS                                        |   18 +
 drivers/hwmon/Kconfig                              |   38 +-
 drivers/hwmon/Makefile                             |    4 +
 drivers/hwmon/abituguru.c                          |    2 +-
 drivers/hwmon/applesmc.c                           |   38 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |    7 +-
 drivers/hwmon/dell-smm-hwmon.c                     |  115 +-
 drivers/hwmon/ina3221.c                            |  163 ++-
 drivers/hwmon/ltc2947-core.c                       | 1183 ++++++++++++++++++++
 drivers/hwmon/ltc2947-i2c.c                        |   49 +
 drivers/hwmon/ltc2947-spi.c                        |   50 +
 drivers/hwmon/ltc2947.h                            |   12 +
 drivers/hwmon/pmbus/Kconfig                        |    9 +
 drivers/hwmon/pmbus/Makefile                       |    1 +
 drivers/hwmon/pmbus/bel-pfe.c                      |  131 +++
 drivers/hwmon/pmbus/ibm-cffps.c                    |   74 +-
 drivers/hwmon/tmp421.c                             |    3 +-
 drivers/hwmon/tmp513.c                             |  772 +++++++++++++
 drivers/hwmon/w83793.c                             |    2 +-
 28 files changed, 3288 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
 create mode 100644 Documentation/hwmon/bel-pfe.rst
 create mode 100644 Documentation/hwmon/dell-smm-hwmon.rst
 create mode 100644 Documentation/hwmon/ltc2947.rst
 create mode 100644 Documentation/hwmon/tmp513.rst
 create mode 100644 drivers/hwmon/ltc2947-core.c
 create mode 100644 drivers/hwmon/ltc2947-i2c.c
 create mode 100644 drivers/hwmon/ltc2947-spi.c
 create mode 100644 drivers/hwmon/ltc2947.h
 create mode 100644 drivers/hwmon/pmbus/bel-pfe.c
 create mode 100644 drivers/hwmon/tmp513.c
