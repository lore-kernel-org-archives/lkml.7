Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08311CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB87221D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYPTEufA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfJYXsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:48:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36877 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJYXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:48:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so2680233pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Bhq3e5+uTtbnGM7apONt9dMc+TmRaAuRWUEzjpFFxKA=;
        b=BYPTEufAVLkHLG6Q3wf3G8dMHPiwZIiYsyj+S/697RWsfwa4c9jd2jJRLAAI6tNE5/
         m6ooU4AS61vxB4eWwc/gMw0I6ZRirirCkWb6cNM3lEFq16sXWQZdsyUaXQyaNVlqWkRf
         BtdDVyXgRgcMr6T9KEd41anhcn1llPhz2mwydOKMwn6LTs2HQxcFMHkupJgq01MNgo4W
         5oz3n0ihU4nVYVEMw1Fn/wbsQ0VwgkpToV06QLqlc6ZrZ6QQM1+oRzY6c1z3qMdbCpN/
         /sWbw8DaH9fC5a72hETtdQHBjO7CoWh2mrjP+c5mf3RSONmIB2rOuPH3hdpu03xNcTGx
         VnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bhq3e5+uTtbnGM7apONt9dMc+TmRaAuRWUEzjpFFxKA=;
        b=cjC9ZyR/sQwRMpDbC97LC3WihukiQp7Mpxi6wDfhnphGL9nAczMTFZCzsHv4ethL/n
         Fs37nOeMtS8iXm1kwFO6rJXd85NO6OoUZ7jbkCR2TPgC1NsvI6k8kZhagCh0l1/aoz6i
         lhvHAwmgpG9Y5416UTbIXXVeeRSkeG43btmjqHN/EYGxeIlE2G/HyR0yCyH9Ng45SoI5
         ql0J3eQ/B0XOtXbSJw9nMtAc3NW7NnZDbkwUFZnqjtSBNzSVqT7mNIDbXDuxMXLi5enM
         qC/qOOzMjws7sd8dd3iVouVH4yKnz1Rw/z/3a/hO8fFSiitoS5jmpbH8Nt7/OHYMSNcT
         0Pyg==
X-Gm-Message-State: APjAAAVPQDALn7ZRekHdCjm198LgIsdI3u6Tteyvcy8qhrHMZRYslAH4
        A0JbgZ9N7S/x87pfaQ+/ziQXIDmQepQ=
X-Google-Smtp-Source: APXvYqxK5zzLBLTheaoqGS6HUi/9jdNBz4CMzP1n1AQBGIWin5A7To0oQJs4sRbfzAk1m2zELppMdw==
X-Received: by 2002:a62:4d04:: with SMTP id a4mr7431646pfb.71.1572047318043;
        Fri, 25 Oct 2019 16:48:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id cx22sm2817179pjb.19.2019.10.25.16.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 16:48:37 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 0/2] Allow DMA BUF heaps to be loaded as modules
Date:   Fri, 25 Oct 2019 23:48:32 +0000
Message-Id: <20191025234834.28214-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the DMA BUF heaps core code has been queued, I wanted
to send out some of the pending changes that I've been working
on.

For use with Android and their GKI effort, it is desired that
DMA BUF heaps are able to be loaded as modules. This is required
for migrating vendors off of ION which was also recently changed
to support modules.

So this patch series simply provides the necessary exported
symbols and allows the system and CMA drivers to be built
as modules.

Due to the fact that dmabuf's allocated from a heap may
be in use for quite some time, there isn't a way to safely
unload the driver once it has been loaded. Thus these
drivers do no implement module_exit() functions and will
show up in lsmod as "[permanent]"

Feedback and thoughts on this would be greatly appreciated!

thanks
-john

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yue Hu <huyue2@yulong.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: dri-devel@lists.freedesktop.org

John Stultz (1):
  dma-buf: heaps: Allow system & cma heaps to be configured as a modules

Sandeep Patil (1):
  mm: cma: Export cma symbols for cma heap as a module

 drivers/dma-buf/dma-heap.c           | 2 ++
 drivers/dma-buf/heaps/Kconfig        | 4 ++--
 drivers/dma-buf/heaps/heap-helpers.c | 2 ++
 kernel/dma/contiguous.c              | 1 +
 mm/cma.c                             | 5 +++++
 5 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.17.1

