Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A84C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ADC2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557226034;
	bh=h/Vf28zyKT7ZTVLlLgZV6Ssyfl0DWtXw+260nTk0YiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=14ISIuTqsgwMrlUNCLvupPs4tLaEx0fle8dFEaQCNSD/LT6copUY+aKWJLoDOJ/+v
	 QojE1Ju+BPfzH1muPq2bYiQ0tjyv/o523tcOGff0PMbcjksGauyec9oc+9KIQb97wI
	 xtqprC77BOL51oiVHOGr3fr5ZPU8Sf9Or2SYpN8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEGKrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:47:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:37278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfEGKrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:47:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D211AD56;
        Tue,  7 May 2019 10:47:11 +0000 (UTC)
Date:   Tue, 7 May 2019 12:47:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, rientjes@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
Message-ID: <20190507104709.GP31017@dhcp22.suse.cz>
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190423175252.GP25106@dhcp22.suse.cz>
 <5a571d64-bfce-aa04-312a-8e3547e0459a@linux.alibaba.com>
 <859fec1f-4b66-8c2c-98ee-2aee9358a81a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <859fec1f-4b66-8c2c-98ee-2aee9358a81a@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[Hmm, I thought, Hugh was CCed]

On Mon 06-05-19 16:37:42, Yang Shi wrote:
> 
> 
> On 4/28/19 12:13 PM, Yang Shi wrote:
> > 
> > 
> > On 4/23/19 10:52 AM, Michal Hocko wrote:
> > > On Wed 24-04-19 00:43:01, Yang Shi wrote:
> > > > The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility
> > > > for each
> > > > vma") introduced THPeligible bit for processes' smaps. But, when
> > > > checking
> > > > the eligibility for shmem vma, __transparent_hugepage_enabled() is
> > > > called to override the result from shmem_huge_enabled().  It may result
> > > > in the anonymous vma's THP flag override shmem's.  For example,
> > > > running a
> > > > simple test which create THP for shmem, but with anonymous THP
> > > > disabled,
> > > > when reading the process's smaps, it may show:
> > > > 
> > > > 7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
> > > > Size:               4096 kB
> > > > ...
> > > > [snip]
> > > > ...
> > > > ShmemPmdMapped:     4096 kB
> > > > ...
> > > > [snip]
> > > > ...
> > > > THPeligible:    0
> > > > 
> > > > And, /proc/meminfo does show THP allocated and PMD mapped too:
> > > > 
> > > > ShmemHugePages:     4096 kB
> > > > ShmemPmdMapped:     4096 kB
> > > > 
> > > > This doesn't make too much sense.  The anonymous THP flag should not
> > > > intervene shmem THP.  Calling shmem_huge_enabled() with checking
> > > > MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
> > > > dax vma check since we already checked if the vma is shmem already.
> > > Kirill, can we get a confirmation that this is really intended behavior
> > > rather than an omission please? Is this documented? What is a global
> > > knob to simply disable THP system wise?
> > 
> > Hi Kirill,
> > 
> > Ping. Any comment?
> 
> Talked with Kirill at LSFMM, it sounds this is kind of intended behavior
> according to him. But, we all agree it looks inconsistent.
> 
> So, we may have two options:
>     - Just fix the false negative issue as what the patch does
>     - Change the behavior to make it more consistent
> 
> I'm not sure whether anyone relies on the behavior explicitly or implicitly
> or not.

Well, I would be certainly more happy with a more consistent behavior.
Talked to Hugh at LSFMM about this and he finds treating shmem objects
separately from the anonymous memory. And that is already the case
partially when each mount point might have its own setup. So the primary
question is whether we need a one global knob to controll all THP
allocations. One argument to have that is that it might be helpful to
for an admin to simply disable source of THP at a single place rather
than crawling over all shmem mount points and remount them. Especially
in environments where shmem points are mounted in a container by a
non-root. Why would somebody wanted something like that? One example
would be to temporarily workaround high order allocations issues which
we have seen non trivial amount of in the past and we are likely not at
the end of the tunel.

That being said I would be in favor of treating the global sysfs knob to
be global for all THP allocations. I will not push back on that if there
is a general consensus that shmem and fs in general are a different
class of objects and a single global control is not desirable for
whatever reasons.

Kirill, Hugh othe folks?
-- 
Michal Hocko
SUSE Labs
