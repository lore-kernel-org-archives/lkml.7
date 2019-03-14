Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26345C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B802087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+3v5zMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfCNQjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:39:23 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55292 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfCNQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:39:23 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so5705915itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdPxKhSCPORUgKyJSeR7Of9rvDzrHujfXr7KWt38S/M=;
        b=o+3v5zMk+4V0e6/vcNI7mhuX+nPbwBnW1vymJKSlDI78SxCqx7IAUjwCOTaZqzNOlY
         pF1atKo6di+/ifEOAB2cpfP6dmJkKTYnqv2sWPkkhKKwogxdmeb/TNIL8GzcJtYb9atV
         /tyx5ZGQ5bvu9kUqz61SpjSqdv7TtO/w1TZyG0gZ6PmL4XkQ9nzaEhGxkJWqoliq9+1V
         GheXSppBkze6/pXXjoeazEcO2JLgagq3mKAEOyBqNVBrIQgZ1QnG3Cx/lw5xoxxLK782
         eAU6ObIjHkH4+fPxq15N3vOgqDswtYK5mzah5zHWW2yMrYkWUyvf7d5gwdZ6D/nkUdwU
         TNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdPxKhSCPORUgKyJSeR7Of9rvDzrHujfXr7KWt38S/M=;
        b=t7ESfyjSWYdixEwiWd/291neiguL/BzBMZBIZwWQv9LzD+bplrBl1j+e/qy+EDqfOx
         scI58XqyISWEcoxWomH2u0SJbps4elI/ZApmHO/Cg5ZbtnQMJW3D95dUau/5IkJeufoD
         iCBMZiThM2ZGzGTNjKIDRzfGe5E1OmUzbyd4KT0omRwy+2rq/sU78eVAIn+Q7gB0JamB
         nRZtnQWnsFGLiS/CVIHCzq6U9GkmSNaZNN8hFfppqfrX+ANvxuUa+pt8ZVna7n9IWpVu
         0vwTrVBjBcsaiCmRQGMR+q/pER+3M9qNpQ5nNTb5S55yi/FnbbJJxhH2GQGiwMa7qTjD
         qN/w==
X-Gm-Message-State: APjAAAW0Vh5ZV3wvOw3P6wvKmIhGf4SUARGzSOf9XNRsAoD/G/S0Q0Bf
        T6KLlbzWYo0F0v4pJIL665ZEN75CWCh1iifNOFCERw==
X-Google-Smtp-Source: APXvYqztkSCBWvbKVl91mTK5YOowxSpMrLgHSQhGznWDGqgcW1h3aiM6g2eLjrjugWcVf44PDU0MlFkd7O292RhT7nI=
X-Received: by 2002:a24:dd82:: with SMTP id t124mr2814312itf.102.1552581561557;
 Thu, 14 Mar 2019 09:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com> <CAJuCfpGAZ6XxJj=e-wVzGx3zmRRLPs=wXm8K0BcjWOm5hM0FcQ@mail.gmail.com>
 <20190314144600.2ulpeipad7jbxyiy@e110439-lin> <CAJuCfpFDVi7O+yqQ+F0DT3pRZN=BtRD8NyUH5Tys0VVkd9JAGg@mail.gmail.com>
 <20190314154052.345v74snhtc4cqbe@e110439-lin>
In-Reply-To: <20190314154052.345v74snhtc4cqbe@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Mar 2019 09:39:09 -0700
Message-ID: <CAJuCfpEWCcWj=B2SPai2pQt+wcjsAhEfVV1O+H0A+_fqLCnb8Q@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets refcounting
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 8:41 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 14-Mar 08:29, Suren Baghdasaryan wrote:
> > On Thu, Mar 14, 2019 at 7:46 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > > On 13-Mar 14:32, Suren Baghdasaryan wrote:
> > > > On Fri, Feb 8, 2019 at 2:06 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> [...]
>
> > > > > The rq::uclamp::bucket[clamp_id][] array is scanned every time we need
> > > > > to find a new MAX aggregated clamp value for a clamp_id. This operation
> > > > > is required only when we dequeue the last task of a clamp bucket
> > > > > tracking the current MAX aggregated clamp value. In these cases, the CPU
> > > > > is either entering IDLE or going to schedule a less boosted or more
> > > > > clamped task.
>
> The following:
>
> > > > > The expected number of different clamp values, configured at build time,
> > > > > is small enough to fit the full unordered array into a single cache
> > > > > line.
>
> will read:
>
> The expected number of different clamp values, configured at build time,
> is small enough to fit the full unordered array into a single cache
> line for the default UCLAMP_BUCKETS configuration of 7 buckets.

I think keeping default to be 5 is good. As you mentioned it's a nice
round number and keeping it at the minimum also hints that this is not
a free resource and the more buckets you use the more you pay.
Documentation might say "to fit the full unordered array into a single
cache line for configurations of up to 7 buckets".

> [...]
>
> > Got it. From reading the documentation at the beginning my impression
> > was that whatever value I choose within allowed 5-20 range it would
> > still fit in a cache line. To disambiguate it might be worse
> > mentioning that this is true for the default value or for values up to
> > 7. Thanks!
>
> Right, I hope the above proposed change helps to clarify that.
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
