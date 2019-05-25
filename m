Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F17BC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E982E20815
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYsmCkkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfEYSNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:13:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46509 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfEYSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:13:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id r18so5426145pls.13;
        Sat, 25 May 2019 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HRYu8PaHsPuH7ZyD14nhDXouGF0HQ0zAn0UWWEnt2PY=;
        b=lYsmCkkVrUO+2GVeYbd8F9i/q2/xfvb5RQaKK7m/KL/+kIXt518Vp9x9T9rPXbou5j
         CbzxHipr4SspD1HHGyqpABcxJr/VMf/28A3DfaK1PbeeLhARtdml0Wut3luUm92nvkIw
         cjWtZywhhDlQGNDrW/efMSGGNoPw8pEtxmUvar8w+zrp8oHuvVDjbBQ6FqQRvzpW4V/B
         YZeqAuddyhDNArChQY2SGnpeUK+RwQ93lhLu0BPQto4WCMzMcJ/tqPCR+fBsTaMECK+X
         7TpooFstkZ6bfWNtAx6v9hp98L600rHvqcKHuYfhtYC2o6vRnoy0zv/U0PRzLfXB4oBs
         IblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HRYu8PaHsPuH7ZyD14nhDXouGF0HQ0zAn0UWWEnt2PY=;
        b=SJ7z51fFCwqbT3Hikpr4OZJEgQ3JsTDqNPLI2dztaJHRYWjLAAeZJiTiFh7Mt68QcX
         TElLUMc2Q5v3arO6sY+0D8sMvg8gqrfHNhIUkhAo5jWjTX0lPU7p92oLERiU3O1TCh/B
         pKSbE7yp6SCXeX8Os3nlasspM2ZWMl0GvHjKKBgrW7q0NX78kn9dORzN4m9qFOsH1z8U
         HJRBGgqPvqB0MJtKSxvvoIcU9/Zw+z7x7GGYPaSfh+qo5VwclrcLXRJr+Qt1+2cscMOa
         tJd0hqJKC8d1S6mbo6OOP1VlDd09zTufihBrWh3qwauvQ/u2dFZmH6ApFk5CSqasabE9
         vuPw==
X-Gm-Message-State: APjAAAWg1BplXiSB3myUslL6qYRTNKNmGTRXvR107tgdi/ItGcEw2ses
        jsetfXjrX061WawWAqlEPx0=
X-Google-Smtp-Source: APXvYqwgce5AQBttT/IsT2xQ37eli2VMim3NEhCJnvjdhjhv2dmB0Yci4JaHaLapKWGYuKBBm/Lyqw==
X-Received: by 2002:a17:902:1029:: with SMTP id b38mr74079371pla.72.1558808012389;
        Sat, 25 May 2019 11:13:32 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z125sm8011552pfb.75.2019.05.25.11.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 11:13:31 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 0/3] add thermal driver for h6 
Date:   Sat, 25 May 2019 14:13:26 -0400
Message-Id: <20190525181329.18657-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for H6 thermal sensor.

BWY, do a cleanup in thermal makfile.

Yangtao Li (3):
  thermal: sun8i: add thermal driver for h6
  dt-bindings: thermal: add binding document for h6 thermal controller
  thermal: fix indentation in makefile

 .../bindings/thermal/sun8i-thermal.yaml       |  71 +++
 MAINTAINERS                                   |   7 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   9 +-
 drivers/thermal/sun8i_thermal.c               | 437 ++++++++++++++++++
 5 files changed, 534 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
 create mode 100644 drivers/thermal/sun8i_thermal.c

---
v3:
-Add a sun8i prefix to some function
-Remove disable callback and rename enable to init
-Remove clock enable, calibration from init callback
-Convert driver to interrupt based
-Convert doc to yaml file
---
2.17.0

