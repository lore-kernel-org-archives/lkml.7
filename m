Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF609C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72754207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hvh0SPyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfKYHcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 02:32:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39194 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725747AbfKYHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 02:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574667139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MKtIx1qNzHvJmmIJepB7/8v3rLE0brG9e0sGrqm/hmA=;
        b=Hvh0SPyMdmG6lm3XIXiWSDRMOwAuLT7NF8/Su3pghdPeqrprAO8WkZb2T4uWe9KjKtyOyd
        JDEqshKyLXQy4n4fada3N++0qPJCH15BZs9CLjqAP2FmLHkHbsRHVjb7ueEuHH6gPa4QGT
        3yGacI/vPOKSzpKyqGQGWRx+2mxKKSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-nWDHVzLvOPqpHKAOsVXBzA-1; Mon, 25 Nov 2019 02:32:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69BD3107ACE4;
        Mon, 25 Nov 2019 07:32:15 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 326A55D6AE;
        Mon, 25 Nov 2019 07:32:13 +0000 (UTC)
Subject: Re: "Revisit iommu_insert_resv_region() implementation" causes
 use-after-free
To:     Qian Cai <cai@lca.pw>, Joerg Roedel <jroedel@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1574435179.9585.21.camel@lca.pw>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <1b86895e-98d5-0127-1ea8-74a7ba21ad09@redhat.com>
Date:   Mon, 25 Nov 2019 08:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574435179.9585.21.camel@lca.pw>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: nWDHVzLvOPqpHKAOsVXBzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/22/19 4:06 PM, Qian Cai wrote:
> Read files under /sys/kernel/iommu_groups/ triggers an use-after-free. Re=
verted
> the commit 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
> implementation") fixed the issue.

Thanks for testing and reporting this.

I've worked on this during the WE but until now I am not able to
reproduce myself or find the issue by review. Since the beginning I have
been testing the algo with a char device driver, injecting various
regions to insert and test whether they are correctly collected and merged.

About the test itself did you try to read the file at specific moments
or with specific concurrency constraints?

