Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA42ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08FE21479
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="P+MDd2FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfIKPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:19:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45002 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfIKPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:19:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id i78so21131487qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZU9ZAjmx+sYl629AtpqCVueI4p9/wYdOG6Cg3kJEbbA=;
        b=P+MDd2FC4Tc061IIYYh+fnI7tLbvNzMEPGfTHDCLdu2V2A1iaUfoGPOyKo1ZcCp2tM
         vDlQak9qwdFXMTF01sdF9NaWHYqP1Z/eiHE2pYAG4FrrFsTi2bCatToJIx7hX7STqCMC
         e85SYvrxtgXBNTGH/ehZFacewWsbP3akXbDmXt6EUDu/lp7mYlWlv1TyYoYV+BNcPW4F
         TyQwa7/S4+maJvqyBvr3GUHM1ID8EHp3pq+TdjfeKrIVUgE8Tw3I5En61hXz9Gu0JACc
         WwgWy0IYjBit1gDB8Hqa1cVn0uxte+0fby7CvbIJdCpE5oqr9900yYQW4eRFZ2W0lIU6
         oFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZU9ZAjmx+sYl629AtpqCVueI4p9/wYdOG6Cg3kJEbbA=;
        b=jIU5KVap59D3aJZofaQf01qibb63k9GiUd5+1OrBWoI7w7mRJ4aqT6EezB80NqvekO
         ap+X4GbzHl/f0FZoOTS8mekkv2L2kLIVluT5z4f7eq0sB198Qo+ENLgnPD1a7VqmR80U
         wyrLOnf14EgBpdiyQjwaRFPyNr8Z6JTB5R02W6hA1xE4n83cGuedEQKLBes5F/Qnycir
         soYq6Pp8A6rxReoz4eH1ynCMZrwaRaXKZwDkPpPTAXBIWb2fAl8c+drDu5t05VNogJz8
         olx4ViIrC2F//kLvhP4RvuYVjTJrRCuCPqtwmR2oP72b7GHBdZBsPyXBXvyIN09el+Xc
         b4vw==
X-Gm-Message-State: APjAAAVUq1t5OUKpRMbjroMcRokRjORTcRP8jyEfRKmJHjLB5cE2Lu6U
        YFf5pkBTXK6ZjXTiviBZZ4opRQ==
X-Google-Smtp-Source: APXvYqwsPae0vNSwigouHMUxOlp4cnOUahDfeE+W9gnOtVKDwdJdfx2UhKXwYdremGpJnC+o/jmyHQ==
X-Received: by 2002:a37:49d6:: with SMTP id w205mr35829035qka.191.1568215161746;
        Wed, 11 Sep 2019 08:19:21 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g194sm11256279qke.46.2019.09.11.08.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:19:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] mm/kasan: dump alloc and free stack for page allocator
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190911083921.4158-1-walter-zh.wu@mediatek.com>
Date:   Wed, 11 Sep 2019 11:19:19 -0400
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E358F4B-552C-4542-9655-E01C7B754F14@lca.pw>
References: <20190911083921.4158-1-walter-zh.wu@mediatek.com>
To:     Walter Wu <walter-zh.wu@mediatek.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2019, at 4:39 AM, Walter Wu <walter-zh.wu@mediatek.com> =
wrote:
>=20
> This patch is KASAN's report adds the alloc/free stack for page =
allocator
> in order to help programmer to see memory corruption caused by the =
page.
>=20
> By default, KASAN doesn't record alloc or free stack for page =
allocator.
> It is difficult to fix up the page use-after-free or double-free =
issue.
>=20
> We add the following changing:
> 1) KASAN enable PAGE_OWNER by default to get the alloc stack of the =
page.
> 2) Add new feature option to get the free stack of the page.
>=20
> The new feature KASAN_DUMP_PAGE depends on DEBUG_PAGEALLOC, it will =
help
> to record free stack of the page, it is very helpful for solving the =
page
> use-after-free or double-free issue.
>=20
> When KASAN_DUMP_PAGE is enabled then KASAN's report will show the last
> alloc and free stack of the page, it should be:
>=20
> BUG: KASAN: use-after-free in kmalloc_pagealloc_uaf+0x70/0x80
> Write of size 1 at addr ffffffc0d60e4000 by task cat/115
> ...
> prep_new_page+0x1c8/0x218
> get_page_from_freelist+0x1ba0/0x28d0
> __alloc_pages_nodemask+0x1d4/0x1978
> kmalloc_order+0x28/0x58
> kmalloc_order_trace+0x28/0xe0
> kmalloc_pagealloc_uaf+0x2c/0x80
> page last free stack trace:
> __free_pages_ok+0x116c/0x1630
> __free_pages+0x50/0x78
> kfree+0x1c4/0x250
> kmalloc_pagealloc_uaf+0x38/0x80
>=20
> Changes since v1:
> - slim page_owner and move it into kasan
> - enable the feature by default
>=20
> Changes since v2:
> - enable PAGE_OWNER by default
> - use DEBUG_PAGEALLOC to get page information
>=20
> cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> cc: Vlastimil Babka <vbabka@suse.cz>
> cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> ---
> lib/Kconfig.kasan | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 4fafba1a923b..4d59458c0c5a 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -41,6 +41,7 @@ config KASAN_GENERIC
> 	select SLUB_DEBUG if SLUB
> 	select CONSTRUCTORS
> 	select STACKDEPOT
> +	select PAGER_OWNER
> 	help
> 	  Enables generic KASAN mode.
> 	  Supported in both GCC and Clang. With GCC it requires version =
4.9.2
> @@ -63,6 +64,7 @@ config KASAN_SW_TAGS
> 	select SLUB_DEBUG if SLUB
> 	select CONSTRUCTORS
> 	select STACKDEPOT
> +	select PAGER_OWNER
> 	help
> 	  Enables software tag-based KASAN mode.
> 	  This mode requires Top Byte Ignore support by the CPU and =
therefore
> @@ -135,6 +137,19 @@ config KASAN_S390_4_LEVEL_PAGING
> 	  to 3TB of RAM with KASan enabled). This options allows to =
force
> 	  4-level paging instead.
>=20
> +config KASAN_DUMP_PAGE
> +	bool "Dump the last allocation and freeing stack of the page"
> +	depends on KASAN
> +	select DEBUG_PAGEALLOC
> +	help
> +	  By default, KASAN enable PAGE_OWNER only to record alloc stack
> +	  for page allocator. It is difficult to fix up page =
use-after-free
> +	  or double-free issue.
> +	  This feature depends on DEBUG_PAGEALLOC, it will extra record
> +	  free stack of page. It is very helpful for solving the page
> +	  use-after-free or double-free issue.
> +	  This option will have a small memory overhead.
> +
> config TEST_KASAN
> 	tristate "Module for testing KASAN for bug detection"
> 	depends on m && KASAN
> =E2=80=94=20

The new config looks redundant and confusing. It looks to me more of a =
document update
in Documentation/dev-tools/kasan.txt to educate developers to select =
PAGE_OWNER and
DEBUG_PAGEALLOC if needed.

