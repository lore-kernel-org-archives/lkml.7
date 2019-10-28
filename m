Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FFECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DC3214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaLQXQPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404202AbfJ1RqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:46:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34781 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfJ1RqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:46:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so10864910wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DbABi5RKgXPdp/kMNJNlgYtEDfXwd3wc9SWHhA53KMM=;
        b=BaLQXQPFYkw3OSp7BsP2kwkJrtahNYp2/gHTinxoQwjMpLQ0NPWPPSXUeczfD1YKA1
         oflerUfRLeHlreV956xjXyBtx1XQWfqFzmxqwZh69lfG+qpQwpbM3s6eygCvmX1XyDKi
         Y0QJ51nT+k7XwTZ6/WsdyCYPDeLBcMaa8KndaMK1VQuwkFGEtpZftOS987Nvvt1D54xM
         I68LIA74JrZb3eqQVR78Qf/2OyMiGmKV5NdO9YoQYDd6DnBegBzHMZWEM24g8i+9dm6g
         75cWgTNBJBEYYNncKfT85+sEVySSehkU5vZh3fxCJ2vKdz275Q33LD30vI8jg9TA4Li6
         qtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DbABi5RKgXPdp/kMNJNlgYtEDfXwd3wc9SWHhA53KMM=;
        b=D8Lghz9wOPc6Q7uN0kLnyO9cGI/K6azkcVtRW/QM/c3kxZDUqsmDIOu8TQX0SNtOtj
         yzVBT444YcMayGcBr2iGrPbKlv9K4i2TdM8tXcDY9jkqJ4BlaNZ6NQAvV1wTyW54AdDv
         lDt6WV+PTk+sfGX7I8fPX596nTPDHncIkLRYDVjVo2PQ7+nNKCfRzyzmlPkuoJqJRahv
         yrlf6PP0GNFyqR0fpzsWSMgvcuXl8pBxBbnIVP2QUFJPBVqZIwtrHk213uski8DFQJpo
         t77c4GMeoWsyoEKiF3hOVKkc/iD5BlXui3aYeT7H6ugSSUPwlexdBhMWm23vBYFuB5U2
         o4wg==
X-Gm-Message-State: APjAAAV0v33HZubdhRk5m5MnRmCpFpmitatyjS1/EADXl6Gk95HHrMWJ
        HeiE32vsCVfSDK2WBBzS6RCevrRBfHAyuA==
X-Google-Smtp-Source: APXvYqypFa/aBrJCROKvL8/ywtkdbbVNi5WAQQZYuunYe8S+qOPSHFTPtKOTP7qBp9Tl/y5vCciwog==
X-Received: by 2002:a05:6000:1051:: with SMTP id c17mr15520745wrx.124.1572284767894;
        Mon, 28 Oct 2019 10:46:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 26sm290047wmi.17.2019.10.28.10.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 10:46:07 -0700 (PDT)
Date:   Mon, 28 Oct 2019 17:46:03 +0000
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, aaron.lwe@gmail.com,
        valentin.schneider@arm.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
Subject: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191028174603.GA246917@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following issue has been observed with 5.4-rc*-based android
kernels both on an x86 VM and native arm64:

