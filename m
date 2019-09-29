Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04103C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C691E21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="q9lW7VSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfI2SfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 14:35:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40623 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfI2SfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 14:35:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id d17so5355592lfa.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eegWp7OFuS9LfQMo/vUVdK64OvhifJQIxUvnCVGZlUo=;
        b=q9lW7VSfebtJhrUCh4TZPVaH9uP5MtEamWEMd5YVMSWIype0GOEU2KXB5qqWXd3M40
         uo2mB2UoilHqqBlyomgwdM2GQDIfN57U0oKK7qXoOTBIyh9PJ6lPMczovH13t6K6jp58
         NNGWAwqAlzz1kp8wzZgMVN9DEC+iKdjSA1HJtfvriOaQHXuRP33p9f0uHmlZt4EfI/vt
         dpjLj9VkvAYm9sFaWhaGdS+jGjZ0kjN90X0KpOpNYNvzYgxpuBR09KIpTs0wE7kGmqEI
         7eE2YmQca7fsAGOHUvIjWgqGijI3kfkYQxBoLb7QpjOtq96PBwdvj3UuJMzgwObHdwy/
         5z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eegWp7OFuS9LfQMo/vUVdK64OvhifJQIxUvnCVGZlUo=;
        b=ZPQNdxUwywyv/ziYVyYVY8RRfam3Ca6MF7BnAQ3T/TXsv5QYKRWQ9QlKPawga/hjR+
         zFBpUVnuZv2Rztp9wu4WoevvHEzBfmWgSroNsPpQ1xcGoMfeETdga+QfdrzcM3gngi+b
         hayU2NcUSj4cgC150lV9AJ3FT0e6e3nD5LH+2AI0ve5E1uiYwP4Nu9usRej3cOlKgFph
         unKZ7TwhleMGN5mnfgrfB+kJYKHTnpW21UAOjcPbuGGHMtyZDMwePFLbIbSRuc3ApxRI
         3mTm8jA7WkQKMLNhI3AvmvJR4dH8ZA655S7PpHE/b9cooSwApjLHlIWFJ1iTc61dn4Mh
         a7/A==
X-Gm-Message-State: APjAAAXyzBB1NxOWAG34T/2Nec0fKjPxSFZau2BhMKkACS5Z+MUtaRCd
        bX+yfNHqTTSOelN5Up9YUndUow==
X-Google-Smtp-Source: APXvYqxLIowMztRfR1dwrzcJ3kM/Z0abdPF1JMvF+WJPFzakdRu7lRiZ4dAJM5JPAOP62XeXjoB28g==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr8939251lff.103.1569782107368;
        Sun, 29 Sep 2019 11:35:07 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id t8sm3041717ljd.18.2019.09.29.11.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Sep 2019 11:35:05 -0700 (PDT)
Date:   Sun, 29 Sep 2019 11:34:53 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20190929183453.4sehzgovw3ouatdj@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 9bfd7319e8d353b8b81c4cfd4d7eced71adbfbb5:

  Merge tag 'fixes-5.4-merge-window' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes (2019-09-29 11:20:48 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A few fixes that have trickled in through the merge window:

 - Video fixes for OMAP due to panel-dpi driver removal
 - Clock fixes for OMAP that broke no-idle quirks + nfsroot on DRA7
 - Fixing arch version on ASpeed ast2500
 - Two fixes for reset handling on ARM SCMI

----------------------------------------------------------------
Adam Ford (4):
      ARM: omap2plus_defconfig: Fix missing video
      ARM: dts: logicpd-torpedo-baseboard: Fix missing video
      ARM: dts: am3517-evm: Fix missing video
      ARM: dts: logicpd-som-lv: Fix i2c2 and i2c3 Pin mux

Arnd Bergmann (1):
      ARM: aspeed: ast2500 is ARMv6K

Olof Johansson (2):
      Merge tag 'scmi-fixes-5.4' of git://git.kernel.org/.../sudeep.holla/linux into arm/fixes
      Merge tag 'fixes-5.4-merge-window' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes

Sudeep Holla (2):
      firmware: arm_scmi: reset: fix reset_state assignment in scmi_domain_reset
      reset: reset-scmi: add missing handle initialisation

Tony Lindgren (3):
      bus: ti-sysc: Fix clock handling for no-idle quirks
      bus: ti-sysc: Fix handling of invalid clocks
      bus: ti-sysc: Remove unpaired sysc_clkdm_deny_idle()

 Documentation/devicetree/bindings/arm/arm,scmi.txt |  17 +
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/am3517-evm.dts                   |  23 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  26 +-
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   |  37 +--
 arch/arm/configs/omap2plus_defconfig               |   1 +
 arch/arm/mach-aspeed/Kconfig                       |   1 -
 arch/arm/mach-omap2/pdata-quirks.c                 |   4 +-
 drivers/bus/ti-sysc.c                              |  52 ++-
 drivers/clk/clk-scmi.c                             |   2 +-
 drivers/firmware/arm_scmi/Makefile                 |   2 +-
 drivers/firmware/arm_scmi/base.c                   |   2 +-
 drivers/firmware/arm_scmi/clock.c                  |  33 +-
 drivers/firmware/arm_scmi/common.h                 |  18 +-
 drivers/firmware/arm_scmi/driver.c                 | 366 +++++++++++++--------
 drivers/firmware/arm_scmi/perf.c                   | 264 ++++++++++++++-
 drivers/firmware/arm_scmi/power.c                  |   6 +-
 drivers/firmware/arm_scmi/reset.c                  | 231 +++++++++++++
 drivers/firmware/arm_scmi/sensors.c                |  57 ++--
 drivers/hwmon/scmi-hwmon.c                         |   2 +-
 drivers/reset/Kconfig                              |  11 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-scmi.c                         | 125 +++++++
 include/linux/scmi_protocol.h                      |  46 ++-
 24 files changed, 1046 insertions(+), 282 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/reset.c
 create mode 100644 drivers/reset/reset-scmi.c
