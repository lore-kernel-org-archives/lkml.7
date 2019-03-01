Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78169C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FB920663
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="ZPsy8Fda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfCAD7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:59:19 -0500
Received: from mail.nic.cz ([217.31.204.67]:53108 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfCAD7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:59:18 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 47C80632B1;
        Fri,  1 Mar 2019 04:59:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551412756; bh=QolaFdgPuCveK5UE2qRGVQPU66fRr5fpHOHVbbDG+wA=;
        h=From:To:Date;
        b=ZPsy8Fdak9p+PiQcHZ2ALNqVpL0mHU62qrNjwBpacYyTUAcdMQ+4pGz+ugONIbs+n
         LSu1kD9BOsWj+Wcb97iYFiovzFqNvaaNijIF6sbdOFVdgX4mzoV+pArnMFwJc98DLx
         moBfl/6u2FYuQo2dA2SWzi0r4iY74K8zFxwCHFrs=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v3 bus+gpio 0/5] Add Moxtet bus and GPIO over Moxtet bus
Date:   Fri,  1 Mar 2019 04:58:47 +0100
Message-Id: <20190301035852.26780-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is the third version of my patches to support the Moxtet bus and
GPIOs over it. Moxtet is a Turris Mox specific tiny bus over SPI.

Patches are rebased to current linux-gpio (branch devel and/or for-next).

Changes since last version:
  - addressed the issues in device tree documentation pointed by Rob Herring
  - cosmetic changes suggested by Linus Walleij
  - added sysfs ABI documentation for /sys/bus/moxtet/devices attribute files as suggested by Linus Walleij

Marek

Marek Behún (5):
  bus: Add support for Moxtet bus
  dt-bindings: bus: Document moxtet bus binding
  bus: moxtet: Add sysfs documentation
  drivers: gpio: Add support for GPIOs over Moxtet bus
  dt-bindings: gpio: Document GPIOs via Moxtet bus

 .../ABI/testing/sysfs-bus-moxtet-devices      |  25 +
 .../devicetree/bindings/bus/moxtet.txt        |  36 ++
 .../devicetree/bindings/gpio/gpio-moxtet.txt  |  18 +
 MAINTAINERS                                   |   8 +
 drivers/bus/Kconfig                           |  10 +
 drivers/bus/Makefile                          |   1 +
 drivers/bus/moxtet.c                          | 533 ++++++++++++++++++
 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-moxtet.c                    | 179 ++++++
 include/linux/moxtet.h                        | 109 ++++
 11 files changed, 929 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-moxtet-devices
 create mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
 create mode 100644 drivers/bus/moxtet.c
 create mode 100644 drivers/gpio/gpio-moxtet.c
 create mode 100644 include/linux/moxtet.h

-- 
2.19.2

