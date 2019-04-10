Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E1D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLPZDRdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfDJRlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:41:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35485 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfDJRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:41:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so1992964pgf.2;
        Wed, 10 Apr 2019 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cIF48K8XpxYwNR94LDHijnfSJcxVFagLr9cYV08b7iE=;
        b=kLPZDRdqAXR2xTAx1wWtZslBLXTGP4lcjNw96zxh14Nxt4kMztbVJh3WRbm7LRybZl
         flvy6UEYRARIBNMDrTTEL4Zl3XggpyHMGTbHcKNgwH7XSfJ5nsdEoX56fRXjbwhZkAfI
         xTFzlH/kard/QtBGMRBibBnYKPZNE+EnyOB5hhoKYoe19Nd20csm14/C0ysOIziFrX7G
         gNFR5I/tB6P7Y8bch9i9QkP51uANBA8dmeO4Vn3KsxAYNRhrKzdbn97btvJK5Ue8BVPE
         QYDJYxH/5/H5zDIWU3/oSqxDbp8VNP8zuhums+5dbo75GKSjAWLX1MHWmi3s0lHwop4P
         r94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cIF48K8XpxYwNR94LDHijnfSJcxVFagLr9cYV08b7iE=;
        b=monIsnhdAy/OVwXp0QdfXvPV1sKHeKrxp6lixBXoAhHI5IE7tVH+o5lTn9GxciUzmw
         ndezYtUqE0xYYRXgh4YVsT/ottoifZiyJayVlM1vWmE01eiu2b8uDxp/8LUL+EZLV7aJ
         qxCbYS7RSQxFLaWR7ua+wRaloL+0M7lYxr7X37iDBhjkZ7UvixYGY8rgxWC+8sgCBXHq
         mOQCmTeb1PWn1vkMRMQtN5lplCkh/vymKV8y06q2oYOkOxW28n8z6LsaNxOzbAL5LxB7
         2Z6mcGnuaTJW99kM4Q8qGXrNU/1MEqW0yVJ2M0uGLZTz6gBA47wE5d5XIjqhKJOTHuO4
         EWjA==
X-Gm-Message-State: APjAAAXYMX06ClxnqQr0zrHzOsOuY27bwBI00+0yZqsSnHjtwR74NsnX
        zylwcaiHL8wSKFd8+t0dMjw=
X-Google-Smtp-Source: APXvYqxy07eYlruoHBkz2KKPT88J0+/pcwSr4sisLJg3WgSfTg142Srfcy3lkTlik6gv4A4Kki9cKQ==
X-Received: by 2002:a62:b61a:: with SMTP id j26mr45122885pff.203.1554918105532;
        Wed, 10 Apr 2019 10:41:45 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j20sm20609850pfn.84.2019.04.10.10.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 10:41:44 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date:   Wed, 10 Apr 2019 13:41:37 -0400
Message-Id: <20190410174139.20012-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.

Yangtao Li (2):
  cpufreq: Add sunxi nvmem based CPU scaling driver
  dt-bindings: cpufreq: Document allwinner,cpu-operating-points-v2

 .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 168 +++++++++++++
 MAINTAINERS                                   |   7 +
 drivers/cpufreq/Kconfig.arm                   |  10 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/sunxi-cpufreq-nvmem.c         | 232 ++++++++++++++++++
 6 files changed, 420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
 create mode 100644 drivers/cpufreq/sunxi-cpufreq-nvmem.c

---
v3:
-update changelog and title
-convert compatibles to allwinner,cpu-operating-points-v2
-document the valid names for opp-microvolt-<name>
v2:
-update changelog
-convert to dev_pm_opp_set_prop_name instead of
 dev_pm_opp_set_supported_hw
-some change in OPP Node 
---
2.17.0

