Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EED1C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685A72070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LPp1jYpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfJGKly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:41:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46624 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfJGKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:41:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so12021670qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8ycSeDCC1GZiryzM3NK5XnFiikWmWhbkO4qYr8NwHI4=;
        b=LPp1jYpI4d9vCHY+Zzga4x5udOxeaTRt7Ikya/1psx/NAf8c3w2X7SjIcCeo5ppvLg
         kIVuW02f2ndybNu+poRPNP+hXMn8ZaEbqD/DU5P28usm1add5gQFxbI/5It18ofgy/pO
         2PCR/tNJYLbIRIfFFb6s7e7pMyrO2tyBBiPW03vC9GNRpoZRC7/14HF4wEqDPrkQej8l
         FsTkmNlSQQwxl36193VKEm1GhvR4MGgK0dFymQg71c6227p2DmDLyKY78EmrEp+9+jah
         ZYL1JRsLgqplCq1NOs9aNAQc8UKdwck2DRxOuN6X/UoPaB1I+B2my6e0g+prwfRlS0d2
         D9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8ycSeDCC1GZiryzM3NK5XnFiikWmWhbkO4qYr8NwHI4=;
        b=MmKZQhXeHplm47tUR5WAmiALdnI4mWJGFsNjetNDvCrbJ9kyDMkKctX7rzCmm2Wo0r
         OI+L0k3Opz7QsvQpuxm5xVBcMwioBoaZnVjdG92OFAW7fwlFXI+NOpXVVA48mmoMBbEh
         JB3Q9R0Aq9B0x2MKPXuddiAd3zMiNhIuyIVr0OE05VmUeXOHsZeKercqBJlbZkbgLlb+
         8nhUUAkjnbz8g8ib2K//4baoeYVqDmbtkLoyvZqMfDtQe+PALbT5EAkramQqjbmw5OH2
         R2KLIVOq9CRRSluHotOmHqs3brQ7Jn4BtUHBMPXBMHFGWqqJ6JGMzaKtERNQy8Tm3aZl
         oH9Q==
X-Gm-Message-State: APjAAAU45LgaDR+IOFHHsInVbG1kFPJRUnroaclnrmQbD91t+ig56uA1
        gaoTaJxrXyObwcCfMGe+3oPFOQ==
X-Google-Smtp-Source: APXvYqw5/lFhcwAK6ZDXflSg6/KFpP6HFKN95InGjPVh+Gc3kjffBIOE8Dx1qXpA4nXroK6UPjbfDA==
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr20769736qkf.263.1570444912890;
        Mon, 07 Oct 2019 03:41:52 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d133sm7699145qkg.31.2019.10.07.03.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 03:41:52 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 2/3] mm, page_owner: decouple freeing stack trace from debug_pagealloc
