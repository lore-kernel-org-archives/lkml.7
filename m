Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE427C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA04B20651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555051771;
	bh=9NlAKE/RaSODUcIyJzffvEnaRq9LS4Y7iVt5UpO0j/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W3+06w3PL4uBkRMw74FxnnIxi06warZaWDFkn6+s91AZgBZSo7i8vSIS47peHCaF8
	 UFol1c+nnAJwrlZH6ifdPl3LlnyvcXGc6OAgy5J6gXTiHrvYIbrQcM2wh5AJbAk8tu
	 P2Sq6gW5GZdAc+u16HV5nDyqtsc3AdRuGAN2uxrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDLGta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:49:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfDLGta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:49:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB344ADD9;
        Fri, 12 Apr 2019 06:49:27 +0000 (UTC)
Date:   Fri, 12 Apr 2019 08:49:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20190412064925.GB13373@dhcp22.suse.cz>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 10:47:50, Daniel Colascione wrote:
> On Thu, Apr 11, 2019 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Apr 11, 2019 at 10:33:32AM -0700, Daniel Colascione wrote:
> > > On Thu, Apr 11, 2019 at 10:09 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > On Thu, Apr 11, 2019 at 8:33 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > > > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > > > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > > > > victim process. The usage of this flag is currently limited to SIGKILL
> > > > > > signal and only to privileged users.
> > > > >
> > > > > What is the downside of doing expedited memory reclaim?  ie why not do it
> > > > > every time a process is going to die?
> > > >
> > > > I think with an implementation that does not use/abuse oom-reaper
> > > > thread this could be done for any kill. As I mentioned oom-reaper is a
> > > > limited resource which has access to memory reserves and should not be
> > > > abused in the way I do in this reference implementation.
> > > > While there might be downsides that I don't know of, I'm not sure it's
> > > > required to hurry every kill's memory reclaim. I think there are cases
> > > > when resource deallocation is critical, for example when we kill to
> > > > relieve resource shortage and there are kills when reclaim speed is
> > > > not essential. It would be great if we can identify urgent cases
> > > > without userspace hints, so I'm open to suggestions that do not
> > > > involve additional flags.
> > >
> > > I was imagining a PI-ish approach where we'd reap in case an RT
> > > process was waiting on the death of some other process. I'd still
> > > prefer the API I proposed in the other message because it gets the
> > > kernel out of the business of deciding what the right signal is. I'm a
> > > huge believer in "mechanism, not policy".
> >
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

I was thinking about this as well. And SYNC_SIGKILL would workaround the
current expectations of how quick the current implementation is. The
harder part would what is the actual semantic. Does the kill wait until
the target task is TASK_DEAD or is there an intermediate step that would
we could call it end of the day and still have a reasonable semantic
(e.g. the original pid is really not alive anymore).
-- 
Michal Hocko
SUSE Labs
