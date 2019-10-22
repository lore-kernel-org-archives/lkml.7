Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B74CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DBB214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E31SHK/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbfJVIcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:32:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28137 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388086AbfJVIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571733142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dc2umbkKVz4f5hnZVLJiec/QWg7rqFClZGhjSv2za1w=;
        b=E31SHK/62aoXqKO4+kqyrxTzc6g8NytQPYgEZNxVyIbhMDToN7sP3XfYno1Xp0MXo0d2Bv
        UCpKnv9wLVcRa6bAdPmyy7PgApHZrGcTtvSBiIq++odtq28QU01Ldh2Z+USNIGsJjbUWpY
        f1UnXRhF6s2Dc8pf6qh4V7v7jUpwtxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-aZEEnpg9OfyWojsOJzqmiw-1; Tue, 22 Oct 2019 04:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B9C31005500;
        Tue, 22 Oct 2019 08:32:15 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE8CE5C1D4;
        Tue, 22 Oct 2019 08:32:11 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
References: <20191021172353.3056-1-david@redhat.com>
 <25d3f071-3268-298b-e0c8-9c307d1015fe@redhat.com>
 <20191022080835.GZ9379@dhcp22.suse.cz>
 <1f56744d-2c22-6c12-8fe8-4a71e791c467@redhat.com>
 <20191022082131.GC9379@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
Date:   Tue, 22 Oct 2019 10:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022082131.GC9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: aZEEnpg9OfyWojsOJzqmiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.19 10:21, Michal Hocko wrote:
> On Tue 22-10-19 10:15:07, David Hildenbrand wrote:
>> On 22.10.19 10:08, Michal Hocko wrote:
>>> On Tue 22-10-19 08:52:28, David Hildenbrand wrote:
>>>> On 21.10.19 19:23, David Hildenbrand wrote:
>>>>> Two cleanups that popped up while working on (and discussing) virtio-=
mem:
>>>>>     https://lkml.org/lkml/2019/9/19/463
>>>>>
>>>>> Tested with DIMMs on x86.
>>>>>
>>>>> As discussed with michal in v1, I'll soon look into removing the use
>>>>> of PG_reserved during memory onlining completely - most probably
>>>>> disallowing to offline memory blocks with holes, cleaning up the
>>>>> onlining+offlining code.
>>>>
>>>> BTW, I remember that ZONE_DEVICE pages are still required to be set
>>>> PG_reserved. That has to be sorted out first.
>>>
>>> Do they?
>>
>> Yes, especially KVM code :/
>=20
> Details please?
>=20


E.g., arch/x86/kvm/mmu.c:kvm_is_mmio_pfn()

And I currently have


From 55606751b67989bd06d17844a6bcfbf85d44ee69 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 22 Oct 2019 10:08:04 +0200
Subject: [PATCH v1] KVM: x86/mmu: Prepare kvm_is_mmio_pfn() for PG_reserved
 changes

Right now, ZONE_DEVICE memory is always set PG_reserved. We want to
change that in the future.

KVM has this weird use case that you can map anything from /dev/mem
into the guest. pfn_valid() is not a reliable check whether the memmap
was initialized and can be touched. pfn_to_online_page() makes sure
that we have an initialized memmap - however, there is no reliable and
fast check to detect memmaps that were initialized and are ZONE_DEVICE.

