Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE1C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4226920850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEZV1zpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfENSHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:07:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46189 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfENSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:07:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so8998920pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqed65o+00TUEDfhl5S4jemqONUpRuqUUbQE+V6VwOg=;
        b=ZEZV1zpt4zoI3zCOkldM9cVVQHl+agll74+rv4+8x9K0wng4dHFAuTFSL9odqftmTj
         mL11PwG53KbrFYgsU9os7GEDrRO3aNoteyJBtfiRX3g61jXch01X/Bs6+AXI514WpeoG
         +1eXJewmhWMJ15BPPJ+t/gN/uRqFDVQJHqhBnqBoEbbqz/v7jyzHMaGt8DFrGTDuVzji
         1PLVObBeo8DfVNfZ078He66tknyo2EE0O7zAskpWT0YvgJhy4s0k3Ik40G04xwQijHWu
         KXpORUKZQ5Wxad0M3ZFvRPkOBbeAk5gR07DAum7c+n2N0rWdUVDjElFbm4l/VisvoVL1
         thyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqed65o+00TUEDfhl5S4jemqONUpRuqUUbQE+V6VwOg=;
        b=BfenpqpHihig+AuF37Re8WlxvfhAJnmWk/0jIYxlwQ1GAwNmnOR56rNUZH21CH9tOs
         7L5DdcoR4fMixCJj4qhUoGJXTxVGGBdc3W1udTcuSE6PuqaD2QjjqH9jBtltSP3arxBm
         SPzJY+0vzBR75K4ckUOII9ZiZd7pAcoK6FpjN5A1/C2AM0Nqcn2jxCYD46AmWYCOek4H
         uoT99Ve/Lxba2/3wGJOmRETX86D/tQ0z45U3tJu+IERMe6xEQdKsAh/Wacut8w5D+ues
         R4FluQq9W17el6mRzSz2KNxJ3TkpAJTvj7B7DQApVqRX/CaIkpTBhCQKERtVCxUQd5JU
         W6lA==
X-Gm-Message-State: APjAAAVsDwIoETMAZrhfC9Gfg6P90evczyx7OsKs8DBEZLeIlfKdk2pF
        8yZ473eruos0qIMICDyhSYmew9nM+Ufnhr40jUM=
X-Google-Smtp-Source: APXvYqzJqyvFiaKm/wPBr+hvYK+HHRtZqWpfm/nvGfRcq9AIPHKUJ/CeE9/QHGJ2MDuThim0D4rn+4G+P5yvXldohJA=
X-Received: by 2002:a62:75d8:: with SMTP id q207mr10192507pfc.35.1557857220504;
 Tue, 14 May 2019 11:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190514002747.7047-1-xiyou.wangcong@gmail.com> <20190514123213.GR2589@hirez.programming.kicks-ass.net>
In-Reply-To: <20190514123213.GR2589@hirez.programming.kicks-ass.net>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 14 May 2019 11:06:49 -0700
Message-ID: <CAM_iQpX1PTqUqMWfa+LvTPpT85jCJu-LNanyoxM2nCvzPNaCpg@mail.gmail.com>
Subject: Re: [RFC Patch] perf_event: fix a cgroup switch warning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 5:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 13, 2019 at 05:27:47PM -0700, Cong Wang wrote:
> > We have been consistently triggering the warning
> > WARN_ON_ONCE(cpuctx->cgrp) in perf_cgroup_switch() for a rather
> > long time, although we still have no clue on how to reproduce it.
> >
> > Looking into the code, it seems the only possibility here is that
> > the process calling perf_event_open() with a cgroup target exits
> > before the process in the target cgroup exits but after it gains
> > CPU to run. This is because we use the atomic counter
> > perf_cgroup_events as an indication of whether cgroup perf event
> > has enabled or not, which is inaccurate, illustrated as below:
> >
> > CPU 0                                 CPU 1
> > // open perf events with a cgroup
> > // target for all CPU's
> > perf_event_open():
> >   account_event_cpu()
> >   // perf_cgroup_events == 1
> >                               // Schedule in a process in the target cgroup
> >                               perf_cgroup_switch()
> > perf_event_release_kernel():
> >   unaccount_event_cpu()
> >   // perf_cgroup_events == 0
> >                               // schedule out
> >                               // but perf_cgroup_sched_out() is skipped
> >                               // cpuctx->cgrp left as non-NULL
>
>                                 which implies we observed:
>                                 'perf_cgroup_events == 0'
>
> >                               // schedule in another process
> >                               perf_cgroup_switch() // WARN triggerred
>
>                                 which implies we observed:
>                                 'perf_cgroup_events == 1'
>
>
> Which is impossible. It _might_ have been possible if the out and in
> happened on different CPUs. But then I'm not sure that is enough to
> trigger the problem.

Good catch, but this just needs one more perf_event_open(),
right? :)


>
> > The proposed fix is kinda ugly,
>
> Yes :-)
>
> > Suggestions? Thoughts?
>
> At perf_event_release time, when it is the last cgroup event, there
> should not be any cgroup events running anymore, so ideally
> perf_cgroup_switch() would not set state.
>
> Furthermore; list_update_cgroup_event() will actually clear cpuctx->cgrp
> on removal of the last cgroup event.

Ah, yes, this probably explains why it is harder to trigger than I expected.


>
> Also; perf_cgroup_switch() will WARN when there are not in fact any
> cgroup events at all. I would expect that WARN to trigger too in your
> scneario. But you're not seeing that?

Not sure if I follow you, but if there is no cgroup event, cgrp_cpuctx_list
should be empty, right?

From the stack traces I can't tell, what I can tell is that we use cgroup
events in most cases.


>
> I do however note that that check seems racy; we do that without holding
> the ctx_lock.

Hmm? perf_ctx_lock() is taken in perf_cgroup_switch(), so I think locking
is fine.

Thanks.
