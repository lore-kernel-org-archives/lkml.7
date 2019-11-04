Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CB3CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69BE222CA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCCb6IZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfKDAsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 19:48:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60758 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728277AbfKDAsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 19:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572828513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4UAof6OUD9D1BtmvPOk/oqTkYL61W/5InMZJOYHD5s=;
        b=CCCb6IZYOlB51wYkwiulxJJAq/YrswvP8Z8QNqaSrwid8KHpvNJ7ithppJp3ztxCJivMLl
        Ifvc5L1ynRB/X4rqn586ByUFeRGgUL4Dgeu0/phfJHWPZoQg9hm94+rAdVU854Jj4Btal8
        /vvqEkQefz3PDPCwpWOmuDENREwE46A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-A3L4x0LcPVK6dNEBo2xXqQ-1; Sun, 03 Nov 2019 19:48:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BA601800D53;
        Mon,  4 Nov 2019 00:48:28 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D819916D20;
        Mon,  4 Nov 2019 00:48:27 +0000 (UTC)
Date:   Mon, 4 Nov 2019 08:48:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct  mapping.
Message-ID: <20191104004825.GK7616@MiWiFi-R3L-srv>
References: <20191102010911.21460-1-msys.mizuma@gmail.com>
 <20191102010911.21460-5-msys.mizuma@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191102010911.21460-5-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: A3L4x0LcPVK6dNEBo2xXqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/19 at 09:09pm, Masayoshi Mizuma wrote:
> ---
>  arch/x86/mm/kaslr.c | 65 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index dc6182eec..a80eed563 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -70,15 +70,60 @@ static inline bool kaslr_memory_enabled(void)
>  =09return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>  }
> =20
> +/*
> + * Even though a huge virtual address space is reserved for the direct
> + * mapping of physical memory, e.g in 4-level paging mode, it's 64TB,
> + * rare system can own enough physical memory to use it up, most are
> + * even less than 1TB. So with KASLR enabled, we adapt the size of
> + * direct mapping area to the size of actual physical memory plus the
> + * configured padding CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
> + * The left part will be taken out to join memory randomization.
> + */
> +static inline unsigned long calc_direct_mapping_size(void)
> +{
> +=09unsigned long padding =3D CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +=09unsigned long size_tb, memory_tb;
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +=09unsigned long actual, maximum, base;
> +
> +=09if (boot_params.max_addr) {
> +=09=09/*
> +=09=09 * The padding size should set to get for kaslr_regions[].base
> +=09=09 * bigger address than the maximum memory address the system can
> +=09=09 * have. kaslr_regions[].base points "actual size + padding" or
> +=09=09 * higher address. If "actual size + padding" points the lower
> +=09=09 * address than the maximum memory size, fix the padding size.
> +=09=09 */
> +=09=09actual =3D roundup(PFN_PHYS(max_pfn), 1UL << TB_SHIFT);
> +=09=09maximum =3D roundup(boot_params.max_addr, 1UL << TB_SHIFT);
> +=09=09base =3D actual + (padding << TB_SHIFT);
> +
> +=09=09if (maximum > base)
> +=09=09=09padding =3D (maximum - actual) >> TB_SHIFT;
> +=09}
> +#endif
> +=09memory_tb =3D  DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> +=09=09=09padding;

Yes, wrapping up the whole adjusting code block for the direct mapping
area into a function looks much better. This was also suggested by Ingo
when I posted UV system issue fix before, just later the UV system issue
is not seen in the current code.

However, I have a small concern about the memory_tb calculateion here.
We can treat the (actual RAM + CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING)
as the default memory_tb, then check if we need adjst it according to
boot_params.max_addr. Discarding the local padding variable can make
code much simpler? And it is a little confusing when mix with the
later padding concept when doing randomization, I mean the get_padding()
thing.


=09memory_tb =3D DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
                CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;

=09if (boot_params.max_addr) {
=09=09maximum =3D roundup(boot_params.max_addr, 1UL << TB_SHIFT);

=09=09if (maximum > memory_tb)
=09=09=09memory_tb =3D maximum;
=09}
#endif

Personal opinion. Anyway, this patch looks good to me. Thanks.

Thanks
Baoquan


> +
> +=09size_tb =3D 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> +
> +=09/*
> +=09 * Adapt physical memory region size based on available memory
> +=09 */
> +=09if (memory_tb < size_tb)
> +=09=09size_tb =3D memory_tb;
> +
> +=09return size_tb;
> +}
> +
>  /* Initialize base and padding for each memory region randomized with KA=
SLR */
>  void __init kernel_randomize_memory(void)
>  {
> -=09size_t i;
> -=09unsigned long vaddr_start, vaddr;
> -=09unsigned long rand, memory_tb;
> -=09struct rnd_state rand_state;
> +=09unsigned long vaddr_start, vaddr, rand;
>  =09unsigned long remain_entropy;
>  =09unsigned long vmemmap_size;
> +=09struct rnd_state rand_state;
> +=09size_t i;
> =20
>  =09vaddr_start =3D pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE=
_OFFSET_BASE_L4;
>  =09vaddr =3D vaddr_start;
> @@ -95,20 +140,10 @@ void __init kernel_randomize_memory(void)
>  =09if (!kaslr_memory_enabled())
>  =09=09return;
> =20
> -=09kaslr_regions[0].size_tb =3D 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> +=09kaslr_regions[0].size_tb =3D calc_direct_mapping_size();
>  =09kaslr_regions[1].size_tb =3D VMALLOC_SIZE_TB;
> =20
> -=09/*
> -=09 * Update Physical memory mapping to available and
> -=09 * add padding if needed (especially for memory hotplug support).
> -=09 */
>  =09BUG_ON(kaslr_regions[0].base !=3D &page_offset_base);
> -=09memory_tb =3D DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> -=09=09CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> -
> -=09/* Adapt phyiscal memory region size based on available memory */
> -=09if (memory_tb < kaslr_regions[0].size_tb)
> -=09=09kaslr_regions[0].size_tb =3D memory_tb;
> =20
>  =09/*
>  =09 * Calculate the vmemmap region size in TBs, aligned to a TB
> --=20
> 2.20.1
>=20

