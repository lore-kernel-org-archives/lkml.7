Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDBCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2655621D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="hdKBeJOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410445AbfJROs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:48:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43981 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389365AbfJROs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:48:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so1333294wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZPMR7fELUyaaR1SCfz3L2Xbka0mvOZ72DEuGj3/RI2w=;
        b=hdKBeJOFMgcZ2K3egqHxgsOX6HKzfDlcjGvdJAhytJp1VBC6RoraWwRXKKQIzGiH74
         0469dFYMx9wgfqpnrBHhqJ3PGfNiphU54VWFyt0bTGC0EasKSyizTmm9FSfRMhS4HROr
         ELT8aqD4BfZe63JrbY7t799h3pblhTacGWL55hk0B+7/mPn4VBR2I+547AaCPmCLdWkZ
         eTeUAwY7AD3nIkO4UGTyX0ShFBakEkYdBG+YzdTOmxNapd9ByXhlsRzrNNz8SplDpNUO
         DoDPBi1jlBdb5SXcQze4sA/GWJ9R5t/9sx2wI9NJJqCwajbapUKbdRWbGqVgI8Lcds4s
         5owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPMR7fELUyaaR1SCfz3L2Xbka0mvOZ72DEuGj3/RI2w=;
        b=d9GzzPlfRd9xNA0Q2CXuWIJIRrWZyrrowgSaTVObAstjdIEN0pL9KYw5ybsoX+S5aQ
         oZfGbWvHlngcfDlf6sMGH/4BF2PZSqTdyRKZsDT7vh5FnHT6sr2GJyyoGZBpepZIHjjf
         CaGzBVieexcOPY1phu9/wSZexnbu4CyYsG+gF7yI4TAJJoW5TX/GS0gSr3fnIYVFjdTd
         irz096OLbpw3+7W2aCskLExHL+Lhg5UZAF08AgPO/iIHkIDVqlNrtt40k0cuWM4mG11w
         jO+JFhsOmxWITOQP2jBqDbgI9bNdldZEtSCbTgfLUigTgWzOxQDlPrVWfiHJ3K8CSE98
         I3Wg==
X-Gm-Message-State: APjAAAWuC6zJaX3SL++xqFIvoYOJntosqNigGBOQXhttsyUc8xyUgjII
        40+/OxhvObrpnX/IAdcC6JusnQ==
X-Google-Smtp-Source: APXvYqzJc29WWep05M5xxc3UBmfFQINrDjz6Iczi9uObDd9pvggV0EMQsE0errdfRHR1WVqfUgep7w==
X-Received: by 2002:adf:e747:: with SMTP id c7mr8183157wrn.384.1571410106491;
        Fri, 18 Oct 2019 07:48:26 -0700 (PDT)
Received: from localhost (97e34ace.skybroadband.com. [151.227.74.206])
        by smtp.gmail.com with ESMTPSA id u26sm5916793wrd.87.2019.10.18.07.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:48:25 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:48:24 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Recalculate per-cpu page allocator batch and high
 limits after deferred meminit
Message-ID: <20191018144824.GI4065@codeblueprint.co.uk>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018115849.GH4065@codeblueprint.co.uk>
 <20191018125449.GJ3321@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018125449.GJ3321@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct, at 01:54:49PM, Mel Gorman wrote:
> On Fri, Oct 18, 2019 at 12:58:49PM +0100, Matt Fleming wrote:
> > On Fri, 18 Oct, at 11:56:03AM, Mel Gorman wrote:
> > > A private report stated that system CPU usage was excessive on an AMD
> > > EPYC 2 machine while building kernels with much longer build times than
> > > expected. The issue is partially explained by high zone lock contention
> > > due to the per-cpu page allocator batch and high limits being calculated
> > > incorrectly. This series addresses a large chunk of the problem. Patch 1
> > > is mostly cosmetic but prepares for patch 2 which is the real fix. Patch
> > > 3 is definiely cosmetic but was noticed while implementing the fix. Proper
> > > details are in the changelog for patch 2.
> > > 
> > >  include/linux/mm.h |  3 ---
> > >  mm/internal.h      |  3 +++
> > >  mm/page_alloc.c    | 33 ++++++++++++++++++++-------------
> > >  3 files changed, 23 insertions(+), 16 deletions(-)
> > 
> > Just to confirm, these patches don't fix the issue we're seeing on the
> > EPYC 2 machines, but they do return the batch sizes to sensible values.
> 
> To be clear, does the patch a) fix *some* of the issue and there is
> something else also going on that needs to be chased down or b) has no
> impact on build time or system CPU usage on your machine?

Sorry, I realise my email was pretty unclear.

These patches *do* fix some of the issue because I no longer see as
much contention on the zone locks with the patches applied.
