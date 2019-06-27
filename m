Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0361C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B4E2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561644128;
	bh=YI563dZ6O4LVMCeIGMb7btzR0KZ2nA8vOv+RmKNOD44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=enH31rxkPLOI9ARkDdxevCVQ5ZZruQlnoDK/ttNQDGXMVqvKQKo5/oEk+FnK5XVD/
	 SXz+wLsQXwS1XqjuxtrjwoWRssGYu7Zgy3x0ZwZmBvjLEMFZb+KyRjKW2rC9v/LHGT
	 nSGkyOwgpcx4beA6DNLNpzuvxxadfa8NW9ZT/pUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfF0OCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:02:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfF0OCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:02:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A49B6AF6A;
        Thu, 27 Jun 2019 14:02:05 +0000 (UTC)
Date:   Thu, 27 Jun 2019 16:02:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 1/5] mm: introduce MADV_COLD
Message-ID: <20190627140203.GB5303@dhcp22.suse.cz>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-2-minchan@kernel.org>
 <343599f9-3d99-b74f-1732-368e584fa5ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343599f9-3d99-b74f-1732-368e584fa5ef@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-06-19 06:13:36, Dave Hansen wrote:
> On 6/27/19 4:54 AM, Minchan Kim wrote:
> > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > MADV_COLD can be used by a process to mark a memory range as not expected
> > to be used in the near future. The hint can help kernel in deciding which
> > pages to evict early during memory pressure.
> > 
> > It works for every LRU pages like MADV_[DONTNEED|FREE]. IOW, It moves
> > 
> > 	active file page -> inactive file LRU
> > 	active anon page -> inacdtive anon LRU
> 
> Is the LRU behavior part of the interface or the implementation?
> 
> I ask because we've got something in between tossing something down the
> LRU and swapping it: page migration.  Specifically, on a system with
> slower memory media (like persistent memory) we just migrate a page
> instead of discarding it at reclaim:

But we already do have interfaces for migrating the memory
(move_pages(2)). Why should this interface duplicate that interface?
I believe the only purpose of these two new madvise modes is to provide
a non-destructive MADV_{DONTNEED,FREE} alteternatives. In other words,
pageout vs. age interface.
-- 
Michal Hocko
SUSE Labs
