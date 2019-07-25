Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD657C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D0D2189F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564031531;
	bh=RJx0tQJaHsgZz3uNM7Y4xe3/5UUxbIkhNcUrubFqGjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ashXkPe2zV1XyP5MMNlBxEfMVd/4HCDY4+4oVWeizL/B0+RvqD1ZlYriR/1AbqWRP
	 bl7/+nQ0T4ZQYwZawyxHmf3OVdtSe9qxKhI5Y69qWnbD/AwPrsXUAnYMDaF8civsUA
	 KfYs2uuNQI+x9fqeFk4dAYcCbFl0PBsVxuT2DWuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbfGYFMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:12:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38849 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390362AbfGYFMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:12:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so22097598pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KSVES4Di2vK/QdofzjdERnWb+kHxNc5zqBfVZ7xWzIg=;
        b=ExyQTREpJfPmp7vJJ2Y1yGisU8EG2uYGosxo5RZHBLokzfppj53F61F1dorQZkWp4L
         1u86lScc0D9LhTdytlPOQoxRM6tw17QDqBS2daquIH4r/ZiHEgkp5YC4rNfWJ7q0nEYZ
         jBQySMe9zOntgtD8mgrOdqsUitUnzzhex3OyfDVVQ4FDOazw5yPVqSQSFA6GVai0TVAg
         vS7ToBS9H80ao1cVZiEbreO1AypmHBqcHzVsDbI7WHPG5Tg+xrl6J5fStZkg4X02FJzr
         J9WrD4s8anQnCFv8ON43mpqzu5no7Lmk9m9UdgdG6IaKHG36YrWvYEo7GwbroRraM//A
         tLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSVES4Di2vK/QdofzjdERnWb+kHxNc5zqBfVZ7xWzIg=;
        b=Pjb+o2fBZyJBXbJAjcJmNqbx086oxayxe4mRZqVR+6tQThDj5KLtV8bC+CgsS1JFnl
         dMNBzxdXwGX2333dZtI5Ru+D8qYo/uDTChsWK1kI6ulqN4gdlAKlUnexS1ff+1sGE3xG
         x58ldmZnn3VwSf+TY7d46sRXzc5iUAvsetf0W8H4w1GAhSNWR7o01/CjtdSDyQPTzuky
         edWhJg6izO/HLDbInVUJrXmpqatKpmccs3x1hKxnLnvzq8Rdi+cuqhcsdbMjO+6MF/Yh
         Rz2qZYQ7VOkbKM4n37YcgYtUBodAF7uKu4+4POO978xWTlX+ASTrYouNEizkmGQCUMoQ
         hElw==
X-Gm-Message-State: APjAAAWDcMwhbkO+QPjHobge509QXU6G79Jwznqh5Xx9IgGAE7lhYicl
        r+vcgtjL2QZ0ATo2UbVUezI=
X-Google-Smtp-Source: APXvYqxKwc0wBeIkkfcXVdrRwVawpYOlqn58OtEpJPbVKg5TevIqJAnENN5egvEYfpctwul3xCGz2Q==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr90704862pjq.102.1564031527596;
        Wed, 24 Jul 2019 22:12:07 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id g2sm62427425pfb.95.2019.07.24.22.12.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 22:12:06 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:12:00 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: replace list_move_tail() with
 add_page_to_lru_list_tail()
Message-ID: <20190725051200.GA65392@google.com>
References: <20190716212436.7137-1-yuzhao@google.com>
 <20190724193249.00875235c4fa2495e0098451@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724193249.00875235c4fa2495e0098451@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Jul 24, 2019 at 07:32:49PM -0700, Andrew Morton wrote:
> On Tue, 16 Jul 2019 15:24:36 -0600 Yu Zhao <yuzhao@google.com> wrote:
> 
> > This is a cleanup patch that replaces two historical uses of
> > list_move_tail() with relatively recent add_page_to_lru_list_tail().
> > 
> 
> Looks OK to me.
> 
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -515,7 +515,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
> >  	del_page_from_lru_list(page, lruvec, lru + active);
> >  	ClearPageActive(page);
> >  	ClearPageReferenced(page);
> > -	add_page_to_lru_list(page, lruvec, lru);
> >  
> >  	if (PageWriteback(page) || PageDirty(page)) {
> >  		/*
> > @@ -523,13 +522,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
> >  		 * It can make readahead confusing.  But race window
> >  		 * is _really_ small and  it's non-critical problem.
> >  		 */
> > +		add_page_to_lru_list(page, lruvec, lru);
> >  		SetPageReclaim(page);
> >  	} else {
> >  		/*
> >  		 * The page's writeback ends up during pagevec
> >  		 * We moves tha page into tail of inactive.
> >  		 */
> 
> That comment is really hard to follow.  Minchan, can you please explain
> the first sentence?

It meant "normal deactivation from the pagevec full". The sentence is
very odd to me, too. ;-( 
Let's remove the weird comment in this chance.

Thanks.

