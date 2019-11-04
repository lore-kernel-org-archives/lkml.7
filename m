Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A757CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6116B218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jR5ue4pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfKDOzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:55:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37382 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:55:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id v2so17951428lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCB1Iq/WOhOO8E7BWFVL1ZTSBqLFoCfJ5l+QYe87RSo=;
        b=jR5ue4pDTreBeJb+rxWIZwdLLF777xKgDOUL4dR4Yh46AO+d24A9WJ4TQcGfBUPNWJ
         zFOFZHijuNpYLRn1VtGwNutUBOyQiamwbj+7Y+x+wuFnKajMqYPnJ8TVPlRBtJMAipP8
         904ukGmnfl0H45AaTREkCBuzRqQ5eemHc4P7R/Y/gFzf95RaQ7qIAkkIHsQTE+QeCZNB
         fWnUvzhiWYQXA3IIIqxLmAgz0gKfsynHoEkED3yOghotQ5660krja5MaANzH+0Ap5n0a
         BImN1Q76AcXT3L+9QLifWSDFbiOqvcs7M4ebKMyzg2RL8cXs4oEg1t1WiPG4pfXqJ8JY
         gHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCB1Iq/WOhOO8E7BWFVL1ZTSBqLFoCfJ5l+QYe87RSo=;
        b=DLk0t+E1kztRmOB0Y6j119q+kVNRI0EO06bCY8U8i7JXs1PvEoRecwqXC9QgTGGbnA
         hVmCDXh6ffMi5Sw29TH7lQmtigDyZiQ1xBQ+axkXBokMeqwEKKzIJ8xU5Xx/KXvIhIY9
         XVI90zm6mg2UvvpCl2ZYM3ZAlRs+dOdZUOAbk1OSIhjec3d4Cs3R7CUzZ+/CaeDMwZKn
         Iu02Un82HNHKfrqP+I8CVcJSCNe77Y0MCSXeG7NVgw06bxKwOfjofrWTFvor+tR8EVR+
         prIx3x5zFs3GxfhhIHji8ksJkPWZCf617G8ein5seiQKS0ASe6tpJFu2Oy7dIG0byssA
         CsKw==
X-Gm-Message-State: APjAAAXh0SIo7IUioqvYNbmGds0eiv3fSQMSIUYsj2qg9j3sn8zguHML
        fe4LYM2jUGaGC0kT55oU0qA0nDG3X11JSdXqZeHFIghUPXY=
X-Google-Smtp-Source: APXvYqy4UjcGCAnV3NNxfpUi5H8Np7E7A3YJjQ7q84uwikINYW2qpkeoGCQ0i5Qv5G8mhLtmREwtbBXVjm4Frr/PeFA=
X-Received: by 2002:a2e:9a08:: with SMTP id o8mr897412lji.214.1572879302296;
 Mon, 04 Nov 2019 06:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20191031184533.67118-1-joshdon@google.com>
In-Reply-To: <20191031184533.67118-1-joshdon@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Nov 2019 15:54:50 +0100
Message-ID: <CAKfTPtDeMevgn0JFxjzUWhp4dS10T2MQSA9P82nOGX73xUjXoA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Do not set skip buddy up the sched hierarchy
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Paul Turner <pjt@google.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Venkatesh Pallipadi <venki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 at 19:45, Josh Don <joshdon@google.com> wrote:
>
> From: Venkatesh Pallipadi <venki@google.com>
>
> Setting skip buddy all the way up the hierarchy does not play well
> with intra-cgroup yield. One typical usecase of yield is when a
> thread in a cgroup wants to yield CPU to another thread within the
> same cgroup. For such a case, setting the skip buddy all the way up
> the hierarchy is counter-productive, as that results in CPU being
> yielded to a task in some other cgroup.
>
> So, limit the skip effect only to the task requesting it.
>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 682a754ea3e1..52ab06585d7f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6647,8 +6647,15 @@ static void set_next_buddy(struct sched_entity *se)
>
>  static void set_skip_buddy(struct sched_entity *se)
>  {
> -       for_each_sched_entity(se)
> -               cfs_rq_of(se)->skip = se;
> +       /*
> +        * One typical usecase of yield is when a thread in a cgroup
> +        * wants to yield CPU to another thread within the same cgroup.
> +        * For such a case, setting the skip buddy all the way up the
> +        * hierarchy is counter-productive, as that results in CPU being
> +        * yielded to a task in some other cgroup. So, only set skip
> +        * for the task requesting it.
> +        */
> +       cfs_rq_of(se)->skip = se;
>  }

You should also update __clear_buddies_skip  to only clear this skip

>
>  /*
> --
> 2.23.0.700.g56cf767bdb-goog
>
