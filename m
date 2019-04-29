Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4C3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA762075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1Ir2B4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfD2UBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:01:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40122 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbfD2UBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:01:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so1895711pfn.7;
        Mon, 29 Apr 2019 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTUR4BU7SNrbGwYw6ulkWST95/i8bxeFGfTLU+5eb+w=;
        b=i1Ir2B4zXgvSHk/6PwCU9zPEunYN5ng1HEP5haDCn4gP7N4ELFmyA9Ewal0kte5wvR
         BGKorEtWwnmHRmi3u8aPeQC0tpgWyES+BRWjW2xUy2i/2XS2fn2tjTqfatIdnqVAWJUq
         kKXEQ5CwR0ukK09Kkgem2drxva8dQi6nLOqQpbroI4GE+vRtG/GBtw5W2e+SBV/lGld2
         Ztfr2v5Jjv0mZO2FIru9oT5vJaChnTt6NWjAubIDV2KME1Zcf/T11O9ktP8polRJvqff
         LtyEKepv5zIR4ZqfKbhC7HpyBj5I+eJZ11v8HXT1hBnP76CKFfbmIJ14sXg1e4iKVy5t
         1pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTUR4BU7SNrbGwYw6ulkWST95/i8bxeFGfTLU+5eb+w=;
        b=NehLj4bfujFwysHbS8fHREC6wjzkoVE5W2A7APhBP+qCWhSpl9KQhw3n8vjYR6tEpK
         by9STkpuyrmqtqe8vgaRuKjciY1rdlPkXDGsunuPojkILDk6P5dnk8xorXAJwjfc5Ffy
         MolB5FBODreC4L7LVhD5zUC27AqlZWnQpVGivGe46EAs0Zh/LDvEkfES7Jbp/U8nXcq/
         5qbpjsSkF5fiFZzGK/dz/uPdaOfqm/6CYw2vmWXwwoajqPwWDZglqT4Nb6eWz7caHZX/
         PIDDOdJx99T5jcX275Fnf8EOscdizhypoLr+NDCQ3eVo1FQuRbjenhCvdZJV1QRH/em0
         VmiA==
X-Gm-Message-State: APjAAAWitsksm/iGP6ghGIbr0nfCkDVpYnDnuhF5rJ07/qq8cIfvFARA
        EtLE+QdI2MXwFSQqZhziQrCotNKXBHc=
X-Google-Smtp-Source: APXvYqxKW8vbi4XT4G2atsGGPz4mRPCYyXzjOGBv5NqldSujI4elCwv1bTo5VHLoQR5TLomi0DnCJw==
X-Received: by 2002:a62:be14:: with SMTP id l20mr29754296pff.241.1556567636750;
        Mon, 29 Apr 2019 12:53:56 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l2sm39841783pgl.2.2019.04.29.12.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:53:55 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Driver for UCS1002
Date:   Mon, 29 Apr 2019 12:53:46 -0700
Message-Id: <20190429195349.20335-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This small series adds a driver for UCS1002 Programmable USB Port
Power Controller with Charger Emulation. See [page] for product page
and [datasheet] for device dataseet. Hopefully each individual patch
is self explanatory.

Note that this series is a revival of the upstreaming effort by Enric
Balletbo Serra last version of which can be found at [original-effort]

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v2]:

    - Fixed a bug pointed out by Lucas

Changes since [v1]:

    - Moved IRQ trigger specification to DT

    - Fixed silent error paths in probe()
    
    - Dropped error message in ucs1002_set_max_current()

    - Fixed license mismatch

    - Changed the driver to configure the chip to BC1.2 CDP by default

    - Made other small fixes as per feedback for v1

[v2] https://lore.kernel.org/lkml/20190429054741.7286-1-andrew.smirnov@gmail.com
[v1] https://lore.kernel.org/lkml/20190417084457.28747-1-andrew.smirnov@gmail.com/
[page] https://www.microchip.com/wwwproducts/en/UCS1002-2
[datasheet] https://ww1.microchip.com/downloads/en/DeviceDoc/UCS1002-2%20Data%20Sheet.pdf
[original-effort] https://lore.kernel.org/lkml/1460705181-10493-1-git-send-email-enric.balletbo@collabora.com/

Andrey Smirnov (3):
  power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant
  power: supply: Add driver for Microchip UCS1002
  dt-bindings: power: supply: Add bindings for Microchip UCS1002

 .../power/supply/microchip,ucs1002.txt        |  27 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/power_supply_sysfs.c     |   2 +-
 drivers/power/supply/ucs1002_power.c          | 646 ++++++++++++++++++
 include/linux/power_supply.h                  |   1 +
 6 files changed, 685 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
 create mode 100644 drivers/power/supply/ucs1002_power.c

-- 
2.20.1

