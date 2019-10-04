Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B35C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14488207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="BhRNITA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfJDNYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:24:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45643 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbfJDNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:24:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33so5781426edh.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kC0wou+Dasn/pd1LnI7XBoVoqfoHQBaDPYzRoYPpQxM=;
        b=BhRNITA6NTYE/ZXWEXJV/K+t8yiBZHujBRRNrxtrKVoLvxG54Jju2AsHqVYpqDl66d
         5IMDajpyyDGlD1YO/U95nfJpF/4jV+Ey/euGrG9fR4Vk+3uapwprtymiREEa63kwohhe
         D1rZimm8b/8e6awZyPZF/1P/LA0YNNQpN5Gqk/jETdi4WgQLWW9APZebz2nHsa7BCAjL
         cZN8pVP9ytNzsSIahA8CFyrSkwC+kVaDr0yse/8rmb067xI5ZrfvAa5amu+X46qpFX/j
         EEi+/nd4y5bteKQEFeBrZE4ICHV47H9nKFxONMVwcYUHZeLB3fGBn033B2WTLzGgttCA
         ugkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kC0wou+Dasn/pd1LnI7XBoVoqfoHQBaDPYzRoYPpQxM=;
        b=U0emoTUiWs5c2rAFqVr+L5JuewThMAD5mMCfcqiPl2pGFfN57Qh3pUxI/DZppsciNK
         ladcFaPKF2TSrQcROFkgn3CD19jovP8qFZjtMkuk2oTtm+unarO8iDz09PtLvLeug2Hi
         L20+ByAvHrQEfc3cv6kxZU461Ju66nLyD6zRXD/17Ar5p/35sA5ktnk4y2eh5TQJqDyw
         AJrp4kCStI3DAB8aM8qCJbkpE6gke/HhIX9llQayzb0CAedgXXMJC+iyx5BkLC4QCuXt
         XUMPdWqVszOlKq2F0vkeSwqV8u/ow5qvZrzwQUx+SX4fxRNN9TugtqZnh2IwIveq7d+V
         sVAg==
X-Gm-Message-State: APjAAAXKOSfosnT81+y57WZOzXgqbauldSGiVrG8qAfx4oLxZyBpXlJD
        B3mPwTfzlQSk8CBviOTHfyXCkg==
X-Google-Smtp-Source: APXvYqwKMovkTP9ls7BP16QYMpDJXtQ1KEBlJSMu1r2z/XB6HGs81c1HF+I/xgQ/Y7dvK5Ygt7OdXQ==
X-Received: by 2002:a50:9402:: with SMTP id p2mr15211536eda.111.1570195448996;
        Fri, 04 Oct 2019 06:24:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id ha2sm601859ejb.63.2019.10.04.06.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:24:08 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4C3FE102143; Fri,  4 Oct 2019 16:24:07 +0300 (+03)
Date:   Fri, 4 Oct 2019 16:24:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v3 2/7] mm: Add a walk_page_mapping() function to the
 pagewalk code
Message-ID: <20191004132407.gzttci7lio6be467@box>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-3-thomas_os@shipmail.org>
 <20191003111708.sttkkrhiidleivc6@box>
 <d336497b-3716-0748-d838-378902399439@shipmail.org>
 <20191004123732.xpr3vroee5mhg2zt@box.shutemov.name>
 <8ef9fff3-df8d-cc14-35f9-d83db62e874f@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ef9fff3-df8d-cc14-35f9-d83db62e874f@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:58:59PM +0200, Thomas Hellström (VMware) wrote:
> On 10/4/19 2:37 PM, Kirill A. Shutemov wrote:
> > On Thu, Oct 03, 2019 at 01:32:45PM +0200, Thomas Hellström (VMware) wrote:
> > > > > + *   If @mapping allows faulting of huge pmds and puds, it is desirable
> > > > > + *   that its huge_fault() handler blocks while this function is running on
> > > > > + *   @mapping. Otherwise a race may occur where the huge entry is split when
> > > > > + *   it was intended to be handled in a huge entry callback. This requires an
> > > > > + *   external lock, for example that @mapping->i_mmap_rwsem is held in
> > > > > + *   write mode in the huge_fault() handlers.
> > > > Em. No. We have ptl for this. It's the only lock required (plus mmap_sem
> > > > on read) to split PMD entry into PTE table. And it can happen not only
> > > > from fault path.
> > > > 
> > > > If you care about splitting compound page under you, take a pin or lock a
> > > > page. It will block split_huge_page().
> > > > 
> > > > Suggestion to block fault path is not viable (and it will not happen
> > > > magically just because of this comment).
> > > > 
> > > I was specifically thinking of this:
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/mm/pagewalk.c#L103
> > > 
> > > If a huge pud is concurrently faulted in here, it will immediatly get split
> > > without getting processed in pud_entry(). An external lock would protect
> > > against that, but that's perhaps a bug in the pagewalk code?  For pmds the
> > > situation is not the same since when pte_entry is used, all pmds will
> > > unconditionally get split.
> > I *think* it should be fixed with something like this (there's no
> > pud_trans_unstable() yet):
> > 
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index d48c2a986ea3..221a3b945f42 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -102,10 +102,11 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> >   					break;
> >   				continue;
> >   			}
> > +		} else {
> > +			split_huge_pud(walk->vma, pud, addr);
> >   		}
> > -		split_huge_pud(walk->vma, pud, addr);
> > -		if (pud_none(*pud))
> > +		if (pud_none(*pud) || pud_trans_unstable(*pud))
> >   			goto again;
> >   		if (ops->pmd_entry || ops->pte_entry)
> 
> Yes, this seems better. I was looking at implementing a pud_trans_unstable()
> as a basis of fixing problems like this, but when I looked at
> pmd_trans_unstable I got a bit confused:
> 
> Why are devmap huge pmds considered stable? I mean, couldn't anybody just
> run madvise() to clear those just like transhuge pmds?

Matthew, Dan, could you comment on this?

> > Or better yet converted to what we do on pmd level.
> > 
> > Honestly, all the code around PUD THP missing a lot of ground work.
> > Rushing it upstream for DAX was not a right move.
> > 
> > > There's a similar more scary race in
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L3931
> > > 
> > > It looks like if a concurrent thread faults in a huge pud just after the
> > > test for pud_none in that pmd_alloc, things might go pretty bad.
> > Hm? It will fail the next pmd_none() check under ptl. Do you have a
> > particular racing scenarion?
> > 
> Yes, I misinterpreted the code somewhat, but here's the scenario that looks
> racy:
> 
> Thread 1		Thread 2
> huge_fault(pud)					- Fell back, for example because of write fault on dirty-tracking.
> 			huge_fault(pud)         - Taken, read fault.
> pmd_alloc()                                     - Will fail pmd_none check and return a pmd_offset()

I see. It also misses pud_tans_unstable() check or its variant.

-- 
 Kirill A. Shutemov
