Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85156C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5086021479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="hxUvmxG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfETVZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:25:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33523 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfETVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:25:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id y3so7329037plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4baXS4Zs8d273Gy9o882X9zO8lduTnF92DlMmytV05M=;
        b=hxUvmxG7ptkvVdHSpo2ElaBiNspTHcKC2JYgBrAVrG5y2EurML2f6nPrNKhA3NCeET
         3Scsw7YYNXr9eL9Ca8ZCXuXSmefL1R3JtQEXbmOebdWIpphXM6nB+6J6N5ERaFt+V4pz
         XO1xDbC7HMcby+Vu7irR6zLKUHyBSWjTp30sFNmSfremzHtJFg8/ZC0q9CgsDQ1uXeG6
         N+/hkHT9IIo99Z2PBwFnT6uOC+9lP8zJ4Q+z7WWXapY3F6DMOpY9ZTENw8KWiRuRZtRu
         qE/JhUJO2LMKhhRceIMpKfqFzg2P6lMF3lnqFRAMUrUJ9CPp4LFxeCPslwMPAqnnQjpq
         kGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4baXS4Zs8d273Gy9o882X9zO8lduTnF92DlMmytV05M=;
        b=ZflXCk42jS7daGB/3NhA9nK6KnNdQtTe8BFAE/Imgdit+EPu1UVqIdCJKv8bRWcEfo
         oQBoEjpYHoCGhC7zXK65n0PSis1vfoQtGt/Op7KUsWgxOkKvWDlgSulKYHfImYULNVit
         xG+wPrDrtJ60JaNkVIw4pNPYTFI0M3iyilBTgb6up/fjWfrg8fai8GO7ds07/k1owk4m
         45QqRVS1HwhVkTGr4h7EGg7kpi0PoXwYSLTZW2A/1XQchBOaHGb9Fi7njh3s8lOjGFNs
         N9sFAk589qLsaXpVk0ZUkXU2/4YhaOZnlItIp1N4HadNmbHEakRVt31zQrogWlcWLfys
         wfzg==
X-Gm-Message-State: APjAAAV3hT+uaC4v5iI0A68+eEdbr6nkIa5Xi4eV8c/0PTc3dX8I+I0s
        +ZV+a8x68HarZFO76kQSt7xU7Q==
X-Google-Smtp-Source: APXvYqxhwzdx1btAt2ypfSCKSGOQNAlxvRe0pPkeGIzVee9WPpZpOSnWSJfWpUdUKNbJbdxU1kdX7A==
X-Received: by 2002:a17:902:9007:: with SMTP id a7mr77181691plp.221.1558387523416;
        Mon, 20 May 2019 14:25:23 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1155:4a00:3a05:ac06? ([2601:646:c200:1ef2:1155:4a00:3a05:ac06])
        by smtp.gmail.com with ESMTPSA id o6sm14811379pfo.164.2019.05.20.14.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 14:25:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190520200703.15997-1-rick.p.edgecombe@intel.com>
Date:   Mon, 20 May 2019 14:25:21 -0700
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, dave.hansen@intel.com, namit@vmware.com,
        Meelis Roos <mroos@linux.ee>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <28F28A46-C57B-483A-A5CB-8BEA06AF15F8@amacapital.net>
References: <20190520200703.15997-1-rick.p.edgecombe@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On May 20, 2019, at 1:07 PM, Rick Edgecombe <rick.p.edgecombe@intel.com> w=
rote:
>=20
> Switch VM_FLUSH_RESET_PERMS to use a regular TLB flush intead of
> vm_unmap_aliases() and fix calculation of the direct map for the
> CONFIG_ARCH_HAS_SET_DIRECT_MAP case.
>=20
> Meelis Roos reported issues with the new VM_FLUSH_RESET_PERMS flag on a
> sparc machine. On investigation some issues were noticed:
>=20

Can you split this into a few (3?) patches, each fixing one issue?

> 1. The calculation of the direct map address range to flush was wrong.
> This could cause problems on x86 if a RO direct map alias ever got loaded
> into the TLB. This shouldn't normally happen, but it could cause the
> permissions to remain RO on the direct map alias, and then the page
> would return from the page allocator to some other component as RO and
> cause a crash.
>=20
> 2. Calling vm_unmap_alias() on vfree could potentially be a lot of work to=

