Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112DB20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="IRf9RCXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfCGMxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:53:25 -0500
Received: from mail.nic.cz ([217.31.204.67]:34451 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCGMxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:53:18 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 36116633EF;
        Thu,  7 Mar 2019 13:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551963195; bh=gtOfD2MZKCSmq4GCwQ4L9gKprttf0yWXffULGODrOZs=;
        h=From:To:Date;
        b=IRf9RCXGKqw1/xwqyWmOquYFPnPpmle0+KCjBdpw5hAIBaAx3JN8NvygJJD50NqVy
         SU0v+Jul/G3LLfezQsWXdSYUao+BcUmhr3EAZUJRfBAaR1ES1Rl/G6+32xg3Esoyfg
         e9Qw7u/yLhUct/f6+gIF51NLaw0+hZZdsD9ZI5dk=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v4 armsoc/drivers/bus+gpio 0/5] Add Moxtet bus and GPIO over Moxtet bus
Date:   Thu,  7 Mar 2019 13:52:46 +0100
Message-Id: <20190307125251.724-1-marek.behun@nic.cz>
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

this is the fourth version of patches to support the Moxtet bus and
GPIOs over it. Moxtet is a Turris Mox specific tiny bus over SPI.

I know that merge window is now closed, but I am trying this anyway now, since
Documentation/process/2.Process.rst mentions that even when merge window is
closed, "An occasional exception is made for drivers for previously-unsupported
hardware; if they touch no in-tree code, they cannot cause regressions and
should be safe to add at any time."

These patches apply to current linux/master, linux-gpio/devel
and arm-soc/arm/drivers.

I would appreciate reviews for the changes I made. I removed the Acked-by,
since the changes in drivers/bus/moxtet.c are non-trivial.

Marek

Changes since v3:
  - added module_description file in /sys/bus/moxtet/devices/*/
  - moved debugging into debugfs:
    - removed input_value and output_value debug files from
      /sys/bus/moxtet/devices/*/
    - added input and output debug files to debugfs/moxtet
  - added support for interrupts into moxtet driver:
    Some modules send interrupt via a shared line for all modules.
    In addition to this, they also send interrupt information via the SPI
    shift register, so that the system can distinguish which modules exactly
    sent it and won't have to check all modules.
    This is also needed to fix some bugs when one module sent IRQ and then
    another module sent another IRQ before the first was handled by the system,
    but the handling was already in progress. Since the shared line is
    falling-edge, the second IRQ was never handled.
  - since moxtet driver is now also interrupt controller, device-tree binding
    documentation is also changed

Changes since v2:
  - addressed the issues in device tree documentation pointed by Rob Herring
  - cosmetic changes suggested by Linus Walleij
  - added sysfs ABI documentation for /sys/bus/moxtet/devices attribute files
    as suggested by Linus Walleij

Marek Behún (5):
  bus: Add support for Moxtet bus
  dt-bindings: bus: Document moxtet bus binding
  bus: moxtet: Add sysfs and debugfs documentation
  drivers: gpio: Add support for GPIOs over Moxtet bus
  dt-bindings: gpio: Document GPIOs via Moxtet bus

 Documentation/ABI/testing/debugfs-moxtet      |  23 +
 .../ABI/testing/sysfs-bus-moxtet-devices      |  17 +
 .../devicetree/bindings/bus/moxtet.txt        |  44 +
 .../devicetree/bindings/gpio/gpio-moxtet.txt  |  18 +
 MAINTAINERS                                   |  12 +
 drivers/bus/Kconfig                           |  10 +
 drivers/bus/Makefile                          |   1 +
 drivers/bus/moxtet.c                          | 886 ++++++++++++++++++
 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-moxtet.c                    | 179 ++++
 include/dt-bindings/bus/moxtet.h              |  16 +
 include/linux/moxtet.h                        | 109 +++
 13 files changed, 1325 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-moxtet
 create mode 100644 Documentation/ABI/testing/sysfs-bus-moxtet-devices
 create mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
 create mode 100644 drivers/bus/moxtet.c
 create mode 100644 drivers/gpio/gpio-moxtet.c
 create mode 100644 include/dt-bindings/bus/moxtet.h
 create mode 100644 include/linux/moxtet.h

-- 
2.19.2

