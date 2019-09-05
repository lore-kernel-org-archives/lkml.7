Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F67EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B57206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567717888;
	bh=CaQ3F6fm1/CUlyDYz/y+HzSYQRNEdh5yTD8s/4zXdFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rKWFkvSbo5J/0CCTXgkWqswMU/XK2LOyBzvhY+0z6IoqEsyGdbPBtj+hjcN6HDT8a
	 hfnx4t6N0ZJDe09WkeEdHIjpF7lAPnnRnwu/eoeccEfaMH9kKBCjI6zxJKqL40pMPg
	 P2GD0mgWiNklxmPuD7CDZ4Tszhwg5CIOBcv46xAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404128AbfIEVL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:11:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35230 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388578AbfIEVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:11:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so3994741lje.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJ1viyEd746u1MzO5bkdAZU+71ZT2HJWhvIS6MWOLz4=;
        b=d4fpCjgqvFKqBijwNopM5Tjl0Abua4COwRNrVEApjvF/wjmS5dLW3m+kZhLhJeWnNu
         iSfejJzg0trBi/IHb6f2jl/1tb3uJHRcCRTEU7aIX6HTXwYewwZvmYkWtTpA7+5upHD6
         uWJrxHL1ER3GQibDLiYN4aNmhG5i7+LEzMMxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJ1viyEd746u1MzO5bkdAZU+71ZT2HJWhvIS6MWOLz4=;
        b=gayb1YOR52ct1IUWIDez9tjq4woK7WirpbyAyBP5rhu6jNQOFWXaplpmXtCo6Wzb08
         TzCc7WdXLqhW+/oI1onVppTKRIgiy17pJ+Yjzr4PlzoZuHlo7RYcUotL94hHptO34Lrv
         PpsFSGxEaVqKY8+aEQWGZRJSh33KgB4Mvmv0wCMmCoox2AYNyRofHWyELOb3j0tftA6J
         TrdTtGnKhMR+Mglw1xnjiDmF/S0L9QzjJnmq5GqtwSajEJjbAegADCao3TIuGPvg6xdn
         yRPZVGHh4saUjhtkuNdG8L1hhRM/knAbfZYFpn6RMfp825owcZTd1WySOL/n3ozIlKhI
         5Uxg==
X-Gm-Message-State: APjAAAVx9ctD5cz6HLJmNay8mtigl46V58/pDsA8P5dg0mOtjBY8ZHRq
        Ip9pkGo8tFlekCV9oGFCpe8i5ymHx/g=
X-Google-Smtp-Source: APXvYqwbXnYg5haVJT02Ym0reVLR9jbtZtebTezEeTIsDLYke9+J+pxiwhnerUBty3mMl95r4Wp5aA==
X-Received: by 2002:a2e:8656:: with SMTP id i22mr2445374ljj.32.1567717884844;
        Thu, 05 Sep 2019 14:11:24 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t16sm652722lfp.38.2019.09.05.14.11.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 14:11:24 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id y23so3642106ljn.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:11:24 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr3621962ljg.72.1567717580519;
 Thu, 05 Sep 2019 14:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190905101534.9637-1-peterx@redhat.com>
In-Reply-To: <20190905101534.9637-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 14:06:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSwiRsT4=q71jnF_5JrUn5qg76VBw+oMJ-e7SQ17Q1QA@mail.gmail.com>
Message-ID: <CAHk-=wgSwiRsT4=q71jnF_5JrUn5qg76VBw+oMJ-e7SQ17Q1QA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mm: Page fault enhancements
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 3:15 AM Peter Xu <peterx@redhat.com> wrote:
>
> This series is split out of userfaultfd-wp series to only cover the
> general page fault changes, since it seems to make sense itself.

The series continues to look sane to me, but I'd like VM people to
take a look. I see a few reviewed-by's, it would be nice to see more
comments from people. I'd like to see Andrea in particular say "yeah,
this looks all good to me".

Also a question on how this will get to me - it smells like Andrew's
-mm tree to me, both from a VM and a userfaultfd angle (and looking
around, at least a couple of previous patches by Peter have gone that
way).

And it would be lovely to have actual _numbers_ for the alleged
latency improvements. I 100% believe them, but still, numbers rule.

Talking about latency, what about that retry loop in gup()? That's the
one I'm not at all convinced about. It doesn't check for signals, so
if there is some retry logic, it loops forever. Hmm?

             Linus
