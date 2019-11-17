Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB2DC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 00:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674A2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 00:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNjt/EPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfKQAm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 19:42:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726887AbfKQAm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 19:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573951345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETuN/H9y2vTvsFbgW/XPeIhwhQEOjzjHzEf34AtqMfg=;
        b=GNjt/EPPPQ9Xm+C6Wn9irmS7EbzJSOK2hpdGPIc073olbaSevpF3z/3+oC6sC7OFGGf1N+
        cpTahKsWjOPt3vrtLXzGuMNMIEet6HSZOHUPUr7SLPVNi718jaKmOcqBpZ061SFw7AbmIN
        37o3O/kA/BFpoodfjs4ODEHPhgJf+u8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-R8F7VJG0O3CkH3v_a16NNw-1; Sat, 16 Nov 2019 19:42:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D5A1477;
        Sun, 17 Nov 2019 00:42:20 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A15B19C68;
        Sun, 17 Nov 2019 00:42:19 +0000 (UTC)
Date:   Sun, 17 Nov 2019 08:42:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct mapping.
Message-ID: <20191117004216.GN30906@MiWiFi-R3L-srv>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191115144917.28469-5-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: R8F7VJG0O3CkH3v_a16NNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 at 09:49am, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> The system sometimes crashes while memory hot-adding on KASLR
> enabled system. The crash happens because the regions pointed by
> kaslr_regions[].base are overwritten by the hot-added memory.
>=20
> It happens because of the padding size for kaslr_regions[].base isn't
> enough for the system whose physical memory layout has huge space for
> memory hotplug. kaslr_regions[].base points "actual installed
> memory size + padding" or higher address. So, if the "actual + padding"
> is lower address than the maximum memory address, which means the memory
> address reachable by memory hot-add, kaslr_regions[].base is destroyed by
> the overwritten.
>=20
>   address
>     ^
>     |------- maximum memory address (Hotplug)
>     |                                    ^
>     |------- kaslr_regions[0].base       | Hotadd-able region
>     |     ^                              |
>     |     | padding                      |
>     |     V                              V
>     |------- actual memory address (Installed on boot)
>     |
>=20
> Fix it by getting the maximum memory address from SRAT and store
> the value in boot_param, then set the padding size while KASLR
> initializing if the default padding size isn't enough.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/mm/kaslr.c | 57 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index dc6182eecefa..1f0aa9e68226 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -70,15 +70,52 @@ static inline bool kaslr_memory_enabled(void)
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

The doc doesn't reflect the the case of boot_params.max_addr existed?

Otherwise, it looks good to me and easy to understand. You can remove my
'Signed-off' and feel free to add my ack.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> + */
> +static inline unsigned long calc_direct_mapping_size(void)
> +{
> +=09unsigned long size_tb, memory_tb;
> +
> +=09memory_tb =3D DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> +=09=09CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +=09if (boot_params.max_addr) {
> +=09=09unsigned long maximum_tb;
> +
> +=09=09maximum_tb =3D DIV_ROUND_UP(boot_params.max_addr,
> +=09=09=09=091UL << TB_SHIFT);
> +
> +=09=09if (maximum_tb > memory_tb)
> +=09=09=09memory_tb =3D maximum_tb;
> +=09}
> +#endif
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
> @@ -95,20 +132,10 @@ void __init kernel_randomize_memory(void)
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

