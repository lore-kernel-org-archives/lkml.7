Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71EBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C86233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566515861;
	bh=VEJEONhWfk/WukaJbmkMh8WQd3wSqaeL0fnc4kfKLRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ydb46gEXhzX70gcRecvzxjpdmsS0sOVE0MagtUahBjJ+GZiz5+3LKCh4BRdDkZo0h
	 DlPrmlVHqw8aDd2o1D/L+8nNY/Y2/MgKv92sPB96UOUWu0emy/AXHk5kQeo1d09nVf
	 amKt4jOKuPoIh7JGkSQPag/Wuajw5mmDSsyMEo/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405633AbfHVXRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405538AbfHVXRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:17:40 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289372173E;
        Thu, 22 Aug 2019 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566515859;
        bh=VEJEONhWfk/WukaJbmkMh8WQd3wSqaeL0fnc4kfKLRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eq6e920n03QqMtZHtU65ENAUyTt5UdCda4ZnRXq4af144N6CGohpF9H0MoXYbCy7X
         +qCRdw3coCdMO0AmooZErI8fnbwP6GNr0PNkwAXP/4/xs2oKIl4Z7xzyRrYV23zsfE
         xolST8n19Znx5gIHrLQiltNelfhC35fe/AeuINyI=
Date:   Thu, 22 Aug 2019 16:17:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jason Xing <kerneljasonxing@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] psi: get poll_work to run when calling poll syscall
 next time
Message-Id: <20190822161738.02297ead0abd424c44fb33b9@linux-foundation.org>
In-Reply-To: <CAJuCfpHULB5wQWf0Uxo=zSoyOAUmVFanrTZ0fo0-cfGc1o9hNQ@mail.gmail.com>
References: <1566357985-97781-1-git-send-email-joseph.qi@linux.alibaba.com>
        <20190822152107.adc0d4cd374fcc3eb8e148a9@linux-foundation.org>
        <CAJuCfpHULB5wQWf0Uxo=zSoyOAUmVFanrTZ0fo0-cfGc1o9hNQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 16:11:15 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Thu, Aug 22, 2019 at 3:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 21 Aug 2019 11:26:25 +0800 Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
> >
> > > Only when calling the poll syscall the first time can user
> > > receive POLLPRI correctly. After that, user always fails to
> > > acquire the event signal.
> > >
> > > Reproduce case:
> > > 1. Get the monitor code in Documentation/accounting/psi.txt
> > > 2. Run it, and wait for the event triggered.
> > > 3. Kill and restart the process.
> > >
> > > The question is why we can end up with poll_scheduled = 1 but the work
> > > not running (which would reset it to 0). And the answer is because the
> > > scheduling side sees group->poll_kworker under RCU protection and then
> > > schedules it, but here we cancel the work and destroy the worker. The
> > > cancel needs to pair with resetting the poll_scheduled flag.
> >
> > Should this be backported into -stable kernels?
> 
> Adding GregKH and stable@vger.kernel.org
> 
> I was able to cleanly apply this patch to stable master and
> linux-5.2.y branches (these are the only branches that have psi
> triggers).
> Greg, Andrew got this patch into -mm tree. Please advise on how we
> should proceed to land it in stable 5.2.y and master.

That isn't the point - we know how to merge patches ;)

What I'm asking is whether it is desirable that -stable kernels have
this patch.  It certainly sounds like it from the changelog, so I'm
wondering if the omission of cc:stable was intentional?


