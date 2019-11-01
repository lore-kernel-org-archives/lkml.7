Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EFECA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8838F217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFbGIvYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfKAVwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:52:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21762 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbfKAVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572645127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fFZh0sNi/fd7fj0v3ddpEtBoGzaPZyNFzrwTft9wTIk=;
        b=VFbGIvYWy9PspA4Ke36DfQIwUZRtNidfxPhSlvxF/nijcQZeVDxcFhdxI2DrRX7quSZ8AZ
        zYRVzPfFerZVXT+G49XhsnQ9qsVf/veXIS2xmjlcrRp8N1/e+WiYly4Cyh5Bx7MYHwZFvS
        pnzg+KMSBmPqwsdu2c2VxV9AxdtDS94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-wpvGGtTDM22--vEZJANzAQ-1; Fri, 01 Nov 2019 17:52:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18CB5107ACC0;
        Fri,  1 Nov 2019 21:52:02 +0000 (UTC)
Received: from [10.36.116.33] (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B027B60870;
        Fri,  1 Nov 2019 21:51:58 +0000 (UTC)
Subject: Re: [PATCH v1] mm/memory_hotplug: Fix try_offline_node()
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
References: <20191028105458.28320-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b03bc9be-e555-b282-7dfd-2c94fc56fb34@redhat.com>
Date:   Fri, 1 Nov 2019 22:51:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028105458.28320-1-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wpvGGtTDM22--vEZJANzAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.19 11:54, David Hildenbrand wrote:
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
> Luckily, we can piggy pack on the node span and the sysfs links between
> memory blocks and the node. Currently, the node span is grown when callin=
g
> move_pfn_range_to_zone() - e.g., when onlining memory, and shrunk when
> removing memory, before calling try_offline_node(). Sysfs links are
> created via link_mem_sections(), e.g., during boot or when adding memory.
>=20
> If the node still spans memory or if any memory block is linked to the
> node in sysfs, we don't set the node offline. Without CONFIG_NUMA, or
> without CONFIG_SYSFS, we will simply always detect the node as being
> linked to the memory block and not set the node offline.
>=20
> Add a way to test if a sysfs link exists.
>=20
> Note: We will soon stop shrinking the ZONE_DEVICE zone and the node span
> when removing ZONE_DEVICE memory to fix similar issues (acess of garbage
> memmaps) - until we have a reliable way to identify whether these memmaps
> were properly initialized. This implies later, that once a node had
> ZONE_DEVICE memory, we won't be able to set a node offline -
> which should be acceptable.
>=20
> Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
> memory to zones until online") memory that is added is not assoziated
> with a zone/node (memmap not initialized). The introducing commit
> 60a5a19e7419 ("memory-hotplug: remove sysfs file of node") already
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
> I just realized that we are are missing a try_online_node() call in the
> memremap path. Bad when adding device memory to a memory-less and cpu-les=
s
> node - the pgdat is not initialized. Will also have to be fixed.
>=20
> We stop shrinking the ZONE_DEVICE zone after the following patch:
> =09[PATCH v6 04/10] mm/memory_hotplug: Don't access uninitialized memmaps
> =09in shrink_zone_span()
> This implies, the above note regarding ZONE_DEVICE on a node blocking a
> node from getting offlined until we sorted out how to properly shrink
> the ZONE_DEVICE zone.
>=20
> This patch is especially important for:
> =09[PATCH v6 05/10] mm/memory_hotplug: Shrink zones when offlining
> =09memory
> As the BUG fixed with this patch becomes now easier to observe when memor=
y
> is offlined (in contrast to when memory would never have been onlined
> before).
>=20
> As both patches are stable fixes and in next/master for a long time, we
> should probably pull this patch in front of both and also backport this
> patch at least to
> =09Cc: stable@vger.kernel.org # v4.13+
> I have not checked yet if there are real blockers to do that. I guess not=
.
>=20
> ---
>   drivers/base/node.c   |  9 +++++++++
>   fs/sysfs/symlink.c    | 21 +++++++++++++++++++++
>   include/linux/node.h  |  7 +++++++
>   include/linux/sysfs.h |  6 ++++++
>   mm/memory_hotplug.c   | 42 ++++++++++++++++++++++++++----------------
>   5 files changed, 69 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 98a31bafc8a2..32aeb85f1d4a 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -833,6 +833,15 @@ int link_mem_sections(int nid, unsigned long start_p=
fn, unsigned long end_pfn)
>   =09=09=09=09  register_mem_sect_under_node);
>   }
>  =20
> +bool memory_block_registered_under_node(struct memory_block *mem, int ni=
d)
> +{
> +=09if (mem->nid =3D=3D nid)
> +=09=09return true;
> +=09/* memory blocks can span multiple nodes. Check against the link. */
> +=09return sysfs_link_exists(&mem->dev.kobj,
> +=09=09=09=09 kobject_name(&node_devices[nid]->dev.kobj));
> +}
> +
>   #ifdef CONFIG_HUGETLBFS
>   /*
>    * Handle per node hstate attribute [un]registration on transistions
> diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
> index c4deecc80f67..b99697a9dae6 100644
> --- a/fs/sysfs/symlink.c
> +++ b/fs/sysfs/symlink.c
> @@ -153,6 +153,27 @@ void sysfs_remove_link(struct kobject *kobj, const c=
har *name)
>   }
>   EXPORT_SYMBOL_GPL(sysfs_remove_link);
>  =20
> +/**
> + *=09sysfs_link_exists - test if a symlink exists in object's directory.
> + *=09@kobj:=09object we're acting for.
> + *=09@name:=09name of the symlink to test.
> + */
> +bool sysfs_link_exists(struct kobject *kobj, const char *name)
> +{
> +=09struct kernfs_node *parent =3D NULL, *kn;
> +
> +=09if (!kobj)
> +=09=09parent =3D sysfs_root_kn;
> +=09else
> +=09=09parent =3D kobj->sd;
> +
> +=09kn =3D kernfs_find_and_get(parent, name);
> +=09kernfs_put(kn);
> +
> +=09return kn !=3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(sysfs_link_exists);
> +
>   /**
>    *=09sysfs_rename_link_ns - rename symlink in object's directory.
>    *=09@kobj:=09object we're acting for.
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 4866f32a02d8..353853018689 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -138,6 +138,8 @@ extern void unregister_one_node(int nid);
>   extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>   extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid=
);
>   extern void unregister_memory_block_under_nodes(struct memory_block *me=
m_blk);
> +extern bool memory_block_registered_under_node(struct memory_block *mem,
> +=09=09=09=09=09       int nid);
>  =20
>   extern int register_memory_node_under_compute_node(unsigned int mem_nid=
,
>   =09=09=09=09=09=09   unsigned int cpu_nid,
> @@ -171,6 +173,11 @@ static inline int unregister_cpu_under_node(unsigned=
 int cpu, unsigned int nid)
>   static inline void unregister_memory_block_under_nodes(struct memory_bl=
ock *mem_blk)
>   {
>   }
> +static inline bool memory_block_registered_under_node(struct memory_bloc=
k *mem,
> +=09=09=09=09=09=09      int nid)
> +{
> +=09return true;
> +}
>  =20
>   static inline void register_hugetlbfs_with_node(node_registration_func_=
t reg,
>   =09=09=09=09=09=09node_registration_func_t unreg)
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index fa7ee503fb76..3ae9a69a0786 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -265,6 +265,7 @@ int __must_check sysfs_create_link_nowarn(struct kobj=
ect *kobj,
>   =09=09=09=09=09  struct kobject *target,
>   =09=09=09=09=09  const char *name);
>   void sysfs_remove_link(struct kobject *kobj, const char *name);
> +bool sysfs_link_exists(struct kobject *kobj, const char *name);
>  =20
>   int sysfs_rename_link_ns(struct kobject *kobj, struct kobject *target,
>   =09=09=09 const char *old_name, const char *new_name,
> @@ -420,6 +421,11 @@ static inline void sysfs_remove_link(struct kobject =
*kobj, const char *name)
>   {
>   }
>  =20
> +static inline bool sysfs_link_exists(struct kobject *kobj, const char *n=
ame)
> +{
> +=09return true;
> +}
> +
>   static inline int sysfs_rename_link_ns(struct kobject *k, struct kobjec=
t *t,
>   =09=09=09=09       const char *old_name,
>   =09=09=09=09       const char *new_name, const void *ns)
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0140c20837b6..c75e99b292cd 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1634,6 +1634,15 @@ static int check_cpu_on_node(pg_data_t *pgdat)
>   =09return 0;
>   }
>  =20
> +static int check_no_memblock_registered_under_node_cb(struct memory_bloc=
k *mem,
> +=09=09=09=09=09=09      void *arg)
> +{
> +
> +=09const int nid =3D *(int *)arg;
> +
> +=09return memory_block_registered_under_node(mem, nid) ? -EEXIST : 0;
> +}
> +
>   /**
>    * try_offline_node
>    * @nid: the node ID
> @@ -1645,26 +1654,27 @@ static int check_cpu_on_node(pg_data_t *pgdat)
>    */
>   void try_offline_node(int nid)
>   {
> +=09unsigned long end_pfn =3D section_nr_to_pfn(__highest_present_section=
_nr);
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
> +=09rc =3D walk_memory_blocks(0, PFN_PHYS(end_pfn), &nid,
> +=09=09=09=09check_no_memblock_registered_under_node_cb);
> +=09if (rc)
>   =09=09return;
> -=09}
>  =20
>   =09if (check_cpu_on_node(pgdat))
>   =09=09return;
>=20

I just realized that we don't need the complicated sysfs handling.=20
Memory blocks that belong to multiple nodes can't get offlined and are=20
therefore always spanned by the node. For offline memory blocks, we can=20
rely on the stored nid. Will do a quick test and send the simpler variant :=
)

--=20

Thanks,

David / dhildenb

