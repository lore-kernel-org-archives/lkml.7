Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7CFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444482077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566911853;
	bh=gBY1Hf6Ol8oNw7i9sKfkkUV86Bt0XlKupuLcyhWkc3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QmEo/YIallvlynqCBqhgPTaKqheZd+JlRA5n3zTKibLjRMqh5MngoqC/ckUwLat9N
	 7/ibvkyo/N+WIOFWTmYdG+7KmWUQFBWVaDqVqSU0k7LADc9g9m6B+uZYg6ERCG7VXK
	 4Vwod6dtC2fma/tH7LbdaLvHZ4caWq4Wb6IgWiOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfH0NRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0NRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:17:32 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C86206BF;
        Tue, 27 Aug 2019 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566911851;
        bh=gBY1Hf6Ol8oNw7i9sKfkkUV86Bt0XlKupuLcyhWkc3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Y8Lm6DjGIhFxEi+Vbcu4R56+GWnALp0VlF30VdY2vZHrCodSt4vuQgg3KuXml8gj
         1kOWtaVaNjDjbvmjm0OaRVvQ1fuXAiVb4bfPiEtMR1jctZSl0kkljmcnVfGebTD3nZ
         uRgUzmB9n0y4WJxgz1WA8rdzxJvjHD+BhAdhD7d0=
Date:   Tue, 27 Aug 2019 15:17:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 38/38] posix-cpu-timers: Utilize timerqueue for storage
Message-ID: <20190827131727.GA25843@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.835676817@linutronix.de>
 <20190827004846.GM14309@lenoir>
 <alpine.DEB.2.21.1908270807080.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908270807080.1939@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 08:08:06AM +0200, Thomas Gleixner wrote:
> On Tue, 27 Aug 2019, Frederic Weisbecker wrote:
> 
> > On Wed, Aug 21, 2019 at 09:09:25PM +0200, Thomas Gleixner wrote:
> > >  /**
> > > @@ -92,14 +130,10 @@ struct posix_cputimers {
> > >  
> > >  static inline void posix_cputimers_init(struct posix_cputimers *pct)
> > >  {
> > > -	pct->timers_active = 0;
> > > -	pct->expiry_active = 0;
> > 
> > No more need to initialize these?
> > 
> > > +	memset(pct->bases, 0, sizeof(pct->bases));
> 
> memset() does that IIRC :)

But those two fields aren't part of pct->bases, are they? :)
