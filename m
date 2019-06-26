Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E6FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C30208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lUYAHlxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFZRST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:18:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3wXGP5R/TX8sw3RJ3GrRq0beGc0YXqji6Md+fo6fmNU=; b=lUYAHlxtP5ycR7eIi6pbgkevN
        T6qkNrHMjdlV4173UfU5IMi4e15LWh0FHvjrLmkruewnRiVyCrsNVtW5/qDlqAB7NqT08LmbFFHxF
        PLlEYGz9oQ5wzhCdhpc54IWoyCqHHwEXfPtvmwz1MGjDZFmuHEqs7lshuPv9R+FeY2fvBvXgt1ETV
        CzLMJyF2zCJ4Uo2CBpIBz/4icboeteLez2IcQf2HK/34N9lVdm1OzKENJgusj2mBpMdUy7AiS3Pho
        HgX1Q6z1AbhYsD0LOcyXidJbOPu3Lqod1ddr1F0kSfUKr/pNEXqswpTBcOmcjRRs2rncNd8zSOlM1
        gyTtkHcTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgBYl-0008EV-Ft; Wed, 26 Jun 2019 17:18:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1BCB20A79E8A; Wed, 26 Jun 2019 19:18:13 +0200 (CEST)
Date:   Wed, 26 Jun 2019 19:18:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] get_maintainer: Add --prefix option
Message-ID: <20190626171813.GO3419@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
 <20190624133333.GW3419@hirez.programming.kicks-ass.net>
 <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
 <20190625163701.xcb2ue7phpskvfnz@linutronix.de>
 <8d416a7b0dad3933ceb8d12c9efaad541f7cf269.camel@perches.com>
 <20190626093635.GK3419@hirez.programming.kicks-ass.net>
 <b007126ee329ba5094d84f0af91c0c8eafecbed4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b007126ee329ba5094d84f0af91c0c8eafecbed4.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:36:33AM -0700, Joe Perches wrote:
> On Wed, 2019-06-26 at 11:36 +0200, Peter Zijlstra wrote:

> If a moderator of a list decides an email chain about a
> patch is somehow off-topic and does not forward the email,
> likely that moderated list should be removed from MAINTAINERS.

I think I've seen kernel-hardening complain about this; and that's not
even a moderated list I think. Yes, the patch touched one of 'their'
files, but was mostly unrelated.

I forgot the exact thread.

> Under what use case would you want to use get_maintainer and
> _not_ cc a particular mailing list?

I'm basically going to never send anything to a moderated list, ever.
It's what I've been doing for a long while, but I got lazy the other day
because a patch I did was a wide spray all over the tree and I didn't
want to manually compose the Cc list.
