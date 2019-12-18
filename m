Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FE6C2D0D5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C992B24650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BJO2YVhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfLRDWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:22:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35267 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfLRDWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:22:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id f71so581140otf.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 19:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0/yqBmmyHjEyBnCdPDuIdQzrGTBcrMxGDY4/c0jb9U=;
        b=BJO2YVhDywmtO2MRuOGbvGAOV0aYNh7yKCUrbBGSlKA+tD+Kimu3D7PZEmZeRc2er4
         +q3Pbjw6LXiJmcfJs92lYepy4ij/mVHW+NKf57W9Oqxtu3cVjG57Q92wSUt2ENknVLS0
         osEVuQHvRYMDceJYj/rBZ+nyBeFGL6TVTJC8xsKrNRrd4w9DopBuIdhoQxeUdTsqiz2W
         KRzngXQs98WovJHwse8pYZv3X+Uao0Wt1IXN569KeOQ2BPDf3kn5bBIDZj4pHJaTsQ7+
         7rnOwp14/hBRpwWPjG6PXFfMSpzZTUFP8ODs45Ke0sqRcOtGHnbfjWlyr8SF2sK+wDzS
         cK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0/yqBmmyHjEyBnCdPDuIdQzrGTBcrMxGDY4/c0jb9U=;
        b=hSb7utrnY7xvcquZFDeO7R9VWBvj5hYem8LaFbYZbJjD2dTBkhSbTbZ1gZr1Bj/xHg
         hQyQCX/m8xKTydcpZzMsUKcW1xxrD7hLjEcoEVs4OBqheagggNwdhsFCdSxe0BJ2eMKG
         SLrSVg7ikjWxxn18j3F7ZQypB0GIaqoEAK9vnweKPuQQwMhfWwytA2tK9qQFbCNySCiO
         A35I9qNqdtLHx2kBZ20DXNaeugml6n4E2wCtmsQ8Ji3/QOhGP8t4jTdnpDeWjCe4bi/6
         O3xg/oqO7hrLl50g6uxQl5NC2V9+n9OWpjJ/FQQ6gTbIHL6sj8bFQUIVu3buRS50uuDo
         icCw==
X-Gm-Message-State: APjAAAUOMYo1Mkldr+ETXzlkVPEZV8jiBwli0OJr2ZpagWxAQeGIcBAe
        JlYADY5oKb48tFLQzET9fJlyzU2Z/2BoKTf5Yyv4Kw==
X-Google-Smtp-Source: APXvYqwNWATap3yo6yPjwuMWVFIO4gq3rTPp3XLlEQ4L4+iWoJARLt0VtWFYQgN/vMPdIQCp4OBj/3jqwtHC56+V4bo=
X-Received: by 2002:a05:6830:1744:: with SMTP id 4mr125596otz.71.1576639295795;
 Tue, 17 Dec 2019 19:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20191217104637.5509-1-david@redhat.com>
In-Reply-To: <20191217104637.5509-1-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Dec 2019 19:21:24 -0800
Message-ID: <CAPcyv4gfmXf76XkfVOQVaZO6Z2jmcMBSCrMmV-Y7gyZArnNN=Q@mail.gmail.com>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't free usage map when removing
 a re-added early section
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 2:47 AM David Hildenbrand <david@redhat.com> wrote:
>
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
>         if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
>                 unsigned long section_nr = pfn_to_section_nr(pfn);
>
> -               if (!section_is_early) {

With this change this function no longer needs a local
section_is_early variable...

> +               /*
> +                * When removing an early section, the usage map is kept (as the
> +                * usage maps of other sections fall into the same page). It
> +                * will be re-used when re-adding the section - which is then no
> +                * longer an early section. If the usage map is PageReserved, it
> +                * was allocated during boot.
> +                */
> +               if (!PageReserved(virt_to_page(ms->usage))) {

This looks good. However, if this was wrong then I wonder why you are
not seeing problems with free_map_bootmem()?
