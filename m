Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B2D21883
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S15IC+UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfIEMTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:19:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbfIEMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:19:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so2524845wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MrN3BZcJsYC0iZ+zHMo7h0dJPYXfMi2qws2g4JTc1Xc=;
        b=S15IC+UUPDHdFE4bLWucvQ/qsfsVgPKO9wIdPfgeaFXw1sMFq3a098nTtoRYJIy8tp
         xCYN68qu9fy7TEKrmW5XjB0eqCHvnxa5y4R/GVy/fwRzHUPKGTVGT1rTxDilE7WoOaOk
         QvkomxGPVOA5pqTo4TugedvCrnlxHKglYzcT/D7yugqdYbHHYXJYknmRqzPUzMreboPK
         bdcrYQPp+ih10O2sIlfpHKHfm06FvigdVzs7qU3O/+tJg6gNgls3D1uLJuTCsg5bwBNn
         Q0Y3Ufoo9Dz0U36Pqi215tjQmSLExvg8M6hbiZsO1OWy2Jx7+Kfx0kzCldVi6Zc+JHRJ
         NB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MrN3BZcJsYC0iZ+zHMo7h0dJPYXfMi2qws2g4JTc1Xc=;
        b=Mc20GASqenfssgsnS9QChppShSnX0uuT4Y7Qrz+ok3z6KJRaJmcPfYFrAyk5NCX+zG
         /+vN+ryDKLHSKd1yzZ8A4t/JSsy/TCvCSkun0uoESamjbQFJGwWOGAk/TMrf4joOS7im
         j/UkSKGxEeVjmBZ88H2RtFDNtNDMI2MLezNFd75v6mTVwjserc0Pe0//Tlpc2kn8JyRc
         XvgZWr3yOdS7CuNds0t96+9s1nTWB/FLK0lxutlvKe+DnifW5LNHyFED0F0Rv1JVYRNS
         yxJeyK8m2llCNfst/zbyCe0mq9PKhEu6pt9ZEIabivo5YCPq27EPMmQxJMqVaud5IU0U
         7P6g==
X-Gm-Message-State: APjAAAUNmFtBY27FAXWP2Ei/Hp/P82l3kTdLQj8HC9qWjJuHRD7AhZ6y
        5D8ksVlBNWBWVkXW+fXJEu0=
X-Google-Smtp-Source: APXvYqxDYC4JTglMC/x0H9KInstQSf5vyM3V6ALQHn15RVRKGE6WZKFYpnWjVN4kdDEGyICYXlUSng==
X-Received: by 2002:adf:dd02:: with SMTP id a2mr2448616wrm.15.1567685976473;
        Thu, 05 Sep 2019 05:19:36 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z21sm2240328wmf.30.2019.09.05.05.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 05:19:35 -0700 (PDT)
Date:   Thu, 5 Sep 2019 15:19:34 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.4
Message-ID: <20190905121934.GA31853@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request for habanalabs driver for kernel 5.4.

It contains one major change, the creation of an additional char device
per PCI device. In addition, there are some small changes and
improvements.

Please see the tag message for details on what this pull request contains.

Thanks,
Oded

