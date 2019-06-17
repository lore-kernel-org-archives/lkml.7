Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12488C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA448208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISCeUeI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfFQPua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:50:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36758 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfFQPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:50:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id f21so6058967pgi.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+OUu5AC1XwEziNl7f2ObgXI6EJ5Z9lyfvlo4eWVagcU=;
        b=ISCeUeI6xBkfCbqRsJ5hWj2ky7KLyS5Hxv+dAGBv9LfG6T8joklmRkz/DGgZ8Wr6pU
         nV1z0yejTv+d7GgQL49ysUJX5AyfcfGY/UlEnA7vxXUAQgrgUA7ojdmn0cwgZREC3xql
         fIN0GXBxoAY03Fdw5i2ZrYNPowSKBDHD74DaCUwpv/lbVKD1ai0n/LqaDpetWr7RjdPx
         UvShSP1Ih3+GkTviWGhyjIJsYKOZMu6Wf2n5MRHa/mibVbnckXOKfGUhxLbl7kYz+pLd
         Tx3SLkVSWTEkyC6GkpKsKjCOr4FciJsM8B5cJ4pJmN2AhfQ+Exf8C58jXIBGsXEvfy9T
         iLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+OUu5AC1XwEziNl7f2ObgXI6EJ5Z9lyfvlo4eWVagcU=;
        b=ZVhjZdmFJ5z91GNk8Ds4h5qcc/5UpKg6kiU/UZJNEpBHI7/qdqX6k8bob27MoEDKJl
         Hmk/izQe56SZXxQIm4rlskgUZ5MOSb+BWTKqAcKTX6frlhmcBxX3w4TLzgvjw2zIpUeL
         UnBjz/ch7OOViCFsb9xV5209FbBvFNhqpdtB1a6AsjJu2XoQQPdTfjxsxjDqmJhpjCUK
         b/UcVrrpqNEv7JMhQdzBukzoQJlEW/DOlc5dNEPBXp7jvwxab4s2l+J83IsGXK1X9UTx
         xcDFF/vrf2RrWEuex2Hx/yHldWjnezyLpolSm5Ch3bxDw5zHBgAwr+vZgnzJVbWTEie5
         hiig==
X-Gm-Message-State: APjAAAWgNxNtjFzotNK1GH7zJnwQF2BdCNbE12XAuNgJydVS+1+4nivF
        6vZ02Xq3Hy5ily0CsT6nOEHcRxxClg==
X-Google-Smtp-Source: APXvYqxhRVxSfwiE75iq8WYRByIXfkCZs+a89yfUsZH1N0GqbnvIBgo9g3IOMi9CcY/kejjNVhUwIQ==
X-Received: by 2002:a65:5a42:: with SMTP id z2mr50893750pgs.421.1560786629007;
        Mon, 17 Jun 2019 08:50:29 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:629b:c246:9431:2a24:7932:6dba])
        by smtp.gmail.com with ESMTPSA id n2sm11023603pff.104.2019.06.17.08.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:50:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] Add MFD/Regulator support for ATC260x PMICs
Date:   Mon, 17 Jun 2019 21:20:07 +0530
Message-Id: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds MFD core and Regulator support for Actions Semi ATC260x
PMICs. ATC260x series PMICs integrates Audio Codec, Power management,
Clock generation, and GPIO controller blocks. There are 3 variants of this
PMIC series exist today:

ATC2603A
ATC2603C
ATC2609A

This patchset adds only ATC2609A PMIC support with regulator functionality.
Regulator driver supports 4 DC-DC converters and 10 LDO regulators.

This series has been tested on 96Boards Bubblegum96 board integrating
ATC2609A. Since the board support depends on the SIRQ driver (being reviewed),
I haven't added any dts changes for now!

Thanks,
Mani

Manivannan Sadhasivam (4):
  dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
  mfd: Add initial MFD driver for ATC260x PMICs
  regulator: Add regulator driver for ATC260x PMICs
  MAINTAINERS: Add entry for ATC260x PMIC

 .../devicetree/bindings/mfd/atc260x.txt       | 162 ++++++++
 MAINTAINERS                                   |   9 +
 drivers/mfd/Kconfig                           |  22 +
 drivers/mfd/Makefile                          |   7 +
 drivers/mfd/atc2609a-helpers.c                |  91 ++++
 drivers/mfd/atc260x-core.c                    |  85 ++++
 drivers/mfd/atc260x-i2c.c                     |  98 +++++
 drivers/mfd/atc260x.h                         |  22 +
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/atc260x-regulator.c         | 389 ++++++++++++++++++
 include/linux/mfd/atc260x/atc2609a_regs.h     | 228 ++++++++++
 include/linux/mfd/atc260x/core.h              |  64 +++
 13 files changed, 1186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atc260x.txt
 create mode 100644 drivers/mfd/atc2609a-helpers.c
 create mode 100644 drivers/mfd/atc260x-core.c
 create mode 100644 drivers/mfd/atc260x-i2c.c
 create mode 100644 drivers/mfd/atc260x.h
 create mode 100644 drivers/regulator/atc260x-regulator.c
 create mode 100644 include/linux/mfd/atc260x/atc2609a_regs.h
 create mode 100644 include/linux/mfd/atc260x/core.h

-- 
2.17.1

