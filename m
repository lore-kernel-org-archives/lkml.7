Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A9C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FAB206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4sD8VSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfLDLPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:15:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40777 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:15:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so7409466wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 03:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2dg6vYHfAbIqQs6f5OPzsG4hCTh98ASxjLOtIlWmuN0=;
        b=P4sD8VSBvEo/WuxXT8f9IirLBaAtn9OraQFi6Joeh+nDUHthz6cFe5EGmDQxOxlgN6
         hzKAihoiESWzuWXShRYM5rHaN5U4qGNX4Dg5EB7KyLpxD5GXKqqT96C+uIPC2bnhgb7u
         aNbCL3Tet+7znL2i+gHVlT6iHScZsBei3/f1kDVr9y87pAxtJHJzbdz0ffuXPQJqweAw
         tgPiuUgIqYS8meiNjNR2NJ6pNVD4izxOkkyxYgxavJOaMseqfIY+YmIGJobgQxCJ79Bd
         TQnO133jTMNkw0FNMkMdzjnVe6BewUPs6L0Dfo5HVJomC5Cau3Qp0+Ou5UIiBkK4s6KG
         v7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2dg6vYHfAbIqQs6f5OPzsG4hCTh98ASxjLOtIlWmuN0=;
        b=rx+rN8aEdCFCkpLY0BVfxgwGlbI/e7I4/irzZegBoGAEfGubgvLuhjoEkxgnWXjnqy
         Gai3Wl1V5VU22AG5aVadNV4pp/nqa7rBF/iERPnDtURMbLYd5l49Oo8QESDOdmPphuq8
         RZpCwavTlKLcP/bCPbK6q7DnXej7A8KA7FTRFvKV4K86x7S7LlJrIAZaN/RcBwWqyfat
         RwUaCCWCm+YQJfD+Nr/1zv9PvYbfxntjBI09Z1YbVOBmnkgR65lrsBo8c+MHMNbi3yhS
         NB+COF7Kj/0Vf9tfM5OTtrGfJCzQ2az12wdxTu9yEsEjG/penadkIJYYnrTrE7Lgr65k
         LXiQ==
X-Gm-Message-State: APjAAAX1jzEnUyd+hSAfLuB3gcOI+5WkdiRvu89lkjjfJQXKUr776UBJ
        NoOwtAy4NSXR/0XMy82BoA4yCcgG
X-Google-Smtp-Source: APXvYqzOQO1BXYauV3dqygDR71lpWAVKeeqa8hbZDXpG6lQ5lajku0y+th3P4REmruVE3e0qRdIk0g==
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr6342874wme.90.1575458105168;
        Wed, 04 Dec 2019 03:15:05 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id a6sm5380859wmb.1.2019.12.04.03.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 03:15:04 -0800 (PST)
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
From:   Richard Genoud <richard.genoud@gmail.com>
Subject: fastmap WARN_ON() after ubiupdatevol
Message-ID: <7a4adbc9-2cf0-e80b-8d0c-c351bc64bd35@gmail.com>
Date:   Wed, 4 Dec 2019 12:14:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've seen that fastmap issues a warning after updating an ubifs volume :
ubi0: default fastmap pool size: 95
ubi0: default fastmap WL pool size: 47
ubi0: attaching mtd3
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/mtd/ubi/fastmap.c:781 ubi_attach_fastmap+0xadc/0xc30
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.1-00048-g23479ee4c63a #1
Hardware name: Atmel AT91SAM9
Backtrace: 
[<c000e484>] (dump_backtrace) from [<c000e884>] (show_stack+0x20/0x24)
 r6:00000000 r5:c066d88c r4:00000000 r3:c4bfd525
[<c000e864>] (show_stack) from [<c04b99dc>] (dump_stack+0x20/0x28)
[<c04b99bc>] (dump_stack) from [<c0018d04>] (__warn+0xdc/0x104)
[<c0018c28>] (__warn) from [<c0018da0>] (warn_slowpath_fmt+0x74/0x80)
 r10:00000000 r8:0000030d r7:c066d88c r6:c0332144 r5:00000009 r4:00000000
[<c0018d30>] (warn_slowpath_fmt) from [<c0332144>] (ubi_attach_fastmap+0xadc/0xc30)
 r8:c71fd000 r7:c78b7d98 r6:00000000 r5:c71dcf00 r4:000007a9
[<c0331668>] (ubi_attach_fastmap) from [<c033293c>] (ubi_scan_fastmap+0x668/0x85c)
 r10:b1c9b7aa r9:00000000 r8:c71ff600 r7:00000000 r6:c8afe000 r5:b1c9b7aa
 r4:c71fd000
