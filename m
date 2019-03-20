Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C4EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94E92085A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIijQ38p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCTAEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:04:09 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55367 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfCTAEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:04:09 -0400
Received: by mail-it1-f195.google.com with SMTP id z126so26120268itd.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDZe1t9c0QaacZlrpbAimzEMcql8/pq6sGNUEMnWMjQ=;
        b=CIijQ38pRIRhFAFpNvokHLFR8PSIfXecgjJ8AlRyeY+Kabg6iidqrQRGKu7kYJdzbX
         mAkSf1brUe3fju70jwdjv2B5i+6outQalj3T855ocjYvqJLBxmcu1uZcqTp9cKFhW8f2
         EhGAFalDX31pg/U9SnNKhqYxiV67xGEOEvVa54hbBumop8G9Yl0k3LmFnyWNjCpl5sV7
         2z14fgCmJYLWfhJKF1y4332WYJe2byxf0rdhmR+cku/BIn9yvhHxT/Qw1dbeapxTFU5X
         ev5/OpaIM5PzkBREB0CFnOQ4jnasyGCWnpVlOsvsFU7Sjm4KmjyiSZnNAsqpYcAescQ3
         RKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDZe1t9c0QaacZlrpbAimzEMcql8/pq6sGNUEMnWMjQ=;
        b=cb1Nj02iol8qEGYIF6B8QATQ2MW2pywybHkF1+DEGzFBikg8fN/zyYaxJhOTE7XDQc
         LX0at4B0SBVQJ5cj27x487TuXdKyGf0cofO4vQYd2jxc4s509ISuANaBsoa+b/arwZlX
         HGbKW0iYUCvDv202ddfXRW9T1WyAsisa1hb9ydlrEEPMfcb1hovyQVuRXC/48qkY76l6
         i3R5aTFb40PSf/gSz78kiu6V82OW+GHJuurA+vU8LCYwAiBBYj/LX4MbaB38imwtUvw6
         VLb+ddpd3tx828JlQU7c32DjlBS2kHihVxxxVUxV6cuImLVIpgJLqLk/2oLS92IsKvXN
         wjBw==
X-Gm-Message-State: APjAAAVRVEMf3epPagj+VYh+zHtGg49Dq1B0tT5/nojjFbT5x0zx8N9P
        c7hgGeUOF1By4z5qd/fIZh6dStRcuYVE1NXvlNrutg==
X-Google-Smtp-Source: APXvYqxptOFQVH7/oWAuY9VRvDBG6zdc3/EvfChWluvgRHW5zfYg6whmYLvpG+xVy1gNfS7sSGGUsJnECdn89Yg5udY=
X-Received: by 2002:a24:a81:: with SMTP id 123mr3183294itw.43.1553040247723;
 Tue, 19 Mar 2019 17:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190308184311.144521-1-surenb@google.com> <20190319225144.GA80186@google.com>
