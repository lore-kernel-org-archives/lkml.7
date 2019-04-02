Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6102C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1682087C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ln/E90jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfDBDUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:20:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32823 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfDBDUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:20:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id e5so9279380oii.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fauowZrifyb5kjUWWygvDFT6pWLJF0UH265u1eTckU=;
        b=ln/E90jyTNFCw4+CmR/UtI0kBwyEu7u2lMrnIl+n2CZd/6M+TAyrGKUn0CeNnJp0xg
         q5clTTuzEZEoJV9GsOCYoGao9nSS494vjR7901JZX/uLqdKAHLZNBBaIYvh24ZhePMq8
         BkxgjKiHfHf1QvZh17ByA0ZxX9O4KmuR6OeFWhw7WH4YVdw4QG3rDqbk1PKvlIuRNtmV
         9yM81eW1GYaZb5CAPjh+/MILeLzhGr6f5z80FEi5vBq7kwONRsGEYT5MG0tXqObnwaY6
         +fZRzqwZ6bfAC54dDjxC3e2kC+1O6lkZ2IvMuw+sN2hy/MrBBCvSJ65pD1DhSt9HgF5d
         Hvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fauowZrifyb5kjUWWygvDFT6pWLJF0UH265u1eTckU=;
        b=E5crjqfx98FWAVnRtCOVK2+S86mV6e6OTe+/dOqBlKveGV3lFq9hkZhoYE7OoL8Ar2
         Twee+mNAf3Wc7ef3uKlR5EMFmZA2ydRLxK4r7ZHqL7RRtz7aPXpZ7X2NFbBn5TRY3Plw
         GbVQC5nMm5f//i0481qThy2JJyQtwO8cL6pjIE45BejOZYvrZ7OLHpAMLohXdz9zEfss
         t9/AV00jEKaRu26SotzEvCfVJo4o2QhUZqo6+N6yyXnCXw0wzC8YDX13xCychxuRn38u
         Y0Zs299w/vkuz2hNBFFtqjR2jpRUuE87h+mgkRqeXx4A0Pesz6JzfKkctBIB7QChp2ra
         QqXg==
X-Gm-Message-State: APjAAAXrp5HfGf1QjfGWARFiBu+3CoKH5eW2rfuJmRWK8Kp/DNH4wuIm
        2C5fogRXIAbCZS+69NhXyTNhZYGbADwLvvytaX6ewQ==
X-Google-Smtp-Source: APXvYqzPojZA2XhLmllpFbtwGDUv9AH/FhdJJbPJl+zRI4QVPirRDHr9W5X4yVJfavo2t98/t0FZ9Csz7KVTzK6jD6w=
X-Received: by 2002:aca:dcd7:: with SMTP id t206mr5234114oig.68.1554175241606;
 Mon, 01 Apr 2019 20:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190402023044.GC20952@shao2-debian>
In-Reply-To: <20190402023044.GC20952@shao2-debian>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 2 Apr 2019 05:20:15 +0200
Message-ID: <CAG48ez2hfQjCkHwvwZG-b1Xna4MTc50VRN78bLSt85ZL3qdBvQ@mail.gmail.com>
Subject: Re: [mt76] c1e0d2be0a: BUG:pagefault_on_kernel_address#in_non-whitelisted_uaccess
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 5:10 AM kernel test robot <rong.a.chen@intel.com> wrote:
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: c1e0d2be0acff5e99a59ddcc5af415e48abc6c5e ("mt76: mmio: introduce mt76x02_check_tx_hang watchdog")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
[...]
> [   10.383586] BUG: pagefault on kernel address 0xffff93d4b5cd8000 in non-whitelisted uaccess
> [   10.390934] BUG: unable to handle kernel paging request at ffff93d4b5cd8000
> [   10.390934] #PF error: [normal kernel read fault]
> [   10.390934] PGD 21e00067 P4D 21e00067 PUD 21e04067 PMD 78b57067 PTE 800fffff8a327060
> [   10.390934] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
> [   10.390934] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.0.0-rc1-00033-gc1e0d2b #1
> [   10.390934] RIP: 0010:strncpy_from_user+0x87/0x10c
> [   10.390934] Code: 00 00 66 66 90 4c 39 c2 48 bb ff fe fe fe fe fe fe fe 49 ba 80 80 80 80 80 80 80 80 4c 0f 46 c2 31 c0 45 31 db eb 4c 44 89 d9 <4c> 8b 0c 06 85 c9 74 05 45 31 d2 eb 61 49 8d 0c 19 4c 89 0c 07 49
> [   10.390934] RSP: 0000:ffffbd8c00323bc0 EFLAGS: 00010206
> [   10.390934] RAX: 0000000000000028 RBX: fefefefefefefeff RCX: 0000000000000000
> [   10.390934] RDX: 0000000000000fe0 RSI: ffff93d4b5cd7fd6 RDI: ffff93d4af5e3020
> [   10.390934] RBP: 00000000ffffff9c R08: 0000000000000fe0 R09: 8c93909d92868cd1
> [   10.390934] R10: 8080808080808080 R11: 0000000000000000 R12: ffff93d4b5cd7fd6
> [   10.390934] R13: ffff93d4b5cd7fd6 R14: 0000000000000000 R15: 0000000000000000
> [   10.390934] FS:  0000000000000000(0000) GS:ffff93d4b6400000(0000) knlGS:0000000000000000
> [   10.390934] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.390934] CR2: ffff93d4b5cd8000 CR3: 0000000020c15000 CR4: 00000000000006e0
> [   10.390934] Call Trace:
> [   10.390934]  ? getname_flags+0x6f/0x199
> [   10.390934]  ? user_path_at_empty+0x18/0x2f
> [   10.390934]  ? vfs_statx+0x6d/0xb3
> [   10.390934]  ? clean_path+0x5c/0x102
> [   10.390934]  ? do_name+0xf4/0x40e
> [   10.390934]  ? write_buffer+0x52/0x8a
> [   10.390934]  ? flush_buffer+0xe7/0x140
> [   10.390934]  ? initrd_load+0xa8/0xa8
> [   10.390934]  ? __gunzip+0x53a/0x6b7
> [   10.390934]  ? bunzip2+0x76a/0x76a
> [   10.390934]  ? write_buffer+0x8a/0x8a
> [   10.390934]  ? gunzip+0x39/0x3d
> [   10.390934]  ? initrd_load+0xa8/0xa8
> [   10.390934]  ? unpack_to_rootfs+0x1c6/0x3c6
> [   10.390934]  ? initrd_load+0xa8/0xa8
> [   10.390934]  ? populate_rootfs+0x94/0x213
> [   10.390934]  ? clean_rootfs+0x23b/0x23b
> [   10.390934]  ? do_one_initcall+0x61/0x12a
> [   10.390934]  ? kernel_init_freeable+0x1a8/0x305
> [   10.390934]  ? rest_init+0x13a/0x13a
> [   10.390934]  ? kernel_init+0x5/0xeb
> [   10.390934]  ? ret_from_fork+0x35/0x40
> [   10.390934] Modules linked in:
> [   10.390934] CR2: ffff93d4b5cd8000
> [   10.390934] ---[ end trace 81b307b1a0dd06e6 ]---

This was dealt with in commit 53a41cb7ed381edee91029cdcabe9b3250f43f4d
('Revert "x86/fault: BUG() when uaccess helpers fault on kernel
addresses"').
