Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C6BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70EB2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHcSWb3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfLQKqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:46:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58518 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbfLQKqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576579606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EM2QWafeZ2TAQB5+5cMaXdVr5dTRW0WKU5lYjY+8TB0=;
        b=DHcSWb3sg2HBHvUAbEXSedTIMX+LsVPaXFYl1RuH0lLW6gMbtRyqR6pZ0TDPAPCVc6z/ji
        R1q54jRSbavRrMiKiAmddFnKH0nV/JU2dq832XgZ4Ob7EYZJcfpCPMV0WnQuduiQf686cI
        Nnxfw5cT6wNU0OsF9qJyhyFwW+IxAXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-n-oX3rutPgWe9bnjGsH9Ew-1; Tue, 17 Dec 2019 05:46:43 -0500
X-MC-Unique: n-oX3rutPgWe9bnjGsH9Ew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 077D763CDA;
        Tue, 17 Dec 2019 10:46:42 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3EEA60BE0;
        Tue, 17 Dec 2019 10:46:37 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v1] mm/memory_hotplug: Don't free usage map when removing a re-added early section
Date:   Tue, 17 Dec 2019 11:46:37 +0100
Message-Id: <20191217104637.5509-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we remove an early section, we don't free the usage map, as the
usage maps of other sections are placed into the same page. Once the
section is removed, it is no longer an early section (especially, the
memmap is freed). When we re-add that section, the usage map is reused,
however, it is no longer an early section. When removing that section
again, we try to kfree() a usage map that was allocated during early
boot - bad.

Let's check against PageReserved() to see if we are dealing with an usage
map that was allocated during boot. We could also check against
!(PageSlab(usage_page) || PageCompound(usage_page)), but PageReserved()
is cleaner.

Can be triggered using memtrace under ppc64/powernv:

$ mount -t debugfs none /sys/kernel/debug/
$ echo 0x20000000 > /sys/kernel/debug/powerpc/memtrace/enable
$ echo 0x20000000 > /sys/kernel/debug/powerpc/memtrace/enable
[   12.093442] ------------[ cut here ]------------
[   12.093469] kernel BUG at mm/slub.c:3969!
[   12.093656] Oops: Exception in kernel mode, sig: 5 [#1]
[   12.093961] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA Powe=
rNV
[   12.094320] Modules linked in:
[   12.094615] CPU: 0 PID: 154 Comm: sh Not tainted 5.5.0-rc2-next-201912=
16-00005-g0be1dba7b7c0 #61
[   12.095066] NIP:  c000000000396b38 LR: c000000000385848 CTR: c00000000=
0143d30
[   12.095427] REGS: c000000073077680 TRAP: 0700   Not tainted  (5.5.0-rc=
2-next-20191216-00005-g0be1dba7b7c0)
[   12.095886] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE=
>  CR: 28004828  XER: 20000000
[   12.096395] CFAR: c000000000396b9c IRQMASK: 0
[   12.096395] GPR00: c000000000385848 c000000073077910 c00000000110f300 =
c00000007ffffc00
[   12.096395] GPR04: 0000000000000000 ffffffffffffffff 0000000000000000 =
0000000000000000
[   12.096395] GPR08: 0000000000000000 0000000000000001 0000000000000000 =
ffffffffffffffc8
[   12.096395] GPR12: 0000000000004000 c0000000012d0000 0000000000001000 =
c000000000d33c78
[   12.096395] GPR16: 0000000000000000 c0000000011bfeb0 ffffffffffffe000 =
c0000000000b6370
[   12.096395] GPR20: ffffffffe0000000 c0000000011411c0 0000000000006000 =
c0000000000b6390
[   12.096395] GPR24: 0000000010000000 0000000000000040 0000000000000000 =
0000000000000000
[   12.096395] GPR28: c000000000385848 c00c0000001fffc0 0000000000004000 =
0000000000000000
[   12.099882] NIP [c000000000396b38] kfree+0x338/0x3b0
[   12.100135] LR [c000000000385848] section_deactivate+0x138/0x200
[   12.100508] Call Trace:
[   12.100927] [c000000073077910] [c0000000010599a8] 0xc0000000010599a8 (=
unreliable)
[   12.101338] [c000000073077960] [c000000000385848] section_deactivate+0=
x138/0x200
[   12.101696] [c000000073077a10] [c00000000039b9f4] __remove_pages+0x114=
/0x150
[   12.102025] [c000000073077a60] [c00000000006793c] arch_remove_memory+0=
x3c/0x160
[   12.102381] [c000000073077ae0] [c00000000039c154] try_remove_memory+0x=
114/0x1a0
[   12.102715] [c000000073077b90] [c00000000039c020] __remove_memory+0x20=
/0x40
[   12.103041] [c000000073077bb0] [c0000000000b6714] memtrace_enable_set+=
0x254/0x850
[   12.103402] [c000000073077cb0] [c0000000004197e8] simple_attr_write+0x=
138/0x160
[   12.103751] [c000000073077d10] [c000000000558c9c] full_proxy_write+0x8=
c/0x110
[   12.104100] [c000000073077d60] [c0000000003d02a8] __vfs_write+0x38/0x7=
0
[   12.104409] [c000000073077d80] [c0000000003d3c5c] vfs_write+0x11c/0x2a=
0
[   12.104711] [c000000073077dd0] [c0000000003d4054] ksys_write+0x84/0x14=
0
[   12.105011] [c000000073077e20] [c00000000000b594] system_call+0x5c/0x6=
8
[   12.105357] Instruction dump:
[   12.105606] e93d0000 75290001 41820090 8bfd0051 38a0ffff 7ca5f830 7bff=
0020 7ca507b4
[   12.105993] e95d0000 39200000 754a0001 4182005c <0b090000> 893d0007 3d=
42000b 38800006
[   12.106583] ---[ end trace 4b053cbd84e0db62 ]---

The first invocation will offline+remove memory blocks. The second
invocation will first add+online them again, in order to offline+remove
them again (usually we are lucky and the exact same memory blocks will
get "reallocated").

Tested on powernv with boot memory: The usage map will not get freed.
Tested on x86-64 with DIMMs: The usage map will get freed.

Fixes: 326e1b8f83a4 ("mm/sparsemem: introduce a SECTION_IS_EARLY flag")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/sparse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index b20ab7cdac86..3822ecbd8a1f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -777,7 +777,14 @@ static void section_deactivate(unsigned long pfn, un=
signed long nr_pages,
 	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
 		unsigned long section_nr =3D pfn_to_section_nr(pfn);
=20
-		if (!section_is_early) {
+		/*
+		 * When removing an early section, the usage map is kept (as the
+		 * usage maps of other sections fall into the same page). It
+		 * will be re-used when re-adding the section - which is then no
+		 * longer an early section. If the usage map is PageReserved, it
+		 * was allocated during boot.
+		 */
+		if (!PageReserved(virt_to_page(ms->usage))) {
 			kfree(ms->usage);
 			ms->usage =3D NULL;
 		}
--=20
2.23.0

