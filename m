Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41741ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0959421721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Fk+R68Fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfJHUSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:18:22 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:44664 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfJHUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:18:22 -0400
Received: by mail-qt1-f170.google.com with SMTP id u40so21833qth.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=sxjFlRZeieXOJ7BpgEgdRgqZ0nCCp9v7KTDBX8Ujnnc=;
        b=Fk+R68FkonSbOf5qOFb114l8++ic3r71mvv3VK2386hnV2XzsbXJUQ56bABg7iPvs7
         SXyAbCEj2d+unzTJOw22s1yosqng6WBXK86MceeJFAIuwOinVrtFFIwTxvjFo5JEAPIF
         B5a0B3vd27TE53wOhQiwW/QPtaKbOCoKVCtA8pYxQ374ZJ15Rv0jMuGUwyU1QAwtoAvQ
         7wmhpdrwXIdTBxDPzDzhGDaY+7SuOTbwPZj8PIY0dvXvA962CGxWRXf9v1H5hKmCLczF
         koWeN9E3g8b5795hwsYRTvlk5xiuduwT0GtKYpNM7KpsjN18Dv/WOWfIg7bJdJxfuLIW
         Putw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=sxjFlRZeieXOJ7BpgEgdRgqZ0nCCp9v7KTDBX8Ujnnc=;
        b=ppbSwd1dbxqxPNK5h0ZmA7/eWi3XM77u4p7jG0ZcQKyGmb1rrk0AZk49qkIJEQmNER
         8qOwBq38/ULB4aoclgjsVc4gVtP0rFk4s43B8RofUpAaClLACNzjQ/qtVBBs0XvSnz6H
         LH/lgU6TFU70xQfqfsSzQx8FLZQbonWMOB89bElNIRTwQx75boCrHjKlh0GX6xYJ3mXS
         ctTockSMu0p+9g4p8UgvTXgLWIL3BWwWdlZvucVHFn5AlB4j9QghkdUDfglEs/jMQsBB
         7sMztOf5iPLlTXenVGJK2vBolWlzpsh7lcbWj1sfny8f/ehn0ncTLYPHbTKsZqfyw4i1
         xhSw==
X-Gm-Message-State: APjAAAUbldfflOA28/uuvuN8Cwor5eDzVZr22Gg2IUn2P35vaQWb/RhZ
        z3UKqaBLAU/VDfGX6mIA1woACe2JkWk=
X-Google-Smtp-Source: APXvYqysQBOH0tHNU4sIPA6eyPqQzdPK786LyHK1ll0eiyARnEkTfnoq+XHggCbHcxvcYwpiCT/XIQ==
X-Received: by 2002:a0c:b49a:: with SMTP id c26mr35206877qve.105.1570565900838;
        Tue, 08 Oct 2019 13:18:20 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j2sm10087454qki.15.2019.10.08.13.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 13:18:20 -0700 (PDT)
Message-ID: <1570565898.5576.314.camel@lca.pw>
Subject: "Shrink zones before removing memory" causes kernel panic with
 kpagecount
From:   Qian Cai <cai@lca.pw>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Oct 2019 16:18:18 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next series "mm/memory_hotplug: Shrink zones before removing memory"
[1] causes a kernel panic while reading /proc/kpagecount after offlining a
memory section. It was reproduced on both x86 and powerpc. Reverted the whole
series fixed the problem.

[1] https://lore.kernel.org/linux-mm/20191006085646.5768-1-david@redhat.com/

# echo offline > /sys/devices/system/memory/memory124/state 
# cat /proc/kpagecount