In-Reply-To: <20190319225144.GA80186@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 19 Mar 2019 17:03:56 -0700
Message-ID: <CAJuCfpE7hZVEmNFAa4PGjQhufbM3WHS1TSGr_xutGzGETygG9w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] psi: pressure stall monitors v5
To:     Minchan Kim <minchan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 3:51 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Mar 08, 2019 at 10:43:04AM -0800, Suren Baghdasaryan wrote:
> > This is respin of:
> >   https://lwn.net/ml/linux-kernel/20190206023446.177362-1-surenb%40google.com/
> >
> > Android is adopting psi to detect and remedy memory pressure that
> > results in stuttering and decreased responsiveness on mobile devices.
> >
> > Psi gives us the stall information, but because we're dealing with
> > latencies in the millisecond range, periodically reading the pressure
> > files to detect stalls in a timely fashion is not feasible. Psi also
> > doesn't aggregate its averages at a high-enough frequency right now.
> >
> > This patch series extends the psi interface such that users can
> > configure sensitive latency thresholds and use poll() and friends to
> > be notified when these are breached.
> >
> > As high-frequency aggregation is costly, it implements an aggregation
> > method that is optimized for fast, short-interval averaging, and makes
> > the aggregation frequency adaptive, such that high-frequency updates
> > only happen while monitored stall events are actively occurring.
> >
> > With these patches applied, Android can monitor for, and ward off,
> > mounting memory shortages before they cause problems for the user.
> > For example, using memory stall monitors in userspace low memory
> > killer daemon (lmkd) we can detect mounting pressure and kill less
> > important processes before device becomes visibly sluggish. In our
> > memory stress testing psi memory monitors produce roughly 10x less
> > false positives compared to vmpressure signals. Having ability to
> > specify multiple triggers for the same psi metric allows other parts
> > of Android framework to monitor memory state of the device and act
> > accordingly.
> >
> > The new interface is straight-forward. The user opens one of the
> > pressure files for writing and writes a trigger description into the
> > file descriptor that defines the stall state - some or full, and the
> > maximum stall time over a given window of time. E.g.:
> >
> >         /* Signal when stall time exceeds 100ms of a 1s window */
> >         char trigger[] = "full 100000 1000000"
> >         fd = open("/proc/pressure/memory")
> >         write(fd, trigger, sizeof(trigger))
> >         while (poll() >= 0) {
> >                 ...
> >         };
> >         close(fd);
> >
> > When the monitored stall state is entered, psi adapts its aggregation
> > frequency according to what the configured time window requires in
> > order to emit event signals in a timely fashion. Once the stalling
> > subsides, aggregation reverts back to normal.
> >
> > The trigger is associated with the open file descriptor. To stop
> > monitoring, the user only needs to close the file descriptor and the
> > trigger is discarded.
> >
> > Patches 1-6 prepare the psi code for polling support. Patch 7 implements
> > the adaptive polling logic, the pressure growth detection optimized for
> > short intervals, and hooks up write() and poll() on the pressure files.
> >
> > The patches were developed in collaboration with Johannes Weiner.
> >
> > The patches are based on 5.0-rc8 (Merge tag 'drm-next-2019-03-06').
> >
> > Suren Baghdasaryan (7):
> >   psi: introduce state_mask to represent stalled psi states
> >   psi: make psi_enable static
> >   psi: rename psi fields in preparation for psi trigger addition
> >   psi: split update_stats into parts
> >   psi: track changed states
> >   refactor header includes to allow kthread.h inclusion in psi_types.h
> >   psi: introduce psi monitor
> >
> >  Documentation/accounting/psi.txt | 107 ++++++
> >  include/linux/kthread.h          |   3 +-
> >  include/linux/psi.h              |   8 +
> >  include/linux/psi_types.h        | 105 +++++-
> >  include/linux/sched.h            |   1 -
> >  kernel/cgroup/cgroup.c           |  71 +++-
> >  kernel/kthread.c                 |   1 +
> >  kernel/sched/psi.c               | 613 ++++++++++++++++++++++++++++---
> >  8 files changed, 833 insertions(+), 76 deletions(-)
> >
> > Changes in v5:
> > - Fixed sparse: error: incompatible types in comparison expression, as per
> >  Andrew
> > - Changed psi_enable to static, as per Andrew
> > - Refactored headers to be able to include kthread.h into psi_types.h
> > without creating a circular inclusion, as per Johannes
> > - Split psi monitor from aggregator, used RT worker for psi monitoring to
> > prevent it being starved by other RT threads and memory pressure events
> > being delayed or lost, as per Minchan and Android Performance Team
> > - Fixed blockable memory allocation under rcu_read_lock inside
> > psi_trigger_poll by using refcounting, as per Eva Huang and Minchan
> > - Misc cleanup and improvements, as per Johannes
> >
> > Notes:
> > 0001-psi-introduce-state_mask-to-represent-stalled-psi-st.patch is unchanged
> > from the previous version and provided for completeness.
>
> Please fix kbuild test bot's warning in 6/7
> Other than that, for all patches,

Thanks for the review!
Pushed v6 with the fix for the warning: https://lkml.org/lkml/2019/3/19/987
Also fixed a bug introduced in https://lkml.org/lkml/2019/3/8/686
which I discovered while testing (description in the changelog of the
new patchset).

>
> Acked-by: Minchan Kim <minchan@kernel.org>
