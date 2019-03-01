Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51818C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F42352087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CSk+uBcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCAUUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:20:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34384 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCAUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:20:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id w4so29352620qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JI1qe6LwZbBi1liwMWqrJTVtZaUOSNxajd+HQwYL8nc=;
        b=CSk+uBcTE5pXmdr+ATojNgQGYE7Z9e+bG0ebtCV8A2HabddTdIPjsLUn2WViNBnoUU
         eWbWG2ouIS01RsrRMhxv5mHNFL7H6u2xhoEJAkindPG630YI3XHNi0wA0L7Y6UBKaUkI
         ZYBBvrxu4Cb6CvBDbbdkwZnCl6XfW8o31JxJ42CvwmyXDIYNl78urNbxAHbPrpdbahC8
         ysBN9visHhJUKTF6VNq7SYizq1R6TxuouF4TFDd1RWDQ31GMSGf1RIwQ6427qOE/oAwq
         fOkNmnI0VXgtHByUY10MsmWxLDJGFjbhHuS58GWNiPk2HC4KZlmvvUV2x/qnBsBdYpKT
         zs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JI1qe6LwZbBi1liwMWqrJTVtZaUOSNxajd+HQwYL8nc=;
        b=I/6UaL2ZpWVJ5U5AWs9tsl9dc669D3DsNGoLEdl492UwEEXiBWr01MZ9VA/4UiQnyD
         0zuASdhVG/adGzApGMVLmTWsUlrJt9lHiIG2FNj/2t6Tg5NH6s7lWZ2KRCOtumP9g4n0
         spon2GzmTHGxA9Zu+/FchDu9FZsXuokS1WiVMCH2UCXUIOnCjsy9+S76Kyu5p2q4JXcb
         pewz8X2Z/cssJzHJ3/A2uGi08gJyyMDptMbh3Mbk5p83WiOXCPP6Y6ZNZ/jKbjBpiVHl
         ewwqem/IsF0mNJNJjA5Ea/sIel2F3MfYo602XzRudWPPgNvErGowRSnr5fPQYDj63wPJ
         Xfbw==
X-Gm-Message-State: APjAAAX7h33lMFBV1QWoYuu8rzzYASPnuGK0bEjwKHUKnYSh8f+hwjA0
        Rr0YJm3S1OoJTkQb681Vwcad8TR2aqY=
X-Google-Smtp-Source: APXvYqwZCGdeaKOOUZqSvmSjEYpFrJtYsvXXR9Q3oYLE36B8fDzO0ulMsHBbTgdnA6eWcUiehIUn5Q==
X-Received: by 2002:ac8:3464:: with SMTP id v33mr5571861qtb.65.1551471602258;
        Fri, 01 Mar 2019 12:20:02 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y11sm20006138qky.2.2019.03.01.12.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 12:20:01 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
Date:   Fri,  1 Mar 2019 15:19:50 -0500
Message-Id: <20190301201950.96637-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When onlining a memory block with DEBUG_PAGEALLOC, it unmaps the pages
in the block from kernel, However, it does not map those pages while
offlining at the beginning. As the result, it triggers a panic below
while onlining on ppc64le as it checks if the pages are mapped before
unmapping. However, the imbalance exists for all arches where
double-unmappings could happen. Therefore, let kernel map those pages in
generic_online_page() before they have being freed into the page
allocator for the first time where it will set the page count to one.

On the other hand, it works fine during the boot, because at least for
IBM POWER8, it does,

early_setup
  early_init_mmu
    harsh__early_init_mmu
      htab_initialize [1]
        htab_bolt_mapping [2]

where it effectively map all memblock regions just like
kernel_map_linear_page(), so later mem_init() -> memblock_free_all()
will unmap them just fine without any imbalance. On other arches without
this imbalance checking, it still unmap them once at the most.

[1]
for_each_memblock(memory, reg) {
        base = (unsigned long)__va(reg->base);
        size = reg->size;

        DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
                base, size, prot);

        BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
                prot, mmu_linear_psize, mmu_kernel_ssize));
        }

