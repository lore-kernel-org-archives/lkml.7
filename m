Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AEA21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572001020;
	bh=RruB/bKFg9N2/IRO/VXw/UB5njw8q9jfV1ksfGx2nlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gHjYPuPMz+9xpQfurGEoaiR0zk6+gw1lJLFGlz0VOOTk9QdprkOOhlg811mrtUhHn
	 yPrpZNriROGAQq9NPI5P5acfwB5ZZ0cKwHuk9AlOFHbQGdbe7xg/1TVcB5nBD2tCQR
	 CbWMCH2Q3OjRtaiOsfRRAviELnl00cLnzZu6f1xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502896AbfJYK47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:56:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37729 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409790AbfJYK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:56:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so1313003qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RenG5s/7tKm5qJkbrK8tQzVD2PTjsxof2hDauwNDv6s=;
        b=QLuESO5Pkxvzcc7Noax08j4nTGTXprYSdCUTMxV5Yg1F3WGV+VB1i5OoRygrF7xbDg
         k2lHDnKYI5xXMYcntVYqTqiVy7tPUiR1Wd93pSpGYGx2qSrOLLgVeRLFo+3rum42MN91
         ADlbNXH8WWDbJKv2VWncd/bQOg48dz71oCBkL6W+NJQjoXTAtb9Vz0qUDMEGl+JND0Qs
         x2GaZ6bqLFhvbb6I/IW+KWUhlynxypvfhjsWJ9nk65AFN2IBRy+OUV00gabUkLEB8hN2
         GTpdnHZZvj9/KBS6mvgM85UUQGTieTojHgHhT/bH07RnBbNNB8i9F3j6ZEsszJ7PXf7i
         AvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RenG5s/7tKm5qJkbrK8tQzVD2PTjsxof2hDauwNDv6s=;
        b=dhFHCsjsbXKt54QaMskJthFR6igu/pXJQtci0yok1nhvvqOMKj01tecjPlaf2CIOCo
         QPmiKnWpJC3YLO2ULeq3cIbhuM7bux8mzGDmA82KuFox6y67Om2J9bEMorrURRu25IwC
         gLgQ86SNUZLn6m4ExWuNH2dDCInZdQnBNucozR1UJcqHvynGV8CfjKINsgu8mnnaqao1
         wOJmUo6X7RQ4olwHdluNoBMPsxu3BbRtHdq4YZG9uLZa3ZBuIEdl0Xpciua1PJFqPrPX
         +W0chXRmqaKLwc9GunCmnUkxWh3z2Tsh+1i331fEromvND0PMV6BK8ji9789CRDuyjUr
         D8jw==
X-Gm-Message-State: APjAAAV/bvdDp9nwAk1ALMQuK68hI8F7KUNbrv5MybGgZZqhPXRthao5
        4tQe5oGeMmbGbCfl1v9c/0I=
X-Google-Smtp-Source: APXvYqwW48bscYIPmInoAsu8+6n9e4xo8mZ1XWR0rkKUnZImAv4DtC2PoVfTNB8djCH0r/hs+g6ZhA==
X-Received: by 2002:a37:9207:: with SMTP id u7mr2362568qkd.84.1572001018106;
        Fri, 25 Oct 2019 03:56:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fd3c])
        by smtp.gmail.com with ESMTPSA id u18sm1858216qth.20.2019.10.25.03.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 03:56:57 -0700 (PDT)
Date:   Fri, 25 Oct 2019 03:56:54 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
Message-ID: <20191025105654.GG3622521@devbig004.ftw2.facebook.com>
References: <20191016125019.157144-1-namhyung@kernel.org>
 <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com>
 <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
 <CAM9d7chqPu2qE5XoDVu5dHGzn35NX-GyPMwq-ir6CYgk0b3soA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chqPu2qE5XoDVu5dHGzn35NX-GyPMwq-ir6CYgk0b3soA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 25, 2019 at 06:38:00PM +0900, Namhyung Kim wrote:
> On Fri, Oct 25, 2019 at 5:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >  /*
> > > >   * A cgroup_root represents the root of a cgroup hierarchy, and may be
> > > >   * associated with a kernfs_root to form an active hierarchy.  This is
> > > > @@ -521,7 +529,7 @@ struct cgroup_root {
> > > >       unsigned int flags;
> > > >
> > > >       /* IDs for cgroups in this hierarchy */
> > > > -     struct idr cgroup_idr;
> > > > +     struct cgroup_idr cgroup_idr;
> > >
> > > Given that there's cgroup->self css, can we get rid of the above?
> >
> > I don't follow.  Do you want to remove cgroup_idr and share the
> > css_idr for cgroup id?

Yeah, so, each cgroup has its own css at cgroup->self which has css id
and everything, so I was wondering whether it'd make sense to get rid
of the cgroup id and use cgroup->self.id in its place.

Thanks.

-- 
tejun
