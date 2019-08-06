Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A04C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC24720C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGwMVnpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbfHFNJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:09:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39491 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfHFNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:09:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so37500728pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N8P6BFsOop1K4eWiuZrjN6EJTn34oYRRKch8Go11cDo=;
        b=RGwMVnpzulBrHLjEt9tPbu30lO62P4BcdDb4BrorNxVv35JMEiyj1sYFXsulCS11wn
         wh9a3MUDL1nrPNHp2L8+Ap8UGJ+TIHjUuQQPlCfYP/k3lppoAEuA/M2W1DyCTGhHbYya
         RBVQz7S+zXj0cFqcEC9C3vK7rk+pyl5Bp4VTF7SU2F5x56UdDHWUcAhXR/2jE/q/iBVf
         eOaR/HdFKRT8gtJj8mJhgu5Uuee8Np2kXwt/TeGU57t6LnR+Joy10dK7RtVm0uJUG7kl
         z1N4VnY9Ik6DtLO9AzXz9vjhuyzpCPcu8X8rUnMOIhFIh6dNPZNcrgmMpH/LMc+TZWps
         Xi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N8P6BFsOop1K4eWiuZrjN6EJTn34oYRRKch8Go11cDo=;
        b=oUdaj1iMm6h7fhK3EXgOl2fGzi9NkPO9qyWyLmCH3dj741/VvpaVRODQGfubGrfH7D
         9AXT+RySPj/d+9+W2dqLVRs9qegcSeq+EKBV0k/dWvlt+l6GsEGRHfssoKtyiBESqOIt
         l8ZTpGt1cO8tvWgRwsMEIVfX9lkdGMJcDBcXgzaVllVXT8CAIg3vjFjrA1h/ErlB5Ws4
         qE2LQ2hHO98mmEhR0hpvuqnMIOUq6wLqezkjonTVfFkEAU42W/Sv+kcL+xUvouxufHxc
         urUATEH3fxmKEIZj7bVok/xxqmWmuFFdVH+hYt4j19Pf7nSMvM2dJTl+fFlOKTmbHVHC
         oHSg==
X-Gm-Message-State: APjAAAVrdPUzCkr04uj1yFS+sa+WrcYjZDp+Z7bL1c4U0Q70w2KFO770
        kwxqV12qzFLuFlQnNDT4zo0w
X-Google-Smtp-Source: APXvYqypPfh5IkZ43BoV4ds6TppwLwnLqunFBQ3Z44724sReR5l6o8QdGcy0mOfyeaQtjvbkuF9hhg==
X-Received: by 2002:a63:c64b:: with SMTP id x11mr2960012pgg.319.1565096990514;
        Tue, 06 Aug 2019 06:09:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7180:928a:153d:caa0:477e:f9fd])
        by smtp.gmail.com with ESMTPSA id v8sm73715371pgs.82.2019.08.06.06.09.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:09:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add IMX290 CMOS image sensor support
Date:   Tue,  6 Aug 2019 18:39:35 +0530
Message-Id: <20190806130938.19916-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

* Added Reviewed-by tag from Rob for bindings patch

Manivannan Sadhasivam (3):
  dt-bindings: media: i2c: Add IMX290 CMOS sensor binding
  media: i2c: Add IMX290 CMOS image sensor driver
  MAINTAINERS: Add entry for IMX290 CMOS image sensor driver

 .../devicetree/bindings/media/i2c/imx290.txt  |  51 ++
 MAINTAINERS                                   |   8 +
 drivers/media/i2c/Kconfig                     |  11 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/imx290.c                    | 845 ++++++++++++++++++
 5 files changed, 916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt
 create mode 100644 drivers/media/i2c/imx290.c

-- 
2.17.1

