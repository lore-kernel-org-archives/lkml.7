Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E10C7E0B5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E3724790
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aKmDKPE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfLMSsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:48:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51530 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMSsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7KmksfjGeFy5q5tSUXLtsC+cHDUntZib8I4AEEfjTJs=; b=aKmDKPE9Z/5kBA9KD7AYJERMK
        INtyc2ByA+brwrBP2pw5Xc802GFsiPzrGBzgF/A0LtcKg+Y3rll1uRGWnVyzDSzKibX2sHis2eXlY
        TcW2RVEAC82fyKPyZTBRGIXzK2S0blPkjhNmpQEzMqwhbnStscOeKzvHNIUIL1ArvNrczQmTyOerF
        BjUvJnnYkijkBSsZcQP/3UWtEFZXmfAhKDgdme3GjoxtOzSnivjFJXl/OUVzqdcyfrwLNCB6dekfT
        o+rPNYuY5SON70XCFSMGDnoqk6+gBXpXGKscWF4Txw+1QzZrHN2qBXMPXQRXUJG64A2AdxkpLcHDZ
        q6PtkGm5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifpyr-00013n-2l; Fri, 13 Dec 2019 18:48:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC232304D2B;
        Fri, 13 Dec 2019 19:46:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C74C529E8533C; Fri, 13 Dec 2019 19:47:59 +0100 (CET)
Date:   Fri, 13 Dec 2019 19:47:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
Message-ID: <20191213184759.GH2844@hirez.programming.kicks-ass.net>
References: <20191212223525.1652-1-longman@redhat.com>
 <20191212223525.1652-5-longman@redhat.com>
 <20191213102525.GA2844@hirez.programming.kicks-ass.net>
 <20191213105042.GJ2871@hirez.programming.kicks-ass.net>
 <9a79ef1a-96e0-1fd7-97e8-ef854b08524d@redhat.com>
 <20191213181255.GF2844@hirez.programming.kicks-ass.net>
 <7ca26a9a-003f-6f24-08e4-f01b80e3e962@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca26a9a-003f-6f24-08e4-f01b80e3e962@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:35:05PM -0500, Waiman Long wrote:
> On 12/13/19 1:12 PM, Peter Zijlstra wrote:
> >> In this way, the wasted space will be k bytes where k is the number of
> >> 1-entry chains. I don't think merging adjacent blocks will be that
> >> useful at this point. We can always add this capability later on if it
> >> is found to be useful.
> > I'm thinking 1 entry isn't much of a chain. My brain is completely fried
> > atm, but are we really storing single entry 'chains' ? It seems to me we
> > could skip that.
> >
> Indeed, the current code can produce a 1-entry chain. I also thought
> that a chain had to be at least 2 entries. I got tripped up assuming
> that. It could be a bug somewhere that allow a 1-entry chain to happen,
> but I am not focusing on that right now.

If we need the minimum 2 entry granularity, it might make sense to spend
a little time on that. If we can get away with single entry markers,
then maybe write a comment so we'll not forget about it.
