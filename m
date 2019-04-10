Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ECDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812282075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554882809;
	bh=WCRkmyzVPfKAFV1odAzK9/Oh2cGkBJcHSTk6fx6jXq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K4vjLlhpOg3AM8FV1h1IU7gz/LvgUpq9i1zliQT3U5ulqKrjEilCRLFIlZ6hzIRx6
	 5dkbtgjryuHLT15K5vFaJ7OhoFCXN3v6ocxW4QgeX78hfalZEvwvl07SZ23B4nq1DI
	 mEwFv/TOwbDH5TUfU4l+NiLwsSsEj4etTZV8l7Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfDJHx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:53:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44823 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfDJHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:53:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id i21so938733oib.11;
        Wed, 10 Apr 2019 00:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z69TyCIuHVfdTDh741mUI4+zz+Pu0purl8R0+gL5swU=;
        b=fruWnfQnH0WM0tHE2ojYknoXecTlJbT9ym0cdBYRGGMB5AWGsTqhFkdbuuM7hyHJWe
         tvI2AnIPnLMt7i7A2qU3gdh9AhNP2JSDX0p3CFLzLZBMvQi+L2A86D4vy3h7NptkzN1w
         8eNgkz4uFG5ulQNobW0H+uamM8NiNztoaFr/B+KxDYp/eH/V0pR4RhRSEv+SwjKAIof4
         oQoeCn45w6yMIkVvBEZot1tK/6GhsIcdcY7XzbWrLDQu6R3k8DjbwvNyRZfg20miBPHm
         Iw3wn2wj2RBi2+EAM5Fqd+02Q2HTFZg/0wOhpT3vswlwYX4P0Y9Nu6cCcRZ/YoJpCTtm
         cr0w==
X-Gm-Message-State: APjAAAVtaFfI7OHMzarq5Y5kfHAo7cFGutH+EbExiCol1jy3eG//0nXi
        oWKVf7PHrkxqczN5i1rl/QWqa9Kwc+cBwueOS2c=
X-Google-Smtp-Source: APXvYqxKCWu8ILPX/+7cvPlfe5Y1x2N7fn4jzhNEx72nG1srfQz3lKxmgPx5hE0Tb3TEl76XTNLA/yW+AeSgNDy9s14=
X-Received: by 2002:aca:eb93:: with SMTP id j141mr1627090oih.178.1554882807011;
 Wed, 10 Apr 2019 00:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190410021450.1263-1-cai@lca.pw>
In-Reply-To: <20190410021450.1263-1-cai@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Apr 2019 09:53:15 +0200
Message-ID: <CAJZ5v0i5A7nMdcP5XsuKuiE7AhF=aLGtsp3F2NNKz5Rpv_MAPA@mail.gmail.com>
Subject: Re: [PATCH -next v2] acpi/hmat: fix memory leaks in hmat_init()
To:     Qian Cai <cai@lca.pw>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 4:15 AM Qian Cai <cai@lca.pw> wrote:
>
> The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> memory") introduced some memory leaks below due to it fails to release
> the heap memory in an error path, and then those statically-allocated
> __initdata memory which reference them get freed during boot renders
> those heap memory as leaks. Since it is valid to pass NULL to
> acpi_put_table(), it is fine to call it even if acpi_get_table() returns
> an error.
>
> unreferenced object 0xc8ff8008349e9400 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294709236 (age 48121.476s)
>   hex dump (first 32 bytes):
>     00 d0 9e 34 08 80 ff 84 d8 00 43 11 00 10 ff ff  ...4......C.....
>     00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000869d4503>] __kmalloc+0x568/0x600
>     [<0000000070fd6afb>] alloc_memory_target+0x50/0xd8
>     [<00000000efa2081e>] srat_parse_mem_affinity+0x58/0x5c
>     [<000000008bfaef74>] acpi_parse_entries_array+0x1c8/0x2c0
>     [<0000000022804877>] acpi_table_parse_entries_array+0x11c/0x138
>     [<00000000ffe9cd34>] acpi_table_parse_entries+0x7c/0xac
>     [<00000000a7023afd>] hmat_init+0x90/0x174
>     [<00000000694a86c1>] do_one_initcall+0x2d8/0x5f8
>     [<0000000024889da9>] do_initcall_level+0x37c/0x3fc
>     [<000000009be02908>] do_basic_setup+0x38/0x50
>     [<0000000037b3ac0a>] kernel_init_freeable+0x194/0x258
>     [<00000000f5741184>] kernel_init+0x18/0x334
>     [<000000007b30f423>] ret_from_fork+0x10/0x18
>     [<000000006c7147a8>] 0xffffffffffffffff
>

Fixes: 665ac7e92757 ("acpi/hmat: Register processor domain to its memory")

> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Greg, the patch fixed by this is in your tree, so can you apply this
one too, please?

> ---
>
> v2: goto out_put per Rafael.
>
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..69cdb3cea545 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -637,7 +637,7 @@ static __init int hmat_init(void)
>
>         status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
>         if (ACPI_FAILURE(status))
> -               return 0;
> +               goto out_put;
>
>         hmat_revision = tbl->revision;
>         switch (hmat_revision) {
> --
> 2.17.2 (Apple Git-113)
>
