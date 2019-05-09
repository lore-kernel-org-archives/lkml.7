Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7947C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DFE217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hcS2DnRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfEIUzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 16:55:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35634 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfEIUzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:55:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so4910434wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twHTP9jiSqEVzBzjTXkpWtvwU3evhPvIng4+VfGd1RY=;
        b=hcS2DnRb7b9GpzIeWp9sps7ZKr/qpDqKDGAleSMKHctFqO86hli5j5VtrwVZcSCqF/
         5t/BTlNhBgel9Y6wEBhswVx2ra6finWiwVd3i2yUsm/pZKE9uUXtQaLbbZa0kdgyrQic
         iFzmcd8HYK1hYAMxkdCFeutTKrVHgb8L1EyoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twHTP9jiSqEVzBzjTXkpWtvwU3evhPvIng4+VfGd1RY=;
        b=S9qWtP754uuF3S890t9AV06fcCFpzJlAJh045JuoM25WOpxAtNdRd9tfR4AXFc9Mg+
         kWOv7ze98oR5gc2U4qcKqNHxNavIAKoRO+Sm9Av5wZHa/wGs5pK1X76+tHm4SDOexLEi
         Z5RuA+0suSiZ6DWZiNz11Frg9JV7rnOXQus5iV9EFvcZ4mVY2cx1ubgNtnwsP1TKfPsE
         IMfzUfGXfFf/rccB6h82tnNiS5P3fHNDIszKhor243P+9MdVa12uk/1iWaZa41v0m0S0
         EIKIZi9NOWUfWDpq/xnRYXLW78L1zolLdyQkXNpnqlR52HRJKr7jgdf8VHPkbCielrXp
         Yoog==
X-Gm-Message-State: APjAAAVMPmSTnS7j9UWYnfbYOHwdzuUVDDBK48Cktby8UmenOFKELes7
        +Ycu9XnYRuzNLeBLh2E5j9GFFaLrdnWHNw==
X-Google-Smtp-Source: APXvYqzN7SFzTIwb5hv9O+GZqK4L9tXEwI6AK+V0TgCAPdR1WoX7VjIW4L0no+wHcHs+Emtix0fg+A==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr1549827wrp.240.1557435351265;
        Thu, 09 May 2019 13:55:51 -0700 (PDT)
Received: from andrea ([91.252.228.170])
        by smtp.gmail.com with ESMTPSA id f6sm1944723wmh.13.2019.05.09.13.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:55:50 -0700 (PDT)
Date:   Thu, 9 May 2019 22:55:43 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Yan, Zheng" <ukernel@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/5] ceph: fix improper use of smp_mb__before_atomic()
Message-ID: <20190509205452.GA4359@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-5-git-send-email-andrea.parri@amarulasolutions.com>
 <20190430082332.GB2677@hirez.programming.kicks-ass.net>
 <CAAM7YA=YOM79GJK8b7OOQbzT_-sYRD2UFHYithY7Li1yQt5Hog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAM7YA=YOM79GJK8b7OOQbzT_-sYRD2UFHYithY7Li1yQt5Hog@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:08:43PM +0800, Yan, Zheng wrote:
> On Tue, Apr 30, 2019 at 4:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Apr 29, 2019 at 10:15:00PM +0200, Andrea Parri wrote:
> > > This barrier only applies to the read-modify-write operations; in
> > > particular, it does not apply to the atomic64_set() primitive.
> > >
> > > Replace the barrier with an smp_mb().
> > >
> >
> > > @@ -541,7 +541,7 @@ static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
> > >                                          long long release_count,
> > >                                          long long ordered_count)
> > >  {
> > > -     smp_mb__before_atomic();
> >
> > same
> >         /*
> >          * XXX: the comment that explain this barrier goes here.
> >          */
> >
> 
> makes sure operations that setup readdir cache (update page cache and
> i_size) are strongly ordered with following atomic64_set.

Thanks for the suggestion, Yan.

To be clear: would you like me to integrate your comment and resend?
any other suggestions?

Thanx,
  Andrea


> 
> > > +     smp_mb();
> >
> > >       atomic64_set(&ci->i_complete_seq[0], release_count);
> > >       atomic64_set(&ci->i_complete_seq[1], ordered_count);
> > >  }
> > > --
> > > 2.7.4
> > >
