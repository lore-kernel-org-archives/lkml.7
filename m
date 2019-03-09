Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A7CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220E42086A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfL8kHY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfCIB65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:58:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44068 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfCIB64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 20:58:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id a3so15411527pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 17:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G7FkEcnypMBPvT4q2ATZFH8XeVcIvhyGQ8lI3Q4OJWU=;
        b=BfL8kHY/V+PnvPoN6GIOnQB4nkXmUoZp2j9+3Ko5gSsAQP5Iw4COXiaaYR1WYcfFcb
         2MdDV++sxfrJ7pjqo68xYPY+e7w07dEML6xzoOZmFdRK5c24yft7wi3Kf3QYseNcuxCg
         uoFLcWV9MV6pbXEi3SgS2sPuEnne51eOlgdZKrG+HegHiTqQrT/XczwA89SSUKcUmUaj
         nfNGEc4dq2rsP/LebHWYvyPUWwJPLiaLpYXtJaP9E2roFPFlp+vudLr8hi2yWeeh+cgA
         u9R8TZQfUpdkZxj4uwRcb8gWKuxlNN4cL18j8yY/XdzwwYZd3oA/SJ0wK7N6rR7ue+4I
         Js2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G7FkEcnypMBPvT4q2ATZFH8XeVcIvhyGQ8lI3Q4OJWU=;
        b=lcifIxRfCCW3Lfsa+E/8dpfAnlNYub8f/7EQTFF5CEmlmhT5wnxUR4NeKGcK59Frrn
         Fa5VrXJz9WyBJJ6KkyS5Y1YkfjZZcbEMsgcffGZrw+hh39XpouQiwGtVfqHSo/mtYZxX
         /fInc2gEe/AjB1zJpfkrivfUsMQpY506AQeGmbLG4hNEl2utXFMq7hc/S+QKetmodnFf
         29og7qX90GnJT5KW0YwnIJg/LcGu+JD1Vq3lI+8l3g3OoJLNSoEErFlZH7kHIhpdFf4e
         3k75/u+j8nxOuo0kVE4B2zYTEEfqHw5lWFCNo4SPIfaxtdbEmNd4w1y/U3nQinyaT+YW
         Llaw==
X-Gm-Message-State: APjAAAV2N+ObgfedNa+p04OhLCikWYAu39hlYyITNDrXWiVo44tJLykr
        tTFrGRj6XyBjWe8+jTZSX3PHg5QV4Q==
X-Google-Smtp-Source: APXvYqyfAWOX9HKl5uweYLtR7YUk/MQlqUiadwQsGb3GaeMY03nuKRDBNxE5nzDSDAZ3KXK5L8jVWA==
X-Received: by 2002:a63:2004:: with SMTP id g4mr19684261pgg.337.1552096735282;
        Fri, 08 Mar 2019 17:58:55 -0800 (PST)
Received: from localhost.localdomain ([157.51.75.198])
        by smtp.gmail.com with ESMTPSA id b65sm16040201pfm.127.2019.03.08.17.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 17:58:54 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux@armlinux.org.uk, xuwei5@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, daniel.thompson@linaro.org,
        peter.griffin@linaro.org, guodong.xu@linaro.org,
        haojian.zhuang@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Handle I2C and SPI reset on HI6220 SoC
Date:   Sat,  9 Mar 2019 07:26:33 +0530
Message-Id: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small patchset adds the reset functionality to the I2C and SPI
peripherals on HI6220 SoC from HiSilicon. Those peripherals needs to be
taken out of reset before being used. But earlier we were depending on the
bootloader to do the job but as suggested by Daniel Thompson, a more
cleaner approach would be to handle the reset in corresponding drivers.

Hence, one of the patch adds reset properties to the I2C and SPI nodes
and the other one adds missing reset functionality to the AMBA Primecell
bus driver. Because the AMBA devices are being accessed before the driver
probe (reading pid and cid values), we need to deassert the reset line in
the bus driver itself just before the read.

I'd expect the patch 1 to go via arm tree and patch 2 via hisi tree.

Thanks,
Mani

Manivannan Sadhasivam (2):
  amba: Take device out of reset before reading pid and cid values
  arm64: dts: hisilicon: Add reset properties for HI6220 I2C and SPI

 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 8 ++++++++
 drivers/amba/bus.c                        | 9 +++++++++
 2 files changed, 17 insertions(+)

-- 
2.17.1

