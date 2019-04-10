Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3888C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF58206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs+GnZgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDJTeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:34:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33175 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:34:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so2163519pgh.0;
        Wed, 10 Apr 2019 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RoRP91eqHmZA4ZU0TjZar6G0XQR8yG8No49gQ9v2qAA=;
        b=cs+GnZgAADrH/zJIturFnqmsguNJrAVRTHQZvmYl6HECAMPlaKD0UA6K+MyNzQYf3w
         PUIMc1uKis5re+V2+FqEedB6P9+ne7EWbplBbw6XNrZHxzzkvow0XZlYC1DNTjWiTYy3
         ItdRAa04tnfXw4RyktPTvPEsTjWKofFb9cw+sPzCkHF51rXl1BzwYzFVK1drgM+MUHnG
         oz489z9RdaPf/RICLu1WLIYKvv9BewvQfpVl2R8SR7jZ7D2S+sJpBzdz8GtIBTjUH0Vv
         tQSeNNtTC13O4oxFb/nMLaQODYtP7lTfGrK+1NG4VL6eMm5HPi9NJ54yDawmnGpcwxUt
         Ilng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RoRP91eqHmZA4ZU0TjZar6G0XQR8yG8No49gQ9v2qAA=;
        b=Mdgfb5t17W+5CQfRZPeFmqdZyYoclrlQlglXbYAsOgOfd2bpX7hDpGdSFhBerDM1lz
         qkE2ZP8dLQUng33psFO8uU4/DERwD5cYpzT3qqcY8ojzJ5bklG1mgJifp5qMNTph1q15
         t5MfTDzQ5f8EmxjbjkiLMPWUTQKnNpzRs2/PIrnhDXevKVNpJi1dRKA8JU5dklfSdc4T
         laFAHGS9rvsVwMvx6GbTHgOGluyDA5wdBv5NuvO2quHIaqcz1wcOThYQ/uRsrVDxfOYg
         KpZ/9WtsVp6ahDEPAhnO5bEFZ2wmZPbWiQgcNJohopHNctUPLnIoR/icm9RmMsmh8MxX
         OWbQ==
X-Gm-Message-State: APjAAAX+N+tsrgXTOMKMHSqxKR4nNkujdvKE2P9Q1GmYOf1UAOO0BR1f
        zpqA+FPgPopP+GMK/jpFguY=
X-Google-Smtp-Source: APXvYqw0XG2ZI6CL0aEPtoEmDzpr5neLpTGYMEs5bguF/r9G2ny6RJoTh8p2S21Yqa52QEf9vzxMiw==
X-Received: by 2002:a63:84c7:: with SMTP id k190mr42006660pgd.255.1554924861335;
        Wed, 10 Apr 2019 12:34:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l10sm33988536pfc.46.2019.04.10.12.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:34:19 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:34:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Message-ID: <20190410193418.GA32402@roeck-us.net>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
 <155416006521.9540.5662092375167065834.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155416006521.9540.5662092375167065834.stgit@noble.brown>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 02, 2019 at 10:07:45AM +1100, NeilBrown wrote:
> This patch changes rhashtables to use a bit_spin_lock on BIT(1) of the
> bucket pointer to lock the hash chain for that bucket.
> 
> The benefits of a bit spin_lock are:
>  - no need to allocate a separate array of locks.
>  - no need to have a configuration option to guide the
>    choice of the size of this array
>  - locking cost is often a single test-and-set in a cache line
>    that will have to be loaded anyway.  When inserting at, or removing
>    from, the head of the chain, the unlock is free - writing the new
>    address in the bucket head implicitly clears the lock bit.
>    For __rhashtable_insert_fast() we ensure this always happens
>    when adding a new key.
>  - even when lockings costs 2 updates (lock and unlock), they are
>    in a cacheline that needs to be read anyway.
> 
> The cost of using a bit spin_lock is a little bit of code complexity,
> which I think is quite manageable.
> 
> Bit spin_locks are sometimes inappropriate because they are not fair -
> if multiple CPUs repeatedly contend of the same lock, one CPU can
> easily be starved.  This is not a credible situation with rhashtable.
> Multiple CPUs may want to repeatedly add or remove objects, but they
> will typically do so at different buckets, so they will attempt to
> acquire different locks.
> 
> As we have more bit-locks than we previously had spinlocks (by at
> least a factor of two) we can expect slightly less contention to
> go with the slightly better cache behavior and reduced memory
> consumption.
> 
> To enhance type checking, a new struct is introduced to represent the
>   pointer plus lock-bit
> that is stored in the bucket-table.  This is "struct rhash_lock_head"
> and is empty.  A pointer to this needs to be cast to either an
> unsigned lock, or a "struct rhash_head *" to be useful.
> Variables of this type are most often called "bkt".
> 
> Previously "pprev" would sometimes point to a bucket, and sometimes a
> ->next pointer in an rhash_head.  As these are now different types,
> pprev is NULL when it would have pointed to the bucket. In that case,
> 'blk' is used, together with correct locking protocol.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

