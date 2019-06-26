Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D04C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C23A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mUOX/0Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFZJgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:36:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MfZzo+09y4c4/MlhmBOR83gcoxJ6ThsuRLuH+9ufG7c=; b=mUOX/0VkuieUiDvItDvC9E6Kb
        fb4y+CTdDes0mRGXQKRJhAtaBu5OC02Q8ZXptbwOUcak1L7iHvRllEMzPnRdfvDWAAuhxKW031djz
        xSINl5FvUqfkoSRuEfKU+S5RLV1FWU2vmz/rt8fwhOrac2nWoxo/pscnkMWwsVG3hxD2EmAa+wBRD
        hAPxEFMLqwGzG6lqE8N7zUZT57KjEE/LXvy0PY6pYVX69ye2iozWgmBqqAyqYVaj0FwO9n9N805/z
        ZsTphZoyHDLmsRA4nZQWP7ikXWJTVI6J4a64iCQ9AGzuGD06VNCmtAp0TdIWOB8zGJJqB6yJ353xL
        x7PFJno4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg4M1-0002a1-LR; Wed, 26 Jun 2019 09:36:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF867209CEDD6; Wed, 26 Jun 2019 11:36:35 +0200 (CEST)
Date:   Wed, 26 Jun 2019 11:36:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] get_maintainer: Add --prefix option
Message-ID: <20190626093635.GK3419@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
 <20190624133333.GW3419@hirez.programming.kicks-ass.net>
 <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
 <20190625163701.xcb2ue7phpskvfnz@linutronix.de>
 <8d416a7b0dad3933ceb8d12c9efaad541f7cf269.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d416a7b0dad3933ceb8d12c9efaad541f7cf269.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:23:34AM -0700, Joe Perches wrote:
> There are now simple ways to make sure a patch
> submission is cc'd to appropriate parties.
> 
> git send-email supports --cc-cmd

That assumes one is using git; I'm not, git stinks.

> I want to proposed patches to moderated lists
> and believe everyone really should too.
> 
> I don't care if moderated lists send a
> "waiting for moderation" message as long as the
> list gets the proposed patch eventually.
> 
> I think only Peter cares about those, to him,
> superfluous "being moderated" messages.

I'm really not alone in that. Not only do you get those annoying
messages, the people reading that list might get the discussion in
fragments, because some people that reply are subscribed and do not
require moderation while others do get caught in the moderation thing
and then delayed.

It also puts a burden on the moderator, do they allow the whole
discussion or only part. What if they deem the thing off-topic and want
to kill it, but then some of their whitelisted people do reply.

Cross-posting to moderated lists has been considered bad form ever since
I got on the interweb in the early 90s.

