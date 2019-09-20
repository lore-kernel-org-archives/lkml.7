Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D25C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A537208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DEacpKnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfITU0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:26:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45172 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfITU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:26:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so10097684qtj.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=VRsyGDeb9R/uhxLrzbzo7A02ki7s9rOkj4n2kKbCZWg=;
        b=DEacpKnlBfwxkcPbb8gICvQhBQxqwryBAVa1F9KgqMI/eOwvnVea27HH6pMU04pl2J
         BwNVr/gmS/9HT4m3qjKC5gV+yaKFoLHyLiW0Sbuma+4MbxBkhv1OmPSG5EDMrbCX2aHk
         kFMyD4B9F4eOeowCJ2ZdWAsxkji34kS0EBLeNUtnFRq0QlJ0Oods6PixvSuK7MD+8vb1
         XArFn+i6C/u76uPrF5z0wMfr8jNuzWxECB26URZ5cH8eUWZb+A4xxui27t6kIBL/OfP4
         amrXwasgCMw0Om60EMGOsAzZU6h2zXLwfwIWEac5lIzcFvxxZ3iCSU3h2mYytV7O5NmC
         Xigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=VRsyGDeb9R/uhxLrzbzo7A02ki7s9rOkj4n2kKbCZWg=;
        b=ZbAG2qXFzsBg1+LtXBwI0GEByhkAWvaIQLamze0UfWw+vsL6+rtfmOj4ztDZLnKQ9g
         LbejmazR31TJiGGEQUXixL3nMLd0mZYUt3ifivKkHtEVvXxpd80TGIlkS96lv6wfLD3g
         n+I6DXalZX86kXLRz7azESdi6KpBsRgTb/xEATl5KtcUrM0A4PXm4eh7hSB7Gopz9/fs
         YCmBlsl5O+T9qI/0Ihror5mcR40ZecdMwF1tdn/MEktYn9wdbj6Aim/yqp+cgX6ZBwwB
         x0wuuL4gq15mxMg1adYP30RQ7Q+b/5MDIxjr4oCtYJfZfrWZnsJrr6tK57GnxM/Q0FPP
         VRmQ==
X-Gm-Message-State: APjAAAUDB62uLseAbk9+Fz2RirHzhixj1ciNTdC1MmN4buw+7aMomIKN
        Qo1Gj/FV6xaNiDBD267oQbd0bQ==
X-Google-Smtp-Source: APXvYqwvdEOvPTyF2/FF1Xyi8f53x0fUiTK6UxQ9CYAlzKYH5G2RTlLya93bx+uRVtYelmLKcglSnA==
X-Received: by 2002:aed:2381:: with SMTP id j1mr5285735qtc.373.1569011163865;
        Fri, 20 Sep 2019 13:26:03 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j5sm1490750qkd.56.2019.09.20.13.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 13:26:02 -0700 (PDT)
Message-ID: <1569011160.5576.205.camel@lca.pw>
Subject: "Fix spurious sanity check failures in destroy_workqueue()"
 introduced memory leaks
From:   Qian Cai <cai@lca.pw>
To:     Tejun Heo <tj@kernel.org>
Cc:     Marcin Pawlowski <mpawlowski@fb.com>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 20 Sep 2019 16:26:00 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit [1] introduced a lot of memory leaks while running LTP fs
tests (/opt/ltp/runltp -f fs). Reverted the commit fixed the problem. It seems
the new code wq->rescuer to NULL without free it first, so later rcu_free_wq()
is unable to free it.

unreferenced object 0xffff8f822e7c8428 (size 192):
  comm "fs_fill", pid 8310, jiffies 4294965449 (age 494.720s)
  hex dump (first 32 bytes):
    28 84 7c 2e 82 8f ff ff 28 84 7c 2e 82 8f ff ff  (.|.....(.|.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000030795d2f>] kmem_cache_alloc_node_trace+0x153/0x470
    [<000000000398512e>] alloc_worker+0x21/0x50
    [<000000001934cb3a>] init_rescuer.part.4+0x1d/0xb0
    [<00000000f36417e5>] alloc_workqueue+0x336/0x5f3
    [<0000000011066bf3>] ext4_fill_super+0x1eec/0x2f70 [ext4]
    [<000000001fdee6fd>] mount_bdev+0x191/0x1c0
    [<00000000e2d3e265>] ext4_mount+0x15/0x20 [ext4]
    [<00000000631fe1d9>] legacy_get_tree+0x34/0x60
    [<00000000ee947c38>] vfs_get_tree+0x27/0xb0
    [<00000000f4bcb594>] do_mount+0x8a0/0xae0
    [<0000000005dd5056>] ksys_mount+0xb6/0xd0
    [<00000000fb14e10a>] __x64_sys_mount+0x25/0x30
    [<000000009fb1dd3e>] do_syscall_64+0x6d/0x488
    [<00000000a822a6c4>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
unreferenced object 0xffff8f824c314218 (size 192):
  comm "fs_fill", pid 8310, jiffies 4294966011 (age 489.100s)
  hex dump (first 32 bytes):
    18 42 31 4c 82 8f ff ff 18 42 31 4c 82 8f ff ff  .B1L.....B1L....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000030795d2f>] kmem_cache_alloc_node_trace+0x153/0x470
    [<000000000398512e>] alloc_worker+0x21/0x50
    [<000000001934cb3a>] init_rescuer.part.4+0x1d/0xb0
    [<00000000f36417e5>] alloc_workqueue+0x336/0x5f3
    [<000000000b6d2e88>] xfs_init_mount_workqueues+0x2a/0x150 [xfs]
    [<0000000014c756cd>] xfs_fs_fill_super+0x311/0x760 [xfs]
    [<000000001fdee6fd>] mount_bdev+0x191/0x1c0
    [<00000000d0aa6706>] xfs_fs_mount+0x15/0x20 [xfs]
    [<00000000631fe1d9>] legacy_get_tree+0x34/0x60
    [<00000000ee947c38>] vfs_get_tree+0x27/0xb0
    [<00000000f4bcb594>] do_mount+0x8a0/0xae0
    [<0000000005dd5056>] ksys_mount+0xb6/0xd0
    [<00000000fb14e10a>] __x64_sys_mount+0x25/0x30
    [<000000009fb1dd3e>] do_syscall_64+0x6d/0x488
    [<00000000a822a6c4>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

[1] https://lore.kernel.org/lkml/20190919014340.GM3084169@devbig004.ftw2.faceboo
k.com/
