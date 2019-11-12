Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BBAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9E92084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K8pqxR84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKLLE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:04:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40404 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfKLLEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:04:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so11607840pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFhjUJFs5no4yiSlxY1BbjA9nXYA5kYuXUrDXqqyYHs=;
        b=K8pqxR84jS9pwV24nmhOTvuCjxZjWeopPAXLjsU9s0DgZ27WLwSdic0hrUXkLpfPFK
         nDx3fovBqn9s6Q8iMI4Xc5DnT4XL08sn5MySWYQPNvcV5a0xQfssVe8EnA0kXZ1W+3Qr
         M7MwKlnaQYKVBY9FPsVZA2MmdoBrtU4Ac4wms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFhjUJFs5no4yiSlxY1BbjA9nXYA5kYuXUrDXqqyYHs=;
        b=kOY+8j8fGN8Y/ChZm7ddJFysdbqQ7U2+64kucI+p7b70x3If/8nk0EOH7NRJ2kxjYi
         SbxKHoWYwcJ5Uc3wlM8RXUAgNJnwEm7WcSrAa97MviZsBxost6es7oBe2mbeTSviw6hu
         NhiaKoY0tl3GkSFVZQB2kwVtQK4BxsSQvvq6sr5+YB8+x/cp49cZrAg3Mspcnrifm0aS
         1PRVF8gzBLgTpm7d7JCNa0LeeBmJhctqgw8uEtrShICv1kEDJgEIF7BWGDWMMt9TSQUX
         2OW/IaT5mFnNB96zp64/xnOfE0Ffsthfa8O9+FxXfODyfyX6323FKk80fdZ69mZY2X7H
         E5Nw==
X-Gm-Message-State: APjAAAXyScpz4ihxdoaYB4iqBTOD+ZWw/rOk/eA0ioz/4LEgu4EuK7uz
        K1fvqd83YsR0B/J2P3TMuAwI8w==
X-Google-Smtp-Source: APXvYqyTQedqUkzhJsI4mPQBlLlsEJbFBlBQ4HI5KnQSbc/jCorqCINBQJyavGatvvs1sABtGK8maQ==
X-Received: by 2002:a17:90a:1446:: with SMTP id j64mr5766266pja.142.1573556663436;
        Tue, 12 Nov 2019 03:04:23 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 6sm21528389pfy.43.2019.11.12.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:04:22 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM)
Subject: [PATCH v21 0/4] Add support for mt8183 SCP.
Date:   Tue, 12 Nov 2019 19:03:23 +0800
Message-Id: <20191112110330.179649-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for controlling and communicating with mt8183's system
control processor (SCP), using the remoteproc & rpmsg framework.
And also add a cros_ec driver for CrOS EC host command over rpmsg.

The overall structure of the series is:
* remoteproc/mtk_scp.c: Control the start / stop of SCP (Patch 2).
* remoteproc/mtk_scp_ipi.c: Communicates to SCP using inter-processor
  interrupt (IPI) and shared memory (Patch 2).
* rpmsg/mtk_rpmsg.c: Wrapper to wrap the IPI communication into a rpmsg
  device. Supports name service for SCP firmware to
  announce channels (Patch 3).
* add scp dts node to mt8183 platform (Patch 4).

Changes from v20:
 - Change all public API usage of (struct platform_device *) to (struct
   mtk_scp *).
 - Rename some variables and functions to be more specific.
 - Move docs to implementation, and improve docs.
 - Address review comments.

Changes from v19:
 - Fix an incorrect include in mtk_rpmsg.h (linux/device.h ->
   linux/platform_device.h)

Changes from v18:
 - Change the way shared memory is handled, and drop patch 3.

Changes from v17:
 - Fix mixture use of __iomem found by sparse.
 - Change the ipi handler to take a u32 instead of enum scp_ipi_id.
 - Mark mtk_rpmsg_{prepare,unprepare,stop} as static.

Changes from v16:
 - Change the desc_lock mutex to be a per-id lock.
 - Put the execution of handler inside the per-id lock, to prevent race
   between scp_ipi_unregister and handler being run.
 - Move the initialization of mutex to before scp_ipi_register.

Changes from v15:
 - Fix a bug on incorrect usage of wait_event_timeout return value.

