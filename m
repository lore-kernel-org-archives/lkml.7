Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADCC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15C024680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Us2NFAjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLTKvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:51:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbfLTKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576839062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fluIzYbR26a/yPgpK/E4xZ/RCtwo0lThgvVAxHbP8+w=;
        b=Us2NFAjQGuNE/+wokPZG4lBfPjt8qw7AWUkugndCvY9xAYwRf68rwxZCTeL+pFbtjozUik
        Y+3wp+O8FMYBiFIkjy1Ic6e7lYDmNdyHYD9M6h2w+x1ckwygLL0JeSX3Pwze/xEsFM7Eve
        PgIATTtTyxXUopQ6/DlFpdn2DDa9sMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-QZz8uAntNTiuVLTbXERsVA-1; Fri, 20 Dec 2019 05:50:59 -0500
X-MC-Unique: QZz8uAntNTiuVLTbXERsVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2EBF100550E;
        Fri, 20 Dec 2019 10:50:57 +0000 (UTC)
Received: from [10.36.117.63] (ovpn-117-63.ams2.redhat.com [10.36.117.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C04B460BEC;
        Fri, 20 Dec 2019 10:50:55 +0000 (UTC)
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
 <ac56b850-adab-0801-e583-f1e76949aa2b@redhat.com>
 <20191219173336.v6uvlu4gqz26gvmm@rascal.austin.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <d70f2ed0-8e4e-1548-a963-df6e06597223@redhat.com>
Date:   Fri, 20 Dec 2019 11:50:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219173336.v6uvlu4gqz26gvmm@rascal.austin.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.19 18:33, Scott Cheloha wrote:
> On Wed, Dec 18, 2019 at 10:00:49AM +0100, David Hildenbrand wrote:
>> On 17.12.19 20:32, Scott Cheloha wrote:
>>> Searching for a particular memory block by id is slow because each bl=
ock
>>> device is kept in an unsorted linked list on the subsystem bus.
>>>
>>> Lookup is much faster if we cache the blocks in a radix tree.  Memory
>>> subsystem initialization and hotplug/hotunplug is at least a little f=
aster
>>> for any machine with more than ~100 blocks, and the speedup grows wit=
h
>>> the block count.
>>>
>>> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> ---
>>> v2 incorporates suggestions from David Hildenbrand.
>>>
>>> v3 changes:
>>>   - Rebase atop "drivers/base/memory.c: drop the mem_sysfs_mutex"
>>>
>>>   - Be conservative: don't use radix_tree_for_each_slot() in
>>>     walk_memory_blocks() yet.  It introduces RCU which could
>>>     change behavior.  Walking the tree "by hand" with
>>>     find_memory_block_by_id() is slower but keeps the patch
>>>     simple.
>>
>> Fine with me (splitting it out, e.g., into an addon patch), however, a=
s
>> readers/writers run mutually exclusive, there is nothing to worry abou=
t
>> here. RCU will not make a difference.
>=20
> Oh.  In that case, can you make heads or tails of this CI failure
> email I got about the v2 patch?  I've inlined it at the end of this
> mail.  "Suspicious RCU usage".  Unclear if it's a false positive.  My
> thinking was that I'd hold off on using radix_tree_for_each_slot() and
> introducing a possible regression until I understood what was
> triggering the robot.

Ah, did not see that message. See below.

>=20
> Also, is there anyone else I should shop this patch to?  I copied the
> maintainers reported by scripts/get_maintainer.pl but are there others
> who might be interested?

On memory hotplug (and related) things, it's usually a good idea to CC
Andrew (who picks up basically all MM stuff), Michal Hocko, and Oscar
Salvador. (cc-ing them)

>=20
> --
>=20
> Here's that CI mail.  I've stripped the attached config because it's
> huge.
>=20
> Date: Sun, 1 Dec 2019 23:05:23 +0800
> From: kernel test robot <lkp@intel.com>
> To: Scott Cheloha <cheloha@linux.vnet.ibm.com>
> Cc: 0day robot <lkp@intel.com>, LKP <lkp@lists.01.org>
> Subject: 86dc301f7b ("drivers/base/memory.c: cache blocks in radix tree=
 .."):
>  [    1.341517] WARNING: suspicious RCU usage
> Message-ID: <20191201150523.GE18573@shao2-debian>
>=20
> Greetings,
>=20
> 0day kernel testing robot got the below dmesg and the first bad commit =
is
>=20
> https://github.com/0day-ci/linux/commits/Scott-Cheloha/drivers-base-mem=
ory-c-cache-blocks-in-radix-tree-to-accelerate-lookup/20191124-104557
>=20
> commit 86dc301f7b4815d90e3a7843ffed655d64efe445
> Author:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
> AuthorDate: Thu Nov 21 13:59:52 2019 -0600
> Commit:     0day robot <lkp@intel.com>
> CommitDate: Sun Nov 24 10:45:59 2019 +0800
>=20
>     drivers/base/memory.c: cache blocks in radix tree to accelerate loo=
kup
>    =20
>     Searching for a particular memory block by id is slow because each =
block
>     device is kept in an unsorted linked list on the subsystem bus.
>    =20
>     Lookup is much faster if we cache the blocks in a radix tree.  Memo=
ry
>     subsystem initialization and hotplug/hotunplug is at least a little=
 faster
>     for any machine with more than ~100 blocks, and the speedup grows w=
ith
>     the block count.
>    =20
>     Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
>     Acked-by: David Hildenbrand <david@redhat.com>
>=20
> 0e4a459f56  tracing: Remove unnecessary DEBUG_FS dependency
> 86dc301f7b  drivers/base/memory.c: cache blocks in radix tree to accele=
rate lookup
> +---------------------------------------------------------------------+=
------------+------------+
> |                                                                     |=
 0e4a459f56 | 86dc301f7b |
> +---------------------------------------------------------------------+=
------------+------------+
> | boot_successes                                                      |=
 8          | 0          |
> | boot_failures                                                       |=
 25         | 11         |
> | WARNING:possible_circular_locking_dependency_detected               |=
 25         | 8          |
> | WARNING:suspicious_RCU_usage                                        |=
 0          | 11         |
> | include/linux/radix-tree.h:#suspicious_rcu_dereference_check()usage |=
 0          | 11         |
> +---------------------------------------------------------------------+=
------------+------------+
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> [    1.335279] random: get_random_bytes called from kcmp_cookies_init+0=
x29/0x4c with crng_init=3D0
> [    1.336883] ACPI: bus type PCI registered
> [    1.338295] PCI: Using configuration type 1 for base access
> [    1.340735]=20
> [    1.341049] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    1.341517] WARNING: suspicious RCU usage
> [    1.342266] 5.4.0-rc5-00070-g86dc301f7b481 #1 Tainted: G            =
    T
> [    1.343494] -----------------------------
> [    1.344226] include/linux/radix-tree.h:167 suspicious rcu_dereferenc=
e_check() usage!
> [    1.345516]=20
> [    1.345516] other info that might help us debug this:
> [    1.345516]=20
> [    1.346962]=20
> [    1.346962] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [    1.348134] no locks held by swapper/0/1.
> [    1.348866]=20
> [    1.348866] stack backtrace:
> [    1.349525] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                =
T 5.4.0-rc5-00070-g86dc301f7b481 #1
> [    1.351230] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.10.2-1 04/01/2014
> [    1.352720] Call Trace:
> [    1.353187]  ? dump_stack+0x9a/0xde
> [    1.353507]  ? node_access_release+0x19/0x19
> [    1.353507]  ? walk_memory_blocks+0xe6/0x184
> [    1.353507]  ? set_debug_rodata+0x20/0x20
> [    1.353507]  ? link_mem_sections+0x39/0x3d
> [    1.353507]  ? topology_init+0x74/0xc8
> [    1.353507]  ? enable_cpu0_hotplug+0x15/0x15
> [    1.353507]  ? do_one_initcall+0x13d/0x30a
> [    1.353507]  ? kernel_init_freeable+0x18e/0x23b
> [    1.353507]  ? rest_init+0x173/0x173
> [    1.353507]  ? kernel_init+0x10/0x151
> [    1.353507]  ? rest_init+0x173/0x173
> [    1.353507]  ? ret_from_fork+0x3a/0x50
> [    1.410829] HugeTLB registered 2.00 MiB page size, pre-allocated 0 p=
ages
> [    1.427389] cryptd: max_cpu_qlen set to 1000
> [    1.457792] ACPI: Added _OSI(Module Device)
> [    1.458615] ACPI: Added _OSI(Processor Device)
> [    1.459428] ACPI: Added _OSI(3.0 _SCP Extensions)
>=20


We get a complaint that we do a rcu_dereference() without proper protecti=
on.

We come via

rest_init()->kernel_init()->kernel_init_freeable()->do_basic_setup()->
do_initcalls()->do_initcall_level()->do_one_initcall()->
topology_init()->register_one_node()->link_mem_sections()->
walk_memory_blocks()

E.g., we add ACPI memory similarly via
    ...do_initcalls()...acpi_init()->acpi_scan_init()
also without holding the device hotplug lock. AFAIK, we can't get
races/concurrent hot(un)plug activity here (we even documented that
for ACPI). And if we would, the code would already be wrong ;)

I assume the simplest and cheapest way to suppress the warning would be
to add rcu_read_lock()/rcu_read_unlock() around the
radix_tree_for_each_slot().

Another way to suppress the warning would be to take the device hotplug
lock before calling register_one_node() in all arch specific code - but
we had a similar discussion due to the ACPI code back then and decided
to not take the device hotplug lock if not really necessary.

... but after all we would want a radix_tree_for_each_slot() variant
that does not perform such checks here. We don't hold any locks and
don't need any locks.

--=20
Thanks,

David / dhildenb

