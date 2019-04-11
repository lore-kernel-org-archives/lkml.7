Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1D9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1E92084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TvJqi5e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDKRhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:37:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8lPWfr/fv9Mq3ZVmlINx7ayfGTvu31L2DN7bGB7z/yA=; b=TvJqi5e5iA8HNVMzgRG5pVg2C
        pnS4LZ+5q3WjTH+QWjGi5aCm1XHzH3c2/6EM5FWUbMBI/lpWFGzGZF22jxw8Dbt1KJamgRYaArC12
        nwRAZEY3GWcrMo16GsCRNHNC4UvhKXRZWe6XJF8p+/vgVvrGkci6l6+m2tLGy7zKPBcmny2+Xrrbo
        xZkYjM2cPhS0tQIJkJ40KVMfLY8DAwlBqXWMutjNQIK4kV4rfjhbpPjc0Nmg5WUXSVVMu9wv+9rsw
        /tIaOAMQMqdvrxhy9BMBNK+I8gxj+z9271ydZIrFihNqlAsI0TQ4xmJunIABdEg2xRoVcNLeultQL
        /LpvlJrfQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEdd3-0004oy-Ps; Thu, 11 Apr 2019 17:36:49 +0000
Date:   Thu, 11 Apr 2019 10:36:49 -0700
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
Message-ID: <20190411173649.GF22763@bombadil.infradead.org>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org>
 <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
 <CAKOZuetFU4tXE27bxA86zzDfNSCbw83p8fPxfkQ_d_Em0C04Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuetFU4tXE27bxA86zzDfNSCbw83p8fPxfkQ_d_Em0C04Sg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:33:32AM -0700, Daniel Colascione wrote:
> On Thu, Apr 11, 2019 at 10:09 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > On Thu, Apr 11, 2019 at 8:33 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > > victim process. The usage of this flag is currently limited to SIGKILL
> > > > signal and only to privileged users.
> > >
> > > What is the downside of doing expedited memory reclaim?  ie why not do it
> > > every time a process is going to die?
> >
> > I think with an implementation that does not use/abuse oom-reaper
> > thread this could be done for any kill. As I mentioned oom-reaper is a
> > limited resource which has access to memory reserves and should not be
> > abused in the way I do in this reference implementation.
> > While there might be downsides that I don't know of, I'm not sure it's
> > required to hurry every kill's memory reclaim. I think there are cases
> > when resource deallocation is critical, for example when we kill to
> > relieve resource shortage and there are kills when reclaim speed is
> > not essential. It would be great if we can identify urgent cases
> > without userspace hints, so I'm open to suggestions that do not
> > involve additional flags.
> 
> I was imagining a PI-ish approach where we'd reap in case an RT
> process was waiting on the death of some other process. I'd still
> prefer the API I proposed in the other message because it gets the
> kernel out of the business of deciding what the right signal is. I'm a
> huge believer in "mechanism, not policy".

It's not a question of the kernel deciding what the right signal is.
The kernel knows whether a signal is fatal to a particular process or not.
The question is whether the killing process should do the work of reaping
the dying process's resources sometimes, always or never.  Currently,
that is never (the process reaps its own resources); Suren is suggesting
sometimes, and I'm asking "Why not always?"
