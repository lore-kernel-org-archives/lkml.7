Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C79C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311A62054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557251992;
	bh=P+jamI32pbMmT+ASgKQbcVxOXEJ/lXGFGPsOYi6mGjQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Bxn+0JObKR7qggh5EU0QrM+elshcrj25MgT89W0Zmk4cSv8Hj9INJXjPmHHnnhmGn
	 3QgE/8Tg/l4WLW4iCrjvj8pylnEaz2CZEBlYWOdg6oO6ehDyEMFPFMMvrdoD+203b+
	 ak9Aej1R/UDv2K8mzT/9m9uYBrJ/EKONKmegCbu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfEGR7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfEGR7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:59:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA032054F;
        Tue,  7 May 2019 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557251989;
        bh=P+jamI32pbMmT+ASgKQbcVxOXEJ/lXGFGPsOYi6mGjQ=;
        h=Date:From:To:Cc:Subject:From;
        b=tjF1EmQjIfkwnnzZULSnHAA9UN4eiR8bSEo7OrKa+LmWdhV5vyRreKUpa/qEVxvlt
         zY0/RYyVoB4mxhTtGCeyIh9gTFrV4TKhALUNLWXyQ2fj+Ja39kSaokt7RB3zaMyYue
         KKpiuSXIX649zOjewKxgUwlrhn5V2Vd935nswjJk=
Date:   Tue, 7 May 2019 19:59:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.2-rc1 - part 1
Message-ID: <20190507175947.GA11857@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.2-rc1-part1

for you to fetch changes up to 24f1bc280bcedbde1c05bec2d9f7fbef4a7579ff:

  misc: rtsx: Fixed rts5260 power saving parameter and sd glitch (2019-04-25 21:58:46 +0200)

----------------------------------------------------------------
Char/Misc patches for 5.2-rc1 - part 1

This is the first pull request for the char/misc driver tree for 5.2-rc1

This contains only a small number of bugfixes that would have gone to
you for 5.1-rc8 if that had happened, but instead I let them sit in
linux-next for an extra week just "to be sure".

The "big" patch here is for hyper-v, fixing a bug in their sysfs files
that could cause big problems.  The others are all small fixes,
resolving reported issues that showed up in 5.1-rcs, plus some odd
'static' cleanups for the phy drivers that really should have waited for
-rc1.  Most of these are tagged for the stable trees, so 5.1 will pick
them up.

All of these have been in linux-next for a while, with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (2):
      stm class: Fix channel bitmap on 32-bit systems
      intel_th: pci: Add Comet Lake support

Arnd Bergmann (3):
      phy: allwinner: allow compile testing
      phy: ti: usb2: fix OMAP_CONTROL_PHY dependency
      phy: mapphone-mdm6600: add gpiolib dependency

Dexuan Cui (1):
      Drivers: hv: vmbus: Remove the undesired put_cpu_ptr() in hv_synic_cleanup()

Greg Kroah-Hartman (2):
      Merge tag 'hyperv-fixes-signed' of git://git.kernel.org/.../hyperv/linux into char-misc-linus
      Merge tag 'phy-for-5.1-rc-v2' of git://git.kernel.org/.../kishon/linux-phy into char-misc-next

Kimberly Brown (4):
      Drivers: hv: vmbus: Expose monitor data only when monitor pages are used
      Drivers: hv: vmbus: Refactor chan->state if statement
      Drivers: hv: vmbus: Set ring_info field to 0 and remove memset
      Drivers: hv: vmbus: Fix race condition with new ring_buffer_info mutex

Paul Kocialkowski (1):
      phy: sun4i-usb: Make sure to disable PHY0 passby for peripheral mode

RickyWu (1):
      misc: rtsx: Fixed rts5260 power saving parameter and sd glitch

Tingwei Zhang (1):
      stm class: Fix channel free in stm output free path

Tony Lindgren (1):
      phy: phy-twl4030-usb: Fix cable state handling

Tyler Hicks (1):
      binder: take read mode of mmap_sem in binder_alloc_free_page()

YueHaibing (3):
      phy: rockchip-typec: Make usb3_pll_cfg and dp_pll_cfg static
      phy: qcom-ufs: Make ufs_qcom_phy_disable_iface_clk static
      phy: fix platform_no_drv_owner.cocci warnings

 Documentation/ABI/stable/sysfs-bus-vmbus   |  12 ++-
 drivers/android/binder_alloc.c             |   8 +-
 drivers/hv/channel_mgmt.c                  |   3 +
 drivers/hv/hv.c                            |   1 -
 drivers/hv/hyperv_vmbus.h                  |   3 +
 drivers/hv/ring_buffer.c                   |  22 +++-
 drivers/hv/vmbus_drv.c                     | 166 +++++++++++++++++++++++------
 drivers/hwtracing/intel_th/pci.c           |   5 +
 drivers/hwtracing/stm/core.c               |   9 +-
 drivers/misc/cardreader/rts5260.c          |   7 +-
 drivers/phy/allwinner/Kconfig              |   9 +-
 drivers/phy/allwinner/phy-sun4i-usb.c      |   4 +
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c |   1 -
 drivers/phy/motorola/Kconfig               |   2 +-
 drivers/phy/qualcomm/phy-qcom-ufs.c        |   2 +-
 drivers/phy/rockchip/phy-rockchip-typec.c  |   4 +-
 drivers/phy/ti/Kconfig                     |   2 +-
 drivers/phy/ti/phy-twl4030-usb.c           |  35 +++---
 include/linux/hyperv.h                     |   7 +-
 19 files changed, 220 insertions(+), 82 deletions(-)
