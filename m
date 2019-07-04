Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E5EC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D832A21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmNgFZ44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfGDGXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:23:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43252 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfGDGXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:23:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so5219257wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N1XKsdt47tH6QX/lfb6DoE+8I5nTHHv5tQJUtJXhYCA=;
        b=nmNgFZ44105JNKB3xOxWjQpleCZynxu1XzyvGdBOs1f5Gaw9Qkl3ccAaEgUqcfULQm
         nczeFv3qRpZq4rportapxaNUu/TafZ0m/Rg6zQwlRIk7XX/bSoUVJTDRDr0zzlOhFGLh
         +p8dEBFYy1FykKU84M4NFCoEupdPZxhv+RxqYWlx1kF88QLosvGeKjAvx0hMgQpeNtMh
         6Ruu5tsfxf0Tg4BYABw+tkKAp7y2ZcaCR9gNwZWRanQ9oRaXCr1d0Dp2t1Q9WDckorC3
         aglZwjqDVVJGlqRznaXKDHVXGgD4FMGSydkhyJdBh+52QZBzvEM4J2eU8bUIMIq4yv4n
         KI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N1XKsdt47tH6QX/lfb6DoE+8I5nTHHv5tQJUtJXhYCA=;
        b=B8yFCbcdaNiIVmXdpMBuHvaUhvLYGYOPbnWBN40JG12ZNGe3CNENuDdg0jBm23FNWd
         xoYxvZlO2qXjHWNPbTehCjBmijtlK+TtmkWiv4S0Qa7wVp8LkhnAmt/nhltIkuGwEDOU
         Bd+bm/kZp6vPIJ+spT/Kpc2B9bSYZ2eTMOXygO5PiK7dMohfktS4ARQiuHNvsmepK8hP
         i8LOhAdlrUySE+FjnmFZBLY3dn5p2Tj4YQ0JAtdQ4aSj5vD3oMDHUV5fj0bGZHpglUSD
         2rpSCY4hlHyIePNTCf/o7Hz53CzMLNhrXODD99jNU3awJvxUgkBQZCcTd4fO95enBFb7
         N+mQ==
X-Gm-Message-State: APjAAAU9v5a9SfxvGWKqDV/sx7/uXNn7fv5C/T6305oSP5aHUVjrBzWw
        0OKtNxthpCZLeVdJRzAk/AI=
X-Google-Smtp-Source: APXvYqyRSClWeqWho1TD0jlm3iNpghWLrz2xLC6FSie6MqJ6ZFqcdofgdzZoRnFNpJaDSGb+8WR1PA==
X-Received: by 2002:adf:eb06:: with SMTP id s6mr3365855wrn.151.1562221381741;
        Wed, 03 Jul 2019 23:23:01 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r131sm4373842wmf.4.2019.07.03.23.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 23:23:01 -0700 (PDT)
Date:   Thu, 4 Jul 2019 09:22:59 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.3
Message-ID: <20190704062259.GA1094@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request for habanalabs driver for kernel 5.3.

It mostly contains improvements to the existing code base. Nothing too
exciting this time.

Please see the tag message for details on what this pull request contains.

Thanks,
Oded

The following changes since commit 60e8523e2ea18dc0c0cea69d6c1d69a065019062:

  ocxl: Allow contexts to be attached with a NULL mm (2019-07-03 21:29:47 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-07-04

for you to fetch changes up to 4e2da0648c0def56103ac5af2df107c966865821:

  habanalabs: Add busy engines bitmask to HW idle IOCTL (2019-07-01 13:59:45 +0000)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.3:

- Change the way the device's CPU access the host memory. This allows the
  driver to use the kernel API of setting DMA mask in a standard way (call
  it once).

- Add a new debugfs entry to show the status of the internal DMA and
  compute engines. This is very helpful for debugging in case a command
  submission get stuck.

- Return to the user a mask of the internal engines indicating their busy
  state.

- Make sure to restore registers that can be modified by the user to their
  default values. Only applies to registers that are initialized by the
  driver.

- Elimination of redundant and dead-code.

- Support memset of the device's memory with size larger then 4GB

- Force the user to set the device to debug mode before configuring the
  device's coresight infrastructure

- Improve error printing in case of interrupts from the device

----------------------------------------------------------------
Dalit Ben Zoor (3):
      habanalabs: make tpc registers secured
      habanalabs: clear sobs and monitors in context switch
      habanalabs: restore unsecured registers default values

Oded Gabbay (20):
      habanalabs: improve a couple of error messages
      habanalabs: force user to set device debug mode
      habanalabs: remove dead code in habanalabs_drv.c
      habanalabs: check to load F/W before boot status
      habanalabs: remove redundant CB size adjustment
      habanalabs: remove redundant memory clear
      habanalabs: change polling functions to macros
      habanalabs: pass device pointer to asic-specific function
      habanalabs: support device memory memset > 4GB
      habanalabs: don't limit packet size for device CPU
      habanalabs: remove simulator dedicated code
      habanalabs: add rate-limit to an error message
      docs/habanalabs: update text for some entries in sysfs
      habanalabs: initialize device CPU queues after MMU init
      habanalabs: de-couple MMU and VM module initialization
      habanalabs: initialize MMU context for driver
      habanalabs: add MMU mappings for Goya CPU
      habanalabs: set Goya CPU to use ASIC MMU
      habanalabs: remove DMA mask hack for Goya
      habanalabs: add WARN in case of bad MMU mapping

Omer Shpigelman (4):
      habanalabs: remove redundant CPU checks
      habanalabs: minor documentation and prints fixes
      habanalabs: increase PCI ELBI timeout for Palladium
      habanalabs: print event name for fatal and non-RAZWI events

Tomer Tayar (4):
      habanalabs: Allow accessing host mapped addresses via debugfs
      habanalabs: Update the device idle check
      habanalabs: Add debugfs node for engines status
      habanalabs: Add busy engines bitmask to HW idle IOCTL

 .../ABI/testing/debugfs-driver-habanalabs          |  18 +-
 Documentation/ABI/testing/sysfs-driver-habanalabs  |  42 +-
 drivers/misc/habanalabs/asid.c                     |   2 +-
 drivers/misc/habanalabs/command_submission.c       |  10 +-
 drivers/misc/habanalabs/context.c                  |  11 +-
 drivers/misc/habanalabs/debugfs.c                  |  54 +-
 drivers/misc/habanalabs/device.c                   | 189 +++---
 drivers/misc/habanalabs/firmware_if.c              |  51 +-
 drivers/misc/habanalabs/goya/goya.c                | 635 +++++++++++++++------
 drivers/misc/habanalabs/goya/goyaP.h               |  16 +-
 drivers/misc/habanalabs/goya/goya_security.c       |  16 +
 drivers/misc/habanalabs/habanalabs.h               |  93 ++-
 drivers/misc/habanalabs/habanalabs_drv.c           |  66 ++-
 drivers/misc/habanalabs/habanalabs_ioctl.c         |  11 +-
 drivers/misc/habanalabs/hw_queue.c                 |   2 +-
 .../include/goya/asic_reg/dma_ch_0_masks.h         | 418 ++++++++++++++
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |   1 +
 drivers/misc/habanalabs/memory.c                   |  13 +-
 drivers/misc/habanalabs/mmu.c                      |  20 +-
 drivers/misc/habanalabs/pci.c                      |  10 +-
 drivers/misc/habanalabs/sysfs.c                    |   4 -
 include/uapi/misc/habanalabs.h                     |  30 +-
 22 files changed, 1249 insertions(+), 463 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_masks.h
