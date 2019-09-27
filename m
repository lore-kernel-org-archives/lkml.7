Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6564F217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7j1uVUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfI0Pfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:35:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42134 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfI0Pfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:35:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id w14so7766610qto.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZJdrfl43OTXDprqzuszedX5xeC5q34acvcr4RIosmY=;
        b=W7j1uVUeseE0Bu0ye4U47s0Aa4/9MiPhWQB5N0jZPAVYdHR0o3voTLH8KIKqxpcEVW
         lWQxV28oyikJkCy9APIe7HyDUaJID+PcPVPdZMSkyd4orugPhzpsLR/jA+bWFKwDXWiP
         QfIiCHfoncKjZR3HC73w5HAb96/NWLjEEvUFY1Ow1OmbfXsPZi+32JKXzxXilTJraArz
         SmWEOCzMLPdOuDYqQFtMu06mvbjSWtwr2VZN/1bFUCo+h1jiC+3s6Z9lHo2XDTbgqzRY
         hk4I+ZCjD1Rx2cssb8h4T7fDyW5O6EtXLBZH0aRp2NjfXAOJqy/YDpTYeNzOl8EQX83C
         7w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZJdrfl43OTXDprqzuszedX5xeC5q34acvcr4RIosmY=;
        b=d7r3GuIBoCCYkLvc03u56jPnilx7FRr8F82CDrUEL3AkNvX0ixKRpiziyMJTrMl4dQ
         QhZYJTz1r0tJCtNag7ApwWpFpqVqff1rKw34yPhQUDeqppE8ahD9NwDlsHv69z/erYD4
         lU77vjqYLQzsAv8etbM342/N08G52lYxRQl+IV+lZKKdOyeCVNruhtHujbkLPsNuaVIf
         a4Qo+FhZZ8znQk3XZxkxdvlpeyJoewLO2Bj7VzL0lzc1Mq5CkE0qFt+O6Fo0mShKSTKC
         MZBeU2NsazWkqRnDX0BuxlA9AOJE6czthvnnP+6TALXVHRYDMGxAKRHyrfm99mamgrO9
         idqA==
X-Gm-Message-State: APjAAAU49nNuVc+2wuu4izuTEQvLqYj/1zPDYebTW+eISv0XYZSMmeUc
        i2hhYvlTP878pffo+hYWpYM=
X-Google-Smtp-Source: APXvYqwA0hxktwp5rENIv5piwwLu+q5o0c3bqfXx4l8B8ZoPdTpVS8tjmKaBMPGwXxiC5GJxNl9gOA==
X-Received: by 2002:ac8:3ff2:: with SMTP id v47mr10718124qtk.15.1569598543170;
        Fri, 27 Sep 2019 08:35:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id a14sm1472689qkg.59.2019.09.27.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 08:35:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B99340396; Fri, 27 Sep 2019 12:35:40 -0300 (-03)
Date:   Fri, 27 Sep 2019 12:35:40 -0300
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>
Subject: Re: [PATCH] perf map: fix overlapped map handling
Message-ID: <20190927153540.GB20644@kernel.org>
References: <BN8PR21MB136261C1A4BB2C884F10FCECF7880@BN8PR21MB1362.namprd21.prod.outlook.com>
 <20190920193852.GI4865@kernel.org>
 <BN8PR21MB1362B1921DF8ABF3A19B43A5F7880@BN8PR21MB1362.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB1362B1921DF8ABF3A19B43A5F7880@BN8PR21MB1362.namprd21.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 20, 2019 at 09:46:15PM +0000, Steve MacLean escreveu:
> >>  			after->start = map->end;
> >> +			after->pgoff = pos->map_ip(pos, map->end);
> >
> > So is this equivalent to what __split_vma() does in the kernel, i.e.:
> >
> >        if (new_below)
> >                new->vm_end = addr;
> >        else {
> >                new->vm_start = addr;
> >                new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
> >        }
> >
> > where new->vm_pgoff starts equal to the vm_pgoff of the mmap being split?
> 
> It is roughly equivalent.  The pgoff in struct map is stored in bytes not in pages, so it doesn't include the shift.
> 
> An earlier version of this patch used:
>   			after->start = map->end;
> +			after->pgoff += map->end - pos->start;
> 
> Instead of the newer Functionally equivalent:
>   			after->start = map->end;
> +			after->pgoff = pos->map_ip(pos, map->end);
> 
> I preferred the latter form as it made more sense with the assertion that the mapping of map->end should match in pos and after.

Sorry for the delay in continuing with this discussion, I was at
Plumbers in Lisbon and then some vacations, etc. Also I was hoping
someone else would jump here and provide some Reviewed-by tag, etc :-)

So, if they are equivalent then I think its better to use code that
ressembles the kernel as much as possible, so that when in doubt we can
compare the tools/perf calcs with how the kernel does it, filtering out
things like the PAGE_SHIFT, can we go that way?

Also do you have some reproducer, if you have one then we can try and
have this as a 'perf test' entry, bolting some more checks into
tools/perf/tests/perf-record.c or using it as a start for a test that
stresses this code.

This is not a prerequisite for having your fix on, but would help
checking that perf doesn't regresses in this area.
 
- Arnaldo
