Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A526E206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnuyaiZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEBI7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:59:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44440 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfEBI7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:59:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id l2so710427plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nR2hjJ7UdjaiCokIC7QFZTHdxkSdbYuSlKgyi1UOJCc=;
        b=FnuyaiZMo6zoeUzdXDAHbFFLF00XiKpUHFgqrqvQehNz3iMJgPm/q/ku3A+M+AqYtW
         YIXUfXzGJhU9zGQVsLZIU/h2BiWsH6o33gQLZBqOnbHR4ZEpcgcF/rGxEXcnDBV1zE40
         TeGX/L/peWegooaY8tXN45iGg4Pm53yNeUjL8CuwNZK+Nn52TWWPN6Ks770WFgqJSZNl
         Hv6ueikGZB+0E7k9I6js7oKP8o0pkBQHxD4rWWigT+cwXxVvqXkUVdKN7nHqiEaSgNV4
         80KPtejo0AmGUj9M2rz3AYdog0XN8qmSCL1LntJ8yvhIUNKm3zR4U7T0JkC1ywdxBx8n
         g28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nR2hjJ7UdjaiCokIC7QFZTHdxkSdbYuSlKgyi1UOJCc=;
        b=MH32zcW67tZ/nycDD5c1r8IO7O1eBkYll+yjqg6TpaODwSIBGKF8U6lRaF3r2ERUhE
         QqtmPNWDHhcu1tP6quoYjX1zBiPWfOoQsKykLhn7WMf5+yCpAJlzi6Eo5fB8QlfruYww
         DSpFp+hMBKr0VHWnLTGNT7IGmFnvXAGJ6xCDKaAf6T8E8MY7FtLikE85lFZN2E3UR6vu
         aq6XAKi/MFkjtnlbhy6MX0fmG7Img5GQgYYcv/NwOkcBCqkmprM8zgpVslHtZ2QEIVjc
         zwSCPkf/2xJLc81KEyaviASXKjx0EwZyPArHFTfF6z6QRGsZeIMP4T6pPCXbh70fJnWY
         UoSQ==
X-Gm-Message-State: APjAAAXS+TZPO7xXuOBNvibigYBPYMP31WXcwbBDiAkaZ8BzH2NkRh2a
        jq7GIpExxd5qX6H19qNxXHM=
X-Google-Smtp-Source: APXvYqw/eKFMGVDywRH6P7JDlpGAmL+cFlDS5um4/QOt8InsWmPm8XB9kvyKPJIyUDAGMK5wT1Bw3A==
X-Received: by 2002:a17:902:294b:: with SMTP id g69mr2491883plb.57.1556787576324;
        Thu, 02 May 2019 01:59:36 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id z7sm74960831pgh.81.2019.05.02.01.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 01:59:35 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/4] nvme-pci: support device coredump
Date:   Thu,  2 May 2019 17:59:17 +0900
Message-Id: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables to capture snapshot of controller information via device
coredump machanism, and it helps diagnose and debug issues.

The nvme device coredump is triggered before resetting the controller
caused by I/O timeout, and creates the following coredump files.

- regs: NVMe controller registers, including each I/O queue doorbell
        registers, in nvme-show-regs style text format.

- sq<qid>: I/O submission queue

- cq<qid>: I/O completion queue

The device coredump mechanism currently allows drivers to create only a
single coredump file, so this also provides a new function that allows
drivers to create several device coredump files in one crashed device.

Akinobu Mita (4):
  devcoredump: use memory_read_from_buffer
  devcoredump: allow to create several coredump files in one device
  nvme-pci: add device coredump support
  nvme-pci: trigger device coredump before resetting controller

 drivers/base/devcoredump.c  | 173 +++++++++++++++++++-----------
 drivers/nvme/host/Kconfig   |   1 +
 drivers/nvme/host/pci.c     | 252 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/devcoredump.h |  33 ++++++
 4 files changed, 387 insertions(+), 72 deletions(-)

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
-- 
2.7.4

