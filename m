Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31850C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED227214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI1aZ9ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCLB6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:58:14 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42667 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCLB6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:58:13 -0400
Received: by mail-ua1-f65.google.com with SMTP id s26so261307uao.9;
        Mon, 11 Mar 2019 18:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04Cjv9Dobjc3gTE2CQiiLdUkyBY+xIpz5hgmSh15OBE=;
        b=AI1aZ9aklgB5/zpChAhzEkROfTeOGXpQHMIirfg5c2iVgBDsGfvCe6cl7zXLIlKLf6
         v22Nf227bjpfkufraf3ROUqh7Tzi0DlVLP/Z38RgDAw+srBfK0cQ/SOhEYIRQdkpCRcz
         am8FvVx723ATlCft4FTo0TMeLhYOV4ttbTQfxcbB/YgLmXrKQGXCvJ+58/wURUPKZq3y
         rTxNqLYjh7keUILJfFEXcFT4FaynKNw6EIlfTrzUn5EnSiZiPHFMqMdRQJv+TUdVl7d5
         7CXxcStbkdn7vCpU956FiHy6bqj6b1bUA/M1/es/i/vUVCXODLoLgZknRo+NxJNs8t7P
         pF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04Cjv9Dobjc3gTE2CQiiLdUkyBY+xIpz5hgmSh15OBE=;
        b=lzp+PZGpXVJI66FWV3605Waos4N7V99W73CTOr8FcZYlXKVveeOVOuu1yL+Ul84YmS
         lVh45vnFPXe8uNO4B4bnBJAyCjjvKPheirCNyJg24+aaqhC+T5TOlwGvSPy7KDg5tqJQ
         ZSPfr9iQpqIs1UycV2v/Md+TlYNmSnM0LrCN0OUS+m/ycgmthElkFZz/NAbPkbORhiEV
         8H3AvkJvnOx8kYDQKIb7hTAY7bBpVi/FEp2UcMRFutaFdDk9AinRwW+C8wKD5hgg1w3Y
         wllQCVKxvurc3NXQz7fi97aZlPiejnCiyYjeA1wAn3obvTqNKqXVWkngQWkpF5a8GbIG
         UCAQ==
X-Gm-Message-State: APjAAAVfm77CTEoBqAK127FC+T7rLUfiHeEIGNEBtJ8iUJAdhLliaENG
        f7aSVUcWAhS+W9UZoGcpfnffkPVm4GtJ5yFQzh6yzJgU
X-Google-Smtp-Source: APXvYqwytXFYbD+hTlIjN2ogX1sd6U3CjXllIDFRYWZpOjIJdA/S8R5YjAoak9JTP2UxHDqd4XK5i1zWUw5w/Dy0ICU=
X-Received: by 2002:ab0:73da:: with SMTP id m26mr17322497uaq.71.1552355892360;
 Mon, 11 Mar 2019 18:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190219074500.16454-1-vichy.kuo@gmail.com> <CAL_Jsq+wUGxeQUMJd0eu52QadvLvkkT=36q9e1Qbru2gEsUGCw@mail.gmail.com>
 <CAOVJa8HUx-8Ok8yMm91UmXpo39KAipt6C1BsfOL1c0Q_kqs1Vg@mail.gmail.com>
In-Reply-To: <CAOVJa8HUx-8Ok8yMm91UmXpo39KAipt6C1BsfOL1c0Q_kqs1Vg@mail.gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Tue, 12 Mar 2019 09:58:00 +0800
Message-ID: <CAOVJa8FROiP7e=p_4Bs=QxiwcdqD5ydrrO=6G2GX2TJkQh9U8A@mail.gmail.com>
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

hi Rob, Marek and Frank:
> > > The __reserved_mem_init_node will call region specific reserved memory
> > > init codes, but once all compatibled init codes failed, the memory region
> > > will left in memory.reserved and cause leakage.
> > >
> > > Take cma reserve memory DTS for example, if user declare 1MB size,
> > > which is not align to (PAGE_SIZE << max(MAX_ORDER - 1,
> > > pageblock_order)), rmem_cma_setup will return -EINVAL.
> > > Meanwhile, rmem_dma_setup will also return -EINVAL since "reusable"
> > > property is not set. If finally there is no reserved memory init pick up
> > > this memory, kernel will left the 1MB leak in memory.reserved.
> > >
> > > This patch will remove this kind of memory from memory.reserved, only
> > > when __reserved_mem_init_node return neither 0 nor -ENOENT.
> >
> > I'm not sure that un-reserving memory on error is the correct
> > behavior. It may be fine for something like CMA, but if it is some
> > shared memory used by another processor in the system not reserving it
> > would probably never be correct.
>
> In this patch, we un-reserving memory ONLY if explicit compatible matching fail.
> That mean driver found something wrong while matching and let OS know.
> (But reserved-memory without compatible property will not be affected.)
>
> So per ur explaination, there would be cases that driver reported
> matching memory fail,
> but the memory is still needed by another processor?

Would you mind to give some comment and suggestion for this patch?
Sincerely appreciate ur kind help.
