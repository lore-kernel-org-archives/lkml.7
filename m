Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC9FC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17FF206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="phx1Mq5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbfGPRZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:25:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33344 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfGPRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:25:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so536314pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jmmNrLz05OQxiUsEmtCkS8mBmrl8vj668vZ/xiMeIrY=;
        b=phx1Mq5J6p2gfPq049fRU4kJqr233RVvBA6UMs66Fh5VPoHy5KsLA3yLW7b00Y3rb8
         GTdFxxgsB1P4yFAdo2Qi0lgz4B0At2EUVu95fRfY8Bd7hU1ELdLrEB76Wv/eTo0O/IHK
         cBHGKVh+C260gNquMCThFTjxvff5UR0XDGNu4y01LXooRqWSmV8nFoJlX5Ux8Oc0p4YR
         Ffk+3gQEUfcv+lzY/PFoTBxKXktxFJtv2i/1ZrJEAx+OqMpmcJgHGEZrhE7dlAGzP7Ne
         tVCLPB+rZn10vOY9YPlc33YLioHP5gwh7muhEqrhXj+c2blGXe3qtkyX7eg0lodMWVNf
         3yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jmmNrLz05OQxiUsEmtCkS8mBmrl8vj668vZ/xiMeIrY=;
        b=UC3xLGOHlD6zaNafUhLtE3LNC5o6AwGG+yhd968fdvk1TGL670xbqKZyFwMUbN8MsB
         fGCJLBGRGkYOZOXxbDV+Dmbg1+M0rBo/Me2/TuH36jezUdHhad2rBWwLYZWvKs13tktq
         zKuRKntpd0yCaqckqSyn515PbaHzfiGyL+Ly8ZrYGhkDaHsQJ1QB/ZE3onge/tCyf+yq
         8B/IDU8flQXoyVFUqNvTjlLi1riK7utfSvGcj3CuOEvyc4z0QOfJxBp7n+SDuwqSD9zz
         /e0z4L1gH/GtiwAML2JHstWJFNmXdA4CL6t7QBmNZausV3Z9x4HZNFvgIoyGrSMr0AcQ
         NtkA==
X-Gm-Message-State: APjAAAVo4VQAkYzUNH6wIs8Fs0Chg70AWdYNCgNIZKTMVZNrRoMhM+m0
        UsT8oR2/NNADn9gdFIZLv68=
X-Google-Smtp-Source: APXvYqxNNQERGxivXJ3Js3Bxfn7FLjsI5wI5vL3fUqwqk1694sNNijt4himTh6hZUPRXthewU9p3Tw==
X-Received: by 2002:a63:dd17:: with SMTP id t23mr8718560pgg.295.1563297902419;
        Tue, 16 Jul 2019 10:25:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:dd93])
        by smtp.gmail.com with ESMTPSA id e6sm25465734pfn.71.2019.07.16.10.25.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 10:25:01 -0700 (PDT)
Date:   Tue, 16 Jul 2019 13:24:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: Proportional memory.{low,min} reclaim
Message-ID: <20190716172459.GB16575@cmpxchg.org>
References: <20190124014455.GA6396@chrisdown.name>
 <20190128210031.GA31446@castle.DHCP.thefacebook.com>
 <20190128214213.GB15349@chrisdown.name>
 <20190128215230.GA32069@castle.DHCP.thefacebook.com>
 <20190715153527.86a3f6e65ecf5d501252dbf1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715153527.86a3f6e65ecf5d501252dbf1@linux-foundation.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 03:35:27PM -0700, Andrew Morton wrote:
> On Mon, 28 Jan 2019 21:52:40 +0000 Roman Gushchin <guro@fb.com> wrote:
> 
> > > Hmm, this isn't really a common situation that I'd thought about, but it
> > > seems reasonable to make the boundaries when in low reclaim to be between
> > > min and low, rather than 0 and low. I'll add another patch with that. Thanks
> >
> > It's not a stopper, so I'm perfectly fine with a follow-up patch.
> 
> Did this happen?
> 
> I'm still trying to get this five month old patchset unstuck :(.  The
> review status is: 
> 
> [1/3] mm, memcg: proportional memory.{low,min} reclaim
> Acked-by: Johannes
> Reviewed-by: Roman
> 
> [2/3] mm, memcg: make memory.emin the baseline for utilisation determination
> Acked-by: Johannes
> 
> [3/3] mm, memcg: make scan aggression always exclude protection
> Reviewed-by: Roman

I forgot to send out the actual ack-tag on #, so I just did. I was
involved in the discussions that led to that patch, the code looks
good to me, and it's what we've been using internally for a while
without any hiccups.

> I do have a note here that mhocko intended to take a closer look but I
> don't recall whether that happened.

Michal acked #3 in 20190530065111.GC6703@dhcp22.suse.cz. Afaik not the
others, but #3 also doesn't make a whole lot of sense without #1...

> a) say what the hell and merge them or
> b) sit on them for another cycle or
> c) drop them and ask Chris for a resend so we can start again.

Michal, would you have time to take another look this week? Otherwise,
I think everyone who would review them has done so.
