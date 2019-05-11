Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E496EC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 04:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BE72173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 04:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrAicx2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfEKEKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 00:10:05 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39133 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfEKEKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 00:10:05 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so5234975itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 21:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZ9xWFVonfSWOeedDrbddVsWW/90+f1Lep6wrJrzXd0=;
        b=WrAicx2dt3Kys4ZYx+qN0emWJsBCRP2UnXTZ1rKAJnnJneTbFYRGkUE4WTQqRD3/Aw
         PKc574CF0CRTgg7H/cUEyduqP1yFUo57zU6bA3SpbmjMe+ieCD5G9v+xU8tfuLXFdwmw
         TQQRqx4LLb1x+G3kPRU7oxP2+x0abm10LsagTGk8xckv//ReuD4GzYydxOrofns9Ho77
         OBgz/aU8aYNlnN1436QtZcwQ3BRZybsebzcTSf/SPVsZkxWVSJM71gq1Eggqu511xgAj
         DbYr1DUEy/GJFuNLzDp3hTzExQy3WN0V1FD4iQg3SorQVmsyXqRp8RRMP1NBxWrwzSsJ
         u//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZ9xWFVonfSWOeedDrbddVsWW/90+f1Lep6wrJrzXd0=;
        b=VrGlGcduLtFwre0JcAhm0+quZZiW4UYbZPPb7u0hlAoXV39ETrA0THb9q5NfKk97+/
         gjoR6uqmIzWJntl1O5unZ5Yk6bIOWhoWV2x2wsMmdDX6OfQ0pLgO1WDRFlqxggnZvZqX
         7D8K3pzEM/h7Itc/qWjv5CnePaRDMTQ9rNSIz9w2+7MQcIkEuRr2K7F8G+A8DT6zMKx1
         kmDdGXgnFatpSAkhS5DOeK3CGrPj2auMy+rCkLrrlVQS5RHc6i2py8yDSTOf3BywTT1W
         dDCp4GaZswu2jWv8qWiQUpgckT1Vj8KE/CfU6Kymvdp8Fw6fUVUWmNhOfVpuM+RJEW+C
         Ffuw==
X-Gm-Message-State: APjAAAUdFNDxFwR/IWIptUc0r9FWWYz/exvWj5eHpxnzOMcReb8SV4ov
        mHsFC1KWU/1KRTv0O+x64G7f8Jf7Elvt0rOJiMQ=
X-Google-Smtp-Source: APXvYqziJYNnx3s7eyc0jYQpIwUY5Kf5xtPUTCHayN9C7SLhdHdv/v73C1zpUDCgiajORqxAfR+jkL+1cxrZnaCd4OE=
X-Received: by 2002:a24:9f86:: with SMTP id c128mr9519107ite.154.1557547804563;
 Fri, 10 May 2019 21:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com> <20190510163612.GA23417@bombadil.infradead.org>
In-Reply-To: <20190510163612.GA23417@bombadil.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 11 May 2019 12:09:57 +0800
Message-ID: <CALOAHbCs62ynCEeTqAr7wx2TerFmK1ZBp_9r5jh-oP36tGMXDg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 12:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, May 10, 2019 at 10:12:40AM +0800, Huang, Ying wrote:
> > > +           nr_reclaimed += (1 << compound_order(page));
> >
> > How about to change this to
> >
> >
> >         nr_reclaimed += hpage_nr_pages(page);
>
> Please don't.  That embeds the knowledge that we can only swap out either
> normal pages or THP sized pages.

Agreed.
compound_order() is more general than hpage_nr_pages().
It seems to me that hpage_nr_pages() is a little  abuse in lots of places.

Thanks
Yafang
