Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7227C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16D220856
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557193639;
	bh=hjGpvFskyK62aOLDo7aJ3c3Omq3LXz58x3NKbR8+/iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=St0M/jz374V6yZB/w/viiw+7gfcLd+FHkYqA3wPMLA02E1wygtyAbvcc2dm+ISs5U
	 GoyAcptoWEdweqAeCxhBUM5enD8pdduK7Mg6UPT9+q7hCQZokA0h9SgiY7jlVB+x91
	 tCZFxjbZ7LcYmSf5BX126hKiZdmKTVBWNX0cnqQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEGBrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 21:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfEGBrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:47:18 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7B7206BF;
        Tue,  7 May 2019 01:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557193637;
        bh=hjGpvFskyK62aOLDo7aJ3c3Omq3LXz58x3NKbR8+/iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=et2ImoZEQfXTtaxbVnUtcjvHubT6xOB0ocUAgj5QVCrTg4VnG6l0m1nCdNdHoLlRt
         wzFuzxkxBkzXsIQuaelDMIaSjl2QgDeWwAZQnAlsTxpK8UX3BTr3RVLQfDKdkbmeLR
         YAToDTS0U8HnGh1FQnGBa+XNTn/ep9Qg3pY5v1WE=
Date:   Tue, 7 May 2019 03:47:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yuyang Du <duyuyang@gmail.com>, will.deacon@arm.com,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/28] locking/lockdep: Optimize irq usage check when
 marking lock usage bit
Message-ID: <20190507014712.GA14921@lerouge>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-20-duyuyang@gmail.com>
 <20190425193247.GU12232@hirez.programming.kicks-ass.net>
 <CAHttsrY4jK2cayBE8zNCSJKDAkzLiBb40GVfQHpJi2YK1nEZaQ@mail.gmail.com>
 <20190430121148.GV2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430121148.GV2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:11:48PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 26, 2019 at 02:57:37PM +0800, Yuyang Du wrote:
> > Thanks for review.
> > 
> > On Fri, 26 Apr 2019 at 03:32, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Apr 24, 2019 at 06:19:25PM +0800, Yuyang Du wrote:
> > >
> > > After only a quick read of these next patches; this is the one that
> > > worries me most.
> > >
> > > You did mention Frederic's patches, but I'm not entirely sure you're
> > > aware why he's doing them. He's preparing to split the softirq state
> > > into one state per softirq vector.
> > >
> > > See here:
> > >
> > >   https://lkml.kernel.org/r/20190228171242.32144-14-frederic@kernel.org
> > >   https://lkml.kernel.org/r/20190228171242.32144-15-frederic@kernel.org
> > >
> > > IOW he's going to massively explode this storage.
> > 
> > If I understand correctly, he is not going to.
> > 
> > First of all, we can divide the whole usage thing into tracking and checking.
> > 
> > Frederic's fine-grained soft vector state is applied to usage
> > tracking, i.e., which specific vectors a lock is used or enabled.
> > 
> > But for usage checking, which vectors are does not really matter. So,
> > the current size of the arrays and bitmaps are good enough. Right?
> 
> Frederic? My understanding was that he really was going to split the
> whole thing. The moment you allow masking individual soft vectors, you
> get per-vector dependency chains.

Right, so in my patchset there is indeed individual soft vectors masked
so we indeed need per vector checks. For example a lock taken in HRTIMER
softirq shouldn't be a problem if it is concurrently taken while BLOCK softirq
is enabled. And for that we expand the usage_mask so that the 4 bits currently
used for general SOFTIRQ are now multiplied by NR_SOFTIRQ (10) because we need to
track the USED and ENABLED_IN bits for each of them.

The end result is:

4 hard irq bits + 4 * 10 softirq bits + LOCK_USED bit = 45 bits.

Not sure that answers the question as I'm a bit lost in the debate...
