Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C40ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E323221D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571996295;
	bh=dAKplcqrs54QScfv9z+Z/hAzyvZvoXTujGP7/yhPjPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ciXSl8ZLnNsgu6DG3ilsZ1Aq5vuzmwzAA0B3asSV5mxR+fvBQV5sLwk8ImTcdbt1R
	 kZ8PpoLMhuFR9RBE6+rPOpg0fb+NW2omIbAmWCmcRxWFYWV8Q8IIy229buBtD3Xr0N
	 CYO76T7XBLfq6J4C2H8TJsnoYkHolQ9xlJOjduQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438592AbfJYJiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:38:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46712 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394339AbfJYJiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:38:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so1480263wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIIBynMAFwKzFTA/larjXSEWYi11jid5vleBMgrZpiw=;
        b=twZUCNlERe6lDIM2qWubiDhmC/kWNmw46m+4Nd2CHIWeveChCv+lFQtxKiwFW21MGZ
         XvDuljDjrnm4KcSm6WviI1B8X2FmHRzSyvIeG2wsPe+yRCcg7a1pOHnpa5fYuJbuOaVg
         0TicP+Rux3IpWEMLD2bZGALxf1N4pQB0Ei6VfAmaU12M3ABlRPjsVE9I10wMHojBrvW5
         QhjayQfWIRXDQDhHCRU86piCFNruAmLbH0a8LG5t+b6XLiYPxtKexJed5nQ4jYSiJPVs
         WG526IelKMZqRIO+emE7Fk+RGuXLJYvi/7Polx4ahozlXNkCZO7NbOVA7SCxVW/aQhDk
         42hg==
X-Gm-Message-State: APjAAAVPF1n8bL+8ksL+kjF8Q4K57q7VUbmbcx3wAj8V7NQYV8RLP7xx
        XbwPwHMGdeGk3HtgShJp9TjUfMghljwlAFRIBLg=
X-Google-Smtp-Source: APXvYqwyHsJAvR4nXBbn/DB14cRtntGxksHx+h8W/f66spUXrSeObD3A8NUHf3JPOGeEZIFYGUoRrU+9QTDn3n8V+8Y=
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr1968825wrj.283.1571996291599;
 Fri, 25 Oct 2019 02:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191016125019.157144-1-namhyung@kernel.org> <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com> <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
In-Reply-To: <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 25 Oct 2019 18:38:00 +0900
Message-ID: <CAM9d7chqPu2qE5XoDVu5dHGzn35NX-GyPMwq-ir6CYgk0b3soA@mail.gmail.com>
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

On Fri, Oct 25, 2019 at 5:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >  /*
> > >   * A cgroup_root represents the root of a cgroup hierarchy, and may be
> > >   * associated with a kernfs_root to form an active hierarchy.  This is
> > > @@ -521,7 +529,7 @@ struct cgroup_root {
> > >       unsigned int flags;
> > >
> > >       /* IDs for cgroups in this hierarchy */
> > > -     struct idr cgroup_idr;
> > > +     struct cgroup_idr cgroup_idr;
> >
> > Given that there's cgroup->self css, can we get rid of the above?
>
> I don't follow.  Do you want to remove cgroup_idr and share the
> css_idr for cgroup id?

Or, you don't want to add cgroup_idr struct and use idr directly?

Thanks
Namhyung
