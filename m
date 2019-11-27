Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162C4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40A720665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/OwohsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfK0QxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:53:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51577 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbfK0QxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574873600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=XCl1SqLKE8BuRH3r+nP0jrziCSWvWBtmmMotcQUZA+Y=;
        b=T/OwohsLVFKvEbws9WzPC3cv6TyF+WZcXHi0i4Cq4oQ9ybsL8rH8RB2pR3muQ1JoDkXwiB
        WeuovvLoARk7TOHmRlR2fu+XKLnbhc1JQT3DAvXHQ/gO1XVdHnYqp2vLKxrPa7ULqva791
        L1JlLAU9pcFJepnMy2L12t9ICOhZa44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-E91XOfaNMXy8-QgciHXhhQ-1; Wed, 27 Nov 2019 11:53:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E1CADBE6;
        Wed, 27 Nov 2019 16:53:15 +0000 (UTC)
Received: from [10.36.116.69] (ovpn-116-69.ams2.redhat.com [10.36.116.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A7875D6C8;
        Wed, 27 Nov 2019 16:53:13 +0000 (UTC)
Subject: Re: [PATCH v2] drivers/base/node.c: Simplify
 unregister_memory_block_under_nodes()
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Chris von Recklinghausen <crecklin@redhat.com>
References: <20190719135244.15242-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <b2e31976-b07d-11e6-f806-f13f4619be4d@redhat.com>
Date:   Wed, 27 Nov 2019 17:53:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190719135244.15242-1-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: E91XOfaNMXy8-QgciHXhhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.19 15:52, David Hildenbrand wrote:
> We don't allow to offline memory block devices that belong to multiple
> numa nodes. Therefore, such devices can never get removed. It is
> sufficient to process a single node when removing the memory block. No
> need to iterate over each and every PFN.
>=20
> We already have the nid stored for each memory block. Make sure that
> the nid always has a sane value.
>=20
> Please note that checking for node_online(nid) is not required. If we
> would have a memory block belonging to a node that is no longer offline,
> then we would have a BUG in the node offlining code.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> v1 -> v2:
> - Remove the "mixed nid" part, add a comment instead. Drop the warning.
>=20
> ---
>  drivers/base/memory.c |  1 +
>  drivers/base/node.c   | 39 +++++++++++++++------------------------
>  2 files changed, 16 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 20c39d1bcef8..154d5d4a0779 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -674,6 +674,7 @@ static int init_memory_block(struct memory_block **me=
mory,
>  =09mem->state =3D state;
>  =09start_pfn =3D section_nr_to_pfn(mem->start_section_nr);
>  =09mem->phys_device =3D arch_get_memory_phys_device(start_pfn);
> +=09mem->nid =3D NUMA_NO_NODE;
> =20
>  =09ret =3D register_memory(mem);
> =20
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 75b7e6f6535b..840c95baa1d8 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -759,8 +759,6 @@ static int register_mem_sect_under_node(struct memory=
_block *mem_blk,
>  =09int ret, nid =3D *(int *)arg;
>  =09unsigned long pfn, sect_start_pfn, sect_end_pfn;
> =20
> -=09mem_blk->nid =3D nid;
> -
>  =09sect_start_pfn =3D section_nr_to_pfn(mem_blk->start_section_nr);
>  =09sect_end_pfn =3D section_nr_to_pfn(mem_blk->end_section_nr);
>  =09sect_end_pfn +=3D PAGES_PER_SECTION - 1;
> @@ -789,6 +787,13 @@ static int register_mem_sect_under_node(struct memor=
y_block *mem_blk,
>  =09=09=09if (page_nid !=3D nid)
>  =09=09=09=09continue;
>  =09=09}
> +
> +=09=09/*
> +=09=09 * If this memory block spans multiple nodes, we only indicate
> +=09=09 * the last processed node.
> +=09=09 */
> +=09=09mem_blk->nid =3D nid;
> +
>  =09=09ret =3D sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
>  =09=09=09=09=09&mem_blk->dev.kobj,
>  =09=09=09=09=09kobject_name(&mem_blk->dev.kobj));
> @@ -804,32 +809,18 @@ static int register_mem_sect_under_node(struct memo=
ry_block *mem_blk,
>  }
> =20
>  /*
> - * Unregister memory block device under all nodes that it spans.
> - * Has to be called with mem_sysfs_mutex held (due to unlinked_nodes).
> + * Unregister a memory block device under the node it spans. Memory bloc=
ks
> + * with multiple nodes cannot be offlined and therefore also never be re=
moved.
>   */
>  void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>  {
> -=09unsigned long pfn, sect_start_pfn, sect_end_pfn;
> -=09static nodemask_t unlinked_nodes;
> -
> -=09nodes_clear(unlinked_nodes);
> -=09sect_start_pfn =3D section_nr_to_pfn(mem_blk->start_section_nr);
> -=09sect_end_pfn =3D section_nr_to_pfn(mem_blk->end_section_nr);
> -=09for (pfn =3D sect_start_pfn; pfn <=3D sect_end_pfn; pfn++) {
> -=09=09int nid;
> +=09if (mem_blk->nid =3D=3D NUMA_NO_NODE)
> +=09=09return;
> =20
> -=09=09nid =3D get_nid_for_pfn(pfn);
> -=09=09if (nid < 0)
> -=09=09=09continue;
> -=09=09if (!node_online(nid))
> -=09=09=09continue;
> -=09=09if (node_test_and_set(nid, unlinked_nodes))
> -=09=09=09continue;
> -=09=09sysfs_remove_link(&node_devices[nid]->dev.kobj,
> -=09=09=09 kobject_name(&mem_blk->dev.kobj));
> -=09=09sysfs_remove_link(&mem_blk->dev.kobj,
> -=09=09=09 kobject_name(&node_devices[nid]->dev.kobj));
> -=09}
> +=09sysfs_remove_link(&node_devices[mem_blk->nid]->dev.kobj,
> +=09=09=09  kobject_name(&mem_blk->dev.kobj));
> +=09sysfs_remove_link(&mem_blk->dev.kobj,
> +=09=09=09  kobject_name(&node_devices[mem_blk->nid]->dev.kobj));
>  }
> =20
>  int link_mem_sections(int nid, unsigned long start_pfn, unsigned long en=
d_pfn)
>=20


Just a note that this was actually also a bugfix as noted by Chris.

If the memory we are removing was never onlined,
get_nid_for_pfn()->pfn_to_nid() will return garbage. Removing will
succeed but links will remain in place.

Can be triggered by

1. hotplugging a DIMM to node 1
2. not onlining the memory blocks
3. unplugging it
4. re-plugging it to node 1

We will trigger the BUG_ON(ret) in add_memory_resource(), because
link_mem_sections() will return with -EEXIST.

--=20
Thanks,

David / dhildenb

