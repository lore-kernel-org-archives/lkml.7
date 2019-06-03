Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA38CC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAE42469D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559552882;
	bh=Rzr6gfXjAXNtZ72i1f03ZP5xQADxqoyjKQjlDsDgnOU=;
	h=From:Date:Subject:To:List-ID:From;
	b=wEYrO1Afb58rtM+1APrg7CnTJtU5e7A26+RXRaeeEEteE+gnaS4Kl/qVDqyck3asT
	 FIkWO2LCVXZE0GTNDUT4d+VXMusT+UqpSqzysd7sBq20t0mwFIQLCFJz9psaZ/weaL
	 PaS5MjfLgMchWj99zfa5ELFGiZMS2IKGxa7sBYY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfFCJIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfFCJIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:08:00 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D586F2713A;
        Mon,  3 Jun 2019 09:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559552880;
        bh=Rzr6gfXjAXNtZ72i1f03ZP5xQADxqoyjKQjlDsDgnOU=;
        h=From:Date:Subject:To:From;
        b=OFyk4NY4DclC0oTHFd+eXw4x0tlpPhoixH2tmw3kBXKOXH5TYz61qqu8iPuV6Oxov
         pUaAnT2yl/SpS/pTBkp8RfXYzmGPLR5VVU8Rq3Bsvowc2B50/wekJgJPg8z8tp5OC0
         3dySqY9w+R7b6avLDJk8xQJPQ038nr55Pc74dKLs=
Received: by mail-lj1-f181.google.com with SMTP id r76so15397974lja.12;
        Mon, 03 Jun 2019 02:07:59 -0700 (PDT)
X-Gm-Message-State: APjAAAUN/U+s+/4kff/ksnLsTx92XpgCoKoTq/3GmFh1N1n/oBVm8KQJ
        xbkABQ2gvTbsTXw4122o0OqgW/6EFFzyyEy066s=
X-Google-Smtp-Source: APXvYqw8WHJT+fvLmcEcp0Lo0YX/2W6ao7L44cq/RA1vj/2N8oEiiJnTLU0U+PgTYKDOUB7tqpELGDErPLLk8DYOMYs=
X-Received: by 2002:a2e:980e:: with SMTP id a14mr2097047ljj.60.1559552878019;
 Mon, 03 Jun 2019 02:07:58 -0700 (PDT)
MIME-Version: 1.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 3 Jun 2019 11:07:46 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
Message-ID: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
Subject: [BUG BISECT] bug mm/vmalloc.c:470 (mm/vmalloc.c: get rid of one
 single unlink_va() when merge)
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On recent next I see bugs during boot (after bringing up user-space or
during reboot):
kernel BUG at ../mm/vmalloc.c:470!
On all my boards. On QEMU I see something similar, although the
message is "Internal error: Oops - undefined instruction: 0 [#1] ARM",

The calltrace is:
[   34.565126] [<c0275c9c>] (__free_vmap_area) from [<c0276044>]
(__purge_vmap_area_lazy+0xd0/0x170)
[   34.573963] [<c0276044>] (__purge_vmap_area_lazy) from [<c0276d50>]
(_vm_unmap_aliases+0x1fc/0x244)
[   34.582974] [<c0276d50>] (_vm_unmap_aliases) from [<c0279500>]
(__vunmap+0x170/0x200)
[   34.590770] [<c0279500>] (__vunmap) from [<c01d5a70>]
(do_free_init+0x40/0x5c)
[   34.597955] [<c01d5a70>] (do_free_init) from [<c01478f4>]
(process_one_work+0x228/0x810)
[   34.606018] [<c01478f4>] (process_one_work) from [<c0147f0c>]
(worker_thread+0x30/0x570)
[   34.614077] [<c0147f0c>] (worker_thread) from [<c014e8b4>]
(kthread+0x134/0x164)
[   34.621438] [<c014e8b4>] (kthread) from [<c01010b4>]
(ret_from_fork+0x14/0x20)

Full log here:
https://krzk.eu/#/builders/1/builds/3356/steps/14/logs/serial0
https://krzk.eu/#/builders/22/builds/1118/steps/35/logs/serial0

Bisect pointed to:
728e0fbf263e3ed359c10cb13623390564102881 is the first bad commit
commit 728e0fbf263e3ed359c10cb13623390564102881
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Sat Jun 1 12:20:19 2019 +1000
    mm/vmalloc.c: get rid of one single unlink_va() when merge

Boards:
1. Arch ARM Linux
2. exynos_defconfig
3. Exynos boards (Odroid XU3, etc), ARMv7, octa-core (Cortex-A7+A15),
Exynos5422 SoC
4. Systemd: v239, static IP set in kernel command line

Best regards,
Krzysztof
