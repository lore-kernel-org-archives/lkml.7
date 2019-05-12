Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C361C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3992E2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="VnNY2xBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfELI16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 04:27:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35815 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfELI15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 04:27:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id a132so7325663oib.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=DlXa4/IDAtqzy1BADwhitk4qAdknizi2RhvPYQe4tJw=;
        b=VnNY2xBao0SNSTduZXwPtnr5p6UIiP/diuZw6CSI8//cvX0SP0aiRO+Okrk+LZ3A2X
         zHQniQXRHqnPY+cXouzrfrxa9SPDum/pwFDH6GvmAZ0svm+WesPkRUfF0pUnHbeww2uN
         /f429uWG7cTMUGg2plfgvV7LYcOEJuvI+pDyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DlXa4/IDAtqzy1BADwhitk4qAdknizi2RhvPYQe4tJw=;
        b=Jukt2qP338EI0c76uYcsWKaYBiN4Sfo//bzzcpnsfmaDS+Z0ssAStFszB7W+mi1TfQ
         7tqgnaIoh1XhCPGoaP5gJxfw912C1jIbMv1EKi2MUzxZJ2bMZhQRzrmBJyPMtU1ReLGU
         Sje5uVFr66jKMR9xmN7QktRQ5FyWSoylvQkYLt+LXPYJWHUAbge+mlTc1eIHpE9IZqxA
         TN3emHjT5+4OMC8UfR6LQ54XbP8R20Bi1K/fPx9lr3KgxG1yNPaWsRdFj7D0NST/347c
         cZjZmpEHY4js4v32P9TrdsY3IWFk8imU+Cq5LSdSu/wG1MtoAXQSecpvJ/jVJgZ9GWn8
         Rk5A==
X-Gm-Message-State: APjAAAXE6hFXo2FR7crk2WwOROQyCO7r532HFrL1RdhoJ39leV8Yuo1I
        S3DxckzhkNS6xwFhB5Ej8ewl8Vf31b3H/5zUL0oS8+Uxh4DCjA==
X-Google-Smtp-Source: APXvYqy3E1/9sq5tTkY/wIh57Jd5injZb6ZolNwbejv9asXVuh++LZXOLnHGxbVpAVuqkNJqozoGLud+mwLu3ii4UJY=
X-Received: by 2002:aca:a846:: with SMTP id r67mr10084000oie.104.1557649676637;
 Sun, 12 May 2019 01:27:56 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Sun, 12 May 2019 04:27:45 -0400
Message-ID: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
Subject: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at ffffea0002030000
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've turned off zram/zswap and I am still seeing the following during
periods of heavy I/O, I am returning to 5.0.xx in the meantime.

Kernel: 5.1.1
Arch: x86_64
Dist: Debian x86_64

[29967.019411] BUG: unable to handle kernel paging request at ffffea0002030000
[29967.019414] #PF error: [normal kernel read fault]
[29967.019415] PGD 103ffee067 P4D 103ffee067 PUD 103ffed067 PMD 0
[29967.019417] Oops: 0000 [#1] SMP PTI
[29967.019419] CPU: 10 PID: 77 Comm: khugepaged Tainted: G
   T 5.1.1 #4
[29967.019420] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.2 01/16/2015
[29967.019424] RIP: 0010:isolate_freepages_block+0xb9/0x310
[29967.019425] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
0f 84
[29967.019426] RSP: 0018:ffffc900003a7860 EFLAGS: 00010246
[29967.019427] RAX: 0000000000000000 RBX: ffffea0002030000 RCX: ffffc900003a7b69
[29967.019428] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff828c4750
[29967.019429] RBP: 0000000000080c00 R08: 0000000000000001 R09: 0000000000000000
[29967.019429] R10: 0000000000000206 R11: ffffffff828c4390 R12: 0000000000000000
[29967.019430] R13: 0000000000000000 R14: ffffc900003a7af0 R15: 0000000000000000
[29967.019431] FS:  0000000000000000(0000) GS:ffff88903fa80000(0000)
knlGS:0000000000000000
[29967.019432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29967.019432] CR2: ffffea0002030000 CR3: 000000000280e001 CR4: 00000000001606e0
[29967.019433] Call Trace:
[29967.019436]  compaction_alloc+0x83d/0x8d0
[29967.019439]  migrate_pages+0x30d/0x750
[29967.019441]  ? isolate_migratepages_block+0xa10/0xa10
[29967.019442]  ? __reset_isolation_suitable+0x110/0x110
[29967.019443]  compact_zone+0x684/0xa70
[29967.019445]  compact_zone_order+0x109/0x150
[29967.019447]  ? schedule_timeout+0x1ba/0x290
[29967.019461]  ? record_times+0x13/0xa0
[29967.019462]  try_to_compact_pages+0x10d/0x220
[29967.019465]  __alloc_pages_direct_compact+0x93/0x180
[29967.019466]  __alloc_pages_nodemask+0x6c7/0xe20
[29967.019469]  ? __wake_up_common_lock+0xb0/0xb0
[29967.019470]  khugepaged+0x31f/0x19c0
[29967.019472]  ? __wake_up_common_lock+0xb0/0xb0
[29967.019473]  ? collapse_shmem.isra.4+0xc20/0xc20
[29967.019476]  kthread+0x100/0x120
[29967.019478]  ? __kthread_create_on_node+0x1b0/0x1b0
[29967.019480]  ret_from_fork+0x35/0x40
[29967.019481] CR2: ffffea0002030000
[29967.019482] ---[ end trace 8a9801ed5e182a98 ]---
[29967.019484] RIP: 0010:isolate_freepages_block+0xb9/0x310
[29967.019484] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
0f 84
[29967.019485] RSP: 0018:ffffc900003a7860 EFLAGS: 00010246
[29967.019486] RAX: 0000000000000000 RBX: ffffea0002030000 RCX: ffffc900003a7b69
[29967.019487] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff828c4750
[29967.019487] RBP: 0000000000080c00 R08: 0000000000000001 R09: 0000000000000000
[29967.019488] R10: 0000000000000206 R11: ffffffff828c4390 R12: 0000000000000000
[29967.019489] R13: 0000000000000000 R14: ffffc900003a7af0 R15: 0000000000000000
[29967.019489] FS:  0000000000000000(0000) GS:ffff88903fa80000(0000)
knlGS:0000000000000000
[29967.019490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29967.019491] CR2: ffffea0002030000 CR3: 000000000280e001 CR4: 00000000001606e0

Thanks,

Justin.
