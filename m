Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A886C20674
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554821706;
	bh=zpYC3RxGxZ/M90fsBhnwejjsc5FqkeIKoqxHFOecNMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EYs1+8EYz6CTkzsWMYm47UqTIXEGP0rNe9KL7GnUoAjh5co3+E6aqOXBHLx9DnAzF
	 4yMDodAMzMzeomooS+wEPew8DIT2BAAr71brFZi7DVYO/vKchsRfBn5OBTGvtvtUOQ
	 VajGR2RyKjBh7rw64H+G9j1UqhEc7aVFlMjA5jdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDIOzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:55:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41052 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:55:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so13791226oie.8;
        Tue, 09 Apr 2019 07:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfRjzz+00VDiyayhxDXZDKz+OoEJNKL2L2yzqrq71Hc=;
        b=WqfzdkXJj+0xH3e/mZig18Jn2lBOm39sygiOHYsEjDpHTMQfubw4o8oqIJ+dBdSlXh
         3Xe/2lvMEp7154/2LZLyK2TrC2mEpqZcE8PnKH8nkYYffQkWLmoII3DDnj+RPSaEZv4i
         EGHiHwnS1JXti2CPgDzOi5nhRkPYjYXXcBEdftuIktByLTEOcKX3npbiZYTu+hRQsgwO
         BzHzDbqvvkw8Tv5LQ7JWzTwinx27bwLXYztzFyT3wnL4jDhwAHoFnqOdauZPsNrk5XMD
         xSIVKjFH/MHj8uzbT82a5DPLOaNBYZH023Kk4Ena04FqAi6TFcz5agoi1XMezCDY+4Z4
         K/yw==
X-Gm-Message-State: APjAAAVRevwU4gpxCoxnJ7vh+45t0StwFohlha/gWsG1BMRPOjV3sPBC
        +8Hv9xr0Mm1bwNI7CpfIZQgoiC4HlVLXapeaEz4=
X-Google-Smtp-Source: APXvYqwEg0ZkIOLP0CDsBiCCSlZM1e003FYPTC0DlxapcHf61QIaxVjNaUdT29Tn/Tmu3Q5e5uken3pqnmV9IVJ/AmM=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr20030737oib.95.1554821704141;
 Tue, 09 Apr 2019 07:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190406181704.33574-1-cai@lca.pw> <CAJZ5v0jxUn_Hhm21FFBc2eSp49kCciCzR1_UGewHkpJiTy3LGw@mail.gmail.com>
 <1554816309.26196.46.camel@lca.pw>
In-Reply-To: <1554816309.26196.46.camel@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 16:54:52 +0200
Message-ID: <CAJZ5v0g_oLdqv_sp8Un-44wO6vtQH6rVeUTKxSynO8VPPascxA@mail.gmail.com>
Subject: Re: [PATCH -next] acpi/hmat: fix memory leaks in hmat_init()
To:     Qian Cai <cai@lca.pw>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Tue, Apr 9, 2019 at 3:25 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2019-04-09 at 10:25 +0200, Rafael J. Wysocki wrote:
> > On Sat, Apr 6, 2019 at 8:18 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> > > memory") introduced some memory leaks below due to it fails to release
> > > the heap memory in an error path, and then the stack __initdata memory
> > > which reference them get freed during boot renders those heap memory as
> > > leaks.
> > >
> > > unreferenced object 0xc8ff8008349e9400 (size 128):
> > >   comm "swapper/0", pid 1, jiffies 4294709236 (age 48121.476s)
> > >   hex dump (first 32 bytes):
> > >     00 d0 9e 34 08 80 ff 84 d8 00 43 11 00 10 ff ff  ...4......C.....
> > >     00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00  ................
> > >   backtrace:
> > >     [<00000000869d4503>] __kmalloc+0x568/0x600
> > >     [<0000000070fd6afb>] alloc_memory_target+0x50/0xd8
> > >     [<00000000efa2081e>] srat_parse_mem_affinity+0x58/0x5c
> > >     [<000000008bfaef74>] acpi_parse_entries_array+0x1c8/0x2c0
> > >     [<0000000022804877>] acpi_table_parse_entries_array+0x11c/0x138
> > >     [<00000000ffe9cd34>] acpi_table_parse_entries+0x7c/0xac
> > >     [<00000000a7023afd>] hmat_init+0x90/0x174
> > >     [<00000000694a86c1>] do_one_initcall+0x2d8/0x5f8
> > >     [<0000000024889da9>] do_initcall_level+0x37c/0x3fc
> > >     [<000000009be02908>] do_basic_setup+0x38/0x50
> > >     [<0000000037b3ac0a>] kernel_init_freeable+0x194/0x258
> > >     [<00000000f5741184>] kernel_init+0x18/0x334
> > >     [<000000007b30f423>] ret_from_fork+0x10/0x18
> > >     [<000000006c7147a8>] 0xffffffffffffffff
> > >
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> >
> > Well, the catch is good, but the additional label is sort of excessive IMO.
> >
> > > ---
> > >  drivers/acpi/hmat/hmat.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> > > index b7824a0309f7..c9b8abcf012c 100644
> > > --- a/drivers/acpi/hmat/hmat.c
> > > +++ b/drivers/acpi/hmat/hmat.c
> > > @@ -637,7 +637,7 @@ static __init int hmat_init(void)
> > >
> > >         status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
> > >         if (ACPI_FAILURE(status))
> >
> > I would just add a hmat_free_structures() call here or rework the
> > _put_table() logic which is not really straightforward.
>
> I am not sure how adding a hmat_free_structures() call there would be better. If
> the name has bee changed to something else in the future, it ends up needing to
> change 2 places. It also not save the adding line-count either. I don't see how
> to rework the acpi_put_table() logic to be better than adding a label here
> either.

Fewer jumps are easier to follow in general, so avoiding ones that can
be avoided is helpful.

I'm not buying the argument about more code line changes needed if the
function name changes.  It's meaningless.

And if you check the return value of acpi_get_table() for SRAT after
calling acpi_put_table(tbl), you will only need the out_free label, if
I'm not mistaken.
