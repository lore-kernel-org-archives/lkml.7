Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E4EC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6F121951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LRiGObCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfGYRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:35:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfGYRfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7S+mctC2FhBs/Hku2og3Bm1k7tfhyAgfjbJr1N7F9Uk=; b=LRiGObCedXMclAYzSlb4TkgRfX
        QYlk179arC3nQls30Fm2NmETfGCoXzbLHCeaLFFF58gA9+wgVFfIuhnoYMsqaRzDlffp+5AvsCWjQ
        GFWb4MOBLFQOMCnkng/JRLHns6JGNrGuDjxH5Xgx8LtKWuIEybpGNfTKSVOvecFHjNauR34S93lF+
        rP2hrw3khBw1eZQecH4HwS8VdZNp5rlO1IJT4AcH+LfEwpbMHD2fv0gZNWXOdq2aveijdwe6C2gAL
        O+MqzAPvMW+gwsATAamJ/v95B6FMfcDZvs0UDLVXj8siXxlmi6F2JdfA9TRADhP59bfi2xUiTeJwN
        y1/zX8IA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqheE-0006qo-VI; Thu, 25 Jul 2019 17:35:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A91352019A002; Thu, 25 Jul 2019 19:35:21 +0200 (CEST)
Date:   Thu, 25 Jul 2019 19:35:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        gustavo@embeddedor.com, torvalds@linux-foundation.org,
        acme@kernel.org, kan.liang@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, keescook@chromium.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] perf/x86/intel: Mark expected switch
 fall-throughs
Message-ID: <20190725173521.GM31381@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
 <tip-289a2d22b5b611d85030795802a710e9f520df29@git.kernel.org>
 <20190725170613.GC27348@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190725170613.GC27348@nazgul.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 07:06:13PM +0200, Borislav Petkov wrote:
> On Thu, Jul 25, 2019 at 09:27:10AM -0700, tip-bot for Gustavo A. R. Silva wrote:
> > Commit-ID:  289a2d22b5b611d85030795802a710e9f520df29
> > Gitweb:     https://git.kernel.org/tip/289a2d22b5b611d85030795802a710e9f520df29
> > Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
> > AuthorDate: Mon, 24 Jun 2019 11:19:13 -0500
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Thu, 25 Jul 2019 15:57:03 +0200
> > 
> > perf/x86/intel: Mark expected switch fall-throughs
> > 
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> > 
> > This patch fixes the following warnings:
> 
> "This patch"
> 
> > 
> >   arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
> >   arch/x86/events/intel/core.c:4959:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >   arch/x86/events/intel/core.c:5008:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > 
> > Warning level 3 was used: -Wimplicit-fallthrough=3
> > 
> > This patch is part of the ongoing efforts to enable -Wimplicit-fallthrough.
> 
> Another "This patch"
> 
> I think it is clear about which patch the commit message is talking
> about, without stating it explicitly.

It fits with the whole atrocious 'comments are significant' premise that
the Changelog is atrocious too :-)

/me runs for cover.

Seriously though; I detest these patches and we really, as in _really_
should have done that attribute thing.
