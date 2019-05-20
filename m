Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB8C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BD721773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558393076;
	bh=5f5+3koTds52bPW4n2ppSAg8BvUhI/oklac/Pnx3ojc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GaOy5/GwmTftSs/gKfkyGO7m/2UbNulNo89/ozHyW8Dg7DyZVOax8KPoZFlgzrQ9w
	 GYCi0xVDSDW35RCKaGjdXVkHbX0Q1SZsz8/YpAgkuM+cBENcXhCUcblIghJvf5fADW
	 e5ZCs8iMnJIUga3P0u/O462u8C6CkVUR6Y/HRPIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfETW5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 18:57:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39038 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfETW5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 18:57:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so7485497pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rQtjqxgsh4qf6+R3w9WQYkuPaS8z+4gcRAW4fvUK8PA=;
        b=m7aNIAIk79+/sPSFc8fsRue1WTcfLQ8h+JWoFZXgVHRSWPcaDmTrdh2j+iJlwHBNR1
         kwey7G7A9RXpSCKWyHw8TA+JzwwkGnBZjJ0vbyimyDXjx5C1hKIVvd8Q8dX0cZ4lcJ9o
         XML8DCo/iN2IH8D7C5fERQqQoZC/nm8IcTRdNgue67JmDMKAJB3sRPErJISlHY9Ybh0r
         ZvUrzLAmJnogN16jrMiwuZQQeM0Ii6VWbaEet9CTcnlSo+16+HfcIqeSoUMaBdHr1Jxv
         xiGCrW/ywdc1H/6KqtEL1x4uKxUdk7ujhb2S+x5m3BnNVky7FhAaJ4BLr8lEsF6XFN+y
         bDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rQtjqxgsh4qf6+R3w9WQYkuPaS8z+4gcRAW4fvUK8PA=;
        b=ZRjVtPrOayv5Ut8dJ8ruPApjLK2wYdcZckd7dPg75PZgw0DqzkQZAjd6iBOQLYbTcu
         iryp5OIN2td0mOgoaQnWUThvi9bbTJ3anckBVbMsCdkdCvk1Bl7a2mxs1la95f1xQYhu
         FiELk5fw53jZ76R0EvL9xB2JH79w9tLrR+v+DzTiT6XB9qzn12cLtgyuwsisLOz/G2PG
         rPF6xMOVpW7eBW2Px5TYIVkIvRXLhjvjlBK5lQGYD5+MyDLN7DjS29y6AWk+z3RRju8s
         8GzPuEg0Ky9+tRjXKDQaLWXiGbYYhyCxswej4WrOndXlAnNuQyAybJA3H3P7HK5V2HlG
         u3CQ==
X-Gm-Message-State: APjAAAXHZglahnqhWTrcDHbvqEbwC4g0has2kDAqhKZ8aKp9sK64Jx3f
        uH4xnKU7f7SI4w1H7+Uq0yAKS2Sb
X-Google-Smtp-Source: APXvYqwIpXfTnN6FB15wCLD1NBqVQmTzR/Ojff3wL4gw0pzgL9CWZ1vxbSQt9fyp/BOgC/3Ksq6cRQ==
X-Received: by 2002:a63:dc09:: with SMTP id s9mr37019321pgg.425.1558393074279;
        Mon, 20 May 2019 15:57:54 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id s66sm20733434pfb.37.2019.05.20.15.57.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 15:57:52 -0700 (PDT)
Date:   Tue, 21 May 2019 07:57:47 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 2/7] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
Message-ID: <20190520225747.GC10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-3-minchan@kernel.org>
 <20190520165013.GB11665@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520165013.GB11665@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:50:13PM -0400, Johannes Weiner wrote:
> On Mon, May 20, 2019 at 12:52:49PM +0900, Minchan Kim wrote:
> > The local variable references in shrink_page_list is PAGEREF_RECLAIM_CLEAN
> > as default. It is for preventing to reclaim dirty pages when CMA try to
> > migrate pages. Strictly speaking, we don't need it because CMA didn't allow
> > to write out by .may_writepage = 0 in reclaim_clean_pages_from_list.
> >
> > Moreover, it has a problem to prevent anonymous pages's swap out even
> > though force_reclaim = true in shrink_page_list on upcoming patch.
> > So this patch makes references's default value to PAGEREF_RECLAIM and
> > rename force_reclaim with skip_reference_check to make it more clear.
> > 
> > This is a preparatory work for next patch.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> Looks good to me, just one nit below.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks, Johannes.

> 
> > ---
> >  mm/vmscan.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d9c3e873eca6..a28e5d17b495 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1102,7 +1102,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
> >  				      struct scan_control *sc,
> >  				      enum ttu_flags ttu_flags,
> >  				      struct reclaim_stat *stat,
> > -				      bool force_reclaim)
> > +				      bool skip_reference_check)
> 
> "ignore_references" would be better IMO

Sure.
