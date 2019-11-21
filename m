Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8789BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8792068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2pc2QBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKUJeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:34:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33571 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbfKUJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574328849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zAWolVmKWZQrNDMTP07euIwNArNzCm6lKN/fytr4WxQ=;
        b=B2pc2QBpbC6JECI/ujamUlxT3x190yc+vWZOMmqCnU8YhRvMYuiq+sz+5XIVtIaEeAwmLN
        mmfSzVNV5c5Ow+YjRvd2IoiKp1AysFVRhKH3rDeq0v6a6Ns0J6uF/GyB5iob3hEttoWRfo
        nK8zfa9oGhvhjDW//lYazw4ppaDBxoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-4Mkha9w5PHaX3p1-WOIknA-1; Thu, 21 Nov 2019 04:34:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E46CF1005516;
        Thu, 21 Nov 2019 09:34:04 +0000 (UTC)
Received: from [10.36.116.214] (ovpn-116-214.ams2.redhat.com [10.36.116.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 884E952FC5;
        Thu, 21 Nov 2019 09:34:03 +0000 (UTC)
Subject: Re: [PATCH] memory subsystem: cache memory blocks in radix tree to
 accelerate lookup
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com
References: <20191120192536.1980-1-cheloha@linux.vnet.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <17fb3629-c0ea-a3c5-73d1-34aa4182170f@redhat.com>
Date:   Thu, 21 Nov 2019 10:34:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120192536.1980-1-cheloha@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4Mkha9w5PHaX3p1-WOIknA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.19 20:25, Scott Cheloha wrote:
> Searching for a particular memory block by id is slow because each block
> device is kept in an unsorted linked list on the subsystem bus.
>=20
> Lookup is much faster if we cache the blocks in a radix tree.  Memory
> subsystem initialization and hotplug/hotunplug is at least a little faste=
r
> for any machine with more than ~100 blocks, and the speedup grows with
> the block count.
>=20
> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
> ---
> On a 40GB Power9 VM I'm seeing nice initialization speed improvements
> consistent with the change in data structure.  Here's the per-block
> timings before the patch:
>=20
> # uptime        elapsed         block-id
> 0.005121        0.000033        0
> 0.005154        0.000028        1
> 0.005182        0.000035        2
> 0.005217        0.000030        3
> 0.005247        0.000039        4
> 0.005286        0.000031        5
> 0.005317        0.000030        6
> 0.005347        0.000031        7
> 0.005378        0.000030        8
> 0.005408        0.000031        9
> [...]
> 0.091603        0.000143        999
> 0.091746        0.000175        1000
> 0.091921        0.000143        1001
> 0.092064        0.000142        1002
> 0.092206        0.000143        1003
> 0.092349        0.000143        1004
> 0.092492        0.000143        1005
> 0.092635        0.000144        1006
> 0.092779        0.000143        1007
> 0.092922        0.000144        1008
> [...]
> 0.301879        0.000258        2038
> 0.302137        0.000267        2039
> 0.302404        0.000291        2040
> 0.302695        0.000259        2041
> 0.302954        0.000258        2042
> 0.303212        0.000259        2043
> 0.303471        0.000260        2044
> 0.303731        0.000258        2045
> 0.303989        0.000259        2046
> 0.304248        0.000260        2047
>=20
> Obviously a linear growth with each block.
>=20
> With the patch:
>=20
> # uptime        elapsed         block-id
> 0.004701        0.000029        0
> 0.004730        0.000028        1
> 0.004758        0.000028        2
> 0.004786        0.000027        3
> 0.004813        0.000037        4
> 0.004850        0.000027        5
> 0.004877        0.000027        6
> 0.004904        0.000027        7
> 0.004931        0.000026        8
> 0.004957        0.000027        9
> [...]
> 0.032718        0.000027        999
> 0.032745        0.000027        1000
> 0.032772        0.000026        1001
> 0.032798        0.000027        1002
> 0.032825        0.000027        1003
> 0.032852        0.000026        1004
> 0.032878        0.000027        1005
> 0.032905        0.000027        1006
> 0.032932        0.000026        1007
> 0.032958        0.000027        1008
> [...]
> 0.061148        0.000027        2038
> 0.061175        0.000027        2039
> 0.061202        0.000026        2040
> 0.061228        0.000027        2041
> 0.061255        0.000027        2042
> 0.061282        0.000026        2043
> 0.061308        0.000027        2044
> 0.061335        0.000026        2045
> 0.061361        0.000026        2046
> 0.061387        0.000027        2047
>=20
> It flattens out.
>=20
> I'm seeing similar changes on my development PC but the numbers are
> less drastic because the block size on a PC grows with the amount
> of memory.  On powerpc the gains are a lot more visible because the
> block size tops out at 256MB.

One could argue that this is only needed for bigger machines. If we ever=20
care, we could defer filling/using the tree once a certain block count=20
is reached. Future work if we really care.

>=20
>   drivers/base/memory.c | 53 ++++++++++++++++++++++++++-----------------
>   1 file changed, 32 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 84c4e1f72cbd..fc0a4880c321 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -20,6 +20,7 @@
>   #include <linux/memory_hotplug.h>
>   #include <linux/mm.h>
>   #include <linux/mutex.h>
> +#include <linux/radix-tree.h>
>   #include <linux/stat.h>
>   #include <linux/slab.h>
>  =20
> @@ -59,6 +60,13 @@ static struct bus_type memory_subsys =3D {
>   =09.offline =3D memory_subsys_offline,
>   };
>  =20
> +/*
> + * Memory blocks are cached in a local radix tree to avoid
> + * a costly linear search for the corresponding device on
> + * the subsystem bus.
> + */
> +static RADIX_TREE(memory_block_tree, GFP_KERNEL);

simply memory_blocks or memory_block_devices?

> +
>   static BLOCKING_NOTIFIER_HEAD(memory_chain);
>  =20
>   int register_memory_notifier(struct notifier_block *nb)
> @@ -580,20 +588,14 @@ int __weak arch_get_memory_phys_device(unsigned lon=
g start_pfn)
>   /* A reference for the returned memory block device is acquired. */
>   static struct memory_block *find_memory_block_by_id(unsigned long block=
_id)
>   {
> -=09struct device *dev;
> +=09struct memory_block *mem;
>  =20
> -=09dev =3D subsys_find_device_by_id(&memory_subsys, block_id, NULL);
> -=09return dev ? to_memory_block(dev) : NULL;
> +=09mem =3D radix_tree_lookup(&memory_block_tree, block_id);
> +=09if (mem)
> +=09=09get_device(&mem->dev);
> +=09return mem;
>   }
>  =20
> -/*
> - * For now, we have a linear search to go find the appropriate
> - * memory_block corresponding to a particular phys_index. If
> - * this gets to be a real problem, we can always use a radix
> - * tree or something here.
> - *
> - * This could be made generic for all device subsystems.
> - */

As this really only makes sense for subsystems with a lot of devices, I=20
think it is the right thing to do to keep it local in here for now.

>   struct memory_block *find_memory_block(struct mem_section *section)
>   {
>   =09unsigned long block_id =3D base_memory_block_id(__section_nr(section=
));
> @@ -636,9 +638,15 @@ int register_memory(struct memory_block *memory)
>   =09memory->dev.offline =3D memory->state =3D=3D MEM_OFFLINE;
>  =20
>   =09ret =3D device_register(&memory->dev);
> -=09if (ret)
> +=09if (ret) {
>   =09=09put_device(&memory->dev);
> -
> +=09=09return ret;
> +=09}
> +=09ret =3D radix_tree_insert(&memory_block_tree, memory->dev.id, memory)=
;
> +=09if (ret) {
> +=09=09put_device(&memory->dev);
> +=09=09device_unregister(&memory->dev);
> +=09}
>   =09return ret;
>   }
>  =20
> @@ -696,6 +704,8 @@ static void unregister_memory(struct memory_block *me=
mory)
>   =09if (WARN_ON_ONCE(memory->dev.bus !=3D &memory_subsys))
>   =09=09return;
>  =20
> +=09WARN_ON(radix_tree_delete(&memory_block_tree, memory->dev.id) =3D=3D =
NULL);
> +
>   =09/* drop the ref. we got via find_memory_block() */
>   =09put_device(&memory->dev);
>   =09device_unregister(&memory->dev);
> @@ -851,20 +861,21 @@ void __init memory_dev_init(void)
>   int walk_memory_blocks(unsigned long start, unsigned long size,
>   =09=09       void *arg, walk_memory_blocks_func_t func)
>   {
> -=09const unsigned long start_block_id =3D phys_to_block_id(start);
> -=09const unsigned long end_block_id =3D phys_to_block_id(start + size - =
1);
> +=09struct radix_tree_iter iter;
> +=09const unsigned long start_id =3D phys_to_block_id(start);
> +=09const unsigned long end_id =3D phys_to_block_id(start + size - 1);

Please don't rename these two variables, unrelated change.

>   =09struct memory_block *mem;
> -=09unsigned long block_id;
> +=09void **slot;
>   =09int ret =3D 0;
>  =20
>   =09if (!size)
>   =09=09return 0;
>  =20
> -=09for (block_id =3D start_block_id; block_id <=3D end_block_id; block_i=
d++) {
> -=09=09mem =3D find_memory_block_by_id(block_id);
> -=09=09if (!mem)
> -=09=09=09continue;
> -
> +=09radix_tree_for_each_slot(slot, &memory_block_tree, &iter, start_id) {
> +=09=09mem =3D radix_tree_deref_slot(slot);
> +=09=09if (mem->dev.id > end_id)
> +=09=09=09break;

I think you could do a

if (iter.index > end_id)
=09break;
mem =3D radix_tree_deref_slot(slot);

instead, which would be nicer IMHO.

> +=09=09get_device(&mem->dev);
>   =09=09ret =3D func(mem, arg);
>   =09=09put_device(&mem->dev);

I think we can stop doing the get/put here (similar as in=20
for_each_memory_block() now), this function should only be called with=20
the device hotplug lock held (or early during boot), where no concurrent=20
hot(un)plug can happen. I suggest this change as an addon patch.

>   =09=09if (ret)
>=20

With the changes

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

--=20

Thanks,

David / dhildenb

