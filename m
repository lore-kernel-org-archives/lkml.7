Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF5C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2367220879
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="A3R14F4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfEYQFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:05:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44419 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfEYQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:05:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id g18so11336960otj.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=l19XRunZ4edmyDiZ8/eCl7rM5qgS/YH9jQvm1C3vHc0=;
        b=A3R14F4IdcV5sGeshPkMMlET6bqHANhBQb2J1bCY9X4ch70IWyGnvHDaWX7d/Mp9Hp
         079KwzmPK2FQg0CKC4tmO05nGMcJDwLLCcUXRJCjur91/spbZ+8t1wyYdfue3wSQR/bI
         rzz5FyPKSdgU5EZd67GNobxk3dpzASrGl/OQyjqlRV0tOj1qXaEiTpa2uhaIdr8CfPcf
         4NR2FhFt9nxCD0WYLWKucNTfXEL208ZaFL8Jr6G8nuln3V0oAoIaAMIK6qrEkWBmb8S8
         bobds6NAOD3zO8pK0cz+ipbFoYEH4f4ObUqbSIr9KIUzJmXO31+WLiZIgH7hMWFOvsHC
         u4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=l19XRunZ4edmyDiZ8/eCl7rM5qgS/YH9jQvm1C3vHc0=;
        b=dWsTby9t5qT2ujCPoGzHw0Glk91uYoY6jFrxdqLoQB4vd4dMfMH4YjeT0t9hl2QgQw
         vZpv6vQ7u4/1/yGHqwgwZ3qGNIZSN0Zc4SEyA46ijEEKIXT3JrSS/19ln/7omL1GcsqS
         O6kxPGPAofNtZ5PeAn+IKtSvoiJ209tuP720O5tw2cs0M85yC+/2xy18sj4jQl1K6tpN
         02xMxQmhfFaqwQ6QWP+V9lMfOE73FEeJlm6UX9BMqID9WW5ABMQ66aSkanN8JPJlElRK
         NF4yGixnIG771SOZ48BFNzceMFIs9aYIYV0aDwns/TIAtlAmOlQqGC+UO1YC/Acf37sd
         l10Q==
X-Gm-Message-State: APjAAAW22MWgx4kEfhzvlIpXq/XNbQgGpS/shGrmeDXSYTXMmDC4FKyo
        QREgdtwQORriZdMCD/5qyZLxOgOyq/u6GbdeiBDco1w5pNc=
X-Google-Smtp-Source: APXvYqzCSOOpLKL4h1itEOlv/uZne/4BHXc4Cc3fThbuUcmz5bHH1XQuhj/0zSI48i6WyVWu0nKtZVfmMlH6epbuGBk=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr841087otr.207.1558800314745;
 Sat, 25 May 2019 09:05:14 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 25 May 2019 09:05:03 -0700
Message-ID: <CAPcyv4ghA3bGeTFw+wVV5N8cb-izpwdi9BQU5Ec6wNTw8ZywMw@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.2-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.2-rc2

...to receive a regression fix, a small (2 line code change)
performance enhancement, and some miscellaneous compilation warning
fixes. These have soaked in -next the past week with no known issues.
The device-mapper touches have Mike's ack, and the hardened user-copy
bypass was reviewed with Kees.

---

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.2-rc2

for you to fetch changes up to 52f476a323f9efc959be1c890d0cdcf12e1582e0:

  libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead (2019-05-20
20:43:32 -0700)

----------------------------------------------------------------
libnvdimm fixes v5.2-rc2

- Fix a regression that disabled device-mapper dax support

- Remove unnecessary hardened-user-copy overhead (>30%) for dax
  read(2)/write(2).

- Fix some compilation warnings.

----------------------------------------------------------------
Dan Williams (2):
      dax: Arrange for dax_supported check to span multiple devices
      libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead

Qian Cai (1):
      libnvdimm: Fix compilation warnings with W=1

 drivers/dax/super.c          | 88 ++++++++++++++++++++++++++++----------------
 drivers/md/dm-table.c        | 17 ++++++---
 drivers/md/dm.c              | 20 ++++++++++
 drivers/md/dm.h              |  1 +
 drivers/nvdimm/bus.c         |  4 +-
 drivers/nvdimm/label.c       |  2 +
 drivers/nvdimm/label.h       |  2 -
 drivers/nvdimm/pmem.c        | 11 +++++-
 drivers/s390/block/dcssblk.c |  1 +
 include/linux/dax.h          | 26 +++++++++++++
 10 files changed, 129 insertions(+), 43 deletions(-)