This patch causes my qemu q800 boot test to crash reliably.

Starting network: Unable to handle kernel access at virtual address (ptrval)
Oops: 00000000
Modules linked in:
PC: [<00248b90>] sk_filter_trim_cap+0x56/0x158
SR: 2000  SP: (ptrval)  a2: 07a30aa0
d0: 07836300    d1: 0783666c    d2: 00000001    d3: 0025c192
d4: 0025a636    d5: 00248b3a    a0: 078363fe    a1: 60000000
Process ip (pid: 66, task=(ptrval))
Frame format=7 eff addr=6000000c ssw=0505 faddr=6000000c
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 6000000c 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 07a5bdec:
        07a5be5c 0025c192 0025a636 00248b3a 00000000 ef9febc8 078363fe 0787a2d0
        0783645c 07a5be5c 0025c192 0025a636 00248b3a 0787a2d0 07a2c000 0025c470
        078363fe 0787a2d0 00000001 00000000 00000000 07a5be98 07a17500 00000000
        0787a2d0 07a2c000 07a5bef8 07a5beac 7fffffff 0025c7e2 07a2c000 0787a2d0
        00000000 00000000 00000000 0000000c ef9feb14 ef9feb14 00000000 0031a52e
        07a5bef8 07a5bf28 0000000c 0781eba0 00000000 00000042 00000000 00000000
