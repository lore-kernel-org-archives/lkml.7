Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5283D27ABC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559571056;
	bh=DTEl1S9/WHP6uuMXaF6ALTUCnTGHtBY7UQFPnpvsYUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w1/HWE7KtLIRJCRCeFiQhdUvX61AkgS3EjRqC4z6QSgVXAUu/9bFUHqEdTa2lmzxl
	 /CM5fsUEFkQNaZbSbxAqhFVehvV8g+w9qR28wLcEJN71GbSeIGbPOgQagNiEUouPyd
	 Och3BvXs6v8Jw+0NLLbMVylVUYKOnrPdIH73KJsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfFCOK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfFCOKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:10:55 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB9A27AD0;
        Mon,  3 Jun 2019 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559571054;
        bh=DTEl1S9/WHP6uuMXaF6ALTUCnTGHtBY7UQFPnpvsYUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mcwoSVCkk7LtwsFLg6jdfNP+o4HaywLn6eCcix9yDN0dSmR/7tEsIarkiW7pZ3EtG
         FgpyxaGwqfUdBNUpJUdxWsv9KDAevfo4zaG88QMmWowjI1rIiCYHwcaTJfouNezkfc
         LbkUhEViJ2XDHhnKldyJwDgVc1TpHb/G8Wl6nu5g=
Received: by mail-lf1-f47.google.com with SMTP id r15so13705329lfm.11;
        Mon, 03 Jun 2019 07:10:54 -0700 (PDT)
X-Gm-Message-State: APjAAAX0pivBcRIJ0RDDdrUYVibma8saAH3HGWsHpYmasUcYBGuZo7mf
        /dXfbgcGU5oWUSk89oAEnvqsTdiNCObaROonT/o=
X-Google-Smtp-Source: APXvYqzDTAIPHQwCDgcHqsQgXUf8eTz8GkbmKWgiefKcGVYdpIg/raWNYk5RozstG08ewNfS7RtaIsqCR7AWbFYaETw=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr781039lfl.159.1559571052305;
 Mon, 03 Jun 2019 07:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
 <20190603135939.e2mb7vkxp64qairr@pc636>
In-Reply-To: <20190603135939.e2mb7vkxp64qairr@pc636>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 3 Jun 2019 16:10:40 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
Message-ID: <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
Subject: Re: [BUG BISECT] bug mm/vmalloc.c:470 (mm/vmalloc.c: get rid of one
 single unlink_va() when merge)
To:     Uladzislau Rezki <urezki@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 at 15:59, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Krzysztof.
>
> On Mon, Jun 03, 2019 at 11:07:46AM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > On recent next I see bugs during boot (after bringing up user-space or
> > during reboot):
> > kernel BUG at ../mm/vmalloc.c:470!
> > On all my boards. On QEMU I see something similar, although the
> > message is "Internal error: Oops - undefined instruction: 0 [#1] ARM",

Indeed it looks like effect of merge conflict resolution or applying.
When I look at MMOTS, it is the same as yours:
http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/commit/?id=b77b8cce67f246109f9d87417a32cd38f0398f2f

However in linux-next it is different.

Stephen, any thoughts?

Best regards,
Krzysztof

> >
> > The calltrace is:
> > [   34.565126] [<c0275c9c>] (__free_vmap_area) from [<c0276044>]
> > (__purge_vmap_area_lazy+0xd0/0x170)
> > [   34.573963] [<c0276044>] (__purge_vmap_area_lazy) from [<c0276d50>]
> > (_vm_unmap_aliases+0x1fc/0x244)
> > [   34.582974] [<c0276d50>] (_vm_unmap_aliases) from [<c0279500>]
> > (__vunmap+0x170/0x200)
> > [   34.590770] [<c0279500>] (__vunmap) from [<c01d5a70>]
> > (do_free_init+0x40/0x5c)
> > [   34.597955] [<c01d5a70>] (do_free_init) from [<c01478f4>]
> > (process_one_work+0x228/0x810)
> > [   34.606018] [<c01478f4>] (process_one_work) from [<c0147f0c>]
> > (worker_thread+0x30/0x570)
> > [   34.614077] [<c0147f0c>] (worker_thread) from [<c014e8b4>]
> > (kthread+0x134/0x164)
> > [   34.621438] [<c014e8b4>] (kthread) from [<c01010b4>]
> > (ret_from_fork+0x14/0x20)
> >
> > Full log here:
> > https://krzk.eu/#/builders/1/builds/3356/steps/14/logs/serial0
> > https://krzk.eu/#/builders/22/builds/1118/steps/35/logs/serial0
> >
> > Bisect pointed to:
> > 728e0fbf263e3ed359c10cb13623390564102881 is the first bad commit
> > commit 728e0fbf263e3ed359c10cb13623390564102881
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Sat Jun 1 12:20:19 2019 +1000
> >     mm/vmalloc.c: get rid of one single unlink_va() when merge
> >
> I have checked the linux-next. I can confirm it happens because of:
>  mm/vmalloc.c: get rid of one single unlink_va() when merge
>
> The problem is that, it has been applied wrongly into linux-next tree
> for some reason, i do not why. Probably due to the fact that i based
> my work on 5.1/2-rcX, whereas linux-next is a bit ahead of it. If so,
> sorry for that.
>
> See below the clean patch for remotes/linux-next/master:
>
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 650c89f38c1e..0ed95b864e31 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -719,9 +719,6 @@ merge_or_add_vmap_area(struct vmap_area *va,
>                         /* Check and update the tree if needed. */
>                         augment_tree_propagate_from(sibling);
>
> -                       /* Remove this VA, it has been merged. */
> -                       unlink_va(va, root);
> -
>                         /* Free vmap_area object. */
>                         kmem_cache_free(vmap_area_cachep, va);
>
> @@ -746,12 +743,11 @@ merge_or_add_vmap_area(struct vmap_area *va,
>                         /* Check and update the tree if needed. */
>                         augment_tree_propagate_from(sibling);
>
> -                       /* Remove this VA, it has been merged. */
> -                       unlink_va(va, root);
> +                       if (merged)
> +                               unlink_va(va, root);
>
>                         /* Free vmap_area object. */
>                         kmem_cache_free(vmap_area_cachep, va);
> -
>                         return;
>                 }
>         }
> --
> 2.11.0
> <snip>
>
> Andrew, i am not sure how to proceed with that. Should i send an updated series
> based on linux-next tip or you can fix directly that patch?
>
> Thank you!
>
> --
> Vlad Rezki
