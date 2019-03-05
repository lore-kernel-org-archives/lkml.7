Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D30C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D5120684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCXp5fP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCEDgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:36:15 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33690 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfCEDgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:36:14 -0500
Received: by mail-ua1-f68.google.com with SMTP id q17so6499052uam.0;
        Mon, 04 Mar 2019 19:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIcRQWlRuzePKke3kmlr7/WYI2F6GVoViemY5trqCNI=;
        b=mCXp5fP+qhJAdj4eAMnHdUH8WNH3sPg4fF2HNK9R7tY0m7QEajNhF9DPOwYP9rTGuL
         Ofk/BHGLnZryHesn0ttG3qBlOpCD/y2iMC6tz4ll0z+Z7xnhr00hxGj3xTCb9LSLP1cT
         jm0U0DY59rhGH4ilexukNzye6XEGNzoIJgROkGXiLiyEMig9Lj/XpzzlrtCuI0KqcqzM
         WjwBFZv1s00KGAZ3b7Ncv4fJX6BwLTGPuZva7gbTo42t6/9zDsBgWxb7dh5IFjDQY3zH
         kEz8E1RF/WbT9odLRQewnhfctH/8+eeYCPLstTFXNiXL9KZaG5mmaUrb8fiU9hedW9d6
         hxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIcRQWlRuzePKke3kmlr7/WYI2F6GVoViemY5trqCNI=;
        b=IKTQ/zt/DssTrQbEqc8QRIoWeWNBKztapvq4T5S74zHYS1YX7e/bOmBZBBe4VAWIJa
         liRwkowUpkBI1//ih5CZvzOYHXhsLXzLljuewO9w2kr8XI1N110etktAxyNBBBSjwZXl
         a5FOEVmpdyPlm4ZYKrtXX1/1fLQdG4LmqbMZvQx3p4SyvKkfS5zQjs74czAC/uID8RtH
         lMzdmz5Wec5F7tr7wlX8D/ehsEfqGT7HQOdj4xaGoIctOJ7lOFXuzkd5KwCjkG18M38A
         Ouq4Awc4MvBbvOJKWqVrh1onmZ3zkDMwyFefIHoewCcM7y5jUZNfgKyqh0TE3NZTH371
         JwqQ==
X-Gm-Message-State: APjAAAUpuC5GipeS7S7DK5daQvLbkGYBb4SQ7VfI/5OiM/Ebc1sS50sP
        F0KEZ6zpm0nNWiAHwzX26Gkh5O1afHd1zqT61ew=
X-Google-Smtp-Source: APXvYqzn+itzwDo6syX6dM93WwsZwBwiQE+ua0D00HvMi65F/IlwNc2+E4smw9IKdl/k9OeOgsc6qdbgkOmx8VKJjJc=
X-Received: by 2002:a67:78ce:: with SMTP id t197mr64347vsc.152.1551756973215;
 Mon, 04 Mar 2019 19:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20190219074500.16454-1-vichy.kuo@gmail.com> <CAL_Jsq+wUGxeQUMJd0eu52QadvLvkkT=36q9e1Qbru2gEsUGCw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+wUGxeQUMJd0eu52QadvLvkkT=36q9e1Qbru2gEsUGCw@mail.gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Tue, 5 Mar 2019 11:36:01 +0800
Message-ID: <CAOVJa8HUx-8Ok8yMm91UmXpo39KAipt6C1BsfOL1c0Q_kqs1Vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: reserved_mem: fix reserve memory leak
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You should Cc the author(s) of this code. I've added Marek.
Thanks ^^
The cc lists I got were from get_maintainer.pl, no matter running with
of_reserved_mem.c or patch file.

(with file)
$ perl scripts/get_maintainer.pl --separator ,   --norolestats
drivers/of/of_reserved_mem.c
Rob Herring <robh+dt@kernel.org>,Frank Rowand
<frowand.list@gmail.com>,devicetree@vger.kernel.org,linux-kernel@vger.kernel.org

(with patch)
$ perl scripts/get_maintainer.pl --separator , --norolestats
0001-of-reserved_mem-fix-reserve-memory-leak.patch
Rob Herring <robh+dt@kernel.org>,Frank Rowand
<frowand.list@gmail.com>,devicetree@vger.kernel.org,linux-kernel@vger.kernel.org

> > The __reserved_mem_init_node will call region specific reserved memory
> > init codes, but once all compatibled init codes failed, the memory region
> > will left in memory.reserved and cause leakage.
> >
> > Take cma reserve memory DTS for example, if user declare 1MB size,
> > which is not align to (PAGE_SIZE << max(MAX_ORDER - 1,
> > pageblock_order)), rmem_cma_setup will return -EINVAL.
> > Meanwhile, rmem_dma_setup will also return -EINVAL since "reusable"
> > property is not set. If finally there is no reserved memory init pick up
> > this memory, kernel will left the 1MB leak in memory.reserved.
> >
> > This patch will remove this kind of memory from memory.reserved, only
> > when __reserved_mem_init_node return neither 0 nor -ENOENT.
>
> I'm not sure that un-reserving memory on error is the correct
> behavior. It may be fine for something like CMA, but if it is some
> shared memory used by another processor in the system not reserving it
> would probably never be correct.

In this patch, we un-reserving memory ONLY if explicit compatible matching fail.
That mean driver found something wrong while matching and let OS know.
(But reserved-memory without compatible property will not be affected.)

So per ur explaination, there would be cases that driver reported
matching memory fail,
but the memory is still needed by another processor?

Appreciate ur kind help,
