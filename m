Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA4DC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2422D2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ELZQHqIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfJKLdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:33:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44392 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJKLdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:33:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id 21so7637693otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EG1xk3VNtSNli9LstHzFzW8FTASqppOx7Iz+ljSepr4=;
        b=ELZQHqIHKthcOw+cx1/eWMPQh9CdCQe9335QiwqnmEpfsAQo5QrXsB0uM8YeRn9sZB
         DMjCGOF3WmEWsych31ECult+qoZlba+l/4cFwD78LER9wjIOHHvdSaAoQTpzWJHDYhtC
         nMege7elWqUs3JbT4yQBVz2Ys2N8BBYj/kpU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EG1xk3VNtSNli9LstHzFzW8FTASqppOx7Iz+ljSepr4=;
        b=PoOiwXIlXk772ApLIv9R4Kt/BOS0Sx8RzdT/ay6wQwYkpMrNvtQFgbTfrQyRrYTKrf
         zxU8bM++ZSYzlsGSYyjVb8tYejhIrXHQLFui0WP43BbnTuVm08VeJtyktqwFIq6T7Mgo
         psoI0JKj4ihdLfGob4A1ekv4f2zDg3Qz9SS3N1nWCsPRTomPzS4Nkngcdzb8IMIGQpzS
         JJuzPvwYlrIvywBKE5BdXzUnEU5UK3d7WqqFEdcZ/i0Kg3vK/4+zapzREfdTJeqkLnpt
         jWcimCCOe8G3iaEWz2HgfMcJLddWUhzy/c21IvPCyTzxBy6P1MQ4E2pg2mphJRJnaopt
         NGcQ==
X-Gm-Message-State: APjAAAXpxQhLJXOgMhy8r9iCezgfYzNGkf1OIbqHeiv5OrfVNMuZvLoX
        SLmJAJvUUXutQ8v3zxum9GHWpCY+q0FMoEr3zLTdWQ==
X-Google-Smtp-Source: APXvYqw5w6rNknCRSIh4ji+Ht3aKeuI8BuQd38PdEiIXjfB/PVs7LMHEEfKLiC0nZxVBQwz9I2alMQcOdbdmP3o91cs=
X-Received: by 2002:a9d:70c3:: with SMTP id w3mr6065891otj.246.1570793579837;
 Fri, 11 Oct 2019 04:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com> <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com> <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu> <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
 <20191010135436.GA67897@aaronlu> <CANaguZDCtmXpm_rpTkjsfPPBscHCwz4u1OHwUt3XztzgLJa_jA@mail.gmail.com>
 <20191011073338.GA125778@aaronlu>
In-Reply-To: <20191011073338.GA125778@aaronlu>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 11 Oct 2019 07:32:48 -0400
Message-ID: <CANaguZCkKQTmgye+9nQhzQqYBrsnCmcjA46TPmLwN60vvMQ_7w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The reason we need to do this is because, new tasks that gets created will
> > have a vruntime based on the new min_vruntime and old tasks will have it
> > based on the old min_vruntime
>
> I think this is expected behaviour.
>
I don't think this is the expected behavior. If we hadn't changed the root
cfs->min_vruntime for the core rq, then it would have been the expected
behaviour. But now, we are updating the core rq's root cfs, min_vruntime
without changing the the vruntime down to the tree. To explain, consider
this example based on your patch. Let cpu 1 and 2 be siblings. And let rq(cpu1)
be the core rq. Let rq1->cfs->min_vruntime=1000 and rq2->cfs->min_vruntime=2000.
So in update_core_cfs_rq_min_vruntime, you update rq1->cfs->min_vruntime
to 2000 because that is the max. So new tasks enqueued on rq1 starts with
vruntime of 2000 while the tasks in that runqueue are still based on the old
min_vruntime(1000). So the new tasks gets enqueued some where to the right
of the tree and has to wait until already existing tasks catch up the
vruntime to
2000. This is what I meant by starvation. This happens always when we update
the core rq's cfs->min_vruntime. Hope this clarifies.

> > and it can cause starvation based on how
> > you set the min_vruntime.
>
> Care to elaborate the starvation problem?

Explained above.

> Again, what's the point of normalizing sched entities' vruntime in
> sub-cfs_rqs? Their vruntime comparisons only happen inside their own
> cfs_rq, we don't do cross CPU vruntime comparison for them.

As I mentioned above, this is to avoid the starvation case. Even though we are
not doing cross cfs_rq comparison, the whole tree's vruntime is based on the
root cfs->min_vruntime and we will have an imbalance if we change the root
cfs->min_vruntime without updating down the tree.

Thanks,
Vineeth
