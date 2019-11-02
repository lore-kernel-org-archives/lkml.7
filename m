Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4717CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B174921906
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtN6RuT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKBLYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:24:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54654 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726939AbfKBLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572693840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYxznwBlff51oTY0T/3kF9sJKP54f67dFipH+ZtQLPo=;
        b=dtN6RuT4cdkFpFs6mmiDF83OVKFYJPvsUxmh9G1k0GftByXz0WtJkhCH8Fq1os+SOhxIdv
        dI5ITignCXy2d3wvmpDoN9jUHavH4Sysc5GTo1LePsQT62p1SJJsyC/Z4ShYODEMoyDpVS
        Y0RxtBiOY50W1UdT4e5UWoVuTRwgD2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-87shtdxlNnOYgmCCtnFLPg-1; Sat, 02 Nov 2019 07:23:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 906E32A3;
        Sat,  2 Nov 2019 11:23:56 +0000 (UTC)
Received: from [10.36.116.109] (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 533045C54A;
        Sat,  2 Nov 2019 11:23:53 +0000 (UTC)
Subject: Re: [PATCH v2] mm/memory_hotplug: Fix try_offline_node()
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Tang Chen <tangchen@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20191101221118.5959-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3e6849d9-b6d8-521b-394d-6747b85592f2@redhat.com>
Date:   Sat, 2 Nov 2019 12:23:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101221118.5959-1-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 87shtdxlNnOYgmCCtnFLPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.19 23:11, David Hildenbrand wrote:
> try_offline_node() is pretty much broken right now:
> - The node span is updated when onlining memory, not when adding it. We
>    ignore memory that was mever onlined. Bad.
> - We touch possible garbage memmaps. The pfn_to_nid(pfn) can easily
>    trigger a kernel panic. Bad for memory that is offline but also bad
>    for subsection hotadd with ZONE_DEVICE, whereby the memmap of the firs=
t
>    PFN of a section might contain garbage.
> - Sections belonging to mixed nodes are not properly considered.
>=20
> As memory blocks might belong to multiple nodes, we would have to walk al=
l
> pageblocks (or at least subsections) within present sections. However,
> we don't have a way to identify whether a memmap that is not online was
> initialized (relevant for ZONE_DEVICE). This makes things more complicate=
d.
>=20
> Luckily, we can piggy pack on the node span and the nid stored in
> memory blocks. Currently, the node span is grown when calling
> move_pfn_range_to_zone() - e.g., when onlining memory, and shrunk when
> removing memory, before calling try_offline_node(). Sysfs links are
> created via link_mem_sections(), e.g., during boot or when adding memory.
>=20
> If the node still spans memory or if any memory block belongs to the
> nid, we don't set the node offline. As memory blocks that span multiple
> nodes cannot get offlined, the nid stored in memory blocks is reliable
> enough (for such online memory blocks, the node still spans the memory).
>=20
> Note: We will soon stop shrinking the ZONE_DEVICE zone and the node span
> when removing ZONE_DEVICE memory to fix similar issues (access of garbage
> memmaps) - until we have a reliable way to identify whether these memmaps
> were properly initialized. This implies later, that once a node had
> ZONE_DEVICE memory, we won't be able to set a node offline -
> which should be acceptable.
>=20
> Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
> memory to zones until online") memory that is added is not assoziated
> with a zone/node (memmap not initialized). The introducing
> commit 60a5a19e7419 ("memory-hotplug: remove sysfs file of node") already
> missed that we could have multiple nodes for a section and that the
> zone/node span is updated when onlining pages, not when adding them.
>=20
> I tested this by hotplugging two DIMMs to a memory-less and cpu-less NUMA
> node. The node is properly onlined when adding the DIMMs. When removing
> the DIMMs, the node is properly offlined.
>=20
> Fixes: 60a5a19e7419 ("memory-hotplug: remove sysfs file of node")
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memor=
y to zones until online") # visiable after d0dc12e86b319
> Cc: Tang Chen <tangchen@cn.fujitsu.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> v1 -> v2:
> - Drop sysfs handling, simplify, and add a comment
> - Make sure to include last section fully
>=20
> We stop shrinking the ZONE_DEVICE zone after the following patch:
>   [PATCH v6 04/10] mm/memory_hotplug: Don't access uninitialized memmaps
>   in shrink_zone_span()
> This implies, the above note regarding ZONE_DEVICE on a node blocking a
> node from getting offlined until we sorted out how to properly shrink
> the ZONE_DEVICE zone.
>=20
> This patch is especially important for:
>   [PATCH v6 05/10] mm/memory_hotplug: Shrink zones when offlining
>   memory
> As the BUG fixed with this patch becomes now easier to observe when memor=
y
> is offlined (in contrast to when memory would never have been onlined
> before).
>=20
> As both patches are stable fixes and in next/master for a long time, we
> should probably pull this patch in front of both and also backport this
> patch at least to
>   Cc: stable@vger.kernel.org # v4.13+
> I have not checked yet if there are real blockers to do that. I guess not=
.
>=20
> ---
>   mm/memory_hotplug.c | 45 +++++++++++++++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 16 deletions(-)
>=20
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0140c20837b6..b5f696491577 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1634,6 +1634,18 @@ static int check_cpu_on_node(pg_data_t *pgdat)
>   =09return 0;
>   }
>  =20
> +static int check_no_memblock_for_node_cb(struct memory_block *mem, void =
*arg)
> +{
> +=09int nid =3D *(int *)arg;
> +
> +=09/*
> +=09 * If a memory block belongs to multiple nodes, the stored nid is not
> +=09 * reliable. However, such blocks are always online (e.g., cannot get
> +=09 * offlined) and, therefore, are still spanned by the node.
> +=09 */
> +=09return mem->nid =3D=3D nid ? -EEXIST : 0;
> +}
> +
>   /**
>    * try_offline_node
>    * @nid: the node ID
> @@ -1645,26 +1657,27 @@ static int check_cpu_on_node(pg_data_t *pgdat)
>    */
>   void try_offline_node(int nid)
>   {
> +=09const unsigned long end_section_nr =3D __highest_present_section_nr +=
 1;
>   =09pg_data_t *pgdat =3D NODE_DATA(nid);
> -=09unsigned long start_pfn =3D pgdat->node_start_pfn;
> -=09unsigned long end_pfn =3D start_pfn + pgdat->node_spanned_pages;
> -=09unsigned long pfn;
> -
> -=09for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D PAGES_PER_SECTION) {
> -=09=09unsigned long section_nr =3D pfn_to_section_nr(pfn);
> -
> -=09=09if (!present_section_nr(section_nr))
> -=09=09=09continue;
> +=09int rc;
>  =20
> -=09=09if (pfn_to_nid(pfn) !=3D nid)
> -=09=09=09continue;
> +=09/*
> +=09 * If the node still spans pages (especially ZONE_DEVICE), don't
> +=09 * offline it. A node spans memory after move_pfn_range_to_zone(),
> +=09 * e.g., after the memory block was onlined.
> +=09 */
> +=09if (pgdat->node_spanned_pages)
> +=09=09return;
>  =20
> -=09=09/*
> -=09=09 * some memory sections of this node are not removed, and we
> -=09=09 * can't offline node now.
> -=09=09 */
> +=09/*
> +=09 * Especially offline memory blocks might not be spanned by the
> +=09 * node. They will get spanned by the node once they get onlined.
> +=09 * However, they link to the node in sysfs and can get onlined later.
> +=09 */
> +=09rc =3D walk_memory_blocks(0, PFN_PHYS(section_nr_to_pfn(end_section_n=
r)),
> +=09=09=09=09&nid, check_no_memblock_for_node_cb);

walk_memory_block() might be fairly inefficient for this use case (as it=20
uses subsys_find_device_by_id() on any possible memory block, which is a=20
list scan).

I guess I will introduce a walk_each_memory_block() that uses=20
bus_for_each_dev() under the hood.

Sorry for the noise :)


--=20

Thanks,

David / dhildenb

