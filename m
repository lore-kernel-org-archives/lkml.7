Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CECC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AB023426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mB4OiYZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfH3JUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:20:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35843 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfH3JT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:19:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so3106453plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MO4FAsdSxcjZz9XUXbUG6G+n0aMjGeZSAkfHq2M0InE=;
        b=mB4OiYZrs6fA8SMC4/yow7KH/FEcJ+DUD2HdqIiWDf0i5RXXy0iuV333yVQySpoCEt
         kLMSaPWrhXK98sWf1l6nUxdyiisqXR0lvCbhs6jiax1wpUTYNGGf1WlmcUsghyXRSQ/r
         P8RcDykrrJ6RN1LPoLh2tOOQNP/cwZG+mVpYN36vdzIIARFtLhIV0s072z1u9fH4p4xf
         SuIRvHFJEt9H7zXyGjj8zaQNZjHMpq9B0HnNRS7W3dSMo6QzbylLnFG2U+dE08eJ5C9U
         xpVunDMIT+sOAaLg6j6nLaSX5Kh6kEymJOn1DAYjlWngKxrIDFriGdkha7fdJlBIVXjZ
         0gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MO4FAsdSxcjZz9XUXbUG6G+n0aMjGeZSAkfHq2M0InE=;
        b=hx+kV3RAw0DWTz7cDn8z/q1nU9CSGyQlOd5Bg06pvRg0fv7FJAvMG3wW1FD6Z8k7kR
         ca89cU/d30+YknMfJiFA4fRRlk1aY+zmzWpHpS33mqxppiKMxet/45EuBgohwUpZD92+
         z/BiK/KBRX7sP8CKmsIY6gou3LktsWNuANgwPJwTrnpi4mul4CR52MFQCw0lwTSryASk
         fToM70Jn6iHE1rz4Kjb2fnl8lG3ufVvCQmy3b0R9/An8vzJbfNPGj146MMNqYDNG0bi7
         9p89KhrMaRnJ6XnW+HqmyNXEku0TldFJ21D8lvcLK8br//0JMi7J/5NWwRhMV2COLCZ+
         DkVQ==
X-Gm-Message-State: APjAAAVqXZM1hVUJQY2Mlp+7aiWrwD2Gbh4iOUIgGI3Sy+N4/i68yt1g
        VQ1mHr/glfJx5siwo6CRnCAj
X-Google-Smtp-Source: APXvYqwet7PSlkqIUyr0R1qYH0rq5kyhy+3t/vPHkgqfhzlLHiPco1D8+brDPe1ilWjwMyEX3aXUlQ==
X-Received: by 2002:a17:902:2bcb:: with SMTP id l69mr15006887plb.282.1567156798541;
        Fri, 30 Aug 2019 02:19:58 -0700 (PDT)
Received: from localhost.localdomain ([103.59.132.163])
        by smtp.googlemail.com with ESMTPSA id g202sm3142676pfb.155.2019.08.30.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 02:19:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/3] Add IMX290 CMOS image sensor support
Date:   Fri, 30 Aug 2019 14:49:40 +0530
Message-Id: <20190830091943.22646-1-manivannan.sadhasivam@linaro.org>
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

Changes in v3:

As per the review by Sakari:

* Switched to pm runtime
* Used link-frequency property
* Removed useless read calls from buffered read function
* Some other misc changes to the driver and binding

Changes in v2:

* Added Reviewed-by tag from Rob for bindings patch

Manivannan Sadhasivam (3):
  dt-bindings: media: i2c: Add IMX290 CMOS sensor binding
  media: i2c: Add IMX290 CMOS image sensor driver
  MAINTAINERS: Add entry for IMX290 CMOS image sensor driver

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

