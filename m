Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF2BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEB42087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AQsMoKDF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JUYmFiFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCMX3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:29:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCMX3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:29:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF63A60208; Wed, 13 Mar 2019 23:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552519748;
        bh=T8PsrD7XA4Tb3EIysYmAPhdyov1ZVqCygym2gTSDMSA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AQsMoKDFLuQvbjcob36IGa2jib35wCaEz0wdZWTfG25meRwXuqd8k6KMVI4l3zlHX
         BFemf4bL1vCUgZ9zgXeeEsP2g6jXDJt2+KcGV8KqOD3E9ggWoKcoz7uwFUtYfOrMVX
         l49IdgSR3J2QxU1l46ULkTRg9UnJqX3//0nVNaVI=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B00760208;
        Wed, 13 Mar 2019 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552519747;
        bh=T8PsrD7XA4Tb3EIysYmAPhdyov1ZVqCygym2gTSDMSA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JUYmFiFneCQrnqa+qZ6xnrWQbeHu3Wzh3u4ZVJphmT8LSUm6m94gNELDQSMbhYjS1
         +Uf1/jPXcjRFa0exK2LW+CUFkZoC/cArBpeKIU4g3O3IP25u4hqQ6yUwRL+fOfELnZ
         fenEolHViz5Xeo984LP3m9pAUBV2BDE4ebEsTQuc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B00760208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Wed, 13 Mar 2019 16:29:06 -0700 (PDT)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     John Stultz <john.stultz@linaro.org>
cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Marissa Wall <marissaw@google.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
In-Reply-To: <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1903131627160.5462@lmark-linux.qualcomm.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com> <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019, John Stultz wrote:

> On Wed, Mar 13, 2019 at 1:11 PM Liam Mark <lmark@codeaurora.org> wrote:
> > On Tue, 5 Mar 2019, John Stultz wrote:
> > >
> > > Eventual TODOS:
> > > * Reimplement page-pool for system heap (working on this)
> > > * Add stats accounting to system/cma heaps
> > > * Make the kselftest actually useful
> > > * Add other heaps folks see as useful (would love to get
> > >   some help from actual carveout/chunk users)!
> >
> > We use a modified carveout heap for certain secure use cases.
> 
> Cool! It would be great to see if you have any concerns about adding
> such a secure-carveout heap to this framework. I suspect it would be
> fairly similar to how its integrated into ION, but particularly I'd be
> interested in issues around the lack of private flags and other
> allocation arguments like alignment.
> 

We are actively working to drop our secure careveout heap in order to 
improve memory utilization so I don't think there would be a good case for 
upstreaming it.

Our other secure heaps are CMA based and system heap based.
Because people have had difficulty designing a generic secure heap which 
would satisfy enough of everybody's use cases to be upstreamable we have 
been looking into moving away from having local secure heap changes and 
instead have been looking at how to instead have a separate driver be 
responsible for making an ION buffer memory secure. The idea was to do 
this in order to remove a lot of our local ION changes, but if a secure 
heap was upstreamed that supported our secure use cases I am sure we would 
be interested in using that.

The local change the ION API to support these heaps is the addition of all 
the VMID flags so that the client can specify where the client wants the 
memory assigned.


> > Although there would probably be some benefit in discssing how the dma-buf
> > heap framework may want to support
> > secure heaps in the future it is a large topic which I assume you don't
> > want to tackle now.
> 
> So I suspect others (Benjamin?) would have a more informed opinion on
> the details, but the intent is to allow secure heap implementations.
> I'm not sure what areas of concern you have for this allocation
> framework in particular?
> 

I don't have any areas of concern, my thought was just that flushing out a 
potential design for an upstreamable secure heap would allow us catch 
early on if there is anything fundamental that would need to change 
dma-buf heaps framework (such as the allocation API).
I don't think this is a necessary task at this point. 

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
