Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD7A20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NnXmTpqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCGKlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:41:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39840 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfCGKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:41:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id g80so13756514ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=FmKqf8Qx+aeDYJzAPrG2yIdD/YOidKxuBrQ+FK04hyg=;
        b=NnXmTpqrlNyjkVLp1IgfJCDqgQ403RRkL80Yv11InEVfVaqRmes52gNov8kBWsFUqS
         mFrK79F/PaSRHHRT3Wp76wKIeRV2XbUmjR2g+fjZ9V93dsslkN7q1oODRNnntGHmx7+P
         0qtmMf92xb5NTR2fdc9NZGa7UPkuv1b/cfYds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=FmKqf8Qx+aeDYJzAPrG2yIdD/YOidKxuBrQ+FK04hyg=;
        b=NVLRKCVqwRc3JNpMF7ho07xnToAm4COPqH4ArxB155O0i4wZ1mjXkEx5YQOPldMrPS
         ykpJWyFCCgt9ihInAMfdHNrwR997qG8JU/2mWdOcos/uK5CqRiHfApP+OAf3uADivcHn
         UHxQxfsByUlLYiauNjaRX1OSuPiB+nj+dgFd4sooDzLURYhr8AjdpjRwPPqHyyWV169O
         CrFhqpUfD9IpToVN99FqytSr+lR8UVdvZM6bTHXUM2l9y/1DxE+kaqFLjywAWJWQUIbC
         SQrOowBlWvLkxTB/l75CdJGOAo5j1tCbQmaYDrXtyKT56G4q8bmIRP8SX0eXc392rzWl
         gWIw==
X-Gm-Message-State: APjAAAUCg1GGoVxmDImxZAZYUYfq8HgsHlQtmXBI/9T4PijhNZe6RZA0
        5U4vJyTEwFufLrCoIWXtzWitVA==
X-Google-Smtp-Source: APXvYqw/SF/pbg8Df90dtA6OoprpxXqhCjBdiRK8AVjorkcS3Kfl9JGXU6rO8c7GwAWDjIuRGET1kA==
X-Received: by 2002:a2e:965a:: with SMTP id z26mr4776295ljh.59.1551955271101;
        Thu, 07 Mar 2019 02:41:11 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id x87sm769865ljb.91.2019.03.07.02.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 02:41:10 -0800 (PST)
References: <20190304140551.GH25100@shao2-debian>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Marek Majkowski <marek@cloudflare.com>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [LKP] [sk_msg] 1d79895aef: WARNING:at_net/strparser/strparser.c:#strp_done
In-reply-to: <20190304140551.GH25100@shao2-debian>
Date:   Thu, 07 Mar 2019 11:41:09 +0100
Message-ID: <87d0n3ynju.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 03:05 PM CET, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 1d79895aef18fa05789995d86d523c9b2ee58a02 ("sk_msg: Always cancel strp work before freeing the psock")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git pending-fixes
>
> in testcase: kernel_selftests
> with following parameters:
>
> 	group: kselftests-00
>
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +-------------------------------------------------+------------+------------+
> |                                                 | 8c79b35693 | 1d79895aef |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 8          | 4          |
> | boot_failures                                   | 0          | 4          |
> | WARNING:at_net/strparser/strparser.c:#strp_done | 0          | 4          |
> | RIP:strp_done                                   | 0          | 4          |
> +-------------------------------------------------+------------+------------+
>
>
>
> [  103.644327] WARNING: CPU: 1 PID: 9646 at net/strparser/strparser.c:526 strp_done+0x3c/0x40
> [  103.644435] Fork 100 tasks to 'test_hashmap_walk'
> [  103.644438] 
> [  103.646486] Modules linked in: binfmt_misc crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sr_mod cdrom sg ppdev ata_generic pata_acpi aesni_intel crypto_simd cryptd glue_helper snd_pcm snd_timer snd soundcore pcspkr ata_piix serio_raw i2c_piix4 libata floppy parport_pc parport ip_tables
> [  103.653572] CPU: 1 PID: 9646 Comm: kworker/1:26 Not tainted 5.0.0-rc3-00017-g1d79895 #1
> [  103.655420] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  103.657321] Workqueue: events sk_psock_destroy_deferred
> [  103.658499] RIP: 0010:strp_done+0x3c/0x40
> [  103.659471] Code: 28 e8 b8 2d 6c ff 48 8d bb 80 00 00 00 e8 9c 2d 6c ff 48 8b 7b 18 48 85 ff 74 0d e8 ae 9b e8 ff 48 c7 43 18 00 00 00 00 5b c3 <0f> 0b eb cf 66 66 66 66 90 55 53 48 89 fb 48 83 c7 28 89 f5 e8 0b
> [  103.660968] Fork 100 tasks to 'test_arraymap'
> [  103.660972] 
> [  103.663347] RSP: 0018:ffffc90005263e48 EFLAGS: 00010246
> [  103.663350] RAX: ffffffff818b46d0 RBX: ffff8880867eba40 RCX: ffff8880867ea1e8
> [  103.663351] RDX: ffff88813fd22620 RSI: 0000000000000040 RDI: ffff8880867eba40
> [  103.663353] RBP: ffff88813fd22600 R08: 000073746e657665 R09: 8080808080808080
> [  103.663354] R10: ffffc900006b3d88 R11: fefefefefefefeff R12: ffff8880867eba00
> [  103.663355] R13: 0000000000000000 R14: ffff8880867ebbe0 R15: ffff8880867ebbe8
> [  103.663357] FS:  0000000000000000(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
> [  103.663358] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  103.663359] CR2: 00007f47d7f26cb0 CR3: 0000000088b38000 CR4: 00000000000406e0
> [  103.663363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  103.667182] Fork 100 tasks to 'test_arraymap_percpu'
> [  103.667186] 
> [  103.667670] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  103.667671] Call Trace:
> [  103.667678]  sk_psock_destroy_deferred+0x27/0x1c0
> [  103.667683]  ? __schedule+0x268/0x870
> [  103.671331] Fork 1024 tasks to 'test_update_delete'
> [  103.671334] 
> [  103.672256]  process_one_work+0x19c/0x3b0
> [  103.672259]  worker_thread+0x3c/0x3b0
> [  103.672261]  ? process_one_work+0x3b0/0x3b0
> [  103.672263]  kthread+0x11e/0x140
> [  103.672266]  ? kthread_park+0x90/0x90
> [  103.672268]  ret_from_fork+0x35/0x40
> [  103.672271] ---[ end trace efe23fd08e655cc6 ]---


Addressed in:

  https://lore.kernel.org/netdev/20190307103543.15151-1-jakub@cloudflare.com/

Sorry about the oversight.

-Jakub
