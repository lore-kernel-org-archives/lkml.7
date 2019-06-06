Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F7C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE9F208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Od4/Zms7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfFFVOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 17:14:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43086 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfFFVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:14:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so2418377qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=4tzj6zPhT1KdbSrSSR8kBzCJNbXG0KIlt9cGXnaclK4=;
        b=Od4/Zms7qPAZjXes4tQaOJuRZQ4nTLVj4JHC/VRP62XKlWIkgoId1L0gDrYI0upo3Q
         MKL5z/D7EKHlp+2z5LFhIBY29JK5PfXXQX90rbgU4qF+u+9xquvqRVntbfH50/MGohoh
         duZJZg5ha27LSaG0Lwz6HPEL3cS7qVVR+eNIp7LMoXwWpf/nWLE59wbi/J80b7/Y4mUp
         OuwOgWWy6Dhi3DUV3xpLqlf9hfR7qV1r0pUN0HaU57otBERzexLaj+ofdMEq5TNCzr5h
         msQq849jPxf36Tnw/WjR6lkFXwfVfHQLWqQL0WMFnCjajn6rC9xUJ15JHzNeoC9bmmds
         5AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=4tzj6zPhT1KdbSrSSR8kBzCJNbXG0KIlt9cGXnaclK4=;
        b=tNiU3/GFu5MZOH8W1fBd3Xf7plJISs6rlio8CaZsTYGozX2fmz64FVP8rdYt/fnccv
         z5UJ9K4X3I5+qFcMy4nDYWOEnfn1yy1mXKP1TFhBd0uZWy0EP5PHop7Mh0tJm3L6BFJW
         ZkUKINWNM/qTQz0PnTcPHhBVBMKEKI48k523TJFhC5ADnqyTazVahEX+24UI54wm3gUh
         oa42HbF0HVz2e36X/8NK01KPBaZOlWKqzar2A3k/HFPtOJ7ud5fqm/G/vyMVG0LeQbt6
         YKNDE1M2tt58UPxyKfQuedjgRNWjGR4Bkr5I7WVUnp0LaFebFYvsutXIRUzZbp3AUy0v
         Qnhg==
X-Gm-Message-State: APjAAAXn9eCHCnlpbninbUdTQWGuo0Yp2AWlPmnwbw2IgQfiV5o8h+qM
        4FfIwEdkRUqj+MqiYfP0Eif5CA==
X-Google-Smtp-Source: APXvYqydvG1nnTKvPNQw0gMJxfji0CL9Nl6m9nNeJFZ2COEu7Xq+dkCfa2DLi/cIbK4Tl/P8xi5Hmw==
X-Received: by 2002:a37:a4d3:: with SMTP id n202mr39720518qke.84.1559855692552;
        Thu, 06 Jun 2019 14:14:52 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m21sm30540qtp.92.2019.06.06.14.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 14:14:51 -0700 (PDT)
Message-ID: <1559855690.6132.50.camel@lca.pw>
Subject: "locking/lockdep: Consolidate lock usage bit initialization" is
 buggy
From:   Qian Cai <cai@lca.pw>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Jun 2019 17:14:50 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "locking/lockdep: Consolidate lock usage bit
initialization" [1] will always generate a warning below. Looking through the
commit that when mark_irqflags() returns 1 and check = 1, it will do one less
mark_lock() call than it used to.

[1] https://lore.kernel.org/lkml/tip-091806515124b20f8cff7927b4b7ff399483b109@gi
t.kernel.org/

# cat /proc/lockdep_stats,

[ 7410.877772] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) !=
nr_unused)
[ 7410.877798] WARNING: CPU: 58 PID: 126655 at kernel/locking/lockdep_proc.c:249
lockdep_stats_show+0xe44/0x11e0
[ 7410.877841] Modules linked in: brd ext4 crc16 mbcache jbd2 loop i2c_opal
i2c_core ip_tables x_tables xfs sd_mod bnx2x ahci mdio libahci tg3 libphy libata
firmware_class dm_mirror dm_region_hash dm_log dm_mod [last unloaded:
dummy_del_mod]
[ 7410.877954] CPU: 58 PID: 126655 Comm: proc01 Tainted:
G        W  O      5.2.0-rc3-next-20190606+ #2
[ 7410.877987] NIP:  c0000000001a4ae4 LR: c0000000001a4ae0 CTR: c0000000008afa30
[ 7410.878027] REGS: c00000176c5af8e0 TRAP: 0700   Tainted:
G        W  O       (5.2.0-rc3-next-20190606+)
[ 7410.878059] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
28888402  XER: 20040000
[ 7410.878101] CFAR: c000000000118c44 IRQMASK: 0 
               GPR00: c0000000001a4ae0 c00000176c5afb70 c0000000016e5400
0000000000000044 
               GPR04: c00000000171c250 c0000000001b44e8 4e5241575f534b43
75626564284e4f5f 
               GPR08: 0000001ffdf50000 0000000000000000 0000000000000000
212029736b636f6c 
               GPR12: 756e755f726e203d c000001ffffcfe00 0000000000000000
c0000000015ad1d0 
               GPR16: 0000000000000000 0000000000000000 0000000000000000
0000000000000dd7 
               GPR20: 0000000000000000 0000000000000000 0000000000000000
0000000000000000 
               GPR24: 0000000000000000 0000000000000000 0000000000000000
c00000079dd0e158 
               GPR28: 0000000000000000 c00000000171c270 c00000000171c4c4
c00000000171ba18 
[ 7410.878371] NIP [c0000000001a4ae4] lockdep_stats_show+0xe44/0x11e0
[ 7410.878406] LR [c0000000001a4ae0] lockdep_stats_show+0xe40/0x11e0
[ 7410.878443] Call Trace:
[ 7410.878468] [c00000176c5afb70] [c0000000001a4ae0]
lockdep_stats_show+0xe40/0x11e0 (unreliable)
[ 7410.878529] [c00000176c5afca0] [c000000000489c34] seq_read+0x1d4/0x620
[ 7410.878581] [c00000176c5afd30] [c00000000050cd40] proc_reg_read+0x90/0x130
[ 7410.878622] [c00000176c5afd60] [c00000000044b1cc] __vfs_read+0x3c/0x70
[ 7410.878653] [c00000176c5afd80] [c00000000044b2bc] vfs_read+0xbc/0x1a0
[ 7410.878680] [c00000176c5afdd0] [c00000000044b74c] ksys_read+0x7c/0x140
[ 7410.878722] [c00000176c5afe20] [c00000000000b108] system_call+0x5c/0x70
[ 7410.878773] Instruction dump:
[ 7410.878798] 419ef3b0 3d220004 3929abfc 81290000 2f890000 409ef39c 3c82ff33
3c62ff33 
[ 7410.878843] 38840a98 3863f8a8 4bf74101 60000000 <0fe00000> 4bfff37c 60000000
39200000 
[ 7410.878887] ---[ end trace 6a712a083aa01d23 ]---
