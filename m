Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7972CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427112184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="imq0LcQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfH0MRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:17:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37160 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0MRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:17:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id f22so31078241edt.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FbGzDuD3RIJ23CO8zb5ApvjBQtLaEmsyKeBOr5aEVwk=;
        b=imq0LcQtyoCAq4I0t8Dbrpw8qW3p9yhMU1fK7FXpWEAkChTCA/eOGL+sCo2A/5Vdhy
         icR35TMDiD2XozCvk28c+t3qkmvleFbwayAzGcVkDjd8cEbvOQXsizvKLd3TJpRsc7cJ
         g5CFwSbwijT5W50v67l+4k/pNFjK7gLJ4RLSEBNztBjjYSpe8HMYBbm3H88kvoD9nY1Y
         DQc9iQ1MKP6lUqS7opFfw8u2BmSaWPVzNTQ0W0Ppb1AuiGo5HqYTjOkiRWttGHfU9D/3
         5mtZSEGkk24Uu5ynKhR99hKzMK74T9FENLeMmtxBOXPfgmLGdEy40KiYF4IlHYPj7cs8
         tKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FbGzDuD3RIJ23CO8zb5ApvjBQtLaEmsyKeBOr5aEVwk=;
        b=L759wncuU7OFvMezszudJkAdyptP7giEA8peh6bnRencPbr6yl07412AMssI3pPm9K
         ZCdRNv2L9PmStjwFJmLTNSzJ0WLE8kl0TMSb/MTNnrTD8x1oVGPN+Cb2JzYecmUCG1l6
         g9CCwyI2HgXXd0BV7nT36ole6YnB89Q3yyYtQxTdKG27gHknq0gyY0uYjTyBQn5nNa0I
         oJN08rOmex7kyLSssHThaI37mZNFjtnHZgeTgk3Rn9bMWFRQoZxlD+20lP+VLsNvmm/q
         bumhIkD2nxLzz9XRRzzR8O1URxR31zQUC595xMY5o4ByIJyian8y7OH5thvJf0UGTHDv
         65pg==
X-Gm-Message-State: APjAAAXU/VmRXLlbu159sp/FpFhFLH0FzDehYcElU94Eblx7It2KnP+D
        C9GpFaGrOjaT7YivTl42KfgA3Q==
X-Google-Smtp-Source: APXvYqzX5zFQNMBVLvorfdtCo4ceiZTMT5GoTFrvYFVZ1XxJOiQHwWwe82lNcIwbXgct8DP82OccIg==
X-Received: by 2002:a17:906:a3c4:: with SMTP id ca4mr20907390ejb.5.1566908258127;
        Tue, 27 Aug 2019 05:17:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v20sm1927306edl.35.2019.08.27.05.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:17:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C36CA100746; Tue, 27 Aug 2019 15:17:39 +0300 (+03)
Date:   Tue, 27 Aug 2019 15:17:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kirill.shutemov@linux.intel.com,
        Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190827121739.bzbxjloq7bhmroeq@box>
References: <1566410125-66011-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190822080434.GF12785@dhcp22.suse.cz>
 <ee048bbf-3563-d695-ea58-5f1504aee35c@suse.cz>
 <20190822152934.w6ztolutdix6kbvc@box>
 <20190826074035.GD7538@dhcp22.suse.cz>
 <20190826131538.64twqx3yexmhp6nf@box>
 <20190827060139.GM7538@dhcp22.suse.cz>
 <20190827110210.lpe36umisqvvesoa@box>
 <aaaf9742-56f7-44b7-c3db-ad078b7b2220@suse.cz>
 <20190827120923.GB7538@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827120923.GB7538@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:09:23PM +0200, Michal Hocko wrote:
> On Tue 27-08-19 14:01:56, Vlastimil Babka wrote:
> > On 8/27/19 1:02 PM, Kirill A. Shutemov wrote:
> > > On Tue, Aug 27, 2019 at 08:01:39AM +0200, Michal Hocko wrote:
> > >> On Mon 26-08-19 16:15:38, Kirill A. Shutemov wrote:
> > >>>
> > >>> Unmapped completely pages will be freed with current code. Deferred split
> > >>> only applies to partly mapped THPs: at least on 4k of the THP is still
> > >>> mapped somewhere.
> > >>
> > >> Hmm, I am probably misreading the code but at least current Linus' tree
> > >> reads page_remove_rmap -> [page_remove_anon_compound_rmap ->\ deferred_split_huge_page even
> > >> for fully mapped THP.
> > > 
> > > Well, you read correctly, but it was not intended. I screwed it up at some
> > > point.
> > > 
> > > See the patch below. It should make it work as intened.
> > > 
> > > It's not bug as such, but inefficientcy. We add page to the queue where
> > > it's not needed.
> > 
> > But that adding to queue doesn't affect whether the page will be freed
> > immediately if there are no more partial mappings, right? I don't see
> > deferred_split_huge_page() pinning the page.
> > So your patch wouldn't make THPs freed immediately in cases where they
> > haven't been freed before immediately, it just fixes a minor
> > inefficiency with queue manipulation?
> 
> Ohh, right. I can see that in free_transhuge_page now. So fully mapped
> THPs really do not matter and what I have considered an odd case is
> really happening more often.
> 
> That being said this will not help at all for what Yang Shi is seeing
> and we need a more proactive deferred splitting as I've mentioned
> earlier.

It was not intended to fix the issue. It's fix for current logic. I'm
playing with the work approach now.

-- 
 Kirill A. Shutemov
