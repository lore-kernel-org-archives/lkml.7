Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D06DC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8A205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ2jJ1lV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfESRxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:53:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35197 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfESRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:53:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so246844plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7U4GWlu3NhNM+H5m0c8v1GRLQbRyHo7s1euACcIsXE0=;
        b=hZ2jJ1lV41sUooh+QYN+pA+yjuoXiY4VHfZYxskGzaKOZWy5Hw1p68M40Y6IB0E7PN
         c1JJmnhOQ/bS2iqdMwdNSbNd3dF7sv9qdvZ60VgXvxQzqKET3bT9IEsI9AlGelCvIdwc
         FwTyMi+7VtJNS4CBAY9fuIAESaBJOfW3mXLXM+exlywXR3DbxUdlRCjGrGP1cse3W8OJ
         zgjuS0BfZkTC58mdJJDxxa6Y2WzWXZQQANIcTA0hlshoz02yScOS6CKxbedXg8BeIwB3
         d5rEtDwouKwJXxsyYa8b/JSTsVdk1c25ACqkMd6JGS4LSGni7rzBChpOh93kAyAP4kOK
         4NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7U4GWlu3NhNM+H5m0c8v1GRLQbRyHo7s1euACcIsXE0=;
        b=nbklrEiV/bCjMRZXm2HiWA4lvq23c4OSlAG0JPoW2um+ULBmEWQmrQ10eg6NHiLdLt
         sFWFKMtXac9V+us918shWxV47id/2Xi8uLHVDlWYZnQ0XEOUnNbQLFwd0Jyv4c29si29
         X6tcaG252w5r0aw6OdYzwF5P+Hh6HJBdoFVZ/9MpN+YKhKHvqU+J86Pzzcj5Y4VbUy9r
         S+1C7P4TR7xLW2X+c9F69fi6DhykiQmnKd/KjKMt5thdxHXxxJEeBsts+PsjgVJBy8IX
         mwyeCMerNmug4LKYcLCzQgi7/UhanxafF7zTxzumZcEsE2rOQTmrflvNLYIc1TZMF8PI
         THmA==
X-Gm-Message-State: APjAAAUnCWcf+j6QgAegH6c5Df5/xyfjg5IIx5OJ/lmXQClH54HyHmL2
        2ww2Mqh3e1oXlwOJhC40JOWU98VN
X-Google-Smtp-Source: APXvYqyayPBWTYNdQszcQhIMFK+aS0ZvpndSym28CO3lemv+V5G3d3inoDU6heKFHo+0JAyJ5HeyNQ==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr70960833pla.48.1558278435099;
        Sun, 19 May 2019 08:07:15 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:5085:bb4a:e3a8:fc9d])
        by smtp.gmail.com with ESMTPSA id g17sm2441105pfb.56.2019.05.19.08.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 08:07:14 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v4 0/7] nvme-pci: support device coredump
Date:   Mon, 20 May 2019 00:06:51 +0900
Message-Id: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
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

* v4
- Add Reviewed-by tags
- Add nvme_get_telemetry_log() to nvme core module.
- Copy struct nvme_telemetry_log_page_hdr from the latest nvme-cli
- Use bio_vec instead of sg_table to store telemetry log page
- Make nvme_coredump_logs() return error if the device didn't produce
  a response.
- Abandon the reset if nvme_coredump_logs() returns error code

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
  nvme: add basic facilities to get telemetry log page
  nvme-pci: add device coredump infrastructure
  nvme-pci: trigger device coredump on command timeout
  nvme-pci: enable to trigger device coredump by hand

 drivers/base/devcoredump.c  | 168 ++++++++++------
 drivers/nvme/host/Kconfig   |   1 +
 drivers/nvme/host/core.c    |  59 ++++++
 drivers/nvme/host/nvme.h    |   3 +
 drivers/nvme/host/pci.c     | 473 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/devcoredump.h |  33 ++++
 include/linux/nvme.h        |  32 +++
 7 files changed, 696 insertions(+), 73 deletions(-)

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
-- 
2.7.4

