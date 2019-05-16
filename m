Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D95AC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009AF20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaA34fQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfEPR0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:26:40 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46099 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfEPR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:26:40 -0400
Received: by mail-pl1-f179.google.com with SMTP id r18so1935424pls.13;
        Thu, 16 May 2019 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YUfsEJ8lhieJ+G+ZEu//a+N3R5RIXxHhMK0cXmz6bgs=;
        b=ZaA34fQYW8y+vLCZGpBDoaYOqUEAr2LIlZmaQbAM1wgyRPnUL9LnJ6EyfewjiUsJPr
         J5sapg0djxcI6RM5ntfCQvsbuRrXFZ+Wrs1l7hC/snGqdMTSP0wG1hru5vxMDlh37qFp
         Eg2AtuwoZkSqXt1AcXlMkatujdHzvn79OF62DLOksmkB7THX6eO2fSj3tRJLWkDDwlyE
         vYYOm5DLTVhpfK2jEB2j2JQSQuQ8PHVWpBmkl4g3S3vJh3H2/62ZLdkPxii89f0+m63L
         PmqECPCryHfV+5mBF4rF9wABUYlz+xzw7+07ypj2KYhVi6X4VGRu6u5pbBz+UKdBIoJc
         n9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YUfsEJ8lhieJ+G+ZEu//a+N3R5RIXxHhMK0cXmz6bgs=;
        b=NXmXBH9xzeDXc8HjJH5GKDRCloNokLlnXXTXHugYi4ZJ0d9lDEl70C4vq6gQm4tk1j
         qWlxa5jjMjOv1/kkwYj8cGJ1GmlQfiKcpH54erO1eSVgQeq5R6x8eG9HaDLfj6iLfudu
         mqdN3ZBS/f1lWdJ4GwWfdRMEnUssY34pZqJVjBR05YwiilrvEdWGWFs+Z5pXxWHLciEP
         zzp8xjEBe7z0TJBoNsD1IE7pB4s+R8H1IuxbaMXBgfajzclo0S9NrRWL18M20tkJUQ1k
         B2Mx/QbGjxzwv5UaxJDSELFLvqPQgwujrIv7m+Adh2Yf4vDipMuTTUz/iYj1655cULpZ
         J99Q==
X-Gm-Message-State: APjAAAWeKwHWBKZWK4qiOlRg8AmjpARltWyeeQCkAnyEOG+1MnK1O0P3
        yCDWRtN1htwpAaeMaedlo+g=
X-Google-Smtp-Source: APXvYqwdkXSaxriT5ImPSSSj0Bxh+baskm7Ggglk+Ycbodr6SCw+bWqm6L/qc+2VAxhG3zek3J3hyQ==
X-Received: by 2002:a17:902:b094:: with SMTP id p20mr29478865plr.164.1558027599264;
        Thu, 16 May 2019 10:26:39 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q193sm9970130pfc.52.2019.05.16.10.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 10:26:38 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 0/2] add thermal driver for h6
Date:   Thu, 16 May 2019 13:26:31 -0400
Message-Id: <20190516172633.12607-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supprt H6 thermal controller.

Yangtao Li (2):
  thermal: sun8i: add thermal driver for h6
  dt-bindings: thermal: add binding document for h6 thermal controller

 .../bindings/thermal/sun8i-thermal.txt        |  34 ++
 MAINTAINERS                                   |   7 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sun8i_thermal.c               | 422 ++++++++++++++++++
 5 files changed, 478 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.txt
 create mode 100644 drivers/thermal/sun8i_thermal.c

---
v2:
-Additions and deletions of some comments
-Change some function prefix to "ths_"
-Support interrupt
---
2.17.0

