Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0CD21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQmX9/5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfJCJz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:55:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44195 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbfJCJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:55:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id i14so1414457pgt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e6qE7XB76qy7vrZGoWaWqzg5fBcTX3zqPmnTO48m2kI=;
        b=QQmX9/5Phtejcr1s1+XLaQd2GNoMEJRCgCi+qbyPv4OAQyhGeTxqwHOsoWcrQ3h4ls
         0PBrbMSml429sVGl9iiksabhKvcCNZRCsALpvqhhRxjstI3KJQrwjDS6cZZtK/8uOz4l
         sw1hkkpnKXuY6qZB/VyLeoze3Qm71B2UWxRvYm9T6dwL3Uo4zzJ4X0sxX7d+fbUbFohi
         MQHReNnKsu1eC2tK3k5llT2QaaFN0arIMNg3rOYbjbm3HBdJEdaLjyRn62TdLk6zDz+b
         h4HwvSOHP0ntz9Xs2AyqQLL/P+58M1xgZ+JylLH7VXlj/IqJAX0lv7FPnnILMKpKufPl
         Zu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e6qE7XB76qy7vrZGoWaWqzg5fBcTX3zqPmnTO48m2kI=;
        b=nM9dXfQYoAZm66qdSyv1V05E2xokkEecnGJKFsL3vnp1/zM4Gbd9lG1l2loQqZpnvN
         d+xyn08L3noVGyrsf9blMjldc/AerKu3Du8f/pzskh4b1/fADnM7Caiu8LwRhul7tvY4
         klNuu3Q/mSK4ZTXi6v8pm/8lEofEhfOHxCQV9WFoawUGaxIkNJFOTE1vYNejFnBsLodl
         ysML5HS7ACxxFdxMfU/mbqZDjYYa4MKdyrd6B22SuGTTu2/YA9Bp/ffS3IeJi2jMY8MC
         1NCPzEzcnxPEt0aocOfIXUVf2sauo6pMvSVU9r5qIliF62w0Nll+a9BAIovS6uH47B0b
         P+tA==
X-Gm-Message-State: APjAAAV6/YUlfDMRlJsco3ihTz7OH8sRoiYW+swaqook7QI2HE6gJz9R
        l7GL91qdNlkjbTdt00helIua
X-Google-Smtp-Source: APXvYqzydIQYXMnyCqqO3yg3J8kBycFk+XR5FrVUknBJE3cp5jNvElNBPUavGxIrF2g9kfibWX3bzw==
X-Received: by 2002:a63:ed10:: with SMTP id d16mr8924685pgi.307.1570096526650;
        Thu, 03 Oct 2019 02:55:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:801:ac5d:fca3:6f38:70fb:67fc])
        by smtp.gmail.com with ESMTPSA id v3sm2346171pfn.18.2019.10.03.02.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 02:55:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/2] Add IMX290 CMOS image sensor support
Date:   Thu,  3 Oct 2019 15:25:01 +0530
Message-Id: <20191003095503.12614-1-manivannan.sadhasivam@linaro.org>
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
 drivers/media/i2c/imx290.c                    | 885 ++++++++++++++++++
 5 files changed, 962 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt
 create mode 100644 drivers/media/i2c/imx290.c

-- 
2.17.1