[2] linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;

kernel BUG at arch/powerpc/mm/hash_utils_64.c:1815!
Oops: Exception in kernel mode, sig: 5 [#1]
LE SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA pSeries
CPU: 2 PID: 4298 Comm: bash Not tainted 5.0.0-rc7+ #15
NIP:  c000000000062670 LR: c00000000006265c CTR: 0000000000000000
REGS: c0000005bf8a75b0 TRAP: 0700   Not tainted  (5.0.0-rc7+)
MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28422842
XER: 00000000
CFAR: c000000000804f44 IRQMASK: 1
GPR00: c00000000006265c c0000005bf8a7840 c000000001518200 c0000000013cbcc8
GPR04: 0000000000080004 0000000000000000 00000000ccc457e0 c0000005c4e341d8
GPR08: 0000000000000000 0000000000000001 c000000007f4f800 0000000000000001
GPR12: 0000000000002200 c000000007f4e100 0000000000000000 0000000139c29710
GPR16: 0000000139c29714 0000000139c29788 c0000000013cbcc8 0000000000000000
GPR20: 0000000000034000 c0000000016e05e8 0000000000000000 0000000000000001
GPR24: 0000000000bf50d9 800000000000018e 0000000000000000 c0000000016e04b8
GPR28: f000000000d00040 0000006420a2f217 f000000000d00000 00ea1b2170340000
NIP [c000000000062670] __kernel_map_pages+0x2e0/0x4f0
LR [c00000000006265c] __kernel_map_pages+0x2cc/0x4f0
Call Trace:
[c0000005bf8a7840] [c00000000006265c] __kernel_map_pages+0x2cc/0x4f0
(unreliable)
[c0000005bf8a78d0] [c00000000028c4a0] free_unref_page_prepare+0x2f0/0x4d0
[c0000005bf8a7930] [c000000000293144] free_unref_page+0x44/0x90
[c0000005bf8a7970] [c00000000037af24] __online_page_free+0x84/0x110
[c0000005bf8a79a0] [c00000000037b6e0] online_pages_range+0xc0/0x150
[c0000005bf8a7a00] [c00000000005aaa8] walk_system_ram_range+0xc8/0x120
[c0000005bf8a7a50] [c00000000037e710] online_pages+0x280/0x5a0
[c0000005bf8a7b40] [c0000000006419e4] memory_subsys_online+0x1b4/0x270
[c0000005bf8a7bb0] [c000000000616720] device_online+0xc0/0xf0
[c0000005bf8a7bf0] [c000000000642570] state_store+0xc0/0x180
[c0000005bf8a7c30] [c000000000610b2c] dev_attr_store+0x3c/0x60
[c0000005bf8a7c50] [c0000000004c0a50] sysfs_kf_write+0x70/0xb0
[c0000005bf8a7c90] [c0000000004bf40c] kernfs_fop_write+0x10c/0x250
[c0000005bf8a7ce0] [c0000000003e4b18] __vfs_write+0x48/0x240
[c0000005bf8a7d80] [c0000000003e4f68] vfs_write+0xd8/0x210
[c0000005bf8a7dd0] [c0000000003e52f0] ksys_write+0x70/0x120
[c0000005bf8a7e20] [c00000000000b000] system_call+0x5c/0x70
Instruction dump:
7fbd5278 7fbd4a78 3e42ffeb 7bbd0640 3a523ac8 7e439378 487a2881 60000000
e95505f0 7e6aa0ae 6a690080 7929c9c2 <0b090000> 7f4aa1ae 7e439378 487a28dd

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: map pages in kernel at the beginning of online path instead of the offline
    path to avoid possible issues pointed out by Michal.

 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1ad28323fb9f..736e107e2197 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -660,6 +660,7 @@ static void generic_online_page(struct page *page)
 {
 	__online_page_set_limits(page);
 	__online_page_increment_counters(page);
+	kernel_map_pages(page, 1, 1);
 	__online_page_free(page);
 }
 
-- 
2.17.2 (Apple Git-113)

