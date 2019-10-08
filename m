Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC382C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A8721871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfJHVpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfJHVpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:45:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A751B10CC1E3;
        Tue,  8 Oct 2019 21:45:44 +0000 (UTC)
Received: from [10.36.116.42] (ovpn-116-42.ams2.redhat.com [10.36.116.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E435C1D4;
        Tue,  8 Oct 2019 21:45:42 +0000 (UTC)
Subject: Re: "Shrink zones before removing memory" causes kernel panic with
 kpagecount
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1570565898.5576.314.camel@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <a24d8ccb-67db-4062-b00b-9275755a5605@redhat.com>
Date:   Tue, 8 Oct 2019 23:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570565898.5576.314.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 08 Oct 2019 21:45:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.19 22:18, Qian Cai wrote:
> The linux-next series "mm/memory_hotplug: Shrink zones before removing memory"
> [1] causes a kernel panic while reading /proc/kpagecount after offlining a
> memory section. It was reproduced on both x86 and powerpc. Reverted the whole
> series fixed the problem.
> 
> [1] https://lore.kernel.org/linux-mm/20191006085646.5768-1-david@redhat.com/
> 
> # echo offline > /sys/devices/system/memory/memory124/state 
> # cat /proc/kpagecount
> 
> [  133.268032][ T8809] remove from free list 7c000 256 7d000
> [  133.268134][ T8809] remove from free list 7c100 256 7d000
> [  133.268153][ T8809] remove from free list 7c200 256 7d000
> [  133.268182][ T8809] remove from free list 7c300 256 7d000
> [  133.268212][ T8809] remove from free list 7c400 256 7d000
> [  133.268241][ T8809] remove from free list 7c500 256 7d000
> [  133.268260][ T8809] remove from free list 7c600 256 7d000
> [  133.268289][ T8809] remove from free list 7c700 256 7d000
> [  133.268329][ T8809] remove from free list 7c800 256 7d000
> [  133.268359][ T8809] remove from free list 7c900 256 7d000
> [  133.268399][ T8809] remove from free list 7ca00 256 7d000
> [  133.268429][ T8809] remove from free list 7cb00 256 7d000
> [  133.268458][ T8809] remove from free list 7cc00 256 7d000
> [  133.268488][ T8809] remove from free list 7cd00 256 7d000
> [  133.268517][ T8809] remove from free list 7ce00 256 7d000
> [  133.268546][ T8809] remove from free list 7cf00 256 7d000
> [  133.268580][ T8809] Offlined Pages 4096
> [  144.038732][ T8944] BUG: Unable to handle kernel data access at
> 0xfffffffffffffffe
> [  144.038769][ T8944] Faulting instruction address: 0xc000000000590c08
> [  144.038794][ T8944] Oops: Kernel access of bad area, sig: 11 [#1]
> [  144.038807][ T8944] LE PAGE_SIZE=64K MMU=Radix MMU=Hash SMP NR_CPUS=256
> DEBUG_PAGEALLOC NUMA PowerNV
> [  144.038822][ T8944] Modules linked in: ip_tables x_tables xfs sd_mod bnx2x
> mdio ahci libahci tg3 libata libphy firmware_class dm_mirror dm_region_hash
> dm_log dm_mod
> [  144.038864][ T8944] CPU: 116 PID: 8944 Comm: cat Not tainted 5.4.0-rc2+ #6
> [  144.038898][ T8944] NIP:  c000000000590c08 LR: c000000000577330 CTR:
> c0000000005909d0
> [  144.038945][ T8944] REGS: c00020196bd6fa30 TRAP: 0380   Not tainted  (5.4.0-
> rc2+)
> [  144.038989][ T8944] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
> 48022428  XER: 20040000
> [  144.039028][ T8944] CFAR: c000000000590ad0 IRQMASK: 0 
> [  144.039028][ T8944] GPR00: c000000000577330 c00020196bd6fcc0 c000000001122d00
> c0002009d3d4a880 
> [  144.039028][ T8944] GPR04: 00007fffb6870000 0000000000020000 fffffffffffffffe
> c00c000000000000 
> [  144.039028][ T8944] GPR08: 0000000001f00000 c00c000001f00000 0000000000000001
> c0000000009413d0 
> [  144.039028][ T8944] GPR12: c0000000005909d0 c000201fff677000 0000000000000000
> 0000000000000000 
> [  144.039028][ T8944] GPR16: 0000000000000002 00007fffca34cfa8 ffffffffffffffff
> 0000000000000000 
> [  144.039028][ T8944] GPR20: 0000000000000000 0000000000000000 c000000000000000
> c00020196bd6fdf0 
> [  144.039028][ T8944] GPR24: 00007fffb6870000 0000000007ffffff 0000000000000000
> c000000000aa6c20 
> [  144.039028][ T8944] GPR28: 00007fffb6890000 0000000000000008 000000000007c000
> 00007fffb6870000 
> [  144.039240][ T8944] NIP [c000000000590c08] kpagecount_read+0x238/0x3f0
> [  144.039263][ T8944] LR [c000000000577330] proc_reg_read+0x90/0x130
> [  144.039274][ T8944] Call Trace:
> [  144.039304][ T8944] [c00020196bd6fd30] [c000000000577330]
> proc_reg_read+0x90/0x130
> [  144.039342][ T8944] [c00020196bd6fd60] [c0000000004978bc]
> __vfs_read+0x3c/0x70
> [  144.039377][ T8944] [c00020196bd6fd80] [c00000000049799c] vfs_read+0xac/0x170
> [  144.039423][ T8944] [c00020196bd6fdd0] [c000000000497dfc]
> ksys_read+0x7c/0x140
> [  144.039472][ T8944] [c00020196bd6fe20] [c00000000000b378]
> system_call+0x5c/0x68
> [  144.039495][ T8944] Instruction dump:
> [  144.039513][ T8944] 4e800020 60000000 3d22000d 3929c098 7bc83664 e8e90000
> 7d274215 418200ac 
> [  144.039540][ T8944] e9490008 38caffff 714a0001 7cc9309e <e9460000> 2faaffff
> e9490008 419e00fc 
> [  144.039580][ T8944] ---[ end trace 96fb2ea2d503fda9 ]---
> [  144.492072][ T8944] 
> [  145.492172][ T8944] Kernel panic - not syncing: Fatal exception
> 

Thanks, that's somewhat expected as I taint pages more aggressively.
It's a pre-existing issue. You can trigger the exact same BUG by

1. Hotplugging a DIMM but not onlining it
2. cat /proc/kpagecount

The right fix is to add a pgn_to_online_page() to the PFN walker and
skip all PFNs that are not online. This was already discussed in the
context of ZONE_DEVICE and I am yet waiting for a fix.

I can prepare and send a fix for that PFN walker tomorrow.

-- 

Thanks,

David / dhildenb
