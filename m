Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CFEC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9450217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VMD+TAkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfKFLGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:06:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfKFLGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=boBPzgY9tth9op4860QrAhO90mR0ruMMVme/TEc1jGE=; b=VMD+TAkRxmKjuYTsgAKFlcg4C
        i6cu7T9fUEnzmiwiYAb+EGOCFJjla7zFKmevLxGInY+73IuffNZB7xXELEc1Pvzy6lvHk5RY4+zmk
        bnrkiS3/u3qzGgCYRFnswdArztrTot3bsYO46eYrD8+yg/ILCNgXvsCpvqFUlI6BvU/hdGd5DhfnN
        LVZt5zi2/8AM0m2uFeWIWGonj1wthPEnin/4XT8qr9HmscrmR2P+En8u1VkQkIpvxeW55jo5W1hqr
        8BUWg4jF7zdIbdqSt2Lod/mOnFipViLmiEAjWWqIf9VgMZu36+HJFf5l17QsHMzFBN837WSj42Sb7
        yMtpQjN8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSJ97-0002qA-Ly; Wed, 06 Nov 2019 11:06:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7992A301A79;
        Wed,  6 Nov 2019 12:05:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1C89285881A2; Wed,  6 Nov 2019 12:06:32 +0100 (CET)
Date:   Wed, 6 Nov 2019 12:06:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, andi@firstfloor.org, acme@kernel.org,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf/core: fix unlock balance in perf_init_event
Message-ID: <20191106110632.GW4131@hirez.programming.kicks-ass.net>
References: <20191106092352.GU4131@hirez.programming.kicks-ass.net>
 <BFC92F0C-22D3-4543-9FAE-D53C7383CB3F@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFC92F0C-22D3-4543-9FAE-D53C7383CB3F@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:37:34AM -0500, Qian Cai wrote:
> 
> 
> > On Nov 6, 2019, at 4:23 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > You wanted to write:
> > 
> > Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
> > 
> > instead, right? Fixed that for you.
> 
> I was not too sure about if the hashes are stable for commits only in
> the -tip tree. If they remain the same even after merged into the
> mainline, and then yes.

-tip commits are generally stable.
