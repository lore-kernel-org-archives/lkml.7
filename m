Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B69C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E8A20652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="mYV6l/oV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCGJOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:14:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37212 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfCGJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:14:30 -0500
Received: by mail-oi1-f195.google.com with SMTP id w66so12318012oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8YHdCxdMEltSxmwXxvaoreUfIyZKZCTn7ZXtXISX6U=;
        b=mYV6l/oVY0t4ssHS+Gfu1mYrv0QDRROG1TMM3mqBHtnWucwD2sU2WeiXIGGdN7jwqN
         3ux0JO6HRmmeIX4pF7l1W+aXKvFjGR4g5kLYG0sK3KgJX3n0/w8hyx8eB7bkt6O7ScXJ
         ozHD0oU20ENWFaBgyZeOdluvjyMhGNk6znitA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8YHdCxdMEltSxmwXxvaoreUfIyZKZCTn7ZXtXISX6U=;
        b=uRRzPzkYCTvWrPn+wtgbbGMldk9ypsOkrnHTDvmt1slmMOXF9AoqjQjj9gSBjg0+9G
         XzRiSbjLGC7vVrtjBGwbK/hxHw20QlSH2wM279aFLuRHUU7lBm7f6hfcmvlKKfFFF5b1
         bppB56EGcR+F34qW7ZcAa1raLa9/CQcoiHb3oOIg39e1f3hvlH8D8CtLfy6Y10CU4HpT
         xaXJsf6J4fIsToxNBHDheq8MbdyDX3bzXlomzvQm/4ObJk/WYM9P2hZhwSXyUuUbVj01
         h2d5uxKlobpAfbVhqWbdKBilmCiK75FNdiZJ/ZGL7gRSlj3WPB8ugSXnb8my3LSKjK70
         mv/w==
X-Gm-Message-State: APjAAAXlCm/UUWTeRfz2+zhWSCQKWA3Bq8YSJ5IaVKXD4tuw9QVXbpb7
        o6j5qAd0wZLWhfcG8aUBacxqukJusEE2/m1Tc4iIog==
X-Google-Smtp-Source: APXvYqxSJioVsmNG9ZC2LGspGcT2pcS37D76XsXA9ygTPeoAZowgiemumfIm+AI659GwsLhyu+u/oq8WjlUdBtkJXDw=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr4470697oii.170.1551950068108;
 Thu, 07 Mar 2019 01:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20190305163803.18915-1-alban@kinvolk.io> <20190305093240.53095a37@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20190305093240.53095a37@cakuba.hsd1.ca.comcast.net>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Thu, 7 Mar 2019 10:14:14 +0100
Message-ID: <CADZs7q77wnbQSOT-mgX9KRC5ZbBxwt1_GaPDqeQ3jijFa09nMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] tools/bpftool: create map of maps
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>,
        Thilo Fromm <thilo@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reviews, Jakub and Quentin! I will address it and
resend a new version when bpf-next opens again.
I'm also preparing some other patches on "bpftool map" about pinning
and passing file descriptors to help applications that don't support
map pinning directly.

On Tue, Mar 5, 2019 at 6:32 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Tue,  5 Mar 2019 17:38:03 +0100, Alban Crequy wrote:
> > From: Alban Crequy <alban@kinvolk.io>
> >
> > Before this patch, there was no way to fill attr.inner_map_fd, necessary
> > for array_of_maps or hash_of_maps.
> >
> > This patch adds keyword 'innermap' to pass the innermap, either as an id
> > or as a pinned map.
> >
> > Example of commands:
> >
> > $ sudo bpftool map create /sys/fs/bpf/innermap type hash \
> >         key 8 value 8 entries 64 name innermap flags 1
> > $ sudo bpftool map create /sys/fs/bpf/outermap type hash_of_maps \
> >         innermap pinned /sys/fs/bpf/innermap key 64 value 4 \
> >         entries 64 name myoutermap flags 1
> > $ sudo bpftool map show pinned /sys/fs/bpf/outermap
> > 47: hash_of_maps  name myoutermap  flags 0x1
> >       key 64B  value 4B  max_entries 64  memlock 12288B
> >
> > Documentation and bash completion updated as well.
> >
> > Signed-off-by: Alban Crequy <alban@kinvolk.io>
>
> bpf-next is closed let's continue reviewing, but you'll probably have
> to repost after the merge window :(
>
> > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > index e0c650d91784..7d8ce903a471 100644
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
> >                               return -1;
> >                       }
> >                       NEXT_ARG();
> > +             } else if (is_prefix(*argv, "innermap")) {
> > +                     NEXT_ARG();
> > +                     attr.inner_map_fd = map_parse_fd(&argc, &argv);
>
> You need to check if the return value is not -1, and also close this
> file descriptor (a) when done, (b) when error happens.
>
> >               }
> >       }
> >
