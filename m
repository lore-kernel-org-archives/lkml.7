Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF98C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852A021479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E6o0HywK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfGBGGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:06:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39512 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfGBGGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:06:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so7708381pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEIwKMmTJMQNc6cChPg2bTrfjiNFCNKp7eNnSy3mZrU=;
        b=E6o0HywKABOOXkjDGPU/C7z19YwetOJjfUTuePoL5nFksbWw9cY2JNeVWxDvGfGMwb
         2i7CGkrQ7DKdpdo0HDFiA75i+9wha/Z7GZy3UlCbqRFYkpX0a3TgVRzX/DTyL/BFUHI7
         YdMhtY3b2Vs61f0VzIJZ1E9imUTLf/SFTUj9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEIwKMmTJMQNc6cChPg2bTrfjiNFCNKp7eNnSy3mZrU=;
        b=ViYNg/xcZsWkywjrXPwK6Fa4h0JF8XiCkAvOiDgDOj8Y0ieemk8taj0N0Xd0BniILw
         wPpk4F3bKbrD9kVul/gwDBlFW22fA1okpKLuVsn2rPbyWvcvlqISt+2EXaA2BfgBDd0h
         xbXPgRbdvQHdpGQ82rhpmoERgAn2ZMXs+qdsJ4DKXZgrx5MBEBflhExkgyUOdgYH+V9g
         I+3KGFONjPXRzwqOI3/+kKLSCWhZWH4TDFF3b98GrH1IvuRqgBqROAw+LuJCrXuRtPIo
         Cz964UWLuOKvkUIkwX4bBbCo43CdexPrj0pjLNReGQGunmNzJ3pDx3pP92fdxgowpMDT
         L7uw==
X-Gm-Message-State: APjAAAWWfZCpo/d2TO3iaE2KoUuubZM52NwFBNe4w+6sJ9n1VCmu5SaW
        +wHFt5yw09KTOJSkrsIa8YGOzg==
X-Google-Smtp-Source: APXvYqwLqQfcXef68NqInXgd1aLZas8KCW/D9JJ863T0uE5Jsuhrkdo/pYtJDjeqxjDQdKjKePaOvA==
X-Received: by 2002:a17:90a:360c:: with SMTP id s12mr3705655pjb.30.1562047558906;
        Mon, 01 Jul 2019 23:05:58 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id d1sm10284013pgd.50.2019.07.01.23.05.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 23:05:58 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Erin Lo <erin.lo@mediatek.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM), Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v12 0/5] Add support for mt8183 SCP.
Date:   Tue,  2 Jul 2019 14:05:23 +0800
Message-Id: <20190702060546.222934-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
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
* remoteproc/mtk_scp.c: Control the start / stop of SCP (Patch 2, 3).
* remoteproc/mtk_scp_ipi.c: Communicates to SCP using inter-processor
  interrupt (IPI) and shared memory (Patch 2, 3).
* rpmsg/mtk_rpmsg.c: Wrapper to wrap the IPI communication into a rpmsg
  device. Supports name service for SCP firmware to
  announce channels (Patch 4).
* add scp dts node to mt8183 platform (Patch 5).

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

Erin Lo (3):
  dt-bindings: Add a binding for Mediatek SCP
  remoteproc/mediatek: add SCP support for mt8183
  remoteproc: mt8183: add reserved memory manager API

Pi-Hsun Shih (1):
  rpmsg: add rpmsg support for mt8183 SCP.

 .../bindings/remoteproc/mtk,scp.txt           |  36 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  11 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  12 +
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  79 ++
 drivers/remoteproc/mtk_scp.c                  | 683 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_ipi.c              | 163 +++++
 drivers/rpmsg/Kconfig                         |   9 +
 drivers/rpmsg/Makefile                        |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     | 414 +++++++++++
 include/linux/platform_data/mtk_scp.h         | 167 +++++
 include/linux/rpmsg/mtk_rpmsg.h               |  38 +
 13 files changed, 1624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/platform_data/mtk_scp.h
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

-- 
2.22.0.410.gd8fdbe21b5-goog

