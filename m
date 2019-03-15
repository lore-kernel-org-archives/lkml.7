Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012F8218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bddu/U8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfCOIBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:01:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38166 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbfCOIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sOd1YPPJQcxyiI72hmu+RbcgIfVsjyy4EFW10+SkYSA=; b=bddu/U8Wr0rdAPVNr4IT3eK81
        1gPfx229RiXe93Xkg9tgOdOl3Yo09dMCrHi2F/IV+vR+XhMF4UPPhZfiAENdswEsKCzTFPlleYLX7
        uDug1Qf2dX8vH7aQKBVgiwhrGOPDq8naeiO53WBopaWc6L1MGvPp/r2vwtnQQRA75YhQImMj3sy26
        3k3dwWN+cqwayfZbOSzH5HGpIt+ERwp5nVfo0ffbzUTJfV+z9nuiOCdxMeWLtWKiHKWs4a0mglIVl
        XY+c6AORs01s3Rp2dk3CiRJ9xSHg1iLN3GlNDJH16H6FwrwKi1K03mf/5WWlKxX8qfjw9hpiX5vFZ
        4X6Qpag+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4hmB-00049x-QD; Fri, 15 Mar 2019 08:01:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D48221419E59; Fri, 15 Mar 2019 09:01:09 +0100 (CET)
Date:   Fri, 15 Mar 2019 09:01:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [RFC][PATCH 0/8] perf/x86: event scheduling cleanups
Message-ID: <20190315080109.GQ5996@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <CABPqkBT9_ayhH2puPtLiemtM=VOXxNhC4AXrKkOaDMatWifLxQ@mail.gmail.com>
 <CABPqkBRkPQewqJQsNtEESd9Jo2qd8iVG7KDzbQRK_Lg_21p-bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRkPQewqJQsNtEESd9Jo2qd8iVG7KDzbQRK_Lg_21p-bA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:15:55AM -0700, Stephane Eranian wrote:
> On Fri, Mar 15, 2019 at 12:15 AM Stephane Eranian <eranian@google.com> wrote:
> >
> > On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > These here patches are the result of chasing a bug in the TSX Force Abort
> > > patches.
> > >
> > > The first patch is simple and fixes the issue and should be marked /urgent and
> > > backported.
> > >
> > > The rest is the result of having a hard look at how all that event scheduling
> > > stuff worked while trying to figure out wth was going wrong.
> > >
> > > Stephane, since you were involved with writing much of that code, can you
> > > please have a good look? I _think_ I got it, but... :-)
> > >
> > Will do today.
> > But you did not send me PATCH 1/8 apparently.
> 
> Correction : I got it. Mail client had just moved it somewhere else!

Also please look at all 8, I'm reasonably sure 1/8 is correct, but it is
rather more ugly than I'd wish. So the remaining 7 clean it all up (and
effectively revert 1 again) but are much more invasive.
