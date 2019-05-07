Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EEEC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC8B205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3Zmc4Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfEGQ6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:58:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44914 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGQ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:58:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so8951789pfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F24W/VQdFijjB1XGiNkd+uOp8FfAnZYn7ACk/HniCPU=;
        b=Y3Zmc4Ma29TBsmGOUgwg/jPSIzCpH5JEVkNVRIChv+DGVQRwMrPtv4fU/OV5Zdqg9f
         FcehhvuCbJIP6W7xn1UQf2RtbFurlNLSOfo3waSOoI+iEzAhS4wVBuUDBGw6EE1qs1s9
         npyy0aEHaXXEASHaz9KQnjcDzqfp/6zt7R3RfSmuCrWlT1/jxrf5HKdPj6xkST6pOWeG
         SBc2d/bOIDuYHF0tItNJenK6BszLfEBCVBmMIP0prNNeLj9FBjlKD9wO+j/teKWtt7ko
         4KdClyUwrPURGOmeyinrZyvb1wTKNHdl4XLw5WynCm/dfPtgQ+dLTLXsrGA3xN5D/eaD
         zfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F24W/VQdFijjB1XGiNkd+uOp8FfAnZYn7ACk/HniCPU=;
        b=LgR4saq/1aLUJVsfTmporExJJQUQBCU8OBcm4TWTMPb749LViVLDOpPO06JkGVC7l8
         kfesGyBPfZ+M+TaFXayKt8Nr+0HVPBnEKRmW1tyTeDn2Wnzq3Q5V3ML/iert+SQo2bPK
         MpDcD1cytT5UGtDoN2iUnx1be4xtM/VQh4BBocqJ0QhkPx2pM6BtXGJ4ZyrPvLIjLIaL
         22frhSzsy1m6Ovf4OpXgrphTG8Di/PkqkjMzMpRNr/okMDnfoTPe/z5hh7teT6g0kCDn
         bPapkoDOLymH+A/twFbNvGzahd+sb+J9yPifsh1Zf0rAfNXT89OJsTNZCRXw/+rTA8gW
         MOXA==
X-Gm-Message-State: APjAAAWNDUb8sOXGSBXDGJy9/fk5WC5B8iKrgyMUF5VTQao12fe5kZ+q
        7b3OuoajEIX5+sDx+ibxqh0=
X-Google-Smtp-Source: APXvYqyIg1w1Fe7zxUiHrffJfT0aPJd66Jea9lk8GVdzXmRZC1nVbx0EGEdiR0579yTPC1RZ60b+LQ==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr39874187pgh.86.1557248329585;
        Tue, 07 May 2019 09:58:49 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id r12sm18140093pfn.144.2019.05.07.09.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 09:58:48 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v2 0/7] nvme-pci: support device coredump
Date:   Wed,  8 May 2019 01:58:27 +0900
Message-Id: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables to capture snapshot of controller information via device
coredump machanism, and it helps diagnose and debug issues.

The nvme device coredump is triggered when command timeout occurs, and
creates the following coredump files.

 - regs: NVMe controller registers (00h to 4Fh)
 - sq<qid>: Submission queue
 - cq<qid>: Completion queue
 - telemetry-ctrl-log: Telemetry controller-initiated log (if available)
 - data: Empty

(I don't have the NVMe device that supports telemetry log page for now, so
capturing telemetry log is untested.)

The device coredump mechanism currently allows drivers to create only a
single coredump file, so this also provides a new function that allows
drivers to create several device coredump files in one crashed device.

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
  nvme.h: add telemetry log page definisions
  nvme: add facility to check log page attributes
  nvme-pci: add device coredump support
  nvme-pci: trigger device coredump on command timeout

 drivers/base/devcoredump.c  | 168 ++++++++++------
 drivers/nvme/host/Kconfig   |   1 +
 drivers/nvme/host/core.c    |   2 +
 drivers/nvme/host/nvme.h    |   1 +
 drivers/nvme/host/pci.c     | 460 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/devcoredump.h |  33 ++++
 include/linux/nvme.h        |  25 +++
 7 files changed, 617 insertions(+), 73 deletions(-)

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
-- 
2.7.4

