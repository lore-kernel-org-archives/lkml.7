Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EB4C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9302082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjhFS4fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDLUiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:38:20 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34039 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDLUiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:38:19 -0400
Received: by mail-yb1-f194.google.com with SMTP id a3so4113436ybr.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOEqioenipxbzm+7k35/3dZl524W3sMRWwsLbeTAQhk=;
        b=vjhFS4fOxo2Fj0LqIMr1LXlEtE5hGVVS4kg+kni9d0nYGWqXbVHBHSHDIq6HjqHVfK
         6/CW+MALCvXA2OOeNtACh91JZ2d7/8n7Nmk05bGR15WV91PMf6W15BncEgCrcgoFF8QN
         O7fLLfSLR0wLz07gnsUNyjy0216a+mO11nLfQxSY6N6pNAJaXHen01o7PZzJF0yPz/Nk
         QVfTDGoL7y78XALI4X+1XaMzIF7naI/6arE9XqfIOC4GxkYQncqS/CBoVSnnFuCdD78D
         iMGEN3gMLjo5XKLB91tkWEP9ATedoWxAYvi1q/zTbTQZt/BqpSFRYue4qJwPLPzU1/9Y
         /jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOEqioenipxbzm+7k35/3dZl524W3sMRWwsLbeTAQhk=;
        b=ZW4iQJK7MzADP6EDAk0lHmNFNmZtsfVVKliujllxOczuRr+4LWRWfapE0F+V8bIGFH
         wkIHRNQEQecxLy24M7DN4Fb1wU8qIPVZPGXDHTIB4eL2v2YxNqvsdGh+ff7U6Jkv9bbX
         SKGM3PYh+TncdtYnstYsnSDqCoTrnDPFqUNgUif9y+YAoi8UcM8NfdSL5ZtbwMRqvmtS
         ERkeZn9HaUWnxzQCY+dGbNkUlONlhu7EBSYNNUmp24eCtWbXyYHeFabcyxkbWjNvPc5h
         o2Eq7riDiz9I26si56fZ0M1p45la8sb53XfNvYSMKUMoZhg6sTBVHx1UW5oy69XUEqIO
         7urQ==
X-Gm-Message-State: APjAAAWjhZSfILK0oTccC8q3SVPE7FMEeFk0LpKvp1zP/1rDHBLq2d8S
        rgwM+4RhqdL47twZx7/DDZ8/4ZJzfcNeh/sU9787vlTsxkYBdg==
X-Google-Smtp-Source: APXvYqy+H/DZ9V/1mu3nzhtyatvdYzr5K8UG3C4Ui1ihmpMBioYFZTrR+jGYV79BtYfg5f5/InhfgEWMYS5UBCj/QWI=
X-Received: by 2002:a25:1e57:: with SMTP id e84mr48719412ybe.184.1555101498296;
 Fri, 12 Apr 2019 13:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190412151507.2769-1-hannes@cmpxchg.org> <20190412151507.2769-4-hannes@cmpxchg.org>
 <CALvZod4xu10+E41YyaamigysZAnDcdA09f5m-hGd72LeJ9VmEg@mail.gmail.com> <20190412201004.GA27187@cmpxchg.org>
In-Reply-To: <20190412201004.GA27187@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 12 Apr 2019 13:38:07 -0700
Message-ID: <CALvZod6uw0auc_j+QWC-QBEGwLemtG=uUaf2dxwgbZUkOq6=1A@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: memcontrol: fix recursive statistics correctness
 & scalabilty
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 1:10 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Apr 12, 2019 at 12:55:10PM -0700, Shakeel Butt wrote:
> > We also faced this exact same issue as well and had the similar solution.
> >
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
> Thanks for the review!
>
> > (Unrelated to this patchset) I think there should also a way to get
> > the exact memcg stats. As the machines are getting bigger (more cpus
> > and larger basic page size) the accuracy of stats are getting worse.
> > Internally we have an additional interface memory.stat_exact for that.
> > However I am not sure in the upstream kernel will an additional
> > interface is better or something like /proc/sys/vm/stat_refresh which
> > sync all per-cpu stats.
>
> I was talking to Roman about this earlier as well and he mentioned it
> would be nice to have periodic flushing of the per-cpu caches. The
> global vmstat has something similar. We might be able to hook into
> those workers, but it would likely require some smarts so we don't
> walk the entire cgroup tree every couple of seconds.
>
> We haven't had any actual problems with the per-cpu fuzziness, mainly
> because the cgroups of interest also grow in size as the machines get
> bigger, and so the relative error doesn't increase.
>

Yes, this is very machine size dependent. We see this issue more often
on larger machines.

> Are your requirements that the error dissipates over time (waiting for
> a threshold convergence somewhere?) or do you have automation that
> gets decisions wrong due to the error at any given point in time?

Not sure about the first one but we do have the second case. The node
controller does make decisions in an online way based on the stats.
Also we do periodically collect and store stats for all jobs across
the fleet. This data is processed (offline) and is used in a lot of
ways. The inaccuracy in the stats do affect all that analysis
particularly for small jobs.