Call Trace: [<0025c192>] netlink_attachskb+0x0/0x138
 [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
 [<00248b3a>] sk_filter_trim_cap+0x0/0x158
 [<0025c192>] netlink_attachskb+0x0/0x138
 [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
 [<00248b3a>] sk_filter_trim_cap+0x0/0x158
 [<0025c470>] netlink_unicast+0x170/0x1be
 [<0025c7e2>] netlink_sendmsg+0x288/0x2b2
 [<0021a5be>] sock_sendmsg+0x1c/0x44
 [<0021b8a6>] __sys_sendto+0xac/0xd2
 [<00100000>] ext4_read_block_bitmap_nowait+0x4d4/0x4ec
 [<00100000>] ext4_read_block_bitmap_nowait+0x4d4/0x4ec
 [<00219906>] sock_alloc_file+0x50/0x80
 [<000b7a1c>] fd_install+0x12/0x18
 [<0021b1cc>] __sys_socket+0x7e/0x9c
 [<0021b8ea>] sys_sendto+0x1e/0x24
 [<00002a40>] syscall+0x8/0xc
 [<0000c004>] ATANTBL+0x618/0x800
Code: 4a89 6604 4280 60ea 2c2b 000c 2748 000c <2869> 000c 082c 0003 0002 6728 4878 0014 7620 4873 3800 486e ffec 4eb9 002e 5b88
Disabling lock debugging due to kernel taint
Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
Oops: 00000000
Modules linked in:
PC: [<0025bf9c>] netlink_release+0x284/0x446
SR: 2000  SP: (ptrval)  a2: 07a30aa0
d0: 00000780    d1: 00000780    d2: 07a2c26e    d3: 0001a0ba
d4: 07406160    d5: 000000ac    a0: 078094ac    a1: 00000780
Process ip (pid: 66, task=(ptrval))
Frame format=7 eff addr=00000780 ssw=0505 faddr=00000780
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 00000780 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 07a5bc2c:
        00000000 078126a0 0741fe00 07a39208 00000001 ef9febc8 07406160 0740617c
        00000000 00000000 002e8ca6 074061e8 07a5bcf4 00219830 07406160 00000008
        07a39200 0740617c 002198a2 07406160 0740617c 000a3996 0740617c 07a39200
        003deb54 07a39480 002e863c 000000b4 07a30aa0 002e7446 0002934a 07a39200
        600000ff 00033e44 07a30aa0 0790f330 00018f34 07a30aa0 6000000c 0025c192
        0025a636 00248b3a 00000001 ef9febc8 07a5bd84 00037986 0783645c 0790f368
Call Trace: [<002e8ca6>] __down_write+0xe/0x12
 [<00219830>] __sock_release+0x34/0x98
 [<002198a2>] sock_close+0xe/0x14
 [<000a3996>] __fput+0xc4/0x16a
 [<002e863c>] down_read+0x0/0x6
 [<002e7446>] _cond_resched+0x0/0x2a
 [<0002934a>] task_work_run+0x66/0x7c
 [<00033e44>] up_read+0x0/0x6
 [<00018f34>] do_exit+0x2a2/0x724
 [<0025c192>] netlink_attachskb+0x0/0x138
 [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
 [<00248b3a>] sk_filter_trim_cap+0x0/0x158
 [<00037986>] printk+0x0/0x18
 [<00004fd4>] die_if_kernel+0x52/0x56
 [<00005d64>] send_fault_sig+0x74/0x86
 [<00005094>] buserr_c+0xbc/0x518
 [<0025c192>] netlink_attachskb+0x0/0x138
 [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
 [<00248b3a>] sk_filter_trim_cap+0x0/0x158
 [<00002944>] buserr+0x20/0x28
 [<0025c192>] netlink_attachskb+0x0/0x138
 [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
 [<00248b3a>] sk_filter_trim_cap+0x0/0x158
 [<0025c192>] netlink_attachskb+0x0/0x138
 [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
 [<00248b3a>] sk_filter_trim_cap+0x0/0x158
 [<0025c192>] netlink_attachskb+0x0/0x138
 [<0025a636>] __netlink_lookup.isra.3+0x0/0xbc
 [<00248b3a>] sk_filter_trim_cap+0x0/0x158
 [<0025c470>] netlink_unicast+0x170/0x1be
 [<0025c7e2>] netlink_sendmsg+0x288/0x2b2
 [<0021a5be>] sock_sendmsg+0x1c/0x44
 [<0021b8a6>] __sys_sendto+0xac/0xd2
 [<00100000>] ext4_read_block_bitmap_nowait+0x4d4/0x4ec
 [<00100000>] ext4_read_block_bitmap_nowait+0x4d4/0x4ec
 [<00219906>] sock_alloc_file+0x50/0x80
 [<000b7a1c>] fd_install+0x12/0x18
 [<0021b1cc>] __sys_socket+0x7e/0x9c
 [<0021b8ea>] sys_sendto+0x1e/0x24
 [<00002a40>] syscall+0x8/0xc
 [<0000c004>] ATANTBL+0x618/0x800
Code: 41f5 5800 6000 fe34 b082 670a 2200 2240 <2011> 6000 fe48 202b 026e 43f9 0001 a0ba 4a81 677a 2041 2080 4878 0200 2f3c 0025
Kernel panic - not syncing: Aiee, killing interrupt handler!
---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---
qemu-system-m68k: terminating on signal 15 from pid 19836 (/bin/bash)

Bisect log is attached. Obviously I have no idea if this is an issue with qemu
or with the code. qemu is from git@github.com:vivier/qemu-m68k.git, branch
m68k/q800-dev.

Guenter

---
# bad: [87b81df1a63d6791359a475241fa9d2f96fa30be] Add linux-next specific files for 20190410
# good: [15ade5d2e7775667cf191cf2f94327a4889f8b9d] Linux 5.1-rc4
git bisect start 'HEAD' 'v5.1-rc4'
# bad: [35a1393e49d19d625d0270fcdf409fad743263cd] Merge remote-tracking branch 'crypto/master'
git bisect bad 35a1393e49d19d625d0270fcdf409fad743263cd
# good: [d1472e6a10485eb679eec89324ab165533af0be1] Merge remote-tracking branch 'hid/for-next'
git bisect good d1472e6a10485eb679eec89324ab165533af0be1
# bad: [0c9381d9bcfbd7dbc26b6e5f296e90d6396ea4db] Merge branch 'netdevsim-small-spring-cleanup'
git bisect bad 0c9381d9bcfbd7dbc26b6e5f296e90d6396ea4db
# good: [356d71e00d278d865f8c7f68adebd6ce4698a7e2] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect good 356d71e00d278d865f8c7f68adebd6ce4698a7e2
# good: [fe1ec0bdfba4e7bfe6db81a1e4ac74beb36691e8] ehea: remove set but not used variables 'epa' and 'cq_handle_ref'
git bisect good fe1ec0bdfba4e7bfe6db81a1e4ac74beb36691e8
# bad: [ed514fc5615d7688b7c227a76863e98a92fb0d54] cxgb4: Don't return EAGAIN when TCAM is full.
git bisect bad ed514fc5615d7688b7c227a76863e98a92fb0d54
# good: [7090425104dbd87959bd424e9bd5a8711fde0986] net: phy: add amlogic g12a mdio mux support
git bisect good 7090425104dbd87959bd424e9bd5a8711fde0986
# good: [059477830022e1886f55a9641702461c249fa864] net: hsr: fix placement of logical operator in a multi-line statement
git bisect good 059477830022e1886f55a9641702461c249fa864
# good: [7a41c294c1463100fdc82a356e22e36bbaa6b0f9] rhashtable: use cmpxchg() in nested_table_alloc()
git bisect good 7a41c294c1463100fdc82a356e22e36bbaa6b0f9
# bad: [9186c90bbb9525f46eddb590be26c749b5b1def7] Merge branch 'rhashtable-bitlocks'
git bisect bad 9186c90bbb9525f46eddb590be26c749b5b1def7
# bad: [8f0db018006a421956965e1149234c4e8db718ee] rhashtable: use bit_spin_locks to protect hash bucket.
git bisect bad 8f0db018006a421956965e1149234c4e8db718ee
# good: [ff302db965b57c141297911ea647d36d11fedfbe] rhashtable: allow rht_bucket_var to return NULL.
git bisect good ff302db965b57c141297911ea647d36d11fedfbe
# first bad commit: [8f0db018006a421956965e1149234c4e8db718ee] rhashtable: use bit_spin_locks to protect hash bucket.

