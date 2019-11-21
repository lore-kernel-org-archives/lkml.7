Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD13C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DF52072E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y97OH20n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKUOm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:42:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51364 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKUOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:42:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so3731050wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=q/Olg7DOM35HM7vIU895qxlJTUIGF7wwE3/5QEjtx+8=;
        b=Y97OH20nyRr5v3BjSJJld8Ur7jXCzsvNVtWZdpgpyvAijvahM4FMOEaNm8vRvXGLxB
         ZnIgcqpwSDm5dBglA2md/nvSZcoZJECdJdlykqxQmtWK8gmg4BtUaZjh2vKNCCTaLe5T
         GYo54VVSkCJ98x0xfH1DtJZnd348vQeMzy6rkepjlM1iVnhu/7ZOkh5LQsKYcfDYvnbx
         Dl1IPxJZnzOTPd13MBTHCJzIr9FrOV/Bd9P6IJXyqqDcAN1BxtQKJWm6o2L/tasbZs49
         mwp/Z0jLyn8s35mLYY6ASzyAZylZUKKvdJqE2j0nzgMekOX3kApbwNwtmWRvqLjYaxCH
         qBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q/Olg7DOM35HM7vIU895qxlJTUIGF7wwE3/5QEjtx+8=;
        b=uWsGh6PJfqmsI7oSL6efg89/AeWGFc2R1dNy2EvKqu4CZvhylJgEZ3w0M8EXQRtmyZ
         8yNdjRM16RMQyT4UOajMGfyxLMlfR8L5FT6fXQyAe4Ig9wzkIrMuwl38cfNwny0Q7TxZ
         A5m5seA+jr3eZ7AdmGzzxbmCdru86krtuwe9CLpfjhnjvJ6IUzrDJUp8LOwDZm1dTDiR
         wOY4wSmJ7ebXKblWjD8Vs2v8X3ZwPKl6HcMc+z7EfztRd56zMsF/GzOvoZwwVFVIkeUX
         lSGuUvdDHc7M+SmQKBnoYQ3URyjYpR2RsYjePqolsaOCirv2kpxZbBbECvC2P9BmnnVO
         hKig==
X-Gm-Message-State: APjAAAW6A1IMO1d2ahkOITsZn0yVzLq0INOD/2SIAks4XpoWtnjdbqFA
        sg9J8guMq6FL80LM8Y4cvTA=
X-Google-Smtp-Source: APXvYqwqWwq50SFoKeW9cd6WBjhBhp5ITw+JzOCs9V7v3fe0CYtb1PIsDHmz0bcQ7u70oEvXHWKfwg==
X-Received: by 2002:a7b:cd92:: with SMTP id y18mr5155498wmj.52.1574347345721;
        Thu, 21 Nov 2019 06:42:25 -0800 (PST)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f67sm3212980wme.16.2019.11.21.06.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 06:42:25 -0800 (PST)
Date:   Thu, 21 Nov 2019 16:42:23 +0200
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.5
Message-ID: <20191121144223.GA14312@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request for habanalabs driver for kernel 5.5.

It mainly contains improvements to MMU and reset code, and exposes more
information through our INFO IOCTL.

Please see the tag message for more details on what this pull request
contains.

Thanks,
Oded

The following changes since commit ab64ec1db25e0cceab0bad15b03fd57e2b461b15:

  misc: Fix Kconfig indentation (2019-11-20 15:09:49 +0100)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-11-21

for you to fetch changes up to 5feccddcf9922ee3c25587d5e609bf58503ad93e:

  habanalabs: add more protection of device during reset (2019-11-21 11:35:47 +0200)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.5:

- MMU code improvements that includes:
  - Distinguish between "normal" unmapping and unmapping that is done as
    part of the tear-down of a user process. This improves performance of
    unmapping during reset of the device.
  - Add future ASIC support in generic MMU code.

- Improve device reset code by adding more protection around accessing the
  device during the reset process.

- Add new H/W queue type for future ASIC support

- Add more information to be retrieved by users through INFO IOCTL:
  - clock rate
  - board name
  - reset counters

- Small bug fixes and minor improvements to code.

----------------------------------------------------------------
Moti Haimovski (1):
      habanalabs: expose reset counters via existing INFO IOCTL

Oded Gabbay (16):
      habanalabs: handle F/W failure for sensor initialization
      habanalabs: set TPC Icache to 16 cache lines
      habanalabs: add opcode to INFO IOCTL to return clock rate
      habanalabs: expose card name in INFO IOCTL
      habanalabs: read F/W versions before failure
      habanalabs: use registers name defines for ETR block
      habanalabs: set ETR as non-secured
      habanalabs: increase max jobs number to 512
      habanalabs: don't print error when queues are full
      habanalabs: export uapi defines to user-space
      habanalabs: remove prints on successful device initialization
      habanalabs: use defines for F/W files
      habanalabs: make code more concise
      habanalabs: make the reset code more consistent
      habanalabs: flush EQ workers in hard reset
      habanalabs: add more protection of device during reset

Omer Shpigelman (9):
      habanalabs: re-factor memory module code
      habanalabs: type specific MMU cache invalidation
      habanalabs: re-factor MMU masks and documentation
      habanalabs: split MMU properties to PCI/DRAM
      habanalabs: prevent read/write from/to the device during hard reset
      habanalabs: optimize MMU unmap
      habanalabs: skip VA block list update in reset flow
      habanalabs: invalidate MMU cache only once
      habanalabs: remove unnecessary checks

Tomer Tayar (3):
      habanalabs: Fix typos
      habanalabs: Mark queue as expecting CB handle or address
      habanalabs: Add a new H/W queue type

YueHaibing (2):
      habanalabs: remove set but not used variable 'ctx'
      habanalabs: remove set but not used variable 'qman_base_addr'

 drivers/misc/habanalabs/command_submission.c       | 127 ++++---
 drivers/misc/habanalabs/debugfs.c                  | 112 ++++--
 drivers/misc/habanalabs/device.c                   |  18 +-
 drivers/misc/habanalabs/firmware_if.c              |   5 +-
 drivers/misc/habanalabs/goya/goya.c                |  78 ++--
 drivers/misc/habanalabs/goya/goyaP.h               |   2 +
 drivers/misc/habanalabs/goya/goya_coresight.c      |  53 +--
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |  31 ++
 drivers/misc/habanalabs/habanalabs.h               | 171 +++++----
 drivers/misc/habanalabs/habanalabs_ioctl.c         |  73 +++-
 drivers/misc/habanalabs/hw_queue.c                 | 249 ++++++++++---
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |   2 +
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |   1 +
 .../include/goya/asic_reg/psoc_etr_regs.h          | 114 ++++++
 drivers/misc/habanalabs/include/hl_boot_if.h       |   2 +
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |   7 +-
 drivers/misc/habanalabs/include/qman_if.h          |  12 +
 drivers/misc/habanalabs/memory.c                   | 392 +++++++++++----------
 drivers/misc/habanalabs/mmu.c                      | 204 ++++++-----
 include/uapi/misc/habanalabs.h                     |  48 ++-
 20 files changed, 1159 insertions(+), 542 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_etr_regs.h
