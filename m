Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A57C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17306208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFnAxCk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfELPyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:54:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45819 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELPyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:54:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so5785282pfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pp9hsv0U6RxBmNm7s8k4z5FRyT/Bo1Secwg5CSD+HCY=;
        b=qFnAxCk8el7x5LzVJiG7j6Ye5s2U3iuY59le4mkghTmIBcLuHu3dJUbLKdXXnMX77l
         DNHC0OpLZdQXvzWmQxX9bvc7a27ssW6jYKEx/W0IyIMAZDTNnGroevcIUW1NYJ5rIffG
         wBgbkPkkhajuxczSoCJaFNLBmU55SUtjk8xL89MsWBoTVWFqUZ45Dd51gLPpR9dhdPH7
         l5o/ATm2Et2M9ccM5F8hdejoMnv+O9njMsZygQSCjp3zpzhR4ZY/RU3dkCO2KXs3A4yh
         rxX7v1JFDPKhdFXtZCgv68lokwJYrqnqKI99p4N/rVd04vBnM8xQtL3JhGVGJdvhczS9
         9x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pp9hsv0U6RxBmNm7s8k4z5FRyT/Bo1Secwg5CSD+HCY=;
        b=Y+VgcxUmJGYTcM8GCEE1wUZzzq45+OZbOex/DJCN/lDSi/4FGLgzhL6WNMF2VPWURS
         D4kzHcW0tjsdpyrxbbFe6H86V6Y7G82dYkjC1kdmCBi8uvAn5BSAPZGotFxZMo8l+spQ
         jtGxS+c3eT8oOlDMMgykic+f9OqsxcZWu13WbYIYkiOX6c+wE12USEEtyC9GFyFQQEMJ
         4O4wkgqdZcXSuj2o2WWRt9hl6P7GSSUDOIBmoAoZla+b5mOF96p2bd1JdrZ7ZyIlH1aM
         O4Gvig+WuFjlD4rmUDaDQRUwAJ86jdfqw8M5rzds64HVxuUbnV+YVfA3aYdRHhBiTCWX
         CcPw==
X-Gm-Message-State: APjAAAUFGTlmlDlN4aYEx6XVYYWX4fyY5f8T4JaWI+yKwn8pQX1u05le
        6XycUdv+bl4GLAR+hQP3Xb0=
X-Google-Smtp-Source: APXvYqxzfSK06s8Yc7onC8DkGnV7+VC7NSTngBHEbeYYr6A16YGtkImyzFj7kdIZJi+PM99pWWYoEQ==
X-Received: by 2002:a65:62c3:: with SMTP id m3mr26367134pgv.159.1557676478249;
        Sun, 12 May 2019 08:54:38 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:918e:f7e4:1728:3f45])
        by smtp.gmail.com with ESMTPSA id v2sm4470058pgr.2.2019.05.12.08.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 08:54:36 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>
Subject: [PATCH v3 0/7] nvme-pci: support device coredump
Date:   Mon, 13 May 2019 00:54:10 +0900
Message-Id: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables to collect snapshot of controller information via device
coredump mechanism.  The nvme device coredump is triggered when command
timeout occurs, and can also be triggered by writing sysfs attribute.

After finishing the nvme device coredump, the following files are created.

 - regs: NVMe controller registers (00h to 4Fh)
 - sq<qid>: Submission queue
 - cq<qid>: Completion queue
 - telemetry-ctrl-log: Telemetry controller-initiated log (if available)
 - data: Empty

The device coredump mechanism currently allows drivers to create only a
single coredump file, so this also provides a new function that allows
drivers to create several device coredump files in one crashed device.

* v3
- Merge 'add telemetry log page definisions' patch and 'add facility to
  check log page attributes' patch
- Copy struct nvme_telemetry_log_page_hdr from the latest nvme-cli
- Add BUILD_BUG_ON for the size of struct nvme_telemetry_log_page_hdr
- Fix typo s/machanism/mechanism/ in commit log
- Fix max transfer size calculation for get log page
- Add function comments
- Extract 'enable to trigger device coredump by hand' patch
- Don't try to get telemetry log when admin queue is not available
- Avoid deadlock in .coredump callback

* v2
- Add Reviewed-by tag.
- Add patch to fix typo in comment
- Remove unneeded braces.
- Allocate device_entry followed by an array of devcd_file elements.
- Add telemetry log page definisions
- Add facility to check log page attributes
- Exclude the doorbell registers from register dump.
- Save controller registers in a binary format instead of a text format.
- Create an empty 'data' file in the device coredump.
- Save telemetry controller-initiated log if available
- Make coredump procedure into two phases (before resetting controller and
  after resetting as soon as admin queue is available).

Akinobu Mita (7):
  devcoredump: use memory_read_from_buffer
  devcoredump: fix typo in comment
  devcoredump: allow to create several coredump files in one device
  nvme: add basic facility to get telemetry log page
  nvme-pci: add device coredump infrastructure
  nvme-pci: trigger device coredump on command timeout
  nvme-pci: enable to trigger device coredump by hand

 drivers/base/devcoredump.c  | 168 +++++++++------
 drivers/nvme/host/Kconfig   |   1 +
 drivers/nvme/host/core.c    |   3 +
 drivers/nvme/host/nvme.h    |   1 +
 drivers/nvme/host/pci.c     | 494 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/devcoredump.h |  33 +++
 include/linux/nvme.h        |  17 ++
 7 files changed, 644 insertions(+), 73 deletions(-)

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
-- 
2.7.4

