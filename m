Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A79C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E8E2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xEclNzVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfJAVTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:19:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43853 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfJAVTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:19:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id v27so10565186pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=INoMgnqhH49ZFKFHhyaP4EdT7D9OjFM4A6O+XvHM0Oo=;
        b=xEclNzVyc/D7N5Pge7bXfLSjXeQWU6dKIYmcYVwA0mJBEwv3nJRePW7ixJ+OxOcEf3
         oF8fbGpU8WMh5ENrdibkuN3eJ4d/6QL8kHv+ljNO/Ezfnx9lH6BigkMrQZIU522JciH7
         u0AD7f3sMRmvaHpFNXgr6Ke+8I6D7d3q6Ea5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=INoMgnqhH49ZFKFHhyaP4EdT7D9OjFM4A6O+XvHM0Oo=;
        b=WiEHwkoDyo4XlwJwtKj0imDV80szOob+McjmXATLwqRWGVmR1KHP5+rI8B5L1HffP3
         xGJk5MRAX89vcZT9EAlT0SQ9cpwrq3yY/S/+vuMF3ME/HNygA8cS+15ggfPOFsUtF8a/
         wAjElhbALdGSXYZamFkx0Y6IkckZHKgHJXVlSrUniEu5jc9vow7M4SuWY2sjL1o5vaIT
         vu3epfH86oc/dTzGcZD9t8baOnzjn7c8CYKea1V5W7F58+GWeF9gpWnvlq0oF5vGGceM
         FrzoS/17tjB+Q6iPv9VfslVJTGckxRYgJtp9tPvJUUmn3ffiiigkUjQxkJcq/+1/iBDd
         NBwQ==
X-Gm-Message-State: APjAAAXD+4bYoWzLpYSk+Ifp6cNGMqgLxc04IOvAofTjQPmqUWy5NiWH
        Emv6RpOISb3Yj1O2V3CpNiQktg==
X-Google-Smtp-Source: APXvYqykfKxPl+xURQAGrxObt96rfgwmrAvdzsBTTtUGsm71bavcOXuDxOhHS9rP8Fe8Jas2SKCfWA==
X-Received: by 2002:a17:90a:21a9:: with SMTP id q38mr239494pjc.23.1569964790305;
        Tue, 01 Oct 2019 14:19:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e3sm3080069pjs.15.2019.10.01.14.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 14:19:49 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:19:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>, paulmck@linux.ibm.com,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        stern@rowland.harvard.edu, akiyks@gmail.com, npiggin@gmail.com,
        boqun.feng@gmail.com, dlustig@nvidia.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191001211948.GA42035@google.com>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> Hi all,
> 
> We would like to share a new data-race detector for the Linux kernel:
> Kernel Concurrency Sanitizer (KCSAN) --
> https://github.com/google/ktsan/wiki/KCSAN  (Details:
> https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> 
> To those of you who we mentioned at LPC that we're working on a
> watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> renamed it to KCSAN to avoid confusion with KTSAN).
> [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> 
> In the coming weeks we're planning to:
> * Set up a syzkaller instance.
> * Share the dashboard so that you can see the races that are found.
> * Attempt to send fixes for some races upstream (if you find that the
> kcsan-with-fixes branch contains an important fix, please feel free to
> point it out and we'll prioritize that).
> 
> There are a few open questions:
> * The big one: most of the reported races are due to unmarked
> accesses; prioritization or pruning of races to focus initial efforts
> to fix races might be required. Comments on how best to proceed are
> welcome. We're aware that these are issues that have recently received
> attention in the context of the LKMM
> (https://lwn.net/Articles/793253/).
> * How/when to upstream KCSAN?

Looks exciting. I think based on our discussion at LPC, you mentioned
one way of pruning is if the compiler generated different code with _ONCE
annotations than what would have otherwise been generated. Is that still on
the table, for the purposing of pruning the reports?

Also appreciate a CC on future patches as well.

thanks,

 - Joel


> 
> Feel free to test and send feedback.
> 
> Thanks,
> -- Marco
