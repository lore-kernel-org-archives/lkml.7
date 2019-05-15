Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA80C04AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EDA2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEOGZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:25:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42239 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfEOGZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:25:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so1202274wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 23:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uH/Ak+qwpv4XA3p578BfJ9QI58tlfVBtU336J8yg4yM=;
        b=iEEcxP+OkrJbOak0/0b7pjbRSGQWiUJCO+nFb6hZcKDiaWAQMFLAlFaKNYasT5ISsZ
         FGSkEfm/YSso6zyRo2DLmwzd6kY20JCguee+yCVoemgbi1OVVagm5HX0BvFnGKGEmxzu
         o/ilO+F1r0rS47cAHSZSI9l8kovMaYAt95AM/xXfdnEhn2zsedQghp+pL+UyiYKeySUC
         NWTxPIWH1NAphs0ZCuDVOcYPv5b1uEEyxESI6+tLeO7Gx5Qi0uUa6oQl93xBJe2wYiTp
         UeOqxVEIfLiputoYiawLVjfpBmaT6VwouZpxv5VhHFC+QaQuU+r7uliqF36Tvis9hl0H
         ukoQ==
X-Gm-Message-State: APjAAAV1den7NtV45qgsaCrBjJnhX4BXlqP6tJ1rMJpEHU1ibbO2UhMU
        QJy62Y4tnyDIZngZr0bwqIw2vQ==
X-Google-Smtp-Source: APXvYqy9N7PjZcstz8RL5u6WAhk+/8CIFxxZEJZhgG68v3OBGcUpeITTrUhLlcoCe1EHcGvB93LMWQ==
X-Received: by 2002:adf:b6a5:: with SMTP id j37mr20768030wre.4.1557901525798;
        Tue, 14 May 2019 23:25:25 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o6sm1390076wrh.55.2019.05.14.23.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 23:25:25 -0700 (PDT)
Date:   Wed, 15 May 2019 08:25:23 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514145122.GG4683@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, May 14, 2019 at 04:51:22PM +0200, Michal Hocko wrote:
> [Forgot Hugh]
> 
> On Tue 14-05-19 16:41:05, Michal Hocko wrote:
> > [This is adding a new user visible interface so you should be CCing
> > linux-api mailing list. Also CC Hugh for KSM in general. Done now]

Right, thanks for taking care of this.

> > On Tue 14-05-19 15:16:50, Oleksandr Natalenko wrote:
> > > By default, KSM works only on memory that is marked by madvise(). And the
> > > only way to get around that is to either:
> > > 
> > >   * use LD_PRELOAD; or
> > >   * patch the kernel with something like UKSM or PKSM.
> > > 
> > > Instead, lets implement a sysfs knob, which allows marking VMAs as
> > > mergeable. This can be used manually on some task in question or by some
> > > small userspace helper daemon.
> > > 
> > > The knob is named "force_madvise", and it is write-only. It accepts a PID
> > > to act on. To mark the VMAs as mergeable, use:
> > > 
> > >    # echo PID > /sys/kernel/mm/ksm/force_madvise
> > > 
> > > To unmerge all the VMAs, use the same approach, prepending the PID with
> > > the "minus" sign:
> > > 
> > >    # echo -PID > /sys/kernel/mm/ksm/force_madvise
> > > 
> > > This patchset is based on earlier Timofey's submission [1], but it doesn't
> > > use dedicated kthread to walk through the list of tasks/VMAs. Instead,
> > > it is up to userspace to traverse all the tasks in /proc if needed.
> > > 
> > > The previous suggestion [2] was based on amending do_anonymous_page()
> > > handler to implement fully automatic mode, but this approach was
> > > incorrect due to improper locking and not desired due to excessive
> > > complexity.
> > > 
> > > The current approach just implements minimal interface and leaves the
> > > decision on how and when to act to userspace.
> > 
> > Please make sure to describe a usecase that warrants adding a new
> > interface we have to maintain for ever.

I think of two major consumers of this interface:

1) hosts, that run containers, especially similar ones and especially in
a trusted environment;

2) heavy applications, that can be run in multiple instances, not
limited to opensource ones like Firefox, but also those that cannot be
modified.

I'll add this justification to the cover letter once I send another
iteration of this submission if necessary.

Thank you.

> > 
> > > 
> > > Thanks.
> > > 
> > > [1] https://lore.kernel.org/patchwork/patch/1012142/
> > > [2] http://lkml.iu.edu/hypermail/linux/kernel/1905.1/02417.html
> > > 
> > > Oleksandr Natalenko (4):
> > >   mm/ksm: introduce ksm_enter() helper
> > >   mm/ksm: introduce ksm_leave() helper
> > >   mm/ksm: introduce force_madvise knob
> > >   mm/ksm: add force merging/unmerging documentation
> > > 
> > >  Documentation/admin-guide/mm/ksm.rst |  11 ++
> > >  mm/ksm.c                             | 160 +++++++++++++++++++++------
> > >  2 files changed, 137 insertions(+), 34 deletions(-)
> > > 
> > > -- 
> > > 2.21.0
> > > 
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
