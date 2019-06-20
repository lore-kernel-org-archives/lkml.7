Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C29AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3286F20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bFe5M5Vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfFTP5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:57:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33360 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:57:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so3232192ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWGyLei7iIX0YquCcpJVdvUVmyD9HHcydfLdWLV6VdQ=;
        b=bFe5M5Viz6mhTHKLXiMPTsQHKWSneXU/P32CqJMYYaptrO+yxI3A5ZHrwgrV2u0KS5
         rMgI+Roe2+x3nxcZJ1pksI2BGPwWFMRIupONO1kQiB3020Q2Rgino0w1y37GLCitolpZ
         audrqCWFZ8YkyqtOjHihYhu0nEmriemTSSrqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWGyLei7iIX0YquCcpJVdvUVmyD9HHcydfLdWLV6VdQ=;
        b=Ypt8zydfKNu08edY6eBbeqOImPsqTqFtLiMaGWZ38aFNelZfDgS9IlEWVYYoi3263m
         RKbM3uO7Q/2oMAvc7/77aO2aUYHfrWKANcJ8SY/GIaAi9U1YAeuAmfmPzEf28U1/FzSu
         /GJy3PTu2FNsy3pmNpqJ7dnBsqojMgJuDimuFBmPSejln5z0Jb6vx79/YW2v89TgiW/P
         hlRmBd045vp3rn9XLDGtWTbdNm8BotdbkN/bffTNCa3UTR8R7fhc1DcsKBQXluzVfhTK
         YzSrOVHwg8TBX2rHR2NzEjj6cjZ8iZomoXI+Rv0qO8oRiAQC/NDyGP1/9YsztBUrgXnx
         Ye0A==
X-Gm-Message-State: APjAAAUPbWUjNf8POhNa1c8DvfvbUKP0KVIW4XhBjZ/ErAc1FeBGuk19
        kzdoryYp7VoM7vzcP2AhuXqBm8GXnuW1NXBdIpFduA==
X-Google-Smtp-Source: APXvYqwrlNR3lH/4m9IeD5Bkl0pzlV3Ska/rPfDDBMmGCP6oxktUzG4DNWPlJ52+fxSnzyurONehOvGDKpiTNUq3KkQ=
X-Received: by 2002:a2e:3602:: with SMTP id d2mr7778406lja.112.1561046240877;
 Thu, 20 Jun 2019 08:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190603053655.127730-1-minchan@kernel.org> <20190603053655.127730-2-minchan@kernel.org>
 <20190604203841.GC228607@google.com> <20190610100904.GC55602@google.com>
 <20190612172104.GA125771@google.com> <20190613044824.GF55602@google.com>
 <20190619171340.GA83620@google.com> <20190620050132.GC105727@google.com>
In-Reply-To: <20190620050132.GC105727@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 20 Jun 2019 11:57:09 -0400
Message-ID: <CAEXW_YSY2GgW_Fp6VN2Qrf0Gr8c71DUgoTzZoq-V2=jFgDEDvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] mm: introduce MADV_COLD
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>, oleksandr@redhat.com,
        hdanton@sina.com, Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 1:01 AM Minchan Kim <minchan@kernel.org> wrote:
[snip]
> > > >
> > > > I think to fix this, what you should do is clear the PG_Idle flag if the
> > > > young/accessed PTE bits are set. If PG_Idle is already cleared, then you
> > > > don't need to do anything.
> > >
> > > I'm not sure. What does it make MADV_COLD special?
> > > How about MADV_FREE|MADV_DONTNEED?
> > > Why don't they clear PG_Idle if pte was young at tearing down pte?
> >
> > Good point, so it sounds like those (MADV_FREE|MADV_DONTNEED) also need to be fixed then?
>
> Not sure. If you want it, maybe you need to fix every pte clearing and pte_mkold
> part, which is more general to cover every sites like munmap, get_user_pages and
> so on. Anyway, I don't think it's related to this patchset.

Ok, I can look into this issue on my own when I get time. I'll add it
to my list. No problems with your patch otherwise from my side.

 -Joel
