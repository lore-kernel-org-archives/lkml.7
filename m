Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7B6CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF0A20863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572089577;
	bh=rvu33MKZ1ENxUGvB8aqXdYk2dUn12u4LBeAhcGjvlIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RD772jG4hIIycCXLJYfkgDpoA9XZoMwsyalTmBhT0BpvrzKS0fuoeED2/hPvjKkbj
	 9eXwsjSJQlIit/A93JZQCNpwFC6gDhRhj3Mo+OblsakyZeyQz8QRUCRGMUlc8dhwvG
	 ZsF7DTrBPQmfobHQooq4esid99AScJQFLDjHb1zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfJZLc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:32:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46013 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfJZLcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:32:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so5084926wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mzFdXY7nlu6Oj/Y7GlnSaFqo3rbBofg+FlIWTx9SRE=;
        b=t+0nrrj1/PMClURc5GdCFsIeHrJb+AJyZ5QsyeiRLRUfEB89t/n11GDEYdYYFdQpQf
         aPuKC76MXt2sLii1hgQpkSsYekt4EjP1ySwzWSahZRcqtazKiDqaJbbvgLlZXSGVjdpw
         MeESh1TlqLhyESks9bOFNPkSkq1MwK9NZgcp+XbYevgiRfQ6rFCjOnYiHL8tCH+SuqGc
         lpN0tmZY25+IMmrzXewCVN8kmewOdGJEY0eBVzjZe9ez0EphLGKT+42tZxYzIs5iATVV
         if/PZHSbFzGM9wCoro1o2+z0KEcYEMin2QYkDppwcG9avS9PDan6PN8AsqsgWZ0qjuWX
         /M3Q==
X-Gm-Message-State: APjAAAXWrAQe4JpyzMhhfuLNu4/c3IA3XQ603hSCPKu0APRNf7bod/cw
        du1UibvDlN/Q7MYRXsrkAaFU8rYEjMWN2M3vm3g=
X-Google-Smtp-Source: APXvYqzfTVCiUHj4eoz6ahNeDOU7NKGVNv1q+EXWae7BCJdTa21Ewxr4e3UkMcKvvkgAUb2XFMBju4fmOxFCvYZjLCg=
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr4806756wrj.283.1572089573596;
 Sat, 26 Oct 2019 04:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191016125019.157144-1-namhyung@kernel.org> <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com> <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
 <CAM9d7chqPu2qE5XoDVu5dHGzn35NX-GyPMwq-ir6CYgk0b3soA@mail.gmail.com> <20191025105654.GG3622521@devbig004.ftw2.facebook.com>
In-Reply-To: <20191025105654.GG3622521@devbig004.ftw2.facebook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 26 Oct 2019 20:32:42 +0900
Message-ID: <CAM9d7cgH1oeSRMWf7-tFS+HO2PodrD-CS6vC7STAEYXMb4qcNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Fri, Oct 25, 2019 at 7:57 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Oct 25, 2019 at 06:38:00PM +0900, Namhyung Kim wrote:
> > On Fri, Oct 25, 2019 at 5:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >  /*
> > > > >   * A cgroup_root represents the root of a cgroup hierarchy, and may be
> > > > >   * associated with a kernfs_root to form an active hierarchy.  This is
> > > > > @@ -521,7 +529,7 @@ struct cgroup_root {
> > > > >       unsigned int flags;
> > > > >
> > > > >       /* IDs for cgroups in this hierarchy */
> > > > > -     struct idr cgroup_idr;
> > > > > +     struct cgroup_idr cgroup_idr;
> > > >
> > > > Given that there's cgroup->self css, can we get rid of the above?
> > >
> > > I don't follow.  Do you want to remove cgroup_idr and share the
> > > css_idr for cgroup id?
>
> Yeah, so, each cgroup has its own css at cgroup->self which has css id
> and everything, so I was wondering whether it'd make sense to get rid
> of the cgroup id and use cgroup->self.id in its place.

I think it's possible to use self.id as cgroup id.  But css->id is managed
for each subsys, so it still needs to have an idr in cgroup_root for
cgroup->self.id, right?

Or do you want to get rid of subsys->idr and use a single idr for both
cgroup and css?

Thanks
Namhyung