The following changes since commit 25ec8710d9c2cd4d0446ac60a72d388000d543e6:

  w1: add DS2501, DS2502, DS2505 EPROM device driver (2019-09-04 14:34:31 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-09-05

for you to fetch changes up to 6dc66f7c26f97396a570f84f6b3c3593a6de7f11:

  habanalabs: correctly cast variable to __le32 (2019-09-05 14:55:28 +0300)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.4:

- Create an additional char device per PCI device. The new char device
  allows any application to query the device for stats, information, idle
  state and more. This is needed to support system/monitoring
  applications, while also allowing the deep-learning application to send
  work to the ASIC through the main (original) char device.

- Fix possible kernel crash in case user supplies a smaller-than-required
  buffer to the DEBUG IOCTL.

- Expose the device to userspace only after initialization was done, to
  prevent a race between the initialization and user submitting workloads.

- Add uapi, as part of INFO IOCTL, to allow user to query the device
  utilization rate.

- Add uapi, as part of INFO IOCTL, to allow user to retrieve aggregate H/W
  events, i.e. counting H/W events from the loading of the driver.

- Register to the HWMON subsystem with the board's name, to allow the
  user to prepare a custom sensor file per board.

- Use correct macros for endian swapping.

- Improve error printing in multiple places.

- Small bug fixes.

----------------------------------------------------------------
Chuhong Yuan (1):
      habanalabs: Use dev_get_drvdata

Dotan Barak (1):
      habanalabs: explicitly set the queue-id enumerated numbers

Oded Gabbay (21):
      habanalabs: remove write_open_cnt property
      habanalabs: add comments on INFO IOCTL
      habanalabs: add debug print when rejecting CS
      habanalabs: cap simulator timeout
      habanalabs: power management through sysfs is only for GOYA
      habanalabs: add handle field to context structure
      habanalabs: kill user process after CS rollback
      habanalabs: show the process context dram usage
      habanalabs: rename user_ctx as compute_ctx
      habanalabs: maintain a list of file private data objects
      habanalabs: change device_setup_cdev() to be more generic
      habanalabs: create two char devices per ASIC
      habanalabs: replace __cpu_to_le32/64 with cpu_to_le32/64
      habanalabs: replace __le32_to_cpu with le32_to_cpu
      habanalabs: print to kernel log when reset is finished
      habanalabs: add uapi to retrieve device utilization
      habanalabs: add uapi to retrieve aggregate H/W events
      habanalabs: display card name as sensors header
      habanalabs: stop using the acronym KMD
      habanalabs: show correct id in error print
      habanalabs: correctly cast variable to __le32

Omer Shpigelman (2):
      habanalabs: use default structure for user input in Debug IOCTL
      habanalabs: improve security in Debug IOCTL

Tomer Tayar (5):
      habanalabs: Add descriptive names to PSOC scratch-pad registers
      habanalabs: Add descriptive name to PSOC app status register
      habanalabs: Expose devices after initialization is done
      habanalabs: Handle HW_IP_INFO if device disabled or in reset
      habanalabs: Make the Coresight timestamp perpetual

 Documentation/ABI/testing/sysfs-driver-habanalabs  |  14 +-
 drivers/misc/habanalabs/asid.c                     |   2 +-
 drivers/misc/habanalabs/command_buffer.c           |   3 +-
 drivers/misc/habanalabs/command_submission.c       |  27 +-
 drivers/misc/habanalabs/context.c                  |  40 +-
 drivers/misc/habanalabs/debugfs.c                  |  16 +-
 drivers/misc/habanalabs/device.c                   | 488 +++++++++++++++------
 drivers/misc/habanalabs/goya/goya.c                |  95 ++--
 drivers/misc/habanalabs/goya/goyaP.h               |  19 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |  89 ++--
 drivers/misc/habanalabs/goya/goya_hwmgr.c          | 109 +++++
 drivers/misc/habanalabs/habanalabs.h               | 129 ++++--
 drivers/misc/habanalabs/habanalabs_drv.c           | 171 +++++---
 drivers/misc/habanalabs/habanalabs_ioctl.c         | 180 ++++++--
 drivers/misc/habanalabs/hw_queue.c                 |  18 +-
 drivers/misc/habanalabs/hwmon.c                    |  24 +-
 drivers/misc/habanalabs/include/armcp_if.h         |  85 ++--
 drivers/misc/habanalabs/include/goya/goya.h        |   2 +
 .../misc/habanalabs/include/goya/goya_reg_map.h    |  34 ++
 drivers/misc/habanalabs/irq.c                      |   4 +-
 drivers/misc/habanalabs/sysfs.c                    | 126 +-----
 include/uapi/misc/habanalabs.h                     | 102 +++--
 22 files changed, 1177 insertions(+), 600 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_reg_map.h