About KASAN, did you use the INLINE or OUTLINE config, if it were to
change anything?
>=20
> /* no merge needed on elements of different types than @nr */
> if (iter->type !=3D nr->type) {
> =09list_move_tail(&iter->list, &stack);
I guess this is the place where the use of dangling pointer happens?
> =09continue;>
> [=C2=A0=C2=A0160.156964][ T3100] BUG: KASAN: use-after-free in
> iommu_insert_resv_region+0x34b/0x520
> [=C2=A0=C2=A0160.197758][ T3100] Read of size 4 at addr ffff8887aba78464 =
by task cat/3100
> [=C2=A0=C2=A0160.230645][ T3100]=C2=A0
> [=C2=A0=C2=A0160.240907][ T3100] CPU: 14 PID: 3100 Comm: cat Not tainted =
5.4.0-rc8-next-
> 20191122+ #11
> [=C2=A0=C2=A0160.278671][ T3100] Hardware name: HP ProLiant XL420 Gen9/Pr=
oLiant XL420
> Gen9, BIOS U19 12/27/2015
> [=C2=A0=C2=A0160.320589][ T3100] Call Trace:
> [=C2=A0=C2=A0160.335229][ T3100]=C2=A0=C2=A0dump_stack+0xa0/0xea
> [=C2=A0=C2=A0160.354011][ T3100]=C2=A0=C2=A0print_address_description.con=
stprop.5.cold.7+0x9/0x384
> [=C2=A0=C2=A0160.386569][ T3100]=C2=A0=C2=A0__kasan_report.cold.8+0x7a/0x=
c0
> [=C2=A0=C2=A0160.409811][ T3100]=C2=A0=C2=A0? iommu_insert_resv_region+0x=
34b/0x520
> [=C2=A0=C2=A0160.435668][ T3100]=C2=A0=C2=A0kasan_report+0x12/0x20
> [=C2=A0=C2=A0160.455387][ T3100]=C2=A0=C2=A0__asan_load4+0x95/0xa0
> [=C2=A0=C2=A0160.474808][ T3100]=C2=A0=C2=A0iommu_insert_resv_region+0x34=
b/0x520
> [=C2=A0=C2=A0160.500228][ T3100]=C2=A0=C2=A0? iommu_bus_notifier+0xe0/0xe=
0
> [=C2=A0=C2=A0160.522904][ T3100]=C2=A0=C2=A0? intel_iommu_get_resv_region=
s+0x348/0x400
> [=C2=A0=C2=A0160.550461][ T3100]=C2=A0=C2=A0iommu_get_group_resv_regions+=
0x16d/0x2f0
> [=C2=A0=C2=A0160.577611][ T3100]=C2=A0=C2=A0? iommu_insert_resv_region+0x=
520/0x520
> [=C2=A0=C2=A0160.603756][ T3100]=C2=A0=C2=A0? register_lock_class+0x940/0=
x940
> [=C2=A0=C2=A0160.628265][ T3100]=C2=A0=C2=A0iommu_group_show_resv_regions=
+0x8d/0x1f0
> [=C2=A0=C2=A0160.655370][ T3100]=C2=A0=C2=A0? iommu_get_group_resv_region=
s+0x2f0/0x2f0
> [=C2=A0=C2=A0160.684168][ T3100]=C2=A0=C2=A0iommu_group_attr_show+0x34/0x=
50
> [=C2=A0=C2=A0160.708395][ T3100]=C2=A0=C2=A0sysfs_kf_seq_show+0x11c/0x220
> [=C2=A0=C2=A0160.731758][ T3100]=C2=A0=C2=A0? iommu_default_passthrough+0=
x20/0x20
> [=C2=A0=C2=A0160.756898][ T3100]=C2=A0=C2=A0kernfs_seq_show+0xa4/0xb0
> [=C2=A0=C2=A0160.777097][ T3100]=C2=A0=C2=A0seq_read+0x27e/0x710
> [=C2=A0=C2=A0160.795195][ T3100]=C2=A0=C2=A0kernfs_fop_read+0x7d/0x2c0
> [=C2=A0=C2=A0160.815349][ T3100]=C2=A0=C2=A0__vfs_read+0x50/0xa0
> [=C2=A0=C2=A0160.834154][ T3100]=C2=A0=C2=A0vfs_read+0xcb/0x1e0
> [=C2=A0=C2=A0160.852332][ T3100]=C2=A0=C2=A0ksys_read+0xc6/0x160
> [=C2=A0=C2=A0160.871028][ T3100]=C2=A0=C2=A0? kernel_write+0xc0/0xc0
> [=C2=A0=C2=A0160.891307][ T3100]=C2=A0=C2=A0? do_syscall_64+0x79/0xaec
> [=C2=A0=C2=A0160.912446][ T3100]=C2=A0=C2=A0? do_syscall_64+0x79/0xaec
> [=C2=A0=C2=A0160.933640][ T3100]=C2=A0=C2=A0__x64_sys_read+0x43/0x50
> [=C2=A0=C2=A0160.953957][ T3100]=C2=A0=C2=A0do_syscall_64+0xcc/0xaec
> [=C2=A0=C2=A0160.974322][ T3100]=C2=A0=C2=A0? trace_hardirqs_on_thunk+0x1=
a/0x1c
> [=C2=A0=C2=A0160.999130][ T3100]=C2=A0=C2=A0? syscall_return_slowpath+0x5=
80/0x580
> [=C2=A0=C2=A0161.024753][ T3100]=C2=A0=C2=A0? entry_SYSCALL_64_after_hwfr=
ame+0x3e/0xbe
> [=C2=A0=C2=A0161.052416][ T3100]=C2=A0=C2=A0? trace_hardirqs_off_caller+0=
x3a/0x150
> [=C2=A0=C2=A0161.078400][ T3100]=C2=A0=C2=A0? trace_hardirqs_off_thunk+0x=
1a/0x1c
> [=C2=A0=C2=A0161.103711][ T3100]=C2=A0=C2=A0entry_SYSCALL_64_after_hwfram=
e+0x49/0xbe
> [=C2=A0=C2=A0161.130793][ T3100] RIP: 0033:0x7f33e0d89d75
> [=C2=A0=C2=A0161.150732][ T3100] Code: fe ff ff 50 48 8d 3d 4a dc 09 00 e=
8 25 0e 02 00 0f
> 1f 44 00 00 f3 0f 1e fa 48 8d 05 a5 59 2d 00 8b 00 85 c0 75 0f 31 c0 0f 0=
5 <48>
> 3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89
> [=C2=A0=C2=A0161.245503][ T3100] RSP: 002b:00007fff88f0db88 EFLAGS: 00000=
246 ORIG_RAX:
> 0000000000000000
> [=C2=A0=C2=A0161.284547][ T3100] RAX: ffffffffffffffda RBX: 0000000000020=
000 RCX:
> 00007f33e0d89d75
> [=C2=A0=C2=A0161.321123][ T3100] RDX: 0000000000020000 RSI: 00007f33e1201=
000 RDI:
> 0000000000000003
> [=C2=A0=C2=A0161.357617][ T3100] RBP: 00007f33e1201000 R08: 00000000fffff=
fff R09:
> 0000000000000000
> [=C2=A0=C2=A0161.394173][ T3100] R10: 0000000000000022 R11: 0000000000000=
246 R12:
> 00007f33e1201000
> [=C2=A0=C2=A0161.430736][ T3100] R13: 0000000000000003 R14: 0000000000000=
fff R15:
> 0000000000020000
> [=C2=A0=C2=A0161.467337][ T3100]=C2=A0
> [=C2=A0=C2=A0161.477529][ T3100] Allocated by task 3100:
> [=C2=A0=C2=A0161.497133][ T3100]=C2=A0=C2=A0save_stack+0x21/0x90
> [=C2=A0=C2=A0161.515777][ T3100]=C2=A0=C2=A0__kasan_kmalloc.constprop.13+=
0xc1/0xd0
> [=C2=A0=C2=A0161.541743][ T3100]=C2=A0=C2=A0kasan_kmalloc+0x9/0x10
> [=C2=A0=C2=A0161.561330][ T3100]=C2=A0=C2=A0kmem_cache_alloc_trace+0x1f8/=
0x470
> [=C2=A0=C2=A0161.585949][ T3100]=C2=A0=C2=A0iommu_insert_resv_region+0xeb=
/0x520
> [=C2=A0=C2=A0161.610876][ T3100]=C2=A0=C2=A0iommu_get_group_resv_regions+=
0x16d/0x2f0
> [=C2=A0=C2=A0161.638318][ T3100]=C2=A0=C2=A0iommu_group_show_resv_regions=
+0x8d/0x1f0
> [=C2=A0=C2=A0161.665322][ T3100]=C2=A0=C2=A0iommu_group_attr_show+0x34/0x=
50
> [=C2=A0=C2=A0161.688526][ T3100]=C2=A0=C2=A0sysfs_kf_seq_show+0x11c/0x220
> [=C2=A0=C2=A0161.711992][ T3100]=C2=A0=C2=A0kernfs_seq_show+0xa4/0xb0
> [=C2=A0=C2=A0161.734252][ T3100]=C2=A0=C2=A0seq_read+0x27e/0x710
> [=C2=A0=C2=A0161.754412][ T3100]=C2=A0=C2=A0kernfs_fop_read+0x7d/0x2c0
> [=C2=A0=C2=A0161.775493][ T3100]=C2=A0=C2=A0__vfs_read+0x50/0xa0
> [=C2=A0=C2=A0161.794328][ T3100]=C2=A0=C2=A0vfs_read+0xcb/0x1e0
> [=C2=A0=C2=A0161.812559][ T3100]=C2=A0=C2=A0ksys_read+0xc6/0x160
> [=C2=A0=C2=A0161.831554][ T3100]=C2=A0=C2=A0__x64_sys_read+0x43/0x50
> [=C2=A0=C2=A0161.851772][ T3100]=C2=A0=C2=A0do_syscall_64+0xcc/0xaec
> [=C2=A0=C2=A0161.872098][ T3100]=C2=A0=C2=A0entry_SYSCALL_64_after_hwfram=
e+0x49/0xbe
> [=C2=A0=C2=A0161.898919][ T3100]=C2=A0
> [=C2=A0=C2=A0161.909113][ T3100] Freed by task 3100:
> [=C2=A0=C2=A0161.927070][ T3100]=C2=A0=C2=A0save_stack+0x21/0x90
> [=C2=A0=C2=A0161.945711][ T3100]=C2=A0=C2=A0__kasan_slab_free+0x11c/0x170
> [=C2=A0=C2=A0161.968112][ T3100]=C2=A0=C2=A0kasan_slab_free+0xe/0x10
> [=C2=A0=C2=A0161.988601][ T3100]=C2=A0=C2=A0slab_free_freelist_hook+0x5f/=
0x1d0
> [=C2=A0=C2=A0162.012918][ T3100]=C2=A0=C2=A0kfree+0xe9/0x410
Do I understand correctly that the use after free happens in the same
execution of iommu_insert_resv_region and kfree is done in the
check_overlap part?

> [=C2=A0=C2=A0162.029454][ T3100]=C2=A0=C2=A0iommu_insert_resv_region+0x47=
d/0x520
> [=C2=A0=C2=A0162.053701][ T3100]=C2=A0=C2=A0iommu_get_group_resv_regions+=
0x16d/0x2f0
> [=C2=A0=C2=A0162.079671][ T3100]=C2=A0=C2=A0iommu_group_show_resv_regions=
+0x8d/0x1f0
> [=C2=A0=C2=A0162.105484][ T3100]=C2=A0=C2=A0iommu_group_attr_show+0x34/0x=
50
> [=C2=A0=C2=A0162.127709][ T3100]=C2=A0=C2=A0sysfs_kf_seq_show+0x11c/0x220
> [=C2=A0=C2=A0162.149250][ T3100]=C2=A0=C2=A0kernfs_seq_show+0xa4/0xb0
> [=C2=A0=C2=A0162.169085][ T3100]=C2=A0=C2=A0seq_read+0x27e/0x710
> [=C2=A0=C2=A0162.187038][ T3100]=C2=A0=C2=A0kernfs_fop_read+0x7d/0x2c0
> [=C2=A0=C2=A0162.207391][ T3100]=C2=A0=C2=A0__vfs_read+0x50/0xa0
> [=C2=A0=C2=A0162.227829][ T3100]=C2=A0=C2=A0vfs_read+0xcb/0x1e0
> [=C2=A0=C2=A0162.247788][ T3100]=C2=A0=C2=A0ksys_read+0xc6/0x160
> [=C2=A0=C2=A0162.265471][ T3100]=C2=A0=C2=A0__x64_sys_read+0x43/0x50
> [=C2=A0=C2=A0162.285041][ T3100]=C2=A0=C2=A0do_syscall_64+0xcc/0xaec
> [=C2=A0=C2=A0162.304627][ T3100]=C2=A0=C2=A0entry_SYSCALL_64_after_hwfram=
e+0x49/0xbe
> [=C2=A0=C2=A0162.330429][ T3100]=C2=A0
> [=C2=A0=C2=A0162.340199][ T3100] The buggy address belongs to the object =
at
> ffff8887aba78440
> [=C2=A0=C2=A0162.340199][ T3100]=C2=A0=C2=A0which belongs to the cache km=
alloc-64 of size 64
> [=C2=A0=C2=A0162.402050][ T3100] The buggy address is located 36 bytes in=
side of
> [=C2=A0=C2=A0162.402050][ T3100]=C2=A0=C2=A064-byte region [ffff8887aba78=
440, ffff8887aba78480)
> [=C2=A0=C2=A0162.460127][ T3100] The buggy address belongs to the page:
> [=C2=A0=C2=A0162.484696][ T3100] page:ffffea001eae9e00 refcount:1 mapcoun=
t:0
> mapping:ffff888207c02ac0 index:0xffff8887aba78e40
> [=C2=A0=C2=A0162.531045][ T3100] raw: 015fffe000000200 ffff888487c00740 f=
fff888487c00740
> ffff888207c02ac0
> [=C2=A0=C2=A0162.569455][ T3100] raw: ffff8887aba78e40 0000000000080003 0=
0000001ffffffff
> 0000000000000000
> [=C2=A0=C2=A0162.607801][ T3100] page dumped because: kasan: bad access d=
etected
> [=C2=A0=C2=A0162.636603][ T3100] page_owner tracks the page as allocated
> [=C2=A0=C2=A0162.661634][ T3100] page last allocated via order 0, migrate=
type Unmovable,
> gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY)
> [=C2=A0=C2=A0162.716310][ T3100]=C2=A0=C2=A0prep_new_page+0x2ed/0x310
> [=C2=A0=C2=A0162.739158][ T3100]=C2=A0=C2=A0get_page_from_freelist+0x20bb=
/0x3090
> [=C2=A0=C2=A0162.765017][ T3100]=C2=A0=C2=A0__alloc_pages_nodemask+0x2e4/=
0x720
> [=C2=A0=C2=A0162.788440][ T3100]=C2=A0=C2=A0alloc_pages_current+0x9c/0x11=
0
> [=C2=A0=C2=A0162.810324][ T3100]=C2=A0=C2=A0alloc_slab_page+0xc9/0x4e0
> [=C2=A0=C2=A0162.831044][ T3100]=C2=A0=C2=A0allocate_slab+0x70/0x5d0
> [=C2=A0=C2=A0162.851450][ T3100]=C2=A0=C2=A0new_slab+0x46/0x70
> [=C2=A0=C2=A0162.869326][ T3100]=C2=A0=C2=A0___slab_alloc+0x4ab/0x7b0
> [=C2=A0=C2=A0162.889554][ T3100]=C2=A0=C2=A0__slab_alloc+0x43/0x70
> [=C2=A0=C2=A0162.908430][ T3100]=C2=A0=C2=A0kmem_cache_alloc_trace+0x2f1/=
0x470
> [=C2=A0=C2=A0162.932036][ T3100]=C2=A0=C2=A0iommu_insert_resv_region+0xeb=
/0x520
> [=C2=A0=C2=A0162.956179][ T3100]=C2=A0=C2=A0iommu_get_group_resv_regions+=
0x16d/0x2f0
> [=C2=A0=C2=A0162.982083][ T3100]=C2=A0=C2=A0iommu_group_show_resv_regions=
+0x8d/0x1f0
> [=C2=A0=C2=A0163.008373][ T3100]=C2=A0=C2=A0iommu_group_attr_show+0x34/0x=
50
> [=C2=A0=C2=A0163.030557][ T3100]=C2=A0=C2=A0sysfs_kf_seq_show+0x11c/0x220
> [=C2=A0=C2=A0163.052038][ T3100]=C2=A0=C2=A0kernfs_seq_show+0xa4/0xb0
> [=C2=A0=C2=A0163.072179][ T3100] page last free stack trace:
> [=C2=A0=C2=A0163.092612][ T3100]=C2=A0=C2=A0__free_pages_ok+0xa3e/0xb20
> [=C2=A0=C2=A0163.113361][ T3100]=C2=A0=C2=A0__free_pages+0x94/0xd0
> [=C2=A0=C2=A0163.132198][ T3100]=C2=A0=C2=A0__free_slab+0x177/0x520
> [=C2=A0=C2=A0163.150922][ T3100]=C2=A0=C2=A0discard_slab+0x41/0x80
> [=C2=A0=C2=A0163.169708][ T3100]=C2=A0=C2=A0__slab_free+0x4b7/0x520
> [=C2=A0=C2=A0163.188856][ T3100]=C2=A0=C2=A0___cache_free+0xc3/0x120
> [=C2=A0=C2=A0163.208452][ T3100]=C2=A0=C2=A0qlist_free_all+0x44/0xa0
> [=C2=A0=C2=A0163.228335][ T3100]=C2=A0=C2=A0quarantine_reduce+0x1b0/0x240
> [=C2=A0=C2=A0163.253120][ T3100]=C2=A0=C2=A0__kasan_kmalloc.constprop.13+=
0x98/0xd0
> [=C2=A0=C2=A0163.279865][ T3100]=C2=A0=C2=A0kasan_slab_alloc+0x11/0x20
> [=C2=A0=C2=A0163.300175][ T3100]=C2=A0=C2=A0kmem_cache_alloc+0x17a/0x450
> [=C2=A0=C2=A0163.321373][ T3100]=C2=A0=C2=A0ptlock_alloc+0x20/0x50
> [=C2=A0=C2=A0163.340168][ T3100]=C2=A0=C2=A0pte_alloc_one+0x40/0xf0
> [=C2=A0=C2=A0163.359310][ T3100]=C2=A0=C2=A0__handle_mm_fault+0x1257/0x13=
00
> [=C2=A0=C2=A0163.381603][ T3100]=C2=A0=C2=A0handle_mm_fault+0x205/0x4c0
> [=C2=A0=C2=A0163.402312][ T3100]=C2=A0=C2=A0__do_page_fault+0x29c/0x640
> [=C2=A0=C2=A0163.423082][ T3100]=C2=A0
> [=C2=A0=C2=A0163.432556][ T3100] Memory state around the buggy address:
> [=C2=A0=C2=A0163.457292][ T3100]=C2=A0=C2=A0ffff8887aba78300: fc fc fc fc=
 fc fc fc fc fc fc fc fc fc
> fc fc fc
> [=C2=A0=C2=A0163.492994][ T3100]=C2=A0=C2=A0ffff8887aba78380: fc fc fc fc=
 fc fc fc fc fc fc fc fc fc
> fc fc fc
> [=C2=A0=C2=A0163.528530][ T3100] >ffff8887aba78400: fc fc fc fc fc fc fc =
fc fb fb fb fb fb
> fb fb fb
> [=C2=A0=C2=A0163.565023][ T3100]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> [=C2=A0=C2=A0163.598027][ T3100]=C2=A0=C2=A0ffff8887aba78480: fc fc fc fc=
 fc fc fc fc fc fc fc fc fc
> fc fc fc
> [=C2=A0=C2=A0163.633747][ T3100]=C2=A0=C2=A0ffff8887aba78500: fc fc fc fc=
 fc fc fc fc fc fc fc fc fc
> fc fc fc
> [=C2=A0=C2=A0163.669828][ T3100]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0=C2=A0163.705417][ T3100] Disabling lock debugging due to kernel t=
aint
>=20
Thanks

Eric

