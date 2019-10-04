Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D80FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7321D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOuj9JiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbfJDQFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:05:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41230 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389794AbfJDQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:05:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so4157420pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G6wIL875XZuorF2ZOZc99He9fmBICo2vTYfV+CUzHL0=;
        b=lOuj9JiU977ulIU8HkqDBOBQQ89TzhSSv3/X40mTVvctu8QgNnMEIzSohNVLZHTw9V
         yi4CO3DHpQmGWba5f6J8A1SPWwbNg0vzxLlXPa1J4d0YZdy8fz9c6222HH1f/Urwv3DV
         UNrq8NVfMurgeOIegEddRk3k4OFNyZtxaCMX4L3voGeVS3AIC0U7cG4BA3y2LB2LatBW
         6NtnN4NrYC5YhFQ1qf30iUGq72FnmYVgm/jt0U/ZwAXV5aFOQiHzcBMCx1NWz8gSwJ6+
         9hRdIeQxlzIoepLgK22iFJj6lS0qDcqEBgpw3FURlwS7DPIRXKoIGpuN9Yn10L9nQ9r7
         R03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G6wIL875XZuorF2ZOZc99He9fmBICo2vTYfV+CUzHL0=;
        b=C01qKNwC9z+x10C/P5xDUOHPuta1ZZmvJeRsNxKpxY/hawO4z9YN621v7wNn4j3oC9
         HL0qB3x6BfxQTqqbP3aUpy+1eGnOqJGqV3TSl0Upp4SYl+UJRflagqpUiC0T58V8T04b
         dVLUEG+ZOt7YdRvAP9o/AMAshtxMHTYagcE2VQPoeY90ZAhdMI3zoCnPWb0kNGt7ZqKB
         dHXWiTAeNPEYgD9rsh3eUPHRKrDmjlkkPSAxJprC3XBqsDePt6EJ8Ll7O5EkE3ISctlU
         QuYdvWURR3s7GjvwXfQlijr4EiPF3QxeP0xTtsKqPRmBfc9CnpBkNbP7qf0v7ZJsHEIB
         HSEw==
X-Gm-Message-State: APjAAAU2Jml78h8P8MsXZ0xzpS/ngd2/tvrUSLkMs5asDqyYrBcfyBeI
        qhnTq9gp43/sDt6ygMx/6dxg
X-Google-Smtp-Source: APXvYqwEeenp3fnA43Qgkg6DKMInAhQDlL7l8FbjYMHEpk4Ij7IGN5Hqostll6TJ9guDv3Fr28fVSA==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr2556438pjy.55.1570205137188;
        Fri, 04 Oct 2019 09:05:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:648a:e40a:3174:4ae1:69ba:aabb])
        by smtp.gmail.com with ESMTPSA id b5sm5402254pgb.68.2019.10.04.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:05:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/2] Add IMX290 CMOS image sensor support
Date:   Fri,  4 Oct 2019 21:35:23 +0530
Message-Id: <20191004160525.16716-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds support for IMX290 CMOS image sensor from Sony.
Sensor can be programmed through I2C and 4-wire interface but the
current driver only supports I2C interface. Also, the sensor is
capable of outputting frames in following 3 interfaces:

* CMOS logic parallel SDR output
* Low voltage LVDS serial DDR output
* CSI-2 serial data output

But the current driver only supports CSI-2 output available from 4 lanes.
In the case of sensor resolution, driver only supports 1920x1080 and
1280x720 at mid data rate of 445.5 Mpbs.

The driver has been validated using Framos IMX290 module interfaced to
96Boards Dragonboard410c.

Thanks,
Mani

Changes in v5:

* Fixed issues reported by coccinelle
* Moved MAINTAINERS entry to bindings patch as suggested by Sakari

Changes in v4:

As per the review by Sakari:

* Squashed the MAINTAINERS changes with driver patch
* Some misc changes to the driver

Changes in v3:

As per the review by Sakari:

* Switched to pm runtime
* Used link-frequency property
* Removed useless read calls from buffered read function
* Some other misc changes to the driver and binding

Changes in v2:

* Added Reviewed-by tag from Rob for bindings patch

Manivannan Sadhasivam (2):
  dt-bindings: media: i2c: Add IMX290 CMOS sensor binding
  media: i2c: Add IMX290 CMOS image sensor driver

 .../devicetree/bindings/media/i2c/imx290.txt  |  57 ++
 MAINTAINERS                                   |   8 +
 drivers/media/i2c/Kconfig                     |  11 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/imx290.c                    | 881 ++++++++++++++++++
 5 files changed, 958 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt
 create mode 100644 drivers/media/i2c/imx290.c

-- 
2.17.1

