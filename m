Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D7FC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4310E2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diNffEIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfEOOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:11:43 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40745 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfEOOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:11:42 -0400
Received: by mail-yb1-f193.google.com with SMTP id q17so972780ybg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkABSB9+ocVSEDM1acJkspFNCkj7bZrir9llBRZBZbk=;
        b=diNffEIXfA/QFvQ4JDN4yWPbBFk9QYgBHQ4+BVJ1NfD0TF6g+5vVE0YSL1BnVjtejf
         CrAeQK4hrTmj1WQuMCeXacIymo+qMfuKsRMkXThtVIfdGWD3UWU68tOQie85EkAx3kZA
         YA78rnXPrmWhtTDNmjqohIlpLATlRKpAgbVUzdHZ/0oIWDRCWeJPe4MkeQfL4NNPlAhb
         5gw18O/g48n/nZ7gRYd6s2xdXe7fCpmxbuVDtTd8Fhd7nK4blg8+HLxt6MmLicorJV+J
         ANLAPFx1lNLWprZ3HdLcTYYUg1gfx/xT6ADtn2L5nwfSQpvrZp2SEK2dbyUh8ZEYZ9Xq
         UKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkABSB9+ocVSEDM1acJkspFNCkj7bZrir9llBRZBZbk=;
        b=OPCFVvDBAkOudy5p4iODlM3oaIfnuTE0rhkvLvO0VCB3lC5MbHPer+qUMNvRG84tjI
         NdLhvzEoBN2n0mKaba3zeDpdc9F/asJLa81ZMu3yJaVZQBx2q/jdteSUSMpPsSarkUWU
         1n6XEfxrrLNHYWvsNnUE810RaLKqxD+ySprdqgNAujmiNd5MidO25eKzhHdtJoeIvij3
         47fsjVHPL9pKB/eR0wz2iTwr8EWHRXZ3Qg96piQiVzauz1HjIkWUkaBXiUifWjkp0HIr
         BTvFV89s8ybB/ZzDjnFH0CMp2x24u3Ih6WCw1dUGyzpuIvTKSfdyeyB6jEZvzlSkNvBQ
         B75Q==
X-Gm-Message-State: APjAAAW0q/lePWbBqdR2bg6M9Ld2dRpi8O0HKYSQu4daJrt27b1ReQHj
        9FCTWz82jvtflRS+/caE57RX13V+x4QPtMxdhY9uQA==
X-Google-Smtp-Source: APXvYqwFVrkJc6Ars41vZLv1PWwWvp79P7NNy1HRLGKPliMA4SZgci9iPnaAggH1BDGnbrEDsgGovH0KqGY39VpJ6TM=
X-Received: by 2002:a25:4147:: with SMTP id o68mr20740148yba.148.1557929501573;
 Wed, 15 May 2019 07:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190514213940.2405198-1-guro@fb.com> <20190514213940.2405198-6-guro@fb.com>
 <0100016abbcb13b1-a1f70846-1d8c-4212-8e74-2b9be8c32ce7-000000@email.amazonses.com>
In-Reply-To: <0100016abbcb13b1-a1f70846-1d8c-4212-8e74-2b9be8c32ce7-000000@email.amazonses.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 15 May 2019 07:11:30 -0700
Message-ID: <CALvZod5dMM50pZWuOR5SN7aPPG8Zsp-+U3Y+q-UHTNo=Dgz-Nw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] mm: rework non-root kmem_cache lifecycle management
To:     Christopher Lameter <cl@linux.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Lameter <cl@linux.com>
Date: Wed, May 15, 2019 at 7:00 AM
To: Roman Gushchin
Cc: Andrew Morton, Shakeel Butt, <linux-mm@kvack.org>,
<linux-kernel@vger.kernel.org>, <kernel-team@fb.com>, Johannes Weiner,
Michal Hocko, Rik van Riel, Vladimir Davydov,
<cgroups@vger.kernel.org>

> On Tue, 14 May 2019, Roman Gushchin wrote:
>
> > To make this possible we need to introduce a new percpu refcounter
> > for non-root kmem_caches. The counter is initialized to the percpu
> > mode, and is switched to atomic mode after deactivation, so we never
> > shutdown an active cache. The counter is bumped for every charged page
> > and also for every running allocation. So the kmem_cache can't
> > be released unless all allocations complete.
>
> Increase refcounts during each allocation? Looks to be quite heavy
> processing.

Not really, it's a percpu refcnt. Basically the memcg's
percpu_ref_tryget* is replaced with kmem_cache's percpu_ref_tryget,
so, no additional processing.
