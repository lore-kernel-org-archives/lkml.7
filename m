Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932CFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6432220880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554798324;
	bh=oaS6f76BKxRmq8otg6LSpUIPoj6vfOU+3HFQzYGs22Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dEo1xPgySHUlwZPgWYzgtLU5HL5npK0YqHGx3NOh0CddmQm4tupz+5haJ8YmTFO1F
	 nZU6KCch0I96bo/KSFSnza+1e2bEnAt3Sido+sl38f/g7T3YmrD6XQxOcL8bW8jj9K
	 siojJ7X4MgzhZzNVQAo/om3zxiQdRac6IZg+AG74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDIIZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:25:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39671 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfDIIZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:25:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id f10so8650434otb.6;
        Tue, 09 Apr 2019 01:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztTlJVe9dYWkHV8KqSemRa9C2RUeEJ94F76mKLeWHuk=;
        b=dsAyYoJiOaqqTgYxWHj/jaPVBABex4rvbTsPUyWGNnhNIFhiJGGYe5y89gjOV0R13e
         pCpPpSFgUMbHv6agPxxSEaM+iaR4P4TQim9GvBCyE8YE4Khb7FcIOZLKS1GQqMmoAQ7s
         8EhSe0HuVwR1D3+VdL+C5UM69r0am0gyvbEQfk7w2wAajZhsFrHYOoWJEofC56pC9WYB
         84THUT3krzFZx2cM3o/MnvOtYaqBOW9d2Ba3RrQYhMCoQsswhpWjgwGSrhdVj0f2VHZG
         b+Rc0YKtBiWB2fJnuW22CJm3xgI2mICAoQj6koUYS/vOANqWr+/ekamtn9HLsEAub6wr
         9S5Q==
X-Gm-Message-State: APjAAAV6LbmbY3DLeujJLIdnGonCMuclP70Rd0UZaC0/r+TgHEXW4+Ei
        YpKvkoIRXeSUlnsYtRfY0atURsd2tbTl8742w8HgnSDF
X-Google-Smtp-Source: APXvYqzYfuGHwhA9mz5qH7Xuor2infLgy5DuIDet79lXYzCetBa+TCkuKmhsINJj8ebeFwR4zbHGIvtNtUrLFWwodT8=
X-Received: by 2002:a9d:4b11:: with SMTP id q17mr23354309otf.272.1554798322167;
 Tue, 09 Apr 2019 01:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190406181704.33574-1-cai@lca.pw>
In-Reply-To: <20190406181704.33574-1-cai@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 10:25:11 +0200
Message-ID: <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
Subject: Re: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
To:     Qian Cai <cai@lca.pw>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 8:18 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> memory") introduced some memory leaks below due to it fails to release
> the heap memory in an error path, and then the stack __initdata memory
> which reference them get freed during boot renders those heap memory as
> leaks.
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
> Signed-off-by: Qian Cai <cai@lca.pw>

Well, the catch is good, but the additional label is sort of excessive IMO.

> ---
>  drivers/acpi/hmat/hmat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..c9b8abcf012c 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -637,7 +637,7 @@ static __init int hmat_init(void)
>
>         status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
>         if (ACPI_FAILURE(status))

I would just add a hmat_free_structures() call here or rework the
_put_table() logic which is not really straightforward.

> -               return 0;
> +               goto out_free;
>
>         hmat_revision = tbl->revision;
>         switch (hmat_revision) {
> @@ -659,8 +659,9 @@ static __init int hmat_init(void)
>         }
>         hmat_register_targets();
>  out_put:
> -       hmat_free_structures();
>         acpi_put_table(tbl);
> +out_free:
> +       hmat_free_structures();
>         return 0;
>  }
>  subsys_initcall(hmat_init);
> --
