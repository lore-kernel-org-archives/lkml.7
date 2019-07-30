Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45032C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6720651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z551vjfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfG3Jrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:47:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfG3Jra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:47:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so65004510wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=6PuYspoDybeXNpQFC+ln8IGotsrBBPnPAvGZte3Try4=;
        b=Z551vjfbELmdnMj2C0YudUQ71rmPynbSof1ghgeEX0Ld2rFfzQ2UfQ3tEIcUbR1pSG
         xX8LmcfclH/bRyEIC554c9Gn2qeJhLzPD53jR+fArMPcgbQJ9UOzE7RaOhm2+7Thi65+
         cIwwkiP6im93P/SevpMtkdDBRyKgStArk794uWMs+MD13OSPnaulyY/wbCv39DQChYf2
         q6duAe1OS3f1qUXA3vFD18QHrMdlChG2L94BW4F++lKE0UBFORjRB8hBRZCU7cIka/zj
         gIh4uThQEauKe5kv1cykNJxFcv6dt26THJrnrmopTXvLYEi0zRIR5lfdSJrW8ZQ2i5QQ
         KyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=6PuYspoDybeXNpQFC+ln8IGotsrBBPnPAvGZte3Try4=;
        b=FqkxqTVGmkaAxN/HIKZNzETcOnV3tYjLcSVCtoKeZMlU0kbPFIiUCp0uGV+OIjwMQ6
         mSircCqmbxAqZdYfzpjqEJBycPUoP7jdqyKrMUS3PJtOfFve5R4Dkq/jm1fVePeYdMCc
         lKcfzvmUxPSPLsyYRfKFnvGVWnjUASpJNheVcEYnkBIAo67XcqN2TE0y3we+ZG88s75B
         W66ovaR3EaWIvdSivMhVXuCp7gXfs8sgkj8rx6WhHmWQJGcmyuUqHz4kXulRxY43FJdi
         oJlF8Gy0JlFLfTb2q4gaPmR2x5uCyLZ5CtCV8fs0Y8y0BAQ/Vthz3adto31SuPk2zmyC
         zbDw==
X-Gm-Message-State: APjAAAX7NU7EGmuAHYFNCoUs874xwwpZciZoxqroAGZnNCRXe+QwMmmP
        GaQUDCqxfWZSvR4K+FyFYrpCnvespJU=
X-Google-Smtp-Source: APXvYqz7BmyPYspxERlHKFvofozU5XWk6igkKNtLG3fVMQID3x5JLKFBySgU96IXfWErI/PwmuChQw==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr5409514wrw.138.1564480047345;
        Tue, 30 Jul 2019 02:47:27 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k124sm105967360wmk.47.2019.07.30.02.47.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:47:26 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v2 0/7] habanalabs: support info queries by multiple processes
Date:   Tue, 30 Jul 2019 12:47:17 +0300
Message-Id: <20190730094724.18691-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, the driver allows only a single user application (the deep-learning
application) to perform queries of the device's stats, information, idle
state and more.

This is a serious limitation in data centers, where there are
multiple system/monitorining applications that want to continuously
retrieve that information, while allowing the deep-learning application to
perform work on the device.

This patch-set allows unlimited number of user applications to perform
the above queries (by calling the INFO IOCTL), while the deep-learning
application is running.

This is done by creating an additional char device per ASIC, that is
dedicated to information retrieval only (allows only to call the INFO
IOCTL). This method will maintain backward compatibility with existing
userspace applications.

- Patches 1-4 makes small improvements to existing code.
- Patch 5 removes the accounting of the number of open file-descriptors
  and replace it with tracking of the driver's internal file private data
  strcuture.
- Patch 6 is a pre-requisite to creating the two char devices
- Patch 7 introduce the additional char device

Thanks,
Oded

Oded Gabbay (7):
  habanalabs: add handle field to context structure
  habanalabs: kill user process after CS rollback
  habanalabs: show the process context dram usage
  habanalabs: rename user_ctx as compute_ctx
  habanalabs: maintain a list of file private data objects
  habanalabs: change device_setup_cdev() to be more generic
  habanalabs: create two char devices per ASIC

 drivers/misc/habanalabs/context.c          |  38 +--
 drivers/misc/habanalabs/debugfs.c          |   4 +-
 drivers/misc/habanalabs/device.c           | 256 ++++++++++++---------
 drivers/misc/habanalabs/goya/goya_hwmgr.c  |  11 +-
 drivers/misc/habanalabs/habanalabs.h       |  53 +++--
 drivers/misc/habanalabs/habanalabs_drv.c   | 125 ++++++----
 drivers/misc/habanalabs/habanalabs_ioctl.c | 104 ++++++---
 7 files changed, 374 insertions(+), 217 deletions(-)

-- 
2.17.1

