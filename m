Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB88C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 04:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19582133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 04:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEVkss6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfJBE7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 00:59:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41385 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfJBE7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 00:59:54 -0400
Received: by mail-io1-f67.google.com with SMTP id n26so25437602ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 21:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utqwTvRLyjSsVfZRkt/xO+q4bNl5CsJkNoufFxflxJQ=;
        b=oEVkss6VR+9MCsjpkKg1eW3moidaorvQjMfZN1aobBTuZpUSiliyZAD/ZB+LSjwIzx
         ffJcXnSgJUT6H0k5VHNZ8N0lAqZTbi+fmGXl1utWTFytCzdYlsCJfaCKQiHMCWa3jbD/
         HrmS9VKmNkxVQ3WvL5HS7dGXRTvtKi+Pn4ejI9bscexXo9IjPo9FfiiZNmwCoL7uWpiE
         3EIqDGN7ic+YN6gruIZhX3E2bGkGijDJxJ1YZwQHkPyE2tbdAS5ZUKUNO2Knw+uAkba+
         Pi+IOwyNQJGwJMIJmh2CvkWbUL8J/ILcEGUo/IeaaUHYG/ZHyg2Z6VcRhkHylVPJcl76
         w+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utqwTvRLyjSsVfZRkt/xO+q4bNl5CsJkNoufFxflxJQ=;
        b=WFaiZP60qQfj9ftGOtYpc95wYSgSQQaZXadYINjH0v6WTbhiJEi332sDgck70+ScIp
         +RFahhCbr05Zf8AnZFNXcfHZUu1Iayi0Hyz5fz7yUBgACLrPkobasRFVeCkX+hSwG4ul
         KYJe+ERcoOS1+PLJy2SdejOJJ6KiQBXgVrkJlIrzfsR685+FmepOV3RO87+R35PLT2ev
         97yCNNWWF7kW5pgI47B51GCPeNKShIxfCOpWiQ6FNKbMr3svX33d5dukPPRrsbLbu4oy
         9AVr1TpqVWDDbrTOKkx+DEXl9XrtzYxtl/7jt2in7xtRIHC6bgqZ386svHSfsydFBOr+
         wXQQ==
X-Gm-Message-State: APjAAAWuQLXW7+7NbfP8uCWOjVU6/o/ATNGbI6wGr1oH8eIK8IBkXqw6
        GM4TrJ8HlyO6Ba4jtLTbeWo7EWm1y45hGiNAgeU=
X-Google-Smtp-Source: APXvYqx06rpxC7ziYaQbDjJwNP8n17yaCIyqxnU/Wrn7tsZo+KpOiuVAlHvBbHJp0PTPCVEpajAbIk+YHTgN7/i1XLQ=
X-Received: by 2002:a92:4a11:: with SMTP id m17mr1998877ilf.142.1569992393636;
 Tue, 01 Oct 2019 21:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <1569899984-16272-1-git-send-email-laoar.shao@gmail.com> <20191001144524.GB3321@techsingularity.net>
In-Reply-To: <20191001144524.GB3321@techsingularity.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 2 Oct 2019 12:59:14 +0800
Message-ID: <CALOAHbCCGhxtnpsc7par1K0dDO4HANh6W_X4_5fTDDKwpPkkWw@mail.gmail.com>
Subject: Re: [PATCH v2] perf script python: integrate page reclaim analyze script
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     tonyj@suse.com, acme@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Tony Jones <tonyj@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 10:45 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Sep 30, 2019 at 11:19:44PM -0400, Yafang Shao wrote:
> > A new perf script page-reclaim is introduced in this patch. This new script
> > is used to report the page reclaim details. The possible usage of this
> > script is as bellow,
> > - identify latency spike caused by direct reclaim
> > - whehter the latency spike is relevant with pageout
> > - why is page reclaim requested, i.e. whether it is because of memory
> >   fragmentation
> > - page reclaim efficiency
> > etc
> > In the future we may also enhance it to analyze the memcg reclaim.
> >
>
> Hi,
>
> I ended up not reviewing this patch in detail simply because I would
> approach the same class of problem in an entirely different way today.
> There is value in accumulating the stats in a report like this;
>
> >     $ perf script report page-reclaim
> >     Direct reclaims: 4924
> >     Direct latency (ms)        total         max         avg         min
> >                         177823.211    6378.977      36.114       0.051
> >     Direct file reclaimed 22920
> >     Direct file scanned 28306
> >     Direct file sync write I/O 0
> >     Direct file async write I/O 0
> >     Direct anon reclaimed 212567
> >     Direct anon scanned 1446854
> >     Direct anon sync write I/O 0
> >     Direct anon async write I/O 278325
> >     Direct order      0     1     3
> >                  4870    23    31
> >     Wake kswapd requests 716
> >     Wake order      0     1
> >                 715     1
> >
> >     Kswapd reclaims: 9
>
> However, the basic option I would prefer is having the raw latency
> information for Direct latency that can be externally parsed by R or any
> other statistical method. The reason why is because knowing the max latency
> is not enough, I'd want to know the spread of latencies and whether they
> were clustered at a point of time or spread out over long periods of
> time. I would then build the higher-level reports on top if necessary.
>
> Today, I would also have considered getting the latency figures using eBPF
> or systemtap instead although having perf do it may be useful too. That's
> not universally popular though so at minimum I would have;
>

eBPF requires newer kernel, while there're still lots of servers
running with old kernels.
The systemtap is not convenient as it requires many debug packages,
and it is still not stable enough to run on the product environment,
for example, the systemtap deamon may exit without uninstalling the
systemtap kernel module.

> perf script record page-reclaim -- capture all page-reclaim tracepoints
> perf script report page-reclaim -- For reclaim entry/exit, merge the two
>         tracepoints into one that reports latency. Dump the rest out
>         verbatim
>
> For latencies, I would externally post-process them until such time as I
> found a common class of bug that needed a high-level report and then
> build the perf script support for it.
>

This seem like a good suggestion.
I will try to think about it.

> Please note that I did not spot anything wrong with your script, it's
> just that I would not use it myself in its current format for debugging
> a reclaim-related problem.
>
> --
> Mel Gorman
> SUSE Labs