[  133.268032][ T8809] remove from free list 7c000 256 7d000
[  133.268134][ T8809] remove from free list 7c100 256 7d000
[  133.268153][ T8809] remove from free list 7c200 256 7d000
[  133.268182][ T8809] remove from free list 7c300 256 7d000
[  133.268212][ T8809] remove from free list 7c400 256 7d000
[  133.268241][ T8809] remove from free list 7c500 256 7d000
[  133.268260][ T8809] remove from free list 7c600 256 7d000
[  133.268289][ T8809] remove from free list 7c700 256 7d000
[  133.268329][ T8809] remove from free list 7c800 256 7d000
[  133.268359][ T8809] remove from free list 7c900 256 7d000
[  133.268399][ T8809] remove from free list 7ca00 256 7d000
[  133.268429][ T8809] remove from free list 7cb00 256 7d000
[  133.268458][ T8809] remove from free list 7cc00 256 7d000
[  133.268488][ T8809] remove from free list 7cd00 256 7d000
[  133.268517][ T8809] remove from free list 7ce00 256 7d000
[  133.268546][ T8809] remove from free list 7cf00 256 7d000
[  133.268580][ T8809] Offlined Pages 4096
[  144.038732][ T8944] BUG: Unable to handle kernel data access at
0xfffffffffffffffe
[  144.038769][ T8944] Faulting instruction address: 0xc000000000590c08
[  144.038794][ T8944] Oops: Kernel access of bad area, sig: 11 [#1]
[  144.038807][ T8944] LE PAGE_SIZE=64K MMU=Radix MMU=Hash SMP NR_CPUS=256
DEBUG_PAGEALLOC NUMA PowerNV
[  144.038822][ T8944] Modules linked in: ip_tables x_tables xfs sd_mod bnx2x
mdio ahci libahci tg3 libata libphy firmware_class dm_mirror dm_region_hash
dm_log dm_mod
[  144.038864][ T8944] CPU: 116 PID: 8944 Comm: cat Not tainted 5.4.0-rc2+ #6
[  144.038898][ T8944] NIP:  c000000000590c08 LR: c000000000577330 CTR:
c0000000005909d0
[  144.038945][ T8944] REGS: c00020196bd6fa30 TRAP: 0380   Not tainted  (5.4.0-
rc2+)
[  144.038989][ T8944] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
48022428  XER: 20040000
[  144.039028][ T8944] CFAR: c000000000590ad0 IRQMASK: 0 
[  144.039028][ T8944] GPR00: c000000000577330 c00020196bd6fcc0 c000000001122d00
c0002009d3d4a880 
[  144.039028][ T8944] GPR04: 00007fffb6870000 0000000000020000 fffffffffffffffe
c00c000000000000 
[  144.039028][ T8944] GPR08: 0000000001f00000 c00c000001f00000 0000000000000001
c0000000009413d0 
[  144.039028][ T8944] GPR12: c0000000005909d0 c000201fff677000 0000000000000000
0000000000000000 
[  144.039028][ T8944] GPR16: 0000000000000002 00007fffca34cfa8 ffffffffffffffff
0000000000000000 
[  144.039028][ T8944] GPR20: 0000000000000000 0000000000000000 c000000000000000
c00020196bd6fdf0 
[  144.039028][ T8944] GPR24: 00007fffb6870000 0000000007ffffff 0000000000000000
c000000000aa6c20 
[  144.039028][ T8944] GPR28: 00007fffb6890000 0000000000000008 000000000007c000
00007fffb6870000 
[  144.039240][ T8944] NIP [c000000000590c08] kpagecount_read+0x238/0x3f0
[  144.039263][ T8944] LR [c000000000577330] proc_reg_read+0x90/0x130
[  144.039274][ T8944] Call Trace:
[  144.039304][ T8944] [c00020196bd6fd30] [c000000000577330]
proc_reg_read+0x90/0x130
[  144.039342][ T8944] [c00020196bd6fd60] [c0000000004978bc]
__vfs_read+0x3c/0x70
[  144.039377][ T8944] [c00020196bd6fd80] [c00000000049799c] vfs_read+0xac/0x170
[  144.039423][ T8944] [c00020196bd6fdd0] [c000000000497dfc]
ksys_read+0x7c/0x140
[  144.039472][ T8944] [c00020196bd6fe20] [c00000000000b378]
system_call+0x5c/0x68
[  144.039495][ T8944] Instruction dump:
[  144.039513][ T8944] 4e800020 60000000 3d22000d 3929c098 7bc83664 e8e90000
7d274215 418200ac 
[  144.039540][ T8944] e9490008 38caffff 714a0001 7cc9309e <e9460000> 2faaffff
e9490008 419e00fc 
[  144.039580][ T8944] ---[ end trace 96fb2ea2d503fda9 ]---
[  144.492072][ T8944] 
[  145.492172][ T8944] Kernel panic - not syncing: Fatal exception
