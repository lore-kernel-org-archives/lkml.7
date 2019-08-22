Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9C6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE523426
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqcGQimE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389367AbfHVUY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:24:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46194 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbfHVUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:24:28 -0400
Received: by mail-vs1-f68.google.com with SMTP id x20so4501910vsx.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzzTZzNkI7zV82e37gNp8wJsL5VSFkKIKsTyscFR6Tw=;
        b=PqcGQimE75OmNZ5Ta81LevfkQwVCZPgSClh1IEqtFe9OA/99yXwvxa/tq+r/MVe06y
         ttuw9ifAvWw5d6kiAK3Li5qglS2KzIlImd6uC3dsOtVL7ADqqP2Evw/en3aMazYKdwYJ
         np+afo0/w6idFS9yUDId2JTKACZ1qd/r3+RiJywE6S0vyIsbQkdZ7b8qm1V2uU+gayPA
         j2G+BkL/zzJ7/C4WIzdkl03PFQrsrzAEkNXPRcKNN81nEJokenvh4p/zX2QfLw27TYL6
         sMeCkCaBOS4Qgt6p80Xl0gfruKsLVJ47s2ZOmY/t603idGGS1zO/V2G4cu0ona9zVrs0
         BFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzzTZzNkI7zV82e37gNp8wJsL5VSFkKIKsTyscFR6Tw=;
        b=nKRXcj8y1iBQ/xKllAUBegIYwE0QmfhKh18vVxC6lIJa7huOfFvkCWlfQLjFUj+vRM
         awpm7N+oddlRKwIUdJGkIN6O5vjhvc1VJnejHQWVLn3yMGW4rc1KTTG36PAAsH90hkf1
         rxzafm2gxWyW7m3zCyfqaWj4Q5qLMA/gExQel9V6LItuVrDdsefPKT0DpY/YiuCjLcux
         sJk6CkjKXPvI3FDgy2efWBczyBpLHsWjq4LpK12uuo79o6fKYktodK74rGAZQCknfCzg
         YmcMlycqrGx4fACY+O4pM/UO9rLfngdu26Vyad30iBJbXtBvmm/fdk5pGP4UxPjlFazp
         3/cQ==
X-Gm-Message-State: APjAAAUcHxFs5O2b0N5oezQ1+cvhoF6Ye138AVyNQQMXMXGMRFnJdkxf
        VQfSLzVFKpskbH+zORIqSBt7XhlpMvduL18yA0nFhQ==
X-Google-Smtp-Source: APXvYqzwR3Hoj6aRjCbuxBynX89N/VTml5VSE4RdSXs3dO5yLc9vUzidd3K3Brm25b0GM+g/X6nhqhN454sNZFN3Opw=
X-Received: by 2002:a67:be15:: with SMTP id x21mr670078vsq.142.1566505467495;
 Thu, 22 Aug 2019 13:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190813224620.31005-1-dave@stgolabs.net> <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com> <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
In-Reply-To: <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 22 Aug 2019 13:24:15 -0700
Message-ID: <CANN689H0qtpi8ZH7rxUWAVaDVdSxtaPbuQ3KL2JgXLUCX4dWmQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 9:49 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> On Wed, 21 Aug 2019, Michel Lespinasse wrote:
> >I'm not sure where to go with this - would it make sense to add a new
> >interval tree header file that uses [start,end) intervals (with the
> >thought of eventually converting all current interval tree users to it)
> >instead of adding one more use of the less-natural [start,last]
> >interval trees ?
>
> It might be the safest way, although I really hate having another
> header file for interval_tree... The following is a diffstat of a
> tentative conversion (I'll send the patch separately); I'm not sure
> if a single shot conversion would be acceptable, albeit with relevant
> maintainer acks.

That would make sense to me. Maybe doing it all in a single commit is
too hard to review or bisect, but having a small series that
duplicates the interval tree header at the start and removes the old
(closed intervals) version at the end looks like it would work IMO.

> >At first, I thought that you were handling that by removing 1 from the
> >end of the interval, to adjust between the PAT and interval tree
> >definitions. But, I don't see you doing that anywhere.
>
> This should have been my first approach.
>
> >Then, I thought that you were using [start, end( intervals everywhere,
> >and the interval tree functions memtype_interval_iter_first and
> >memtype_interval_iter_next would just return too many candidate
> >matches as as you are passing "end" instead of "last" == end-1 as the
> >interval endpoint, but then you would filter out the extra intervals
> >using is_node_overlap(). But, if that is the case, then I don't
> >understand why you need to redefine is_node_overlap() here.
>
> My original expectation was to actually remove a lot more of pat_rbtree,
> including the is_node_overlap() and the filtering. Yes, I think this can
> be done if the interval-tree is converted to [a,b[ and we can thus
> just iterate the tree seamlessly.

All right. So, my preference would be if we can use a version of
interval trees that would work natively with half open intervals, as
we discussed above. But, if that seems like too much change, I would
also be ready to approve a version of pat_interval.c that would adjust
the interval endpoint to compensate for the interval tree's use of
closed intervals. I think either way, I can't approve the current
version as it's too much of an in-between which makes it hard to
follow IMO.

> I think doing the conversion you suggested to [a,b[ for all users, then
> redoing this series on top of that would be the way to move forward.

That would be ideal; hopefully you don't see the vma_interval_tree
thing as blocking this approach ?

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
