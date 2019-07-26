Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6022DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3333C2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMVDkJlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfGZIln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:41:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33315 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGZIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:41:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so50700455ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7EFyiVoAKYLUOQdsI4eTJ9Ot1vYseeR5ebayqXHG5o=;
        b=cMVDkJltMdeWRKf0oHGucAkB1LBfIentse70S5BhQqsWUsYu4BYjFv9OU+80oypNWx
         FZtshzFy4o8TCiMyX3v0aqD1OEL+PCAVxJT4e70RO+JIuOGZk9IrFl6/aVXJAcn0S36z
         mjuDrct0C1tZjxKRn1LN7JC+f1zSDkJRNH38fpaefn05a9ci6pO/xPeoF/bKqKZ/2eE7
         gGmWW8ZeQAHgRSdcFGy/PIuYK5VuPSb2292ydDshIweNuOqeDqPpE751O1O1h1dCwlwd
         sJLOySU+DfodCI6YEmj6zGpPIv69lPPhTs6jAkr7J1OD7iElvcCAfabjQlX+Zkjn5l8X
         9qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7EFyiVoAKYLUOQdsI4eTJ9Ot1vYseeR5ebayqXHG5o=;
        b=DJIQ4++GaZmVex7QsEsVDlZPfv5WlDB1oj26kXOTByshFspqGEs/IhrxMhxJsQ7OYf
         WjKp6BhJ44JNtYhO/upgZOCX+vNlvzSsfJNwnrfkaoV/RU1Rz+aTXSaSBFGgPnrmLwbC
         uEhoMuJO+rs0qgZsJTpEt4qYZxhy+h7HwhtLU1+hoobM8nGFhVx5CzfmLsxUH8bfsOrw
         BiWbdnXRua6n08/a4WGjp/uYUu+KRaEmfqT0hvv+wsDnEwzfKJfOYsV7CTv3IdfACiuW
         rm0/EiQYYDFA3emeN0F2las6foFWZn5Txuu+dW6fC/AQNnvEj0XO49SV0cMCNk1ocLuL
         lJPg==
X-Gm-Message-State: APjAAAXOCwF5pFElWynj6wgHt10F4DkKk8XzkTK1aPRK/RC04LjSE7qN
        UqaPGwNGo7URidBph7p2hMGUS8dpVQqPCOTuBmV+K8oX
X-Google-Smtp-Source: APXvYqwlvW4gbGo7csbwUfIEw9rxla+Q7cKqB1bGUhKDdoWAL5j8ZxxRGNJn1mFtm2rgte0PYkdLaMyNNld79gglNDA=
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr47585684ljk.219.1564130501331;
 Fri, 26 Jul 2019 01:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-3-git-send-email-vincent.guittot@linaro.org> <20190726021745.GA7168@linux.vnet.ibm.com>
In-Reply-To: <20190726021745.GA7168@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 26 Jul 2019 10:41:30 +0200
Message-ID: <CAKfTPtATBXgp47=gv=yVQ0rox9qr1H3DOXCSngmcZvAmqt-GTg@mail.gmail.com>
Subject: Re: [PATCH 2/5] sched/fair: rename sum_nr_running to sum_h_nr_running
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 04:17, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2019-07-19 09:58:22]:
>
> > sum_nr_running will track rq->nr_running task and sum_h_nr_running
> > will track cfs->h_nr_running so we can use both to detect when other
> > scheduling class are running and preempt CFS.
> >
> > There is no functional changes.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> >       ld_moved = 0;
> > -     if (busiest->nr_running > 1) {
> > +     if (busiest->cfs.h_nr_running > 1) {
>
> We should be looking for nr_running here.
> There could be only one cfs task but that may not be the current running
> task, so it could be a good one to be picked for load balancing.
>
> No?

Yes you're right.
That's what i have done on the new version that I'm preparing


>
> >               /*
> >                * Attempt to move tasks. If find_busiest_group has found
> >                * an imbalance but busiest->nr_running <= 1, the group is
> > --
> > 2.7.4
> >
>
> --
> Thanks and Regards
> Srikar Dronamraju
>
