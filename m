Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0776CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE82086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfJURJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfJURJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:09:00 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8001C3D95A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 17:08:59 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id w26so2562700ljh.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wxgth48wA5oQ8cPlvqbI7UFUAhGTMgHizZwe7uVd1CY=;
        b=KQxB/eI5UCD3CD5jNqOkO2JrgZv3YMa6GKxuQ0kDS3+E4wjUwS/3cEiizw5oqKIp2j
         92rOK/YfY57sdxvngMb24yYXmp1fwjEaUh11EIVCmGdvCgri+xdX1e5yVWxpyOKcr43c
         heyZI2xdSgWLNjTUEzUB6atHtLky68R5UDhNMo3mBiZjmxTE1NaWxblqWcCrrnsoNsbk
         VSU3qp0lwh791iFmuuq3wN5FwkOd1Qwu0SZKQl6wNlCQCQrtGNBkmIBWJ0RAkdV6PlW4
         Kvzk/yHEC+t1y9GeoM69vRkoC+IuJuRlNjOMk4+6KiBcYmwZN1nJvU2NjaV7dPrboARo
         afbw==
X-Gm-Message-State: APjAAAUuCSLZoF8Dp5trUrQts+/y3hIZ1X37SDHJvxHkWfWo5pRGwMb+
        wPuIoxUh2P2okGWTjrPE0MQ8/fJWzrc+zv/Bf+SYw6fcxm75g5Y/mLbI21ieGDE6IouZvvL9TLZ
        5KF+u2feHy+wJQK1Vz1zHGaC3tM241fvNqHzo7p+K
X-Received: by 2002:a05:6512:61:: with SMTP id i1mr3254520lfo.97.1571677738066;
        Mon, 21 Oct 2019 10:08:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwPQCh9ZBZsdeJK9mNzzlh/TEFcN1WafH5ImLJuWpLqh97PHbMtYqa0hCLDioegMrhp3qZvJTc+WBVfIylwcAw=
X-Received: by 2002:a05:6512:61:: with SMTP id i1mr3254497lfo.97.1571677737798;
 Mon, 21 Oct 2019 10:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191021184128.601ff09d@canb.auug.org.au> <c4377d50c8a30ae292cd7886909238ce4fb56ee5.camel@redhat.com>
 <20191021151507.GD25164@mellanox.com> <CAGnkfhzCuCUBG++QRTZbsUyFr8orq059Be7AvyL+_V9Smz7J3g@mail.gmail.com>
 <20191021170111.GB6285@mellanox.com>
In-Reply-To: <20191021170111.GB6285@mellanox.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 21 Oct 2019 19:08:21 +0200
Message-ID: <CAGnkfhwsczOBLMZSJ0pWm=L3bMqgd4mWNitpZB3-NwjFN+fYDA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the rdma-fixes tree
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Joe Perches <joe@perches.com>, Doug Ledford <dledford@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 7:01 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Oct 21, 2019 at 05:39:06PM +0200, Matteo Croce wrote:
> > > I thought I saw that checkpatch was checking this now?
> > >
> > > commit a8dd86bf746256fbf68f82bc13356244c5ad8efa
> > > Author: Matteo Croce <mcroce@redhat.com>
> > > Date:   Wed Sep 25 16:46:38 2019 -0700
> > >
> > >     checkpatch.pl: warn on invalid commit id
> > >
> > > Maybe that check should also check that enough hash is provided and
> > > other details like the correct subject line?
> > >
> > > I also use a check that builds the fixes line from the commit id and
> > > requires it to be the same as the patch provided. This catches all
> > > sorts of wrong fixes lines, and sometimes git even recommends 13 chars
> > > :\
> > >
> > > Jason
> >
> > Hi,
> >
> > actually I just call git_commit_info() which checks for validness.
> > I could also check that the hash is at least 12 digits, would be very easy.
>
> IMHO you should do
>
>   git log --abbrev=12 -1 --format='Fixes: %h (\"%s\")'
>
> And check that the provided fixes line matches the above output
> exactly, or nearly exactly. People do lots of funny things to fixes
> lines..
>

The point in using git_commit_info() instead of calling git directly
is that the latter would generate an error if the working copy is not
a git tree (e.g. a tar.xz downloaded from kernel.org).

-- 
Matteo Croce
per aspera ad upstream