Changes from v14:
 - Fix a typo on variable in DEBUG section.

Changes from v13:
 - Move include/linux/platform_data/mtk_scp.h to
   include/linux/remoteproc/mtk_scp.h.
 - Rename scp_get_reserve_* to scp_get_reserved_*.
 - Add lock for access of scp->ipi_desc.
 - Lock the whole ipi_send function.
 - Move more setting of cache size from SCP firmware to kernel driver,
   to prevent problem while loading firmware onto DRAM.
 - Minor fixes addressing comment.

Changes from v12:
 - Initialize cache before firmware load, to avoid problem while loading
   large firmware.
 - Disable watchdog before stopping SCP, to avoid extra warning message.
 - Fix new warnings by checkpatch.

Changes from v11:
 - Fixed a bug that mtk_rpmsg_endpoint is not properly cleaned up if
   rproc_boot fails.
 - Add missing documentation in comment.

Changes from v10:
 - Drop applied cros_ec_rpmsg patches.
 - Add clock reset before loading SCP firmware.
 - Fix some type mismatch warnings when printing debug messages.

Changes from v9:
 - Remove reserve-memory-vpu_share node.
 - Remove change to cros_ec_commands.h (That is already in
   https://lore.kernel.org/lkml/20190518063949.GY4319@dell/T/)

Changes from v8:
 - Rebased onto https://patchwork.kernel.org/cover/10962385/.
 - Drop merged cros_ec_rpmsg patch, and add scp dts node patch.
 - Add more reserved memory region.

Changes from v7:
 - Rebase onto https://lore.kernel.org/patchwork/patch/1059196/.
 - Fix clock enable/disable timing for SCP driver.
 - Add more SCP IPI ID.

Changes from v6:
 - Decouple mtk_rpmsg from mtk_scp.
 - Change data of EC response to be aligned to 4 bytes.

Changes from v5:
 - Add device tree binding document for cros_ec_rpmsg.
 - Better document in comments for cros_ec_rpmsg.
 - Remove dependency on CONFIG_ in binding tree document.

Changes from v4:
 - Merge patch 6 (Load ELF firmware) into patch 2, so the driver loads
   ELF firmware by default, and no longer accept plain binary.
 - rpmsg_device listed in device tree (as a child of the SCP node) would
   have it's device tree node mapped to the rpmsg_device, so the rpmsg
   driver can use the properties on device tree.

Changes from v3:
 - Make writing to SCP SRAM aligned.
 - Add a new patch (Patch 6) to load ELF instead of bin firmware.
 - Add host event support for EC driver.
 - Fix some bugs found in testing (missing spin_lock_init,
   rproc_subdev_unprepare to rproc_subdev_stop).
 - Fix some coding style issue found by checkpatch.pl.

Changes from v2:
 - Fold patch 3 into patch 2 in v2.
 - Move IPI id around to support cross-testing for old and new firmware.
 - Finish more TODO items.

Changes from v1:
 - Extract functions and rename variables in mtk_scp.c.
 - Do cleanup properly in mtk_rpmsg.c, which also removes the problem of
   short-lived work items.
 - Code format fix based on feedback for cros_ec_rpmsg.c.
 - Extract feature detection for SCP into separate patch (Patch 6).

Eddie Huang (1):
  arm64: dts: mt8183: add scp node

Erin Lo (2):
  dt-bindings: Add a binding for Mediatek SCP
  remoteproc/mediatek: add SCP support for mt8183

Pi-Hsun Shih (1):
  rpmsg: add rpmsg support for mt8183 SCP.

 .../bindings/remoteproc/mtk,scp.txt           |  36 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  11 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  12 +
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  94 +++
 drivers/remoteproc/mtk_scp.c                  | 663 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_ipi.c              | 219 ++++++
 drivers/rpmsg/Kconfig                         |   9 +
 drivers/rpmsg/Makefile                        |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     | 414 +++++++++++
 include/linux/remoteproc/mtk_scp.h            |  66 ++
 include/linux/rpmsg/mtk_rpmsg.h               |  38 +
 13 files changed, 1574 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/remoteproc/mtk_scp.h
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h


base-commit: fc6d6db1df2cb11bbecc542d67885742e75b4b07
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

