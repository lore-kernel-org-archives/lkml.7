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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB68AC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9092133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjTtkcA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGDG6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:58:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34247 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGDG6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:58:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so4547357wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wmbWXidqkuvBIedLHQDdrW1iUlOaCMExfvS6Z0yx96c=;
        b=PjTtkcA0Tm98JXR/1gLChgQpgCNDQn9ty/SQwOQjrwFcHvR5w4J5GMZ7u5dII4ODJj
         e9nPkpUAiMDdjreuCnIrMH35rom3OgyTGnpDH+UJDO2gQ9eurAhpEFIYJXpHckZtc+uK
         R+c/RPrQprBUnxS9KRtgwWaxlebGBtOhqr24WL8HzPkx13FZBehpSG/M3z5b21MF0qgI
         N/TZzfxbGXXxDc9X5bV8um+0Uk5cGH7VcLJp2QxXGqxKNjMgqXFSApnGgZ4DWF3TaZUF
         tJqzxkbeg3Zj7bIfmH/VYGZy2V+trpx+7qx3HGFLi22cOYwaya24BEDS/Ejy6yNQwoSu
         3ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wmbWXidqkuvBIedLHQDdrW1iUlOaCMExfvS6Z0yx96c=;
        b=MIatUlJizhRg0N7DiwGxQyNvtWF0CLgBGyk37G0XzMu0TwsRKpmZjRtNjaa0J77Jrn
         4q69I9F15nIDd9Ai7lbi3jrGlINPE4zY2CrhV6mQWCxM3a4SxlRg7E/li3Wh/N8WuDl3
         CSbDBcvlOS5raHp2hr/60WE/Rp407r5mc3hD2t+GNn3nNJdCoz+u9DSbo0jAjBBKOqt+
         /bk2+PrmHynFcactlbuX6xLe/pVlgoPKyPqdpM+nxY5gLHov4RaQ/eNtVLlj2zXy9hPA
         z8TyNA2AEOhym6zz5XOLoMQQ+SjU7YKvcTPlyQhJTPfnqDShHmplYWTqHTqsyImiWesE
         M6Vw==
X-Gm-Message-State: APjAAAV9MNa77YfEiz4uLflOo9h6+numn4IOJ7U+DfNwr5mAYtDP7+DI
        94m3GjtiHWZ5hxSTwClwcVY=
X-Google-Smtp-Source: APXvYqyVIUJqYCwSX2DmikwA8mw510FldQRJsgJuxubH5FuzLi9hR5+ZLhygyCDAeL6uEXIfemythA==
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr11797994wmc.50.1562223525591;
        Wed, 03 Jul 2019 23:58:45 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id t6sm5205517wmb.29.2019.07.03.23.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 23:58:45 -0700 (PDT)
Date:   Thu, 4 Jul 2019 09:58:43 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull v2] habanalabs pull request for kernel 5.3
Message-ID: <20190704065843.GA21559@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is v2 of the pull request for habanalabs driver for kernel 5.3.

v2 contains the missing sign-off-by tags for the relevant commits.

The commits mostly contains improvements to the existing code base.
Nothing too exciting this time.

Please see the tag message for details on what this pull request contains.

Thanks,
Oded

The following changes since commit 60e8523e2ea18dc0c0cea69d6c1d69a065019062:

  ocxl: Allow contexts to be attached with a NULL mm (2019-07-03 21:29:47 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-07-04

for you to fetch changes up to e8960ca06bb22d0d84edf246b0bf395e8322e127:

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