[<c03322d4>] (ubi_scan_fastmap) from [<c032e1f8>] (ubi_attach+0xe0/0x2a4)
 r10:00000014 r9:c71fd040 r8:00000040 r7:c71dce80 r6:c71dcf00 r5:00000000
 r4:c71fd000
[<c032e118>] (ubi_attach) from [<c03218fc>] (ubi_attach_mtd_dev+0x68c/0xb28)
 r8:c7b85000 r7:00000000 r6:c71fd000 r5:fffff800 r4:00000840 r3:00000002
[<c0321270>] (ubi_attach_mtd_dev) from [<c06fec50>] (ubi_init+0x148/0x1e8)
 r10:c07c53e4 r9:00000000 r8:c07c53e0 r7:00000000 r6:c07c53e4 r5:c7b85000
 r4:00000000
[<c06feb08>] (ubi_init) from [<c000aafc>] (do_one_initcall+0x7c/0x1e0)
 r10:c0711834 r8:00000077 r7:00000000 r6:c073258c r5:00000007 r4:c06feb08
[<c000aa80>] (do_one_initcall) from [<c06da114>] (kernel_init_freeable+0x128/0x1fc)
 r7:c7eebcc0 r6:c073258c r5:00000007 r4:00000020
[<c06d9fec>] (kernel_init_freeable) from [<c04d17d4>] (kernel_init+0x18/0x100)
 r10:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04d17bc r4:00000000
[<c04d17bc>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc78b7fb0 to 0xc78b7ff8)
7fa0:                                     00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r4:00000000 r3:60000053
---[ end trace b00dfb7213ba31a7 ]---
ubi0 error: ubi_scan_fastmap: Attach by fastmap failed, doing a full scan!
random: fast init done
ubi0: scanning is finished
ubi0: attached mtd3 (name "ubi", size 245 MiB)
ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
ubi0: good PEBs: 1964, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 3, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 26/12, WL threshold: 4096, image sequence number: 1761477484
ubi0: available PEBs: 0, total reserved PEBs: 1964, PEBs reserved for bad PEB handling: 40

The corresponding code is :
	/*
	 * If fastmap is leaking PEBs (must not happen), raise a
	 * fat warning and fall back to scanning mode.
	 * We do this here because in ubi_wl_init() it's too late
	 * and we cannot fall back to scanning.
	 */
	if (WARN_ON(count_fastmap_pebs(ai) != ubi->peb_count -
		    ai->bad_peb_count - fm->used_blocks))
		goto fail_bad;

I added some debug and found that, when everything is ok, I have :
ubi_attach_fastmap: count_fastmap_pebs(ai)=1963 ubi->peb_count=1964 ai->bad_peb_count=0 fm->used_blocks=1
But when the warning rises, I have:
ubi_attach_fastmap: count_fastmap_pebs(ai)=1954 ubi->peb_count=1964 ai->bad_peb_count=0 fm->used_blocks=1
It can also be:
ubi_attach_fastmap: count_fastmap_pebs(ai)=1962 ubi->peb_count=1964 ai->bad_peb_count=0 fm->used_blocks=1
ubi_attach_fastmap: count_fastmap_pebs(ai)=1960 ubi->peb_count=1964 ai->bad_peb_count=0 fm->used_blocks=1

After a reboot, all is back to normal.

Kernel is 5.4.1, mtd-utils are 1.5.1 (yes, it's quite old)

The nand layout is :
0x000000000000-0x000010000000 : "all"
0x000000000000-0x000000020000 : "dtb"
0x000000020000-0x000000a00000 : "kernel"
0x000000a00000-0x00000ff80000 : "ubi"
0x00000ff80000-0x000010000000 : "bbt"
page size : 2KiB
subpage size : 2KiB
PEB size: 128KiB
ubi0_0 : 537 LEBs
ubi0_1 : 537 LEBs
ubi0_2 : 844 LEBs
40 PEBs reserved for bad blocks
4 PEB for UBI overhead
2 PEB for fastmap

The ubifs image is created with :
mkfs.ubifs -d dummy/ -e 0x1f000 -c 537 -m 0x800 -x lzo -o toto.ubifs
and updated with:
ubiupdatevol /dev/ubi0_0 toto.ubifs

It seems to happen only when toto.ubifs is quite big (in my case : 57520128
bytes (453 LEBs))

(I can provide the toto.ubifs if needed)

Regards,
Richard
