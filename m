Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F29C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 23:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD0F206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 23:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtb874mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfD1Xyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 19:54:37 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44121 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfD1Xyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 19:54:37 -0400
Received: by mail-yb1-f194.google.com with SMTP id u187so3175553ybg.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJzmJt5dXSr46qHnoNS5EATc+3d/a2ElrqvTmuSBEdg=;
        b=vtb874mzD79EZ4lK/FKahzxhVi0KRxJCPlqZoqswyk+2KOM5zWGrGYQuwyAm+T22Tw
         owM7xGx6+2XBrBj5iKgttpXndlokSkCdXaHqUeHOFf+PlXlCZ2yp0uwBGU9kHmPDBaP3
         NPMqftVpxG32Ym3soeW3UjOB6L1fPjZDBlyMdNqNwt9OVII2tfrlqfl/gnvIPU3bMaZn
         cUVYDFNlR55+wB/mdDdGu/qVqcG7ro7bhCZ4ZElgyYQOn/W0/DI1IikYofKRbuRkkoiy
         mESCGm4KqIGV5Jq0W0rf0Z4UcYiBTtc6ftKlNJ6VQTSglnjByMoBHVI/DsH9MW04d21q
         MSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJzmJt5dXSr46qHnoNS5EATc+3d/a2ElrqvTmuSBEdg=;
        b=F3PTihsGqXmPWA3fg3hGPo8BzW4vJKoTk9mxokPUOn2ADmzExHMdML+84kZwzm/An4
         MkRWQvdYRKFJ9cM4O+zs4wgkiEugJAGK46a99BfC6hBVmlVB0HcoNEX0BS/3LxQoTtEJ
         JUj/b49wtnZRrb7Xyb3mUq//gUT4+yNSNpH7ZTb6yPGowbmA7v6IBpgEMbtghEdQIRA8
         sI0qc0rUwiUD6Qd+jLD8m/HHFoze+JSyE3x3dwD7GHDgscAKpIVA7RzlW0BDJJFKtn5I
         T0VSAMYH+RN8kzbdbGisBgPRcUVK4vg/qefSpop6SGEaVs36SLk6ph6llHSpDsYR+8f7
         uG9A==
X-Gm-Message-State: APjAAAWN0dpVfaS5OOrZsdi3DtT57B0Pi5iP96ufiZSk5i3eH3YW8VPd
        R099c4qYoPoEns3EKJ5gdiI6DqKL8Sggw1p0AqMz7A==
X-Google-Smtp-Source: APXvYqywcrtNm7hfKOwHEbWcro/mUsCfRRyw7no0aSBlNf48FzHe5zU0X1HlsmhnwnPpE8C1iDov7piwnmKx6YCRD8c=
X-Received: by 2002:a25:f507:: with SMTP id a7mr46894022ybe.164.1556495676033;
 Sun, 28 Apr 2019 16:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190423154405.259178-1-shakeelb@google.com> <20190425064858.GL12751@dhcp22.suse.cz>
In-Reply-To: <20190425064858.GL12751@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 28 Apr 2019 16:54:24 -0700
Message-ID: <CALvZod5Peau7D-O1oi0jFfiOCJrSOMHDnr6TPrTxawt_jh9izw@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: refill_stock for kmem uncharging too
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:49 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 23-04-19 08:44:05, Shakeel Butt wrote:
> > The commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for socket
> > memory uncharging") added refill_stock() for skmem uncharging path to
> > optimize workloads having high network traffic. Do the same for the kmem
> > uncharging as well. Though we can bypass the refill for the offlined
> > memcgs but it may impact the performance of network traffic for the
> > sockets used by other cgroups.
>
> While the change makes sense, I would really like to see what kind of
> effect on performance does it really have. Do you have any specific
> workload that benefits from it?
>

Thanks for the review. I will run some benchmarks and report back later.

Shakeel
