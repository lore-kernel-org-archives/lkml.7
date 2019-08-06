Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F978C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531DB2147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1F9z/NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfHFG4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:56:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37831 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbfHFG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:56:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so27105938ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LtfrnrmeJu+Go6Owd6LtdZ7xnPTjhmP+HmRL6tcS9s=;
        b=a1F9z/NIt/UCpLAeuN9xTxaTaCiPdV5yij3843Zn6tupg4V9WjED1yi3aMBsuHRE6a
         QV5DGS6rGrxqAR46TGQejuIB60OCz3JNLTp3CGximAm/FzP0YBTWhlRvrF6ivBqdTWYR
         2LAAg1uxhRZaNZvrK80F7T8xi18UIS4XHVU5O51hcWx2nOOZEVG85MR/uDQ6W68xsQFm
         fp0S7tGrF88aDiSARLeXsiLx1u8ribOWVOaLvPsEuiK6BPK4RLqwmMjlFFDqkDr/vuvV
         D3RQ8/g8yV3I0thLX8BZOd4Ah3IDh8+8dntnK6lg5VkhZhHFFk131SGw/cRMRFM2uV4L
         QDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LtfrnrmeJu+Go6Owd6LtdZ7xnPTjhmP+HmRL6tcS9s=;
        b=rfTxrkgbiJ9fv8bJL2N2yFBkyu0Crinzxv9okXzIu97sxXOM/pWbLs5hgVgpjyuW+p
         fTmQ9YXNX6fHjDoM6gATgXr+M9/8lXnZnRFZqXiyaJ71Lo34S0J/LCmUUU6M7kwc/kBe
         nwOVdUIW5cJJU8UqDZhiHm4LxwPQxuiPVPbxM/y2IZ+sgcVnrxABuKVfrnYTF73rMSfg
         3jdZ9HSy54AX5TVI8YvaTDLU+oipf+q5IQOpGyHl6zWDUtwlVz0qAKO6Q3otCnmg12l9
         k1J9BuZRj5glzLhpejN1V1ca6W4yBliQA1InUuePYYgXf42TjsI+TSyX58Nndt407PXc
         8jtA==
X-Gm-Message-State: APjAAAUElQZwFed/wHTOLNXJwog+mFjaAtSXM1zDc9vKw0CuJ1MNujj1
        9nYkDt0GEcnuYYriQYAwFoeFB3G2dAxUjOuo3IQ=
X-Google-Smtp-Source: APXvYqyEQaB+69wRqcIhzJaBHjx2W0hmROv0fYJfI/k0/KyQ9yMucgSyVULNMqcFLhS1NFkEUX7iJs6tgQnArOBaodM=
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr950887ljk.70.1565074596324;
 Mon, 05 Aug 2019 23:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190613032246.GA17752@sinkpad> <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com> <20190806032418.GA54717@aaronlu>
In-Reply-To: <20190806032418.GA54717@aaronlu>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 6 Aug 2019 14:56:24 +0800
Message-ID: <CAERHkrtJ3f1ggfG7Qo-KnznGo66p0Y3E0sAfb3ki6U=ADT6__g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
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

On Tue, Aug 6, 2019 at 11:24 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On Mon, Aug 05, 2019 at 08:55:28AM -0700, Tim Chen wrote:
> > On 8/2/19 8:37 AM, Julien Desfossez wrote:
> > > We tested both Aaron's and Tim's patches and here are our results.
> > >
> > > Test setup:
> > > - 2 1-thread sysbench, one running the cpu benchmark, the other one the
> > >   mem benchmark
> > > - both started at the same time
> > > - both are pinned on the same core (2 hardware threads)
> > > - 10 30-seconds runs
> > > - test script: https://paste.debian.net/plainh/834cf45c
> > > - only showing the CPU events/sec (higher is better)
> > > - tested 4 tag configurations:
> > >   - no tag
> > >   - sysbench mem untagged, sysbench cpu tagged
> > >   - sysbench mem tagged, sysbench cpu untagged
> > >   - both tagged with a different tag
> > > - "Alone" is the sysbench CPU running alone on the core, no tag
> > > - "nosmt" is both sysbench pinned on the same hardware thread, no tag
> > > - "Tim's full patchset + sched" is an experiment with Tim's patchset
> > >   combined with Aaron's "hack patch" to get rid of the remaining deep
> > >   idle cases
> > > - In all test cases, both tasks can run simultaneously (which was not
> > >   the case without those patches), but the standard deviation is a
> > >   pretty good indicator of the fairness/consistency.
> >
> > Thanks for testing the patches and giving such detailed data.
>
> Thanks Julien.
>
> > I came to realize that for my scheme, the accumulated deficit of forced idle could be wiped
> > out in one execution of a task on the forced idle cpu, with the update of the min_vruntime,
> > even if the execution time could be far less than the accumulated deficit.
> > That's probably one reason my scheme didn't achieve fairness.
>
> I've been thinking if we should consider core wide tenent fairness?
>
> Let's say there are 3 tasks on 2 threads' rq of the same core, 2 tasks
> (e.g. A1, A2) belong to tenent A and the 3rd B1 belong to another tenent
> B. Assume A1 and B1 are queued on the same thread and A2 on the other
> thread, when we decide priority for A1 and B1, shall we also consider
> A2's vruntime? i.e. shall we consider A1 and A2 as a whole since they
> belong to the same tenent? I tend to think we should make fairness per
> core per tenent, instead of per thread(cpu) per task(sched entity). What
> do you guys think?
>

I also think a way to make fairness per cookie per core, is this what you
want to propose?

Thanks,
-Aubrey

> Implemention of the idea is a mess to me, as I feel I'm duplicating the
> existing per cpu per sched_entity enqueue/update vruntime/dequeue logic
> for the per core per tenent stuff.