Let's rewrite kvm_is_mmio_pfn() so we really only touch initialized
memmaps that are guaranteed to not contain garbage. Make sure that
RAM without a memmap is still not detected as MMIO and that ZONE_DEVICE
that is not UC/UC-/WC is not detected as MMIO.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/kvm/mmu.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 24c23c66b226..c91c9a5d14dc 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2962,23 +2962,29 @@ static bool mmu_need_write_protect(struct kvm_vcpu =
*vcpu, gfn_t gfn,
=20
 static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 {
-=09if (pfn_valid(pfn))
-=09=09return !is_zero_pfn(pfn) && PageReserved(pfn_to_page(pfn)) &&
-=09=09=09/*
-=09=09=09 * Some reserved pages, such as those from NVDIMM
-=09=09=09 * DAX devices, are not for MMIO, and can be mapped
-=09=09=09 * with cached memory type for better performance.
-=09=09=09 * However, the above check misconceives those pages
-=09=09=09 * as MMIO, and results in KVM mapping them with UC
-=09=09=09 * memory type, which would hurt the performance.
-=09=09=09 * Therefore, we check the host memory type in addition
-=09=09=09 * and only treat UC/UC-/WC pages as MMIO.
-=09=09=09 */
-=09=09=09(!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
+=09struct page *page =3D pfn_to_online_page(pfn);
+
+=09/*
+=09 * Online pages consist of pages managed by the buddy. Especially,
+=09 * ZONE_DEVICE pages are never online. Online pages that are reserved
+=09 * indicate the zero page and MMIO pages.
+=09 */
+=09if (page)
+=09=09return !is_zero_pfn(pfn) && PageReserved(pfn_to_page(pfn));
=20
-=09return !e820__mapped_raw_any(pfn_to_hpa(pfn),
-=09=09=09=09     pfn_to_hpa(pfn + 1) - 1,
-=09=09=09=09     E820_TYPE_RAM);
+=09/*
+=09 * Any RAM that is not online (e.g., mapped via /dev/mem without
+=09 * a memmap or with an uninitialized memmap) is not MMIO.
+=09 */
+=09if (e820__mapped_raw_any(pfn_to_hpa(pfn), pfn_to_hpa(pfn + 1) - 1,
+=09=09=09=09 E820_TYPE_RAM))
+=09=09return false;
+
+=09/*
+=09 * Finally, anything with a valid memmap could be ZONE_DEVICE - or the
+=09 * memmap could be uninitialized. Treat only UC/UC-/WC pages as MMIO.
+=09 */
+=09return pfn_valid() && !pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn);
 }
=20
 /* Bits which may be returned by set_spte() */
--=20
2.21.0




And also virt/kvm/kvm_main.c:kvm_is_reserved_pfn()


From 928be02b293750e6076c8622268ba41ecd8819e9 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 22 Oct 2019 10:26:46 +0200
Subject: [PATCH v1] KVM:Prepare kvm_is_reserved_pfn() for PG_reserved chang=
es

Right now, ZONE_DEVICE memory is always set PG_reserved. We want to
change that in the future.

KVM has this weird use case that you can map anything from /dev/mem
into the guest. pfn_valid() is not a reliable check whether the memmap
was initialized and can be touched. pfn_to_online_page() makes sure
that we have an initialized memmap. Note that ZONE_DEVICE memory is
never online (IOW, managed by the buddy).

Switching to pfn_to_online_page() keeps the existing behavior for
PFNs without a memmap and for ZONE_DEVICE memory. They are treated as
reserved and the page is not touched (e.g., to set it dirty or accessed).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 virt/kvm/kvm_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 66a977472a1c..b98d5d44c2b8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -151,9 +151,15 @@ __weak int kvm_arch_mmu_notifier_invalidate_range(stru=
ct kvm *kvm,
=20
 bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 {
-=09if (pfn_valid(pfn))
-=09=09return PageReserved(pfn_to_page(pfn));
+=09struct page *page =3D pfn_to_online_page(pfn);
=20
+=09/*
+=09 * We treat any pages that are not online  (not managed by the buddy)
+=09 * as reserved - this includes ZONE_DEVICE pages and pages without
+=09 * a memmap (e.g.., mapped via /dev/mem).
+=09 */
+=09if (page)
+=09=09return PageReserved(pfn_to_page(pfn));
 =09return true;
 }
=20
--=20
2.21.0



I'd like to note that the pfn_valid() check in __kvm_map_gfn() is also bogu=
s,
but switching pfn_to_online_page() is not possible, as we would treat
ZONE_DEVICE memory differently then.

--=20

Thanks,

David / dhildenb