Date:   Mon, 7 Oct 2019 06:41:51 -0400
Message-Id: <4DDB4C10-0EED-4B1A-A09D-656B2305B51A@lca.pw>
References: <20191007091808.7096-3-vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
In-Reply-To: <20191007091808.7096-3-vbabka@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 7, 2019, at 5:18 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> The commit 8974558f49a6 ("mm, page_owner, debug_pagealloc: save and dump
> freeing stack trace") enhanced page_owner to also store freeing stack trac=
e,
> when debug_pagealloc is also enabled. KASAN would also like to do this [1]=
 to
> improve error reports to debug e.g. UAF issues. Kirill has suggested that t=
he
> freeing stack trace saving should be also possible to be enabled separatel=
y
> from KASAN or debug_pagealloc, i.e. with an extra boot option. Qian argued=
 that
> we have enough options already, and avoiding the extra overhead is not wor=
th
> the complications in the case of a debugging option. Kirill noted that the=

> extra stack handle in struct page_owner requires 0.1% of memory.
>=20
> This patch therefore enables free stack saving whenever page_owner is enab=
led,
> regardless of whether debug_pagealloc or KASAN is also enabled. KASAN kern=
els
> booted with page_owner=3Don will thus benefit from the improved error repo=
rts.
>=20
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D203967
>=20
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Suggested-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Documentation/dev-tools/kasan.rst |  3 +++
> mm/page_owner.c                   | 28 +++++++---------------------
> 2 files changed, 10 insertions(+), 21 deletions(-)

The diffstat looks nice!

Reviewed-by: Qian Cai <cai@lca.pw>

>=20
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/k=
asan.rst
> index b72d07d70239..525296121d89 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -41,6 +41,9 @@ smaller binary while the latter is 1.1 - 2 times faster.=

> Both KASAN modes work with both SLUB and SLAB memory allocators.
> For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
>=20
> +To augment reports with last allocation and freeing stack of the physical=
 page,
> +it is recommended to enable also CONFIG_PAGE_OWNER and boot with page_own=
er=3Don.
> +
> To disable instrumentation for specific files or directories, add a line
> similar to the following to the respective kernel Makefile:
>=20
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index d3cf5d336ccf..de1916ac3e24 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -24,12 +24,10 @@ struct page_owner {
>    short last_migrate_reason;
>    gfp_t gfp_mask;
>    depot_stack_handle_t handle;
> -#ifdef CONFIG_DEBUG_PAGEALLOC
>    depot_stack_handle_t free_handle;
> -#endif
> };
>=20
> -static bool page_owner_disabled =3D true;
> +static bool page_owner_enabled =3D false;
> DEFINE_STATIC_KEY_FALSE(page_owner_inited);
>=20
> static depot_stack_handle_t dummy_handle;
> @@ -44,7 +42,7 @@ static int __init early_page_owner_param(char *buf)
>        return -EINVAL;
>=20
>    if (strcmp(buf, "on") =3D=3D 0)
> -        page_owner_disabled =3D false;
> +        page_owner_enabled =3D true;
>=20
>    return 0;
> }
> @@ -52,10 +50,7 @@ early_param("page_owner", early_page_owner_param);
>=20
> static bool need_page_owner(void)
> {
> -    if (page_owner_disabled)
> -        return false;
> -
> -    return true;
> +    return page_owner_enabled;
> }
>=20
> static __always_inline depot_stack_handle_t create_dummy_stack(void)
> @@ -84,7 +79,7 @@ static noinline void register_early_stack(void)
>=20
> static void init_page_owner(void)
> {
> -    if (page_owner_disabled)
> +    if (!page_owner_enabled)
>        return;
>=20
>    register_dummy_stack();
> @@ -148,25 +143,18 @@ void __reset_page_owner(struct page *page, unsigned i=
nt order)
> {
>    int i;
>    struct page_ext *page_ext;
> -#ifdef CONFIG_DEBUG_PAGEALLOC
>    depot_stack_handle_t handle =3D 0;
>    struct page_owner *page_owner;
>=20
> -    if (debug_pagealloc_enabled())
> -        handle =3D save_stack(GFP_NOWAIT | __GFP_NOWARN);
> -#endif
> +    handle =3D save_stack(GFP_NOWAIT | __GFP_NOWARN);
>=20
>    page_ext =3D lookup_page_ext(page);
>    if (unlikely(!page_ext))
>        return;
>    for (i =3D 0; i < (1 << order); i++) {
>        __clear_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -        if (debug_pagealloc_enabled()) {
> -            page_owner =3D get_page_owner(page_ext);
> -            page_owner->free_handle =3D handle;
> -        }
> -#endif
> +        page_owner =3D get_page_owner(page_ext);
> +        page_owner->free_handle =3D handle;
>        page_ext =3D page_ext_next(page_ext);
>    }
> }
> @@ -450,7 +438,6 @@ void __dump_page_owner(struct page *page)
>        stack_trace_print(entries, nr_entries, 0);
>    }
>=20
> -#ifdef CONFIG_DEBUG_PAGEALLOC
>    handle =3D READ_ONCE(page_owner->free_handle);
>    if (!handle) {
>        pr_alert("page_owner free stack trace missing\n");
> @@ -459,7 +446,6 @@ void __dump_page_owner(struct page *page)
>        pr_alert("page last free stack trace:\n");
>        stack_trace_print(entries, nr_entries, 0);
>    }
> -#endif
>=20
>    if (page_owner->last_migrate_reason !=3D -1)
>        pr_alert("page has been migrated, last migrate reason: %s\n",
> --=20
> 2.23.0
