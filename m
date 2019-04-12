Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD0C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788B520869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNryO1YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDLVEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:04:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDLVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=47f99Mo+hydUFa/g/RdJ33gOWoAsO4NFmnQJgCAGVXk=; b=hNryO1YEnoE8oEpdDtnRTm8cf
        JQ8mTLNe6qyVi3NbhxLCX4hE+lVbiJMP8XxnqGIS/wy4lodGJ2uSCJOLKMN2YHDKO91vuKZWTqu/7
        jAUw3bgOhP8ucd+59v2q08TyCmpbK3hoQu7Ma9sb9owgfQHqDycjvAJuyzGkR1gLoRfb+ozgtYE/S
        knL+iMLMxk+X79PVU1BCkGVacxHq1o1iyHAdYaGbDrI7BxLgxN5Zygn/+RH4yxLRBIuuZIjJLdObd
        SjlkiVbsVlWMecRw3ZfbM64obc731htiPKdvWq2HUCiEmix3qnPZzmUnlNCl1+mNjYo7MyJInnBNE
        QE151ghYw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hF3L1-0004EH-RX; Fri, 12 Apr 2019 21:03:55 +0000
Date:   Fri, 12 Apr 2019 14:03:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
Message-ID: <20190412210355.GC899@bombadil.infradead.org>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org>
 <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
 <CAKOZuetFU4tXE27bxA86zzDfNSCbw83p8fPxfkQ_d_Em0C04Sg@mail.gmail.com>
 <20190411173649.GF22763@bombadil.infradead.org>
 <CAKOZuet8-en+tMYu_QqVCxmkak44T7MnmRgfJBot0+P_A+Qzkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuet8-en+tMYu_QqVCxmkak44T7MnmRgfJBot0+P_A+Qzkw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:47:50AM -0700, Daniel Colascione wrote:
> On Thu, Apr 11, 2019 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> > It's not a question of the kernel deciding what the right signal is.
> > The kernel knows whether a signal is fatal to a particular process or not.
> > The question is whether the killing process should do the work of reaping
> > the dying process's resources sometimes, always or never.  Currently,
> > that is never (the process reaps its own resources); Suren is suggesting
> > sometimes, and I'm asking "Why not always?"
> 
> FWIW, Suren's initial proposal is that the oom_reaper kthread do the
> reaping, not the process sending the kill. Are you suggesting that
> sending SIGKILL should spend a while in signal delivery reaping pages
> before returning? I thought about just doing it this way, but I didn't
> like the idea: it'd slow down mass-killing programs like killall(1).
> Programs expect sending SIGKILL to be a fast operation that returns
> immediately.

Suren said that the implementation in this proposal wasn't to be taken
literally.

You've raised some good points here though.  Do mass-killing programs
like kill with a pgid or killall expect the signal-sending process to
be fast, or do they not really care?

From the kernel's point of view, the same work has to be done, no matter
whether the killer or the victim does it.  Should the work be accounted
to the killer or the victim?  It probably doesn't matter.  The victim
doing the work allows for parallelisation, but I'm not convinced that's
important either.

I see another advantage for the killer doing the work -- if the task
is currently blocking on I/O (eg to an NFS mount that has gone away),
the killer can get rid of the task's page tables.  If we have to wait
for the I/O to complete before the victim reaps its own page tables,
we may be waiting forever.
