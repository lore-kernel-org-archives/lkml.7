Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300AEC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE602080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NFJ5mx3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbfHAV70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:59:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfHAV7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FlbNAsgaWkp1ShDCheHxAkj85en9Tu2y9Hru44fhYz0=; b=NFJ5mx3pun9BIYphO0C68UAUu
        bNIl5t6nnsxHXQq8rOyvK1+2xENKG1banbuqonFceMoKyQfDoNijJJq1cmdDthZGkLdEJaHaa+JRR
        sy9AZHK01JafhzTXpLIhZcM24Nt52lWl/kRGtNf5E6LX5xx1DNeoa8ZNntincpMLRDHuDoi7WC/+y
        HA3O23EObKhT4TPP+bFOaHWWnfil3CE5Ggc/aCnZxceKFfwCToLfXOTGqgxuInpjTOEyU5G52eQ61
        7gsEOZqcrfczHuU7P7Dx4ONddvwcraEmcYcTxxpMkFOgVNQGyPcL7cM+eMlCVnQ+Z2HDd9+SLiVEF
        If+0fSSdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htJ6I-0002fJ-Mv; Thu, 01 Aug 2019 21:59:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51E57202953B0; Thu,  1 Aug 2019 23:59:04 +0200 (CEST)
Date:   Thu, 1 Aug 2019 23:59:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        Dennis Zhou <dennis@kernel.org>,
        Dennis Zhou <dennisszhou@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Nick Kralevich <nnk@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] psi: do not require setsched permission from the
 trigger creator
Message-ID: <20190801215904.GC2332@hirez.programming.kicks-ass.net>
References: <20190730013310.162367-1-surenb@google.com>
 <20190730081122.GH31381@hirez.programming.kicks-ass.net>
 <CAJuCfpH7NpuYKv-B9-27SpQSKhkzraw0LZzpik7_cyNMYcqB2Q@mail.gmail.com>
 <20190801095112.GA31381@hirez.programming.kicks-ass.net>
 <CAJuCfpHGpsU4bVcRxpc3wOybAOtiTKAsB=BNAtZcGnt10j5gbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHGpsU4bVcRxpc3wOybAOtiTKAsB=BNAtZcGnt10j5gbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:28:30AM -0700, Suren Baghdasaryan wrote:
> > By marking it FIFO-99 you're in effect saying that your stupid
> > statistics gathering is more important than your life. It will preempt
> > the task that's in control of the band-saw emergency break, it will
> > preempt the task that's adjusting the electromagnetic field containing
> > this plasma flow.
> >
> > That's insane.
> 
> IMHO an opt-in feature stops being "stupid" as soon as the user opted
> in to use it, therefore explicitly indicating interest in it. However
> I assume you are using "stupid" here to indicate that it's "less
> important" rather than it's "useless".

Quite; PSI does have its uses. RT just isn't one of them.
