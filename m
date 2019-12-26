Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC67DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C256B206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLlRtcY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLZW3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:29:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33692 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZW3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:29:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so24712418wrq.0;
        Thu, 26 Dec 2019 14:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cNvwamoo4dW30eKmzFIFFIcQpw4e7mEPfnTJXuvvdsc=;
        b=JLlRtcY/8CBDaPzFepxOtonk9vTzRAHaTYqApa/UOMvai0S8wJ8GZW4HU5h1cO7N9r
         cCes7ekRdCOtbw/jtgcWE20ocoyD/zaNpo3J0IFrhTm3FbEf39kiD/PbpfDOV1/MOq8t
         84eCIs94LrrY2WNvfqtjGOgJeCpFOyFdktf3L5ntnWU5rG/D8jrbIKabTFuWsSurCRRG
         0xDXuZ+Tia7tEwtI4aA+53vaqJM+jz2ISPQOby+Hbz9SZzO5XfFNkDGzXYJH2nr3xVTp
         LB4Q+k/42Y8WU6zuVNzaem3PYqhBL12t689pHwOw46qVfb1/t+TyfgBBHPsgBAPTBkeh
         0LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cNvwamoo4dW30eKmzFIFFIcQpw4e7mEPfnTJXuvvdsc=;
        b=kIhUQ1Zfandzg07OM4OKDWlV5FV+AOCLlqY8Ldw8OLu6Is4wGxikqt0AeLXofbrVnw
         DeHFO9rfK0F/yMkjJLeePrw1LlbP+JRkMau2xzC//jVTp96Vb3gfm+vD7Y2GqRKYLfWp
         bBsrBjH3+hsvHUSrTJK5MaeGVdx3wduvqf7GQ9CNRGFMTPGEDo0PGd6XPxMcMp6u4mAr
         ITCkF3zgyG+V6fsgASqI9jDEGDy0qKvUY3EdzyAI4NZh888hlGoWOhcA4pOmtfUBDKwg
         7aansysGfzSlFSfM0GJeAlOvKkgKIKePKl8mnsKJ7UQSJ8eKQC8Z09JL8Te9ExSvO/DD
         zUMw==
X-Gm-Message-State: APjAAAWsP5CEEnorLbp6IZgBzfYh+Uonc4koWJFnEl6c6nh+EXeiPF3+
        booeW2M1a5xr5zkx1zfJotg=
X-Google-Smtp-Source: APXvYqz27JK6nLbXAntRU3P2XYprFSagQ5bHWeh2eGH1ngIHB7ECWzyR7wuR+C1tIUamhRGjOIh9KA==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr47383927wrl.117.1577399381531;
        Thu, 26 Dec 2019 14:29:41 -0800 (PST)
Received: from localhost.localdomain (p5B3F7018.dip0.t-ipconnect.de. [91.63.112.24])
        by smtp.gmail.com with ESMTPSA id j2sm9731276wmk.23.2019.12.26.14.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:29:40 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add regulator support for mpq7920
Date:   Thu, 26 Dec 2019 23:29:26 +0100
Message-Id: <20191226222930.8882-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V4:
    - fixed 0-DAY warnings

Changes in V3:
    - fixed review comments in Documentation and dt_bindings_check passed 

Changes in V2:
    - fixed all the review comments in the driver, avoid ternery operator, inline & constant
    - fixed/modifed review comments in Documentation

This patch series add support for PMIC regulator driver for Monolithic
Power System's MPQ7920 chipset. MPQ7920 provides support for 4-BUCK converter,
one fixed voltage RTCLDO and 4-LDO regualtor, accessed over I2C.

Saravanan Sekar (4):
  dt-bindings: Add an entry for Monolithic Power System, MPS
  dt-bindings: regulator: add document bindings for mpq7920
  regulator: mpq7920: add mpq7920 regulator driver
  MAINTAINERS: Add entry for mpq7920 PMIC driver

 .../bindings/regulator/mpq7920.yaml           | 143 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mpq7920.c                   | 392 ++++++++++++++++++
 drivers/regulator/mpq7920.h                   |  72 ++++
 7 files changed, 627 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h

-- 
2.17.1

