Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CE5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503E82133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561479664;
	bh=kq0ajRiki1iEP/Fh8o1U8wAY2tObmS5WYdbp1gbsIDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JvSeuJ7yCZqA1br3V5Uucit4rbs7VfwK2xMZK0m1aGjzEwjfpsMYCGj04CTse3f/3
	 J9oRO+8sRyjnEyJY+NuJh1z49/aH1uiPhC5iBlJc9FP4AKjjD7dNFeC5iA/AWHpV4n
	 Esutx/bXUUgv/miV4ZN7lypl6a3VWD1FMOyRpakg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfFYQVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfFYQVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:21:02 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FCC42080C;
        Tue, 25 Jun 2019 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561479661;
        bh=kq0ajRiki1iEP/Fh8o1U8wAY2tObmS5WYdbp1gbsIDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z91I0SzgIAuPl6foiMg7uxG1ChZfikxG+aGXGWYF18ipeY3F3fK8LtwHHSxnNK1pq
         kempM5Q+Akauoz1y0WmUMqByouzKgIXEnRIKaG+SiO4yoU0X8Ei8m566uN4zCc7k2U
         tilTobk11SlKK+1A6Eu9yMUGFZwWkWXgrm5E2MZY=
Date:   Tue, 25 Jun 2019 18:20:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190625162058.GB23880@lenoir>
References: <20190621175027.GA23260@linux.ibm.com>
 <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
 <20190625004300.GB17497@lerouge>
 <20190625075139.GT3436@hirez.programming.kicks-ass.net>
 <20190625122514.GA23880@lenoir>
 <20190625135430.GW26519@linux.ibm.com>
 <20190625140538.GC3419@hirez.programming.kicks-ass.net>
 <20190625141624.GX26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625141624.GX26519@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:16:24AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 25, 2019 at 04:05:38PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 25, 2019 at 06:54:30AM -0700, Paul E. McKenney wrote:
> > > And it allows dispensing with the initialization.  How about like
> > > the following?
> > 
> > Looks good to me!
> 
> Limited rcutorture testing looking good thus far.  Here is hoping!
> 
> Frederic, you OK with this approach?

Yep, all good!

Thanks!
