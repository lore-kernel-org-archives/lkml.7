Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16F1C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 16:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4A5208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 16:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz2oXdfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfFWQmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 12:42:15 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37873 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 12:42:12 -0400
Received: by mail-pf1-f171.google.com with SMTP id 19so6116946pfa.4;
        Sun, 23 Jun 2019 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=guN3ScMcBAl3EdBUUBqxZnez+QFG6VTe2Us/ZifbIac=;
        b=Mz2oXdfcHCl/AjLIwcbhOTvV4DP6dKb58+chvGV34eLndltGe35g/temtiD24fRjEN
         yO1BCIoo8bh5zc6/o2VRRFRtjsovwC8cLmA+1lVCHOhT0SFjZk5L3YCig71oXdx65Ay6
         IJlxs0Y3LoduHUNd8+DrFVCawb+VjTlRPH+zQU6SuvJBEefpifliMWnFp2zbWLm0slwC
         tjDZURjLb8nicaltlMwIObu0WLqBfV7PR3AUoucywPMLq9ER8zdNaIil71f0+MqSRy0j
         wXrslvoMOx9iyv0PhWNIJXmZaRM0w/a81eNMSJFXw/zoQqBitfzFru9jbmphDrk+v/qm
         F7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=guN3ScMcBAl3EdBUUBqxZnez+QFG6VTe2Us/ZifbIac=;
        b=GF/SriaDlAKpY4xJdZ6htSDpTTEuzJCLiVaQit2yjx06aqZbxpWSJzIZxUoUDqNG//
         0ffrpaIgBahg3BWNES4rTzAcFl3/KvAmk90sipbMuoSjI/q+4A0SmvjcsS5QweER0BIp
         BQlQ9wEbrbjE8BOJWefQB00Y5TyUfQIccogEb9+b4xABBBtAaAbnMEIKePvd2WCfu81N
         0wlbJvAuNkqhLf70adnmcdRKfWojzP5Nskyhr5idQmcoN/Ua93OUUu60TBSt7ToMc97V
         xVvb3OmYE9zsr1EY7s3LVJyVrmEpEKW8zxv4Oo9rSU6Tf4sKVFp1qbZ/YWeTPLou4nzo
         Txsg==
X-Gm-Message-State: APjAAAVC5m/U1qmVdou9OAUoUzZbxbuQIgx6ze+iMU1Gq1LUAwN8KGkt
        KoO4YZHIFv0003iwLl7U8xk=
X-Google-Smtp-Source: APXvYqzuNeNzlJfb0O2anqXdpR3fq7SW1y1TKzsXPcMSAaI/+wflpHzkgSycjT+gG4vxsg6zpZE3fg==
X-Received: by 2002:a17:90a:a404:: with SMTP id y4mr20304680pjp.58.1561308131121;
        Sun, 23 Jun 2019 09:42:11 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v138sm9644465pfc.15.2019.06.23.09.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:10 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 00/11] add thermal driver for h6
Date:   Sun, 23 Jun 2019 12:41:55 -0400
Message-Id: <20190623164206.7467-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for H3 and H6 thermal sensor.

BTY, do a cleanup in thermal makfile.

Yangtao Li (11):
  thermal: sun8i: add thermal driver for h6
  dt-bindings: thermal: add binding document for h6 thermal controller
  thermal: fix indentation in makefile
  thermal: sun8i: get ths sensor number from device compatible
  thermal: sun8i: rework for sun8i_ths_get_temp()
  thermal: sun8i: get ths init func from device compatible
  thermal: sun8i: rework for ths irq handler func
  thermal: sun8i: support ahb clocks
  thermal: sun8i: rework for ths calibrate func
  dt-bindings: thermal: add binding document for h3 thermal controller
  thermal: sun8i: add thermal driver for h3

 .../bindings/thermal/sun8i-thermal.yaml       |  94 +++
 MAINTAINERS                                   |   7 +
 drivers/thermal/Kconfig                       |  14 +
 drivers/thermal/Makefile                      |   9 +-
 drivers/thermal/sun8i_thermal.c               | 534 ++++++++++++++++++
 5 files changed, 654 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
 create mode 100644 drivers/thermal/sun8i_thermal.c

---
v4:
-add h3 support
-fix yaml file
---
2.17.1

