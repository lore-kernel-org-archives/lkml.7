Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C27DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDAE20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=indeed.com header.i=@indeed.com header.b="oZO5Y0/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfE1WZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:25:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37129 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfE1WZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:25:49 -0400
Received: by mail-it1-f194.google.com with SMTP id s16so417376ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9EQwLvAO9oXFChsQAamKMxe068zBhP/svdhcV040aU=;
        b=oZO5Y0/DQnUWbpFkchPEk+KHgUZmbFsV53HDF5Y2snBl8sfk23OBpMHuYhiQnjogbn
         Pypla7gFHvnyePY6+WprzNqKLk3FagutRMWa9TFsABvcrJGecUYKfDQk8MBHawwtWdLt
         nT+OHEv2XEM1YDavmsCLBLsIK2pCcvpfcsM94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9EQwLvAO9oXFChsQAamKMxe068zBhP/svdhcV040aU=;
        b=OahAtWE63PTwz/RXlUwmSv71pCdqOFXzvgoYzQ9eKdpW+IUK4Rk6Qj6wEROBy0qOX9
         XUIyX6TRjkzhkubWtqcAFt9jWJR2BgFo5EVeva7Wj6/MlJB4T2yJYds6lNF+z1LclTKn
         LLH67z635Qp+xfD7G7RDuS/hz9cGotYiM2yLVCScIbmlqkoF+aBzIwsTfx/ajuCFC4J9
         spdhRWAX2gCcuZQPIuKVO7dWD4K4fki5Jgxjqr2eNlz9TBQgdVsL1zz1QYHXtR/ruR6F
         M5GKJB3Bw7yp8/RwSaD3jNoCOZ0SPn3UYImqwAtOFO+4xkpFvfAC8vv1e8KX+afnWjZ4
         TFzA==
X-Gm-Message-State: APjAAAVEotD1kh+1lrUcQfHYnPKYt6jCbRdJTJKrGyBv11Ypax237oxo
        K8djqbFDApCYB+Qzr7b3Hr2NE4xMtnKGma8H4zZShw==
X-Google-Smtp-Source: APXvYqwjrxpOFdzc5YSwWMqBJZhisJgsSpvWXZgotkxIyikt6pPN38HtmxmJRw/90O11/yml8aEQ+U4Iies2fr6ATd8=
X-Received: by 2002:a24:680c:: with SMTP id v12mr4820680itb.67.1559082348194;
 Tue, 28 May 2019 15:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-2-git-send-email-chiluk+linux@indeed.com>
 <CAFTs51W0KdK4nw6wydn2HjNYvFRC8DYMmVeKX9FAe+4YUGEAZg@mail.gmail.com>
 <20190524143204.GB4684@lorien.usersys.redhat.com> <CAC=E7cXxsyMLw1PR+8QchTH8FYL7WX6_8LBVdqueR1yjW+VVkQ@mail.gmail.com>
 <CAFTs51Vm258CkDXi_Jj_cGOMotTvhdYR_VW8aUwAUvgistZOFQ@mail.gmail.com>
 <CAC=E7cXVrGRKMNkJPhd4fJi7wgdYk=YcXPV7B8GVNL5M69BarQ@mail.gmail.com> <CAFTs51VhpDk9iW5UT62CkPCN3SjgUHHO1nVqhe+ssHMYqou6Bg@mail.gmail.com>
In-Reply-To: <CAFTs51VhpDk9iW5UT62CkPCN3SjgUHHO1nVqhe+ssHMYqou6Bg@mail.gmail.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Tue, 28 May 2019 17:25:22 -0500
Message-ID: <CAC=E7cVrLFDOm3uNQ_45DzmMVJ_i9bNvjsi7yRPaPe0HcaykUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched/fair: Fix low cpu usage with high throttling
 by removing expiration of cpu-local slices
To:     Peter Oskolkov <posk@posk.io>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ben Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 5:07 PM Peter Oskolkov <posk@posk.io> wrote:
> Linux CPU scheduling tail latency is a well-known issue and a major
> pain point in some workloads:
> https://www.google.com/search?q=linux+cpu+scheduling+tail+latency
>
> Even assuming that nobody noticed this particular cause
> of CPU scheduling latencies, it does not mean the problem should be waved
> away. At least it should be documented, if at this point it decided that
> it is difficult to address it in a meaningful way. And, preferably, a way
> to address the issue later on should be discussed and hopefully agreed to.

Pursuing reducing tail latencies for our web application is the
precise reason I created this patch set.  Those applications that
previously were responding in 20ms 95% where now taking 220ms.  Those
were correctly sized applications prior to 512ac999. After which, they
started seeing massive increases in their latencies  due to hitting
throttling with lower than quota amounts of cpu usage.

I'll see if I can rework the documentation.  Any specific
suggestions for how that can be worded would be appreciated.