---8<---
[  222.515957] BUG: kernel NULL pointer dereference, address: 0000000000000040
[  222.518871] #PF: supervisor read access in kernel mode
[  222.518871] #PF: error_code(0x0000) - not-present page
[  222.518871] PGD 800000007cdf7067 P4D 800000007cdf7067 PUD 7c868067 PMD 0 
[  222.518871] Oops: 0000 [#1] PREEMPT SMP PTI
[  222.518871] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.4.0-rc4-mainline-g6a9b34166c05 #1
[  222.518871] Hardware name: ChromiumOS crosvm, BIOS 0 
[  222.518871] RIP: 0010:set_next_entity+0xf/0xf0
[  222.518871] Code: 42 0b e5 85 31 c0 e8 90 1a fc ff 0f 0b eb 9b 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 41 56 53 48 89 f3 49 89 fe <83> 7e 40 00 74 3d 4c 89 f7 48 89 de e8 80 f9 ff ff 4c 8d 7b 18 4d
[  222.518871] RSP: 0018:ffffb95040073de8 EFLAGS: 00010046
[  222.518871] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff85ec0c30
[  222.518871] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9ec44c728500
[  222.518871] RBP: ffffb95040073e00 R08: 0000000000000000 R09: 0000000000000000
[  222.518871] R10: 0000000000000000 R11: ffffffff84ef0a30 R12: 0000000000000000
[  222.518871] R13: 0000000000000000 R14: ffff9ec44c728500 R15: ffffb95040073e60
[  222.518871] FS:  0000000000000000(0000) GS:ffff9ec44c700000(0000) knlGS:0000000000000000
[  222.518871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  222.518871] CR2: 0000000000000040 CR3: 000000007c87a002 CR4: 00000000003606e0
[  222.518871] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  222.518871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  222.518871] Call Trace:
[  222.518871]  pick_next_task_fair+0xe8/0x410
[  222.518871]  ? rcu_note_context_switch+0x3ef/0x520
[  222.518871]  ? finish_task_switch+0x10d/0x250
[  222.518871]  __schedule+0x1f8/0x6e0
[  222.518871]  schedule_idle+0x27/0x40
[  222.518871]  do_idle+0x21c/0x240
[  222.518871]  cpu_startup_entry+0x25/0x30
[  222.518871]  start_secondary+0x18d/0x1b0
[  222.518871]  secondary_startup_64+0xa4/0xb0
[  222.518871] Modules linked in: vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock_diag vsock can_raw can snd_intel8x0 snd_ac97_codec ac97_bus virtio_input virtio_pci virtio_mmio virtio_crypto mmc_block mmc_core dummy_cpufreq rtc_test dummy_hcd can_dev vcan virtio_net net_failover failover virt_wifi virtio_blk virtio_gpu ttm virtio_rng virtio_ring virtio 8250_of crypto_engine
[  222.518871] CR2: 0000000000000040
[  222.518871] ---[ end trace ae741809965b22f2 ]---
[  222.518871] RIP: 0010:set_next_entity+0xf/0xf0
[  222.518871] Code: 42 0b e5 85 31 c0 e8 90 1a fc ff 0f 0b eb 9b 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 41 56 53 48 89 f3 49 89 fe <83> 7e 40 00 74 3d 4c 89 f7 48 89 de e8 80 f9 ff ff 4c 8d 7b 18 4d
[  222.518871] RSP: 0018:ffffb95040073de8 EFLAGS: 00010046
[  222.518871] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff85ec0c30
[  222.518871] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9ec44c728500
[  222.518871] RBP: ffffb95040073e00 R08: 0000000000000000 R09: 0000000000000000
[  222.518871] R10: 0000000000000000 R11: ffffffff84ef0a30 R12: 0000000000000000
[  222.518871] R13: 0000000000000000 R14: ffff9ec44c728500 R15: ffffb95040073e60
[  222.518871] FS:  0000000000000000(0000) GS:ffff9ec44c700000(0000) knlGS:0000000000000000
[  222.518871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  222.518871] CR2: 0000000000000040 CR3: 000000007c87a002 CR4: 00000000003606e0
[  222.518871] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  222.518871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  222.518871] Kernel panic - not syncing: Fatal exception
[  222.518871] Kernel Offset: 0x3e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
--->8---

The issue is very transient and relatively hard to reproduce.

After digging a bit, the offending commit seems to be:

    67692435c411 ("sched: Rework pick_next_task() slow-path")

By 'offending' I mean that reverting it makes the issue go away. The
issue comes from the fact that pick_next_entity() returns a NULL se in
the 'simple' path of pick_next_task_fair(), which causes obvious
problems in the subsequent call to set_next_entity().

I'll dig more, but if anybody understands the issue in the meatime feel
free to send me a patch to try out :)

Thanks,
Quentin
