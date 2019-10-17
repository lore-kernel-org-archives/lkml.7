Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC389FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF4A218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571273404;
	bh=IYJzNb9unWNMZK55GWXexB0DpsKeOwmGxuFGk3dxhMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jhWewkUwY4TqHkd2o5za0EM8vYcSJ9glOvUuNx6MRq8eCvD8lx3g2Ch1SlLCE1n1d
	 P49i2hTWG51hy1CVBRpWlPwprXJGhF5PmmBL/enriDJuZQNecAhAM+r/HI/Eg65oxE
	 ZisYKL7muiIKMSXuKp502RPLn6UXvxc3nqw+fYyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405384AbfJQAt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 20:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403893AbfJQAt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:49:56 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC56420872;
        Thu, 17 Oct 2019 00:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571273396;
        bh=IYJzNb9unWNMZK55GWXexB0DpsKeOwmGxuFGk3dxhMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZF1baU1o3y5gSgLWTM6fEbQK9smKG/HjbhMqyqekJ0qvU5Nm6MbJeLUHCSeNh5w3J
         tg3gDIAsXqpfhuNrM0faCk4eASmCQYMgKcHSZJkC4YFi7z7U1XUCR6tXGkZFgICAao
         UECGGb/C/2pSDVkEp9eeIi9yxgwjVWUtPiI79YTw=
Date:   Wed, 16 Oct 2019 17:49:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>, <mhocko@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Unsigned 'nr_pages' always larger than zero
Message-Id: <20191016174955.300d5fd4968537151d3ad43f@linux-foundation.org>
In-Reply-To: <5DA6DDE0.6000804@huawei.com>
References: <1567592763-25282-1-git-send-email-zhongjiang@huawei.com>
        <5505fa16-117e-8890-0f48-38555a61a036@suse.cz>
        <20190904114820.42d9c4daf445ded3d0da52ab@linux-foundation.org>
        <73c49a1b-4f42-c21d-ccd8-2b063cdf1293@nvidia.com>
        <5DA6DDE0.6000804@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 17:07:44 +0800 zhong jiang <zhongjiang@huawei.com> wrote:

> >> --- a/mm/gup.c~a
> >> +++ a/mm/gup.c
> >> @@ -1450,6 +1450,7 @@ static long check_and_migrate_cma_pages(
> >>       bool drain_allow = true;
> >>       bool migrate_allow = true;
> >>       LIST_HEAD(cma_page_list);
> >> +    long ret;
> >>     check_again:
> >>       for (i = 0; i < nr_pages;) {
> >> @@ -1511,17 +1512,18 @@ check_again:
> >>            * again migrating any new CMA pages which we failed to isolate
> >>            * earlier.
> >>            */
> >> -        nr_pages = __get_user_pages_locked(tsk, mm, start, nr_pages,
> >> +        ret = __get_user_pages_locked(tsk, mm, start, nr_pages,
> >>                              pages, vmas, NULL,
> >>                              gup_flags);
> >>   -        if ((nr_pages > 0) && migrate_allow) {
> >> +        nr_pages = ret;
> >> +        if (ret > 0 && migrate_allow) {
> >>               drain_allow = true;
> >>               goto check_again;
> >>           }
> >>       }
> >>   -    return nr_pages;
> >> +    return ret;
> >>   }
> >>   #else
> >>   static long check_and_migrate_cma_pages(struct task_struct *tsk,
> >>
> >
> > +1 for this approach, please.
> >
> >
> > thanks,
> Hi,  Andrew
> 
> I didn't see the fix for the issue in the upstream. Your proposal should be
> appiled to upstream. Could you appiled the patch or  repost by me ?

Forgotten about it ;)  Please send a patch sometime?
