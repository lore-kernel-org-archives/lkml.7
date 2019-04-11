Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1FDC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D702083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCrxixgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDKQZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:25:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33607 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfDKQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:25:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id a190so3859917vsd.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6URVyeJUSk4JGBhzUK/GU3l+GiR1jafukhgScONoVh8=;
        b=CCrxixgma4yFpHCkZzUEv9SdR6N+nGl21esIDWcXQHPs/rneFFO1ER7Yy3t/O3kvF6
         K2LjEoUEUPmyDMq7RAaPlpLis7lAfXDTS8pxT2Zch6lvz2bLr3P9wSHHS/59Wt8IM7e3
         vaAF7DEX4jyCHQK9U0VNFdFzcxmQEtJXCsqxZh6JSoTmTVJ2MewFgXKUnHVvFZ+v2B5n
         tRWuGsTBo0fPP3L7a3+E/yvdFYYkRjBBjxOu+SP9DjfrZSKt3XkVN4VmMzw2dIiD0KK7
         z9GI8GwZRe/JGK8edMcgZlynAfWMd6pRwRgZtrJz3SVey2z7P1EFR2lKrHovn0GWIqj+
         Rx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6URVyeJUSk4JGBhzUK/GU3l+GiR1jafukhgScONoVh8=;
        b=AInfcXS4Uu2UMjD7OiUAqSh17pLHRsvDlMHF5/nedQ0XQfZAfNLWrcQg34MJedkTzl
         YIZacxmWPsPYk3KTVmUYj4VKyBh5gGu1dRRD4eKyObIB8Nf2nhO7Hpodotq3rWTmthmh
         SVUZPe+vJPIJLj4t11VefzL4uiRCZtpyfR3WTArfXLIES7fqAfWXkunnhJo+qc72tsm2
         W8+4cUzCfjun0BrrsVAuxiACgFniG5g7voCuRNqYu1YOGRsTF9w3FZVa5BtPVX/QeazS
         rUa1Zshg+u4KpisIRySWBWW8CXOLvhU92XKVIjUdJzPwg1Kx4zbx6Ihnxd8vUANaYqay
         MxyA==
X-Gm-Message-State: APjAAAVOZQLRmmzquoAFAhXH+BYQ4ipVOm+5U3/IPUXaHoRvGeSMCqKb
        3H2/BWcPDXEGMM6FRluP5sJ836Bivml25vY6WKBhyQ==
X-Google-Smtp-Source: APXvYqwqdTSlcxUw2QsTDyZA0bTXMB88+SSatujAvWzoL8vneYzf/siPNRgBheK5KubuB7JpH0/MTvYJxRsBXwuZuw4=
X-Received: by 2002:a67:e256:: with SMTP id w22mr17217643vse.173.1554999953603;
 Thu, 11 Apr 2019 09:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411103018.tcsinifuj7klh6rp@brauner.io> <CAJuCfpE4BsUHUZp_5XzSYrXbampFwOZoJ-XYp2iZtT6vqSEruQ@mail.gmail.com>
 <CAJuCfpFb-PtqdxbGeMLwycL1TvQs6q++M=Re1Yrw=J38y8qo1w@mail.gmail.com>
In-Reply-To: <CAJuCfpFb-PtqdxbGeMLwycL1TvQs6q++M=Re1Yrw=J38y8qo1w@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 11 Apr 2019 09:25:41 -0700
Message-ID: <CAKOZuesgCpyLzs3g=RxyjBMjiMMxDbA2kOZZs3YOqOv=Ri6KgQ@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 8:23 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > > victim process. The usage of this flag is currently limited to SIGKILL
> > > > signal and only to privileged users.

FWIW, I like Suren's general idea, but I was thinking of a different
way of exposing the same general functionality to userspace. The way I
look at it, it's very useful for an auto-balancing memory system like
Android (or, I presume, something that uses oomd) to recover memory
*immediately* after a SIGKILL instead of waiting for the process to
kill itself: a process's death can be delayed for a long time due to
factors like scheduling and being blocked in various uninterruptible
kernel-side operations. Suren's proposal is basically about pulling
forward in time page reclaimation that would happen anyway.

What if we let userspace control exactly when this reclaimation
happens? I'm imagining a new* kernel facility that basically looks
like this. It lets lmkd determine for itself how much work the system
should expend on reclaiming memory from dying processes.

size_t try_reap_dying_process(
  int pidfd,
  int flags /* must be zero */,
  size_t maximum_bytes_to_reap);

Precondition: process is pending group-exit (someone already sent it SIGKILL)
Postcondition: some memory reclaimed from dying process
Invariant: doesn't sleep; stops reaping after MAXIMUM_BYTES_TO_REAP

-> success: return number of bytes reaped
-> failure: (size_t)-1

EBUSY: couldn't get mmap_sem
EINVAL: PIDFD isn't a pidfd or otherwise invalid arguments
EPERM: process hasn't been send SIGKILL: try_reap_dying_process on a
process that isn't dying is illegal

Kernel-side, try_reap_dying_process would try-acquire mmap_sem and
just fail if it couldn't get it. Once acquired, it would release
"easy" pages (using the same check the oom reaper uses) until it
either ran out of pages or hit the MAXIMUM_BYTES_TO_REAP cap. The
purpose of MAXIMUM_BYTES_TO_REAP is to let userspace bound-above the
amount of time we spend reclaiming pages. It'd be up to userspace to
set policy on retries, the actual value of the reap cap, the priority
at which we run TRY_REAP_DYING_PROCESS, and so on. We return the
number of bytes we managed to free this way so that lmkd can make an
informed decision about what to do next, e.g., kill something else or
wait a little while.

Personally, I like th approach a bit more that recruiting the oom
reaper through because it doesn't affect any kind of  emergency memory
reserve permission and because it frees us from having to think about
whether the oom reaper's thread priority is right for this particular
job.

It also occurred to me that try_reap_dying_process might make a decent
shrinker callback. Shrinkers are there, AIUI, to reclaim memory that's
easy to free and that's not essential for correct kernel operation.
Usually, it's some kind of cache that meets these criteria. But the
private pages of a dying process also meet the criteria, don't they?
I'm imagining the shrinker just picking an arbitrary doomed (dying but
not yet dead) process and freeing some of its pages. I know there are
concerns about slow shrinkers causing havoc throughout the system, but
since this shrinker would be bounded above on CPU time and would never
block, I feel like it'd be pretty safe.

* insert standard missive about system calls being cheap, but we can
talk about the way in which we expose this functionality after we
agree that it's a good idea generally
