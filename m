Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D996C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549B020665
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="xjVonQsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfIYMRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 08:17:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40010 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIYMRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:17:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so4660362wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqFYHh7P1zkKGNcj3JI+kOGE1cX5L+ByeTo5y44rHeo=;
        b=xjVonQsz/4QZ8/Lk18W0rcjnghr3JMgUBDvgQR3p6G0dTYAXKe8Q2JZEpVM7gWL6/8
         lrp0RDCjIrsPL6F89T9yVdt+JkllEBD3Qty7ewmyojUO95yw+vVlooLLIhtqL6a2GGas
         IHliVfvBF1RV7LSVLdT0PaivVi67xgMc9m7lb7aP2VuPJQvfeWjjYGl4BsKXutpwMo+b
         bBXCEYIxViYCNhuWC9Riij8Q0c5x/JjTKhK9pZcZivSUf5D+6N52viccNNZFAR+WVcBe
         vBXDMVwVgylG4jPDkoyMyPm9PN3sLAlhb4aR2XbRSJGEdQUHrppH5I7OhGVv7186ybuV
         EIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqFYHh7P1zkKGNcj3JI+kOGE1cX5L+ByeTo5y44rHeo=;
        b=PasblzEp1ZHNBNEBkKTQSGHqqUH+CMSTaumAdfUHaYsbP96dNv3KvSJNe2BiacME3+
         iFtO9O+LsKaP62Xu8wz0N4bXhGzXDLNy2J58idtA763a0JcI06XVUP004PjVtwoSsUMI
         tPUNEMKGQD4R+rf9L3sxNQby1vB0OYqbBGy/8bnQT47M/ltx2C/PVr/u8vo/XQdueF/B
         ja70FR12bpMptVUHWaHS1UHpAcegaqCCzO4US5doFautArxDD0MnEbl729qjSWMpH2vv
         C5rsYJBTOpKXYQhQXMIkNqYiT8shAIrfy75TBd+cSr0lKlKnJyFmpjZ/PCq7pep81jzo
         tmeQ==
X-Gm-Message-State: APjAAAUPCku7E/BP0HA+UwXWTE7HZnAH8ETt/ABH0iTWGP2Mgl5THR2w
        BJX+13i2dk+exhOpUMABaRiRRw==
X-Google-Smtp-Source: APXvYqzItaZV+20Vaqxd+notYcQrDLZwBviGcDdP/Otb4i1YIx3iH1LXhQMg01OGijHUOFb2O/YtIg==
X-Received: by 2002:a05:600c:389:: with SMTP id w9mr7210774wmd.139.1569413869649;
        Wed, 25 Sep 2019 05:17:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bo6sm514411ejb.30.2019.09.25.05.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 05:17:48 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B835B1022AB; Wed, 25 Sep 2019 15:17:50 +0300 (+03)
Date:   Wed, 25 Sep 2019 15:17:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lance Roy <ldr709@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Omar Sandoval <osandov@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: don't expose page to fast gup prematurely
Message-ID: <20190925121750.zxrt2zkc4g73h6cp@box>
References: <20190514230751.GA70050@google.com>
 <20190914070518.112954-1-yuzhao@google.com>
 <20190924112316.324l7gqpdzhpiliq@box>
 <20190924220550.GA123810@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924220550.GA123810@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 04:05:50PM -0600, Yu Zhao wrote:
> On Tue, Sep 24, 2019 at 02:23:16PM +0300, Kirill A. Shutemov wrote:
> > On Sat, Sep 14, 2019 at 01:05:18AM -0600, Yu Zhao wrote:
> > > We don't want to expose page to fast gup running on a remote CPU
> > > before all local non-atomic ops on page flags are visible first.
> > > 
> > > For anon page that isn't in swap cache, we need to make sure all
> > > prior non-atomic ops, especially __SetPageSwapBacked() in
> > > page_add_new_anon_rmap(), are order before set_pte_at() to prevent
> > > the following race:
> > > 
> > > 	CPU 1				CPU1
> > > set_pte_at()			get_user_pages_fast()
> > > page_add_new_anon_rmap()		gup_pte_range()
> > > 	__SetPageSwapBacked()			SetPageReferenced()
> > 
> > Is there a particular codepath that has what you listed for CPU?
> > After quick look, I only saw that we page_add_new_anon_rmap() called
> > before set_pte_at().
> 
> I think so. One in do_swap_page() and another in unuse_pte(). Both
> are on KSM paths. Am I referencing a stale copy of the source?

I *think* it is a bug. Setting a pte before adding the page to rmap may
lead to rmap (like try_to_unmap() or something) to miss the VMA.

Do I miss something?

-- 
 Kirill A. Shutemov
