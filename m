Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9ACC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D20F2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqphQP92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDKWAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:00:06 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40367 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDKWAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:00:05 -0400
Received: by mail-wr1-f44.google.com with SMTP id h4so9286358wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NawObyE9Zp16eLwFu5OPgzzdF2i4lMyPHI2QyUPOlK0=;
        b=MqphQP92OgsvRoMbbmbXn3lXPPv7JgQOj3uXy35tv7nQiYjdSaAyYZaXa/Q7P7wDXE
         kGDHBRN5P2Lxpgtg6vv9KELeDa+b3yyz+BtJsKyHo48XdAlE2kKFtC1jZgiuMjPMBn/9
         OjTpxGIvco4tQgJzkGyFaNaRFQw9jCg2YL9qyPEAMG5OlnctCup4J4BXFYZ/5M2VYQr0
         Xz7YQh086MWcG/jvWQkMTlzO9JW1GGWdNOTMp5I2/2LKJbdmYK+RLRhBva2DzlJdqhdP
         JiesYrjhOGVLwWT6cGkmVZ6UZseKXfSVFLy30lBl+Ts4/WKG4lrSxQ+OyS3G12/Y4EFk
         KCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NawObyE9Zp16eLwFu5OPgzzdF2i4lMyPHI2QyUPOlK0=;
        b=fIrHA/j6+GTqIC/4NsFCcWhCx9YzuAGi3TfAfW2yxjL9H4jS1tuFOxBxcXEPZo4wz+
         M/Ga9wifR0A0nuMna9YkAZUPrLFbSGt3AHmb3WtE4VAOm28sV8VoCfzkMykqjbzJx9eK
         eWAJMW7GhJMwZ//OmYMtD2H4rjl1jcNCgO1JusP6M2mvKKhQFnNfgJWg9XN15GehUpfy
         GA3/xnbP2WPz7Bm74KUXz04jPf8t/AjbYUtpw8s7vwFhUE8tGixe5pyqTVEovgBbbz9N
         GNN+DjVTNpir/b0Pq+Qn75q3GBl5eaYRcCxX147JqnsdAPmGRqREmHAMwZh/577Y7GK1
         U5kw==
X-Gm-Message-State: APjAAAXiVgdELXI7fLLJ1ML2qE2cbtCwp5RANrMue5VRFhwI+eKZO1Ci
        CYpQgqUra8uQAe3XjmuboYMr8hYdfvllQaY8dBi3jw==
X-Google-Smtp-Source: APXvYqywLXFZ26VMEzhbK5mzgQdSEa7/h59iSNw606UZ4yYmpRG6kaPD22As4lJ8uuB9GyxIbnLHPOuNGB/AzmlW7dI=
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr13689115wrj.16.1555020003406;
 Thu, 11 Apr 2019 15:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
 <20190411214458.GB31565@tower.DHCP.thefacebook.com>
In-Reply-To: <20190411214458.GB31565@tower.DHCP.thefacebook.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 11 Apr 2019 14:59:51 -0700
Message-ID: <CAJuCfpFjwv7SFEYZ9gbZXYdiPSPpnKHaXfsbEJorN8Y55QAjVg@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Roman Gushchin <guro@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        "yuzhoujian@didichuxing.com" <yuzhoujian@didichuxing.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 2:45 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Apr 11, 2019 at 10:09:06AM -0700, Suren Baghdasaryan wrote:
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
>
> Hello, Suren!
>
> I also like the idea to reap always.
>
> > I think with an implementation that does not use/abuse oom-reaper
> > thread this could be done for any kill. As I mentioned oom-reaper is a
> > limited resource which has access to memory reserves and should not be
> > abused in the way I do in this reference implementation.
>
> In most OOM cases it doesn't matter that much which task to reap,
> so I don't think that reusing the oom-reaper thread is bad.
> It should be relatively easy to tweak in a way, that it won't
> wait for mmap_sem if there are other tasks waiting to be reaped.
> Also, the oom code add to the head of the list, and the expedited
> killing to the end, or something like this.
>
> The only think, if we're going to reap all tasks, we probably
> want to have a per-node oom_reaper thread.

Thanks for the ideas Roman. I'll take some time to digest the input
from everybody. What I heard from everyone is that we want this to be
a part of generic kill functionality which does not require a change
in userspace API.

> Thanks!
>
> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
