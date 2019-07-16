Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78486C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414512173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563284544;
	bh=Vw/idVh7Sc9FkQHJBYJh/radei2L3mJILwWiBzy0SpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oc/pB4bMBSjIDyAnlTveT5vSDL2HNKDs00ekW/pbOTnmN6U45JlvR1XBFLFT7K3TW
	 ScgYRZbOFDPqsZsTRYl+f6wA5WtGXtvgDtucQChnF5OO6fQH11VnyRKlymW8f9saS0
	 03vbjQGGwVzO9JbekRJwqQAX7cdDhd/M7X07mc8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbfGPNmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfGPNmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:42:22 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63A22173B;
        Tue, 16 Jul 2019 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563284542;
        bh=Vw/idVh7Sc9FkQHJBYJh/radei2L3mJILwWiBzy0SpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQso73W//C9Bau/8iSPNI4x6+4yOKqR0Ea9YDIlI6KmtykvsLMa/dGZspYWLz3eA1
         xpiVFHPNBzW3XaeiAm6O3G4vJ8GeNNC7slaTnw6sgm47SFbcGs6mnt4akBFgD7GpQz
         GhsVrt1fxuhAPbN5KtwPuIIn7j2YJPycBomaPnVQ=
Date:   Tue, 16 Jul 2019 15:42:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Borislav Petkov <bp@suse.de>,
        syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] perf/hw_breakpoint: Fix breakpoint overcommit issue
Message-ID: <20190716134219.GB4000@lenoir>
References: <20190709134821.8027-1-frederic@kernel.org>
 <20190710140421.GP3402@hirez.programming.kicks-ass.net>
 <20190710153406.GA18838@lenoir>
 <20190711105305.GY3402@hirez.programming.kicks-ass.net>
 <20190715124737.GN3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715124737.GN3463@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 02:47:37PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 11, 2019 at 12:53:05PM +0200, Peter Zijlstra wrote:
> > > I wish we could use event->ctx->task instead but on pmu::init() there
> > > is no ctx yet (we could pass the task in parameter though) 
> > 
> > Right, that should be fairly easy.
> > 
> > > and on event->destroy() it's TASK_TOMBSTONE and retrieving the task at
> > > that time would be non trivial.
> > 
> > Well, right, we can maybe make TOMBSTONE be the LSB instead of the whole
> > word, then we can recover the task pointer... *yuck* though.
> 
> Something like the attached, completely untested patches.
> 
> I didn't do the hw_breakpoint bit, because I got lost in that, but this
> basically provides what you asked for I think.
> 

Thanks they look good! I can take them and work on top if you like.