> do on a free operation. Simply flushing the TLB instead of the whole
> vm_unmap_alias() operation makes the frees faster and pushes the heavy
> work to happen on allocation where it would be more expected.
> In addition to the extra work, vm_unmap_alias() takes some locks including=

> a long hold of vmap_purge_lock, which will make all other
> VM_FLUSH_RESET_PERMS vfrees wait while the purge operation happens.
>=20
> 3. page_address() can have locking on some configurations, so skip calling=

> this when possible to further speed this up.
>=20
> Fixes: 868b104d7379 ("mm/vmalloc: Add flag for freeing of special permsiss=
ions")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Cc: Meelis Roos <mroos@linux.ee>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>=20
> Changes since v1:
> - Update commit message with more detail
> - Fix flush end range on !CONFIG_ARCH_HAS_SET_DIRECT_MAP case
>=20
> mm/vmalloc.c | 23 +++++++++++++----------
> 1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c42872ed82ac..8d03427626dc 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2122,9 +2122,10 @@ static inline void set_area_direct_map(const struct=
 vm_struct *area,
> /* Handle removing and resetting vm mappings related to the vm_struct. */
> static void vm_remove_mappings(struct vm_struct *area, int deallocate_page=
s)
> {
> +    const bool has_set_direct =3D IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_M=
AP);
> +    const bool flush_reset =3D area->flags & VM_FLUSH_RESET_PERMS;
>    unsigned long addr =3D (unsigned long)area->addr;
> -    unsigned long start =3D ULONG_MAX, end =3D 0;
> -    int flush_reset =3D area->flags & VM_FLUSH_RESET_PERMS;
> +    unsigned long start =3D addr, end =3D addr + area->size;
>    int i;
>=20
>    /*
> @@ -2133,7 +2134,7 @@ static void vm_remove_mappings(struct vm_struct *are=
a, int deallocate_pages)
>     * This is concerned with resetting the direct map any an vm alias with=

>     * execute permissions, without leaving a RW+X window.
>     */
> -    if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> +    if (flush_reset && !has_set_direct) {
>        set_memory_nx(addr, area->nr_pages);
>        set_memory_rw(addr, area->nr_pages);
>    }
> @@ -2146,22 +2147,24 @@ static void vm_remove_mappings(struct vm_struct *a=
rea, int deallocate_pages)
>=20
>    /*
>     * If not deallocating pages, just do the flush of the VM area and
> -     * return.
> +     * return. If the arch doesn't have set_direct_map_(), also skip the
> +     * below work.
>     */
> -    if (!deallocate_pages) {
> -        vm_unmap_aliases();
> +    if (!deallocate_pages || !has_set_direct) {
> +        flush_tlb_kernel_range(start, end);
>        return;
>    }
>=20
>    /*
>     * If execution gets here, flush the vm mapping and reset the direct
>     * map. Find the start and end range of the direct mappings to make sur=
e
> -     * the vm_unmap_aliases() flush includes the direct map.
> +     * the flush_tlb_kernel_range() includes the direct map.
>     */
>    for (i =3D 0; i < area->nr_pages; i++) {
> -        if (page_address(area->pages[i])) {
> +        addr =3D (unsigned long)page_address(area->pages[i]);
> +        if (addr) {
>            start =3D min(addr, start);
> -            end =3D max(addr, end);
> +            end =3D max(addr + PAGE_SIZE, end);
>        }
>    }
>=20
> @@ -2171,7 +2174,7 @@ static void vm_remove_mappings(struct vm_struct *are=
a, int deallocate_pages)
>     * reset the direct map permissions to the default.
>     */
>    set_area_direct_map(area, set_direct_map_invalid_noflush);
> -    _vm_unmap_aliases(start, end, 1);
> +    flush_tlb_kernel_range(start, end);
>    set_area_direct_map(area, set_direct_map_default_noflush);
> }
>=20
> --=20
> 2.20.1
>=20
