Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FA4C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F0321924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bm+fX8E+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbfISVK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:10:26 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33617 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732968AbfISVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:10:26 -0400
Received: by mail-yw1-f66.google.com with SMTP id i188so1346022ywf.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fLuZdNyw0Snk0exp1fU4mQvEVp2x5alNsR3Ohooz1k=;
        b=Bm+fX8E+MsWWqY81xavfe3H5GLkrjQESG9r887oiAmSLvXqf8181s7bc/zmPHXEpVg
         Mg7AYO2OdJhxb5WVWdZOCkA+uaibGlu0EebIQdODcz4t79dvcx1cLSx+UeM8cgg4RFHQ
         WvjirispzY+V1lDwPTN2kPpCtZx+XD7A5D2E6Ij8Pwam5uSLI5qqHpx6M7U/ijJgEdaj
         4BeiXMuJXWkmYvnAA1s1spqt7slmOHQ1bNin0UefIkOryrSUpzo7Oz3HPulkdBW3ritX
         7454Ul7Dn43yZCg0DYGxDFHhWzDvcvw8FnHjrloKn/ybGR+Zz0oIDQyih7J7NhOxtMis
         iy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fLuZdNyw0Snk0exp1fU4mQvEVp2x5alNsR3Ohooz1k=;
        b=Bm6nQAB6y91W4SJQ2nSJ0ZodVi/4Qki3J6R3T5c5SQoDaxoePjv3oogNBwbvH50k+C
         ZP9n7e+9n8kWDTVaYj6+gxKFH2epEzw0PjnTtk7ZLh1gsTn35Fcj4u2KZYIG7e3Le1FA
         MiUxD1zogIF4xwRFbMKAjfYcdTkt4i3SoQnxRnHbZxdVMfA3bDTbakJ7eqtGh4yGgxMh
         L/LAwfMGrVQ7y1+IaqzwdqMxjjRLv3LBsEZGgfddSd1/Z8PrA9SAzmRgxvBiGwU8RBwQ
         e72s53hQbsgOwSt8LM5rnJYGlBmj5f9qmSwwX8LRGp2ibKKMrj+M91WjAVIs101NFU+N
         G34Q==
X-Gm-Message-State: APjAAAXycG8B1vmU0BQnH637Nqaep/CTWHliwolV+SuPU4w+dwE1I3Gk
        T9EH8sxvR1RxLpEcB/SlDnxZfdiRsl04zI9z/BQAlg==
X-Google-Smtp-Source: APXvYqy05dUD5LdL2CsLc4dACa1bZKX2dz1Dlblo6H2A3XbIouWdeOe0BHBVElBSyh6Yw1pva4kChkZEAlJKgGu/w/I=
X-Received: by 2002:a81:3c81:: with SMTP id j123mr9453956ywa.393.1568927423190;
 Thu, 19 Sep 2019 14:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190905214553.1643060-1-guro@fb.com> <CABCjUKByipk2e1Hh1_PwC+p2Fig=6RMfd0zBeVQtyn5Y48gYXQ@mail.gmail.com>
 <20190919162204.GA20035@castle.dhcp.thefacebook.com>
In-Reply-To: <20190919162204.GA20035@castle.dhcp.thefacebook.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Fri, 20 Sep 2019 06:10:11 +0900
Message-ID: <CABCjUKB2BFF9s0RsYj4reUDbPrSkwxDo96Rmqk3tOc0_vo3Xag@mail.gmail.com>
Subject: Re: [PATCH RFC 00/14] The new slab memory controller
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 1:22 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Sep 19, 2019 at 10:39:18PM +0900, Suleiman Souhlal wrote:
> > On Fri, Sep 6, 2019 at 6:57 AM Roman Gushchin <guro@fb.com> wrote:
> > > The patchset has been tested on a number of different workloads in our
> > > production. In all cases, it saved hefty amounts of memory:
> > > 1) web frontend, 650-700 Mb, ~42% of slab memory
> > > 2) database cache, 750-800 Mb, ~35% of slab memory
> > > 3) dns server, 700 Mb, ~36% of slab memory
> >
> > Do these workloads cycle through a lot of different memcgs?
>
> Not really, those are just plain services managed by systemd.
> They aren't restarted too often, maybe several times per day at most.
>
> Also, there is nothing fb-specific. You can take any new modern
> distributive (I've tried Fedora 30), boot it up and look at the
> amount of slab memory. Numbers are roughly the same.

Ah, ok.
These numbers are kind of surprising to me.
Do you know if the savings are similar if you use CONFIG_SLAB instead
of CONFIG_SLUB?

> > For workloads that don't, wouldn't this approach potentially use more
> > memory? For example, a workload where everything is in one or two
> > memcgs, and those memcgs last forever.
> >
>
> Yes, it's true, if you have a very small and fixed number of memory cgroups,
> in theory the new approach can take ~10% more memory.
>
> I don't think it's such a big problem though: it seems that the majority
> of cgroup users have a lot of them, and they are dynamically created and
> destroyed by systemd/kubernetes/whatever else.
>
> And if somebody has a very special setup with only 1-2 cgroups, arguably
> kernel memory accounting isn't such a big thing for them, so it can be simple
> disabled. Am I wrong and do you have a real-life example?

No, I don't have any specific examples.

-- Suleiman
