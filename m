Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB6AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B190218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556092720;
	bh=FcaNy2nrusFk15HgfA9bZ5ezqkv2p1qH8YfrjKayM2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uqNEsNe0Xv6OPncUo/lpqEFZUumh2nXc65Ya+aN5KTq4t10wvY3lXmotwja0i35ND
	 ojS0qHnmFFImFSey8JbKtvl7DbiO+1XM7SwKIzfgYmVKcNwzeSBl7dbaYurAIYdPHo
	 LGahvF9m2RWU0Bm/jnciKlbF4QQQkcLAc9n+NBzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfDXH6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:58:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:56538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727333AbfDXH6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:58:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25D96AE2B;
        Wed, 24 Apr 2019 07:58:36 +0000 (UTC)
Date:   Wed, 24 Apr 2019 09:58:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     vbabka@suse.cz, rientjes@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
Message-ID: <20190424075834.GB12751@dhcp22.suse.cz>
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190423175252.GP25106@dhcp22.suse.cz>
 <6004f688-99d8-3f8c-a106-66ee52c1f0ee@linux.alibaba.com>
 <dace50e0-b72c-33db-5624-bf7449552ff8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dace50e0-b72c-33db-5624-bf7449552ff8@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-04-19 17:22:36, Yang Shi wrote:
> 
> 
> On 4/23/19 11:34 AM, Yang Shi wrote:
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
> > > 
> > > I have to say that the THP tuning API is one giant mess :/
> > > 
> > > Btw. this patch also seem to fix khugepaged behavior because it
> > > previously
> > > ignored both VM_NOHUGEPAGE and MMF_DISABLE_THP.
> 
> Second look shows this is not ignored. hugepage_vma_check() would check this
> for both anonymous vma and shmem vma before scanning. It is called before
> shmem_huge_enabled().

Right. I have missed the earlier check. The main question remains
though.

-- 
Michal Hocko
SUSE Labs
