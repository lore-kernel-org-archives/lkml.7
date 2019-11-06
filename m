Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C1C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6184A217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gg0JNqLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfKFNIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:08:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfKFNIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ysmyeQuCWUxR2JMbHNgT/a1i2tmoz69jj5TSgPi059w=; b=gg0JNqLU0+0XO29H1NTao9AwR
        EtbjuUKLk7Bfv63FAk0Ee2s9c13LIdmL6/jZtuUqt1KeiFgKrc/cGzgz6N4vfeIaJ8z3wJGitrRaR
        CR5UlhdjtlyFsTD9f8DjCpuaOnF7soZdzKTPZkZfazcK/1b7H7DeBehZFPtfFWYTkIBfJ6269TLar
        iqbfeVwNckDtMvRZEhg56OmLxCdnGs0MtaQuW1xZBsJnn3yOmG9zTB+lMlCkhyej8mQKlsA20FkL0
        eRtZaDXtBEJ8AMD4xtTETSF5EYb22hzjTSVIVT8RK1C2La5IuIBDPxipU/WfckuHmuE9lAkVB2UOT
        ZNoJA8XGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSL3B-0004uR-9W; Wed, 06 Nov 2019 13:08:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F740300692;
        Wed,  6 Nov 2019 14:07:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4AAB2025EDA2; Wed,  6 Nov 2019 14:08:38 +0100 (CET)
Date:   Wed, 6 Nov 2019 14:08:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        valentin.schneider@arm.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191106130838.GL5671@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106120525.GX4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:05:25PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2019 at 05:46:03PM +0000, Quentin Perret wrote:
> > 
> > After digging a bit, the offending commit seems to be:
> > 
> >     67692435c411 ("sched: Rework pick_next_task() slow-path")
> > 
> > By 'offending' I mean that reverting it makes the issue go away. The
> > issue comes from the fact that pick_next_entity() returns a NULL se in
> > the 'simple' path of pick_next_task_fair(), which causes obvious
> > problems in the subsequent call to set_next_entity().
> > 
> > I'll dig more, but if anybody understands the issue in the meatime feel
> > free to send me a patch to try out :)
> 
> So for all those who didn't follow along on IRC, the below seems to cure
> things.
> 
> The only thing I'm now considering is if we shouldn't be setting
> ->on_cpu=2 _before_ calling put_prev_task(). I'll go audit the RT/DL
> cases.

So I think it all works, but that's more by accident than anything else.
I'll move the ->on_cpu=2 assignment earlier. That clearly avoids calling
put_prev_task() while we're in put_prev_task().
