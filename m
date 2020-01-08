Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0700C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA599205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjKw009P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgAHIT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:19:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28182 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726492AbgAHIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578471565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=TZ728a+9tzwZLEUFjsJhApBRnwg5ygLUc7EANqJ8Hxw=;
        b=NjKw009PAizKh1wU1LTbeUp5qXxW7Bl6n7ZBKPDEBVBMbyPDyscSTh7ScW5lA7OeDtgHBv
        EkNDJ+Hni247wvnoKemQK71GS06QyRGVfUUukGwyrJr75UVpqRetLJ9U52ZU4AGlgF7B3e
        GqoBiVJ4iPqeE3o5GKOnZxe66rSueK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-h1_meSt2MKaB8Vmwe3SYnw-1; Wed, 08 Jan 2020 03:19:22 -0500
X-MC-Unique: h1_meSt2MKaB8Vmwe3SYnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E8F800D41;
        Wed,  8 Jan 2020 08:19:20 +0000 (UTC)
Received: from [10.36.117.90] (ovpn-117-90.ams2.redhat.com [10.36.117.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 876E210016DA;
        Wed,  8 Jan 2020 08:19:18 +0000 (UTC)
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't free usage map when removing
 a re-added early section
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, piliu@redhat.com
References: <20191217104637.5509-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <c9be027b-a2a4-44b7-1eda-83a8fd0bf87a@redhat.com>
Date:   Wed, 8 Jan 2020 09:19:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191217104637.5509-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.19 11:46, David Hildenbrand wrote:
> When we remove an early section, we don't free the usage map, as the
> usage maps of other sections are placed into the same page. Once the
> section is removed, it is no longer an early section (especially, the
> memmap is freed). When we re-add that section, the usage map is reused,
> however, it is no longer an early section. When removing that section
> again, we try to kfree() a usage map that was allocated during early
> boot - bad.
> 
> Let's check against PageReserved() to see if we are dealing with an usage
> map that was allocated during boot. We could also check against
> !(PageSlab(usage_page) || PageCompound(usage_page)), but PageReserved()
> is cleaner.
> 
> Can be triggered using memtrace under ppc64/powernv:
> 
> $ mount -t debugfs none /sys/kernel/debug/
> $ echo 0x20000000 > /sys/kernel/debug/powerpc/memtrace/enable
> $ echo 0x20000000 > /sys/kernel/debug/powerpc/memtrace/enable
> [   12.093442] ------------[ cut here ]------------
> [   12.093469] kernel BUG at mm/slub.c:3969!
> [   12.093656] Oops: Exception in kernel mode, sig: 5 [#1]
> [   12.093961] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA PowerNV
> [   12.094320] Modules linked in:
> [   12.094615] CPU: 0 PID: 154 Comm: sh Not tainted 5.5.0-rc2-next-20191216-00005-g0be1dba7b7c0 #61
> [   12.095066] NIP:  c000000000396b38 LR: c000000000385848 CTR: c000000000143d30
> [   12.095427] REGS: c000000073077680 TRAP: 0700   Not tainted  (5.5.0-rc2-next-20191216-00005-g0be1dba7b7c0)
> [   12.095886] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28004828  XER: 20000000
> [   12.096395] CFAR: c000000000396b9c IRQMASK: 0
> [   12.096395] GPR00: c000000000385848 c000000073077910 c00000000110f300 c00000007ffffc00
> [   12.096395] GPR04: 0000000000000000 ffffffffffffffff 0000000000000000 0000000000000000
> [   12.096395] GPR08: 0000000000000000 0000000000000001 0000000000000000 ffffffffffffffc8
> [   12.096395] GPR12: 0000000000004000 c0000000012d0000 0000000000001000 c000000000d33c78
> [   12.096395] GPR16: 0000000000000000 c0000000011bfeb0 ffffffffffffe000 c0000000000b6370
> [   12.096395] GPR20: ffffffffe0000000 c0000000011411c0 0000000000006000 c0000000000b6390
> [   12.096395] GPR24: 0000000010000000 0000000000000040 0000000000000000 0000000000000000
> [   12.096395] GPR28: c000000000385848 c00c0000001fffc0 0000000000004000 0000000000000000
> [   12.099882] NIP [c000000000396b38] kfree+0x338/0x3b0
> [   12.100135] LR [c000000000385848] section_deactivate+0x138/0x200
> [   12.100508] Call Trace:
> [   12.100927] [c000000073077910] [c0000000010599a8] 0xc0000000010599a8 (unreliable)
> [   12.101338] [c000000073077960] [c000000000385848] section_deactivate+0x138/0x200
> [   12.101696] [c000000073077a10] [c00000000039b9f4] __remove_pages+0x114/0x150
> [   12.102025] [c000000073077a60] [c00000000006793c] arch_remove_memory+0x3c/0x160
> [   12.102381] [c000000073077ae0] [c00000000039c154] try_remove_memory+0x114/0x1a0
> [   12.102715] [c000000073077b90] [c00000000039c020] __remove_memory+0x20/0x40
> [   12.103041] [c000000073077bb0] [c0000000000b6714] memtrace_enable_set+0x254/0x850
> [   12.103402] [c000000073077cb0] [c0000000004197e8] simple_attr_write+0x138/0x160
> [   12.103751] [c000000073077d10] [c000000000558c9c] full_proxy_write+0x8c/0x110
> [   12.104100] [c000000073077d60] [c0000000003d02a8] __vfs_write+0x38/0x70
> [   12.104409] [c000000073077d80] [c0000000003d3c5c] vfs_write+0x11c/0x2a0
> [   12.104711] [c000000073077dd0] [c0000000003d4054] ksys_write+0x84/0x140
> [   12.105011] [c000000073077e20] [c00000000000b594] system_call+0x5c/0x68
> [   12.105357] Instruction dump:
> [   12.105606] e93d0000 75290001 41820090 8bfd0051 38a0ffff 7ca5f830 7bff0020 7ca507b4
> [   12.105993] e95d0000 39200000 754a0001 4182005c <0b090000> 893d0007 3d42000b 38800006
> [   12.106583] ---[ end trace 4b053cbd84e0db62 ]---
> 
> The first invocation will offline+remove memory blocks. The second
> invocation will first add+online them again, in order to offline+remove
> them again (usually we are lucky and the exact same memory blocks will
> get "reallocated").
> 
> Tested on powernv with boot memory: The usage map will not get freed.
> Tested on x86-64 with DIMMs: The usage map will get freed.
> 
> Fixes: 326e1b8f83a4 ("mm/sparsemem: introduce a SECTION_IS_EARLY flag")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/sparse.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b20ab7cdac86..3822ecbd8a1f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -777,7 +777,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
>  
> -		if (!section_is_early) {
> +		/*
> +		 * When removing an early section, the usage map is kept (as the
> +		 * usage maps of other sections fall into the same page). It
> +		 * will be re-used when re-adding the section - which is then no
> +		 * longer an early section. If the usage map is PageReserved, it
> +		 * was allocated during boot.
> +		 */
> +		if (!PageReserved(virt_to_page(ms->usage))) {
>  			kfree(ms->usage);
>  			ms->usage = NULL;
>  		}
> 

We have another reproducer that is used more frequently than memtrace :)

Using Dynamic Memory under a Power DLAPR can trigger it easily.
Triggering removal (I assume after previously removed+re-added) of
memory from the HMC GUI can crash the kernel with the same call trace
and is fixed by this patch.

CCing Pingfan who verified that this patch fixes the issue - maybe he
wants to provide a Tested-by:

@Andrew, any chance we can get this upstream soon-ish? Thanks!

-- 
Thanks,

David / dhildenb

