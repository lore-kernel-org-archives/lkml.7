Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143EC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA4420862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QxcuWXbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbfJDMhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:37:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42732 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfJDMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:37:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id y91so5647764ede.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FCR5dbyFL4JcthMLmOPGE4IWt+rC/CEpp1RTDjU/JI0=;
        b=QxcuWXbCCNxVcngInfcaD8sQPGmbvwR9uvtRh6g+yghAM03yT5vEYmXLb5J0dLFMie
         /Kt7C2MzYByQ3WAdirPwd2H0a6g56Hw74YEgRh9gdoHrW6duA/S3aSUySspepW5NYh6P
         zwiAQSZO/zF520LziTlfYf65ZbZVQHA3f67yecMMr2fV1xro9QC7toOY+M76PiNlr28R
         x1CmlXn1VncpN4uEZNLYvVYriPM8+sSUaOXCle9jg3h/PXJ63vtPy4JIipEQm+obBfRN
         S5AvS8w0q8BqAmljMp/GiRQrHEiaC8tnvhD2YsPX7seJySpnZP9RouXFwKjrWZsSTrXy
         2W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FCR5dbyFL4JcthMLmOPGE4IWt+rC/CEpp1RTDjU/JI0=;
        b=Pr1IwRaQaHKcVsgwlD4B39HP9pvS194rcvV3N3RUCR+I09E8LHIB7vfz3s/gdFvzwK
         IoKJew0xdSvT55jJXbvyg7Y4vmrap9eyACb3t0z2rtbJm4NAikNqkdKOADPLBQOakejf
         qX7LA/L1zhhcolAsenyhD3OUTpbVc1CdPYryKwJWH6Vo8CR+vzhCNGUUrZkPdbeJmuom
         XTDk7My+cvhyGp9yjyIsVeiYTauBKqQS6bidMrmk1MthWfThWYqXMN+dUmQ/LqB6ryZi
         Qux+IHLb1ek9c0OrlXP0AKqbTMblwFP9i+TWKBjX+SgcwbP+xxGUpWtkQV5tFJs4pz9a
         Rq8Q==
X-Gm-Message-State: APjAAAUmD6ST1EP4cWc1BmT2D+RJ815TNxRXteWdmIpbLrGj0qSmXcrM
        2s3ORmPUTLJcMPbtGDMxCgg2DQ==
X-Google-Smtp-Source: APXvYqwaN9Piat7yNEqCbXckJquXUPHqHDwzQ6A5013aE6ofJKK6A8PoqNI0M1Tpps3POLL5d8VhLw==
X-Received: by 2002:aa7:d386:: with SMTP id x6mr14874136edq.264.1570192654850;
        Fri, 04 Oct 2019 05:37:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id gx14sm584793ejb.38.2019.10.04.05.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 05:37:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 50C4A102143; Fri,  4 Oct 2019 15:37:32 +0300 (+03)
Date:   Fri, 4 Oct 2019 15:37:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v3 2/7] mm: Add a walk_page_mapping() function to the
 pagewalk code
Message-ID: <20191004123732.xpr3vroee5mhg2zt@box.shutemov.name>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-3-thomas_os@shipmail.org>
 <20191003111708.sttkkrhiidleivc6@box>
 <d336497b-3716-0748-d838-378902399439@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d336497b-3716-0748-d838-378902399439@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:32:45PM +0200, Thomas Hellström (VMware) wrote:
> > > + *   If @mapping allows faulting of huge pmds and puds, it is desirable
> > > + *   that its huge_fault() handler blocks while this function is running on
> > > + *   @mapping. Otherwise a race may occur where the huge entry is split when
> > > + *   it was intended to be handled in a huge entry callback. This requires an
> > > + *   external lock, for example that @mapping->i_mmap_rwsem is held in
> > > + *   write mode in the huge_fault() handlers.
> > Em. No. We have ptl for this. It's the only lock required (plus mmap_sem
> > on read) to split PMD entry into PTE table. And it can happen not only
> > from fault path.
> > 
> > If you care about splitting compound page under you, take a pin or lock a
> > page. It will block split_huge_page().
> > 
> > Suggestion to block fault path is not viable (and it will not happen
> > magically just because of this comment).
> > 
> I was specifically thinking of this:
> 
> https://elixir.bootlin.com/linux/latest/source/mm/pagewalk.c#L103
> 
> If a huge pud is concurrently faulted in here, it will immediatly get split
> without getting processed in pud_entry(). An external lock would protect
> against that, but that's perhaps a bug in the pagewalk code?  For pmds the
> situation is not the same since when pte_entry is used, all pmds will
> unconditionally get split.

I *think* it should be fixed with something like this (there's no
pud_trans_unstable() yet):

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d48c2a986ea3..221a3b945f42 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -102,10 +102,11 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 					break;
 				continue;
 			}
+		} else {
+			split_huge_pud(walk->vma, pud, addr);
 		}
 
-		split_huge_pud(walk->vma, pud, addr);
-		if (pud_none(*pud))
+		if (pud_none(*pud) || pud_trans_unstable(*pud))
 			goto again;
 
 		if (ops->pmd_entry || ops->pte_entry)

Or better yet converted to what we do on pmd level.

Honestly, all the code around PUD THP missing a lot of ground work.
Rushing it upstream for DAX was not a right move.

> There's a similar more scary race in
> 
> https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L3931
> 
> It looks like if a concurrent thread faults in a huge pud just after the
> test for pud_none in that pmd_alloc, things might go pretty bad.

Hm? It will fail the next pmd_none() check under ptl. Do you have a
particular racing scenarion?

-- 
 Kirill A. Shutemov
