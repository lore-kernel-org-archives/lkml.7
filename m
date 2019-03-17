Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03DEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68A020896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 19:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYpqEmfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCQT7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51500 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfCQT7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id n19so11012281wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VNTJ18EZUBatLNw/DiLf2Hr/y3zJHjJHdT7D9txMGbA=;
        b=OYpqEmfHM48BqxZU+NSkFxBFZTkJGCYTfJr6UCkLOKPcEukIrSomv4bqYmgt6bzmQB
         6WEe8z0Qr3xOvq59UraemNjqf1FzoHDyjGwLTrwEMiP6pk07i2+W1rAssYFpYyjdO/UW
         oDcVB69Agv/ay9xjNqyXLfQ9BcirAMncfbIK/z/LsCqq+S5DgbRVCtGCONRi9QybZ9vO
         x9P+5RmNlLmNdtcy0Rs8uiQCN1ebp8zXiZU+kkX4r5Fde14s7x5iv2iwzGVFJSe7ChzN
         xpFdS4vbuMuboSdRAhipOnpBfiXzvlqL1PkSEOm4BlfTWYDbA888KvT2ChbCsEDipQDr
         gzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VNTJ18EZUBatLNw/DiLf2Hr/y3zJHjJHdT7D9txMGbA=;
        b=q3BIjQD2DyIuHN71ENTdUDHP+Xfzd3BUnRAjIgdwGGLz6MU9JLiY7ow+3shSJWFRQf
         F3pqNnXiP9BnWvS+MTYC76y4xHC0qE/mukhORIxHUAkQdGDrV9qoGZmUE9TAH5vO468q
         7y0wUqRDG3WHTAAnrVMC9n+PBS9bU3yAv4q4Ieak2ECbyaRVqLXTM5rpbkDjuubkQz0U
         bdz2b2+//pehpyb/jfPH5zV4q+M7mtlHRhTg5EzHYWciUOVIEjOIcKhJzu4fEyROFs8i
         EPNeKagSACCZGmGIMzUEbcNPO86caF0TkeT9wnqEHjrRP1FFr6hrTKHTqdABjfmXn9e8
         Iz3A==
X-Gm-Message-State: APjAAAU9kuF0tpZDqZ4UkZfn1Pdz5lhQzy6unPKobILfNw5/2QSGOo/S
        BF4zWCqjnzl8zyphcllent3rhqSZ
X-Google-Smtp-Source: APXvYqw5MnHdCyCVDgB4RltrDWOU13mdJSEza6BWv4p9abpwkGNQiVKU1ctBGWMKJ8jOXbIpsW7soQ==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr8589669wmc.112.1552852769899;
        Sun, 17 Mar 2019 12:59:29 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:29 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 00/15] habanalabs: various improvements and updates
Date:   Sun, 17 Mar 2019 21:59:12 +0200
Message-Id: <20190317195927.26238-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set contains various improvements to existing code and some
updates from our internal tree at habanalabs.

None of the patches here is critical fix for the 5.1 kernel release, and
they will be queued in the main pull request for the 5.2 merge window.

Thanks,
Oded

Dotan Barak (1):
  habanalabs: remove implicit include from header files

Igor Grinberg (1):
  habanalabs: add new device CPU boot status

Oded Gabbay (7):
  habanalabs: rename goya_non_fatal_events array to all events
  habanalabs: use EQ MSI/X ID per chip
  habanalabs: remove unused defines
  habanalabs: ratelimit warnings at start of IOCTLs
  uapi/habanalabs: add some comments in habanalabs.h
  habanalabs: keep track of the device's dma mask
  habanalabs: never fail hard reset of device

Omer Shpigelman (1):
  habanalabs: add MMU shadow mapping

Tomer Tayar (5):
  habanalabs: Move device CPU code into common file
  habanalabs: Move PCI code into common file
  habanalabs: Remove unneeded function pointers
  habanalabs: Add a printout with the name of a busy engine
  habanalabs: Allow accessing DRAM virtual addresses via debugfs

 drivers/misc/habanalabs/Makefile              |   2 +-
 drivers/misc/habanalabs/command_submission.c  |   2 +-
 drivers/misc/habanalabs/debugfs.c             |  96 ++-
 drivers/misc/habanalabs/device.c              |  19 +-
 drivers/misc/habanalabs/firmware_if.c         | 324 ++++++++
 drivers/misc/habanalabs/goya/goya.c           | 719 +++---------------
 drivers/misc/habanalabs/goya/goyaP.h          |  29 +-
 drivers/misc/habanalabs/goya/goya_security.c  |   1 +
 drivers/misc/habanalabs/habanalabs.h          |  72 +-
 drivers/misc/habanalabs/habanalabs_drv.c      |   3 +
 drivers/misc/habanalabs/habanalabs_ioctl.c    |   4 +-
 drivers/misc/habanalabs/include/armcp_if.h    |  10 +-
 .../include/goya/asic_reg/goya_masks.h        |  12 -
 drivers/misc/habanalabs/include/goya/goya.h   |   4 -
 .../include/goya/goya_async_events.h          |   9 +
 .../misc/habanalabs/include/goya/goya_fw_if.h |   2 +
 drivers/misc/habanalabs/include/hl_boot_if.h  |   3 +-
 .../include/hw_ip/mmu/mmu_general.h           |  16 +-
 .../include/hw_ip/pci/pci_general.h           |  23 +
 drivers/misc/habanalabs/mmu.c                 | 597 ++++++++-------
 drivers/misc/habanalabs/pci.c                 | 402 ++++++++++
 include/uapi/misc/habanalabs.h                |   7 +-
 22 files changed, 1404 insertions(+), 952 deletions(-)
 create mode 100644 drivers/misc/habanalabs/firmware_if.c
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
 create mode 100644 drivers/misc/habanalabs/pci.c

-- 
2.17.1

