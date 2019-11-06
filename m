Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E3C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6542187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jbKtM3Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbfKFQyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:54:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfKFQyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TqFiX/TxrEBMTuixkbn/nkca9tyWxgwszGYJJ1sXL28=; b=jbKtM3TeVTPE+bUGcnH546tTM
        1eQe+mbjhaiYqn6i13+odDl03kTEil1OszifDPkmh6e+9y5PI7BWus/4vgov7K2GM/DqAEDrDSQji
        PS81nA8H14dUCXlMSMqD1K2MJ/Nhdcz539fLOxiBkCWEM0eDY+UydhAc6wg58dbJ6rHAa5BimU514
        0mYrD1Xx9Yljt0fWLx85staoIYStJ+z74rOJ8LkQiENvobS0Y8VgRs2zyK27mJPo7CIB+elSuXRJ4
        GrumUiSptQmLaa2Wk8QX/BgtVJR6VrpxTTxaGjBiJLH21R/27Dl94bG0SyZYzU+A6uOPOD5Gx7wBd
        cqqD2ai0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSOZv-0008J4-Jb; Wed, 06 Nov 2019 16:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A2B4302C0F;
        Wed,  6 Nov 2019 17:53:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 451552025EDA7; Wed,  6 Nov 2019 17:54:37 +0100 (CET)
Date:   Wed, 6 Nov 2019 17:54:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191106165437.GX4114@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 06:51:40PM +0300, Kirill Tkhai wrote:
> > +#ifdef CONFIG_SMP
> > +	if (!rq->nr_running) {
> > +		/*
> > +		 * Make sure task_on_rq_curr() fails, such that we don't do
> > +		 * put_prev_task() + set_next_task() on this task again.
> > +		 */
> > +		prev->on_cpu = 2;
> >  		newidle_balance(rq, rf);
> 
> Shouldn't we restore prev->on_cpu = 1 after newidle_balance()? Can't prev
> become pickable again after newidle_balance() releases rq->lock, and we
> take it again, so this on_cpu == 2 never will be cleared?

Indeed so.
