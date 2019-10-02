Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6E1C4CED1
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D9C222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570059501;
	bh=aIYU0BQaA3Qjkeqyvj5HMtftv1DGk5LFME9OTU/Ao+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q1lc7ZsInnIjNCGsrwVKYdiurnax7YEWHxYAf6pm1wGOX2XYWhzVpBRp2ukaFtykz
	 of2s/nYe0of1mfb9oPBTT5oZ2yQurx4VhWmV/cp5UQkP8upSAc6GCGZy0UbJYicwNa
	 LEBLto6gThv5le3KJMjZ1GLE50F6vWPfZXg+1tn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfJBXiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:38:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37197 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfJBXiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:38:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so359686lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZjgSIj0qxyD6RaNtViJgY4xf89RohIDwPAnz/d5hI8=;
        b=XctgwNUSLJVHyx0l1z7HmbUqXz/kLm2tlmec02aPXrV9Mg4o/2cYv7qFPK2f4824Fy
         huoPbZKRtlv3H5nyAAxtBbaDGrOWa3y+sAgPN1x/k8UITKbzDoFrTzAhN7+ANuYCBttV
         48q8QQY3ufyqk60ntMEla2tbGmOT9eQW9m25M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZjgSIj0qxyD6RaNtViJgY4xf89RohIDwPAnz/d5hI8=;
        b=c85tImgTim2pVGOH6vPkY42bdBFr6EJhvJ1Vlp/78gJ/SXb0kUW188rSY5Szk1E6FG
         Dv74pan/6doQnNrPpux9KKh5OtQoMDPeHF4ohTBlCNGXlbx1ZmUyYSUtrZZgAzVqtyIv
         ZOf47QFJnhGxxvx6VzWjX96QkkRiiH+Pd9loAlw/5tVym/xM315hRNH9Nl2d1HlTiCFP
         MRhKm0e7DSoyVxh5D7o3iBHT5Iq+MTC/QZv1Vy8lNfqJ6EKXz6jUdZl8nM/w66diTIpr
         kqgrTwoXqEz2sPkjO7eI2UbEkRx5TxMnezvhgdm2j3eebaOJ3ko9ZCUBVN95WrfzAOIg
         F8xQ==
X-Gm-Message-State: APjAAAW6/nW+iAXlA6N6MhH239V5p17bojdAWRQIleSY83Olkt8PP8bo
        w/hURsBjuaTTnOWikizb8B44MZrX2s0=
X-Google-Smtp-Source: APXvYqydTgdIDhf56LkICaXhrC9ofEXeFths+miKbLciMY+caX1ZCnlUGzSbaKYpZTG+67PvsPilIQ==
X-Received: by 2002:ac2:4853:: with SMTP id 19mr3753993lfy.69.1570059495433;
        Wed, 02 Oct 2019 16:38:15 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q3sm174823ljq.4.2019.10.02.16.38.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 16:38:13 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id y23so619117lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:38:13 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr4178421ljf.48.1570059493007;
 Wed, 02 Oct 2019 16:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Oct 2019 16:37:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTqcdgyWjsj0Kip-2GLqx+dkWGoUTKmxCT3VN7Ya2bSg@mail.gmail.com>
Message-ID: <CAHk-=wgTqcdgyWjsj0Kip-2GLqx+dkWGoUTKmxCT3VN7Ya2bSg@mail.gmail.com>
Subject: Re: [rfc] mm, hugetlb: allow hugepage allocations to excessively reclaim
To:     David Rientjes <rientjes@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 4:03 PM David Rientjes <rientjes@google.com> wrote:
>
> Since hugetlb allocations have explicitly preferred to loop and do reclaim
> and compaction, exempt them from this new behavior at least for the time
> being.  It is not shown that hugetlb allocation success rate has been
> impacted by commit b39d0ee2632d but hugetlb allocations are admittedly
> beyond the scope of what the patch is intended to address (thp
> allocations).

I'd like to see some numbers to show that this special case makes sense.

I understand the "this is what it used to do, and hugetlbfs wasn't the
intended recipient of the new semantics", and I don't think the patch
is wrong.

But at the same time, we do know that swap storms happen for other
loads, and if we say "hugetlbfs is different" then there should at
least be some rationale for why it's different other than "history".
Some actual "yes, we _want_ the possibile swap storms, because load
XYZ".

And I don't mean microbenchmark numbers for "look, behavior changed".
I mean "look, this is a real load, and now it runs X% slower because
it relied on this hugetlbfs behavior".

               Linus
