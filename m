Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A1C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7662072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576671522;
	bh=m/h7t2Wn87r0YwVxwYo9jz2wKBuHu9QOIlom1bjjdpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VhNLBE8Eg75uqxUikdgT+Qj/2YXwFHNAlhl3Qn9Qi28ocf0GbEx1Mq4AvegZd54dl
	 4KNbAdkpPN+aALLeZQyLluUrsqqMf7IFNKjY0+mnfSlOKHS1+masjfDZXL5EiuB4xq
	 jSgLxvX3RJntMeFgkEquFa4CPytucrp4tZ9iGPiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLRMSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:18:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41076 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRMSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:18:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so2050682wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 04:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HdA4x4Mpp0Ob+ig4Pc6f4Csozs6EHGzpAf+wfwCPZUM=;
        b=oKw60tibz2ozN6kXgqmUjIxiZJSkhYCSVlM16hOVIFRcF2dOG9Blm7NLiydXcTws5B
         z2h+NoL4ngtuxa0FtUSRbmVb+w7OuEki889FzgTXbuIsrMivC0iD0K/tFsXIw2ht3rl7
         6yD7Jb2tgnbitAI71s0TsGZ7BeNQjrgvsVBxb0DvD6VhQB08rJaCUKFs5w18yVjjEWSd
         +HJHIkgCcOfk+G57Hnb6S7ZGpC0695zwmTpDVQq1ikbev0cBNUdKy+QEBB++eFiaKJQH
         e0vSrSYDX+ZNOa2fFygTHeXgOgZNuN4hRYkdsBvXON5nm5MKldz3g+HnqAYyVru3nqS4
         CqSQ==
X-Gm-Message-State: APjAAAVuKdAD87omyhi3FKCXNT/3+1QGVmmvC5gne3FviijfHWrEkrtp
        rFZ9IUMYlwuoTcW1hyzO8JY=
X-Google-Smtp-Source: APXvYqwvdlQcIhXXIIukIAvOpQerf7Pd1fFtKLlBDSy+5nmuElWfeJOxSRHPfmDBZCM7c9loTD64lQ==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr2388982wrv.368.1576671519196;
        Wed, 18 Dec 2019 04:18:39 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v20sm2242610wmj.32.2019.12.18.04.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 04:18:38 -0800 (PST)
Date:   Wed, 18 Dec 2019 13:18:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Waiman Long <longman@redhat.com>,
        Eric B Munson <emunson@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com, Jarod Wilson <jarod@redhat.com>
Subject: hugetlbfs testing coverage (was: Re: [PATCH v2] mm/hugetlb: defer
 free_huge_page() to a workqueue)
Message-ID: <20191218121837.GD21485@dhcp22.suse.cz>
References: <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
 <79d3a7e1-384b-b759-cd84-56253fb9ed40@redhat.com>
 <20191216132658.GG30281@dhcp22.suse.cz>
 <98ac628d-f8be-270d-80bc-bf2373299caf@redhat.com>
 <21a92649-bb9f-b024-e52b-4ce9355f973b@redhat.com>
 <20191217090054.GA31063@dhcp22.suse.cz>
 <ca035fbb-752d-70ff-1be8-e2d2f90b3c0e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca035fbb-752d-70ff-1be8-e2d2f90b3c0e@oracle.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-12-19 10:05:06, Mike Kravetz wrote:
> Cc: Eric
> 
> On 12/17/19 1:00 AM, Michal Hocko wrote:
> > On Mon 16-12-19 13:44:53, Waiman Long wrote:
> >> On 12/16/19 10:38 AM, Waiman Long wrote:
> > [...]
> >>>> Can you extract guts of the testcase and integrate them into hugetlb
> >>>> test suite?
> >>
> >> BTW, what hugetlb test suite are you talking about?
> > 
> > I was using tests from libhugetlbfs package in the past. There are few
> > tests in LTP project but the libhugetlbfs coverage used to cover the
> > largest part of the functionality.
> > 
> > Is there any newer home for the package than [1], Mike? Btw. would it
> > mak sense to migrate those tests to a more common place, LTP or kernel
> > selftests?
> 
> That is the latest home/release for libhugetlbfs.
> 
> The libhugetlbfs test suite is somewhat strange in that I suspect it started
> as testing for libhugetlbfs itself.  When it was written, the thought may have
> been that people would use libhugetlfs as the primary interface to hugetlb
> pages.  That is not the case today.  Over time, hugetlbfs tests not associated
> with libhugetlbfs were added.
> 
> If we want to migrate libhugetlbfs tests, then I think we would only want to
> migrate the non-libhugetlbfs test cases.  Although, the libhugetlbfs specific
> tests are useful as they 'could' point out regressions.

Yeah, I can second that. I remember using the suite and it pointed to
real issues when I was touching the area in the past. So if we can get
as many tests to be independent on the library and integrate it to some
existing testing project - be it kernel selftest or LTP - then it would
be really great and I assume the testing coverage of the hugetlb
functionality would increase dramatically.
-- 
Michal Hocko
SUSE Labs
