Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32517CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D58222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571420523;
	bh=ByzaJhLWQDhYvhzZNYkjFZvEYfpXrCTgrRuj8JgtiFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l62VtzxWZjT8kc9RQ0QhTwFE02z+s75UBzVNONvyAKkPY+59gXE54ugaMKw8J5T62
	 Vg0ULhyAk5cSe4VNgJCpnMBJC+4bOoVVXIaY1eaHvc1ydrtGS5yyU/VNDh3sDCKwh8
	 78cBvKNQg6Wl1Hz1K4itqfKVDNhVrPW2fdbbOA1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505340AbfJRRmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405272AbfJRRmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:42:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA2E222C2;
        Fri, 18 Oct 2019 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571420520;
        bh=ByzaJhLWQDhYvhzZNYkjFZvEYfpXrCTgrRuj8JgtiFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DeguvO5n+N0AvKbTtla8iJJAcvwhQnXBGsNC/fB7Iiha89DuiJ56Iaf9EfeFN8WQl
         55MfqI3QgCcvVrdPQp6M8qiR2nG7YxOqPPE9v6t27s6GcAHLk/6Yv+Fp2yk6ypk1Qy
         JWYmlJkZkwP5cYmxeFp3H+3/VO4Bqx4Sm2pzxNuw=
Date:   Fri, 18 Oct 2019 18:41:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] arm64: Fixes for -rc4
Message-ID: <20191018174153.slpmkvsz45hb6cts@willie-the-truck>
References: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
 <CAHk-=wjPZYxiTs3F0Vbrd3kRizJGq-rQ_jqH1+8XR9Ai_kBoXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjPZYxiTs3F0Vbrd3kRizJGq-rQ_jqH1+8XR9Ai_kBoXg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:06:54PM -0700, Linus Torvalds wrote:
> On Thu, Oct 17, 2019 at 4:43 PM Will Deacon <will@kernel.org> wrote:
> >
> > Note that the workaround code ended up being based on -rc2, so I had a
> > bit of a faff trying to generate the right diffstat for this pull request
> > after merging that branch into our fixes branch based on -rc1. In the end
> > I had to emulate the pull locally because I couldn't figure out how to
> > drive request-pull correctly despite the shortlog being correct. I'd love
> > to know what I should've done instead.
> 
> You did the right thing.
> 
> When there are multiple merge bases, a regular "git diff" doesn't work
> since it's fundamentally about two end-points (well, it _can_ work
> almost by mistake, but doesn't work in the general case). So the only
> way to get a "proper" diff is to do a merge and then diff the result.
> 
> That said, I also accept the output of "git diff" which will then have
> a lot of noise from all the _other_ work done between the two merge
> bases. I can figure out what happened, and do my own two-endpoint diff
> and see what happened, and still se that "yes, that's what the pull
> request meant, and that's why the diffstat is garbage".
> 
> What you did is the "good quality" pull request, though.

Thanks, that's helpful to know for next time. I guess I'm most surprised by
the discrepancy between the shortlog and the diffstat, whereas I intuitively
expected them to be generated in the same way.

Will
