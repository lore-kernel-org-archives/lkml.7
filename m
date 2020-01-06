Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125A6C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B672075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2kNiL47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgAFOwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:52:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43803 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgAFOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:52:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id p27so21940692pli.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 06:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=69A4MG78RKfrEDfmzVSuKK32EleEQVn7yGID65LIOfM=;
        b=I2kNiL47eWmhNnI9vSn2RTsMaLTkdelP5OIOw7hmEOyPjqtfRf7bNnhdFA8fo+FE6w
         wQrJN+WBhgCLbu4JgEuUIYBZvs7qqvbR8DDJoOjUzZA8rAm0sv6LwTt/hVfvGIG7O45+
         yE5qE9UIlnk69ALo55V88PmGD2RwZr6KW3x0YBVaWsnez3CuapcUac1g25LU8um0kr1D
         untXCOK3+4pmM5MOUPRFT35HbKGgT+g/EKhr5z6Zz/jkyB5se4boXkePEL8OpIpjt+R4
         Wm+7N2KJygI+l0IC/AUsUq5Y1iVtsjkHE5PAru+Ur+SzJ1IFz9FXrPZsNebQPPKijNy+
         mBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69A4MG78RKfrEDfmzVSuKK32EleEQVn7yGID65LIOfM=;
        b=aF9/mp8tcKxthO7weYSz6O6slPN9lR4+sf4HEktXYyEpwhsN8aI7qSAxyNDDzFoQaQ
         pxTg266a5/OxhbYWB9o71oymBK7rMhi39+Z82aQPyshyKg2RB1J1b/H+sGF5G+f1IKm8
         Ow4xa3AuSnDAfVRxMS7fNrQGHpKrBBxh3nnFhDhK3tOknNZ2ifEODpWCRlF1zTIMOFJw
         7FtELEFPIqYpkC/RzGWKdIH/dE9zQv0OTBZcsDkZj7IjHHhMc1jmtZf/JjjoVfmRq/gF
         AG0Oz8vlv6l8X6wHmfptaPc8VCorGsj077Q3SmOpvf/7JGVRx4BeSXiurusGR9TqiUfE
         OcCw==
X-Gm-Message-State: APjAAAXvbaTn6hLKoIKVnx8954AY54NeddcCLvvnqQcoglmqQShvh140
        pRHvw9nzXepLdN7HfSu2uR4=
X-Google-Smtp-Source: APXvYqwwkz2t/dzKTwei0hQm0J4Pv7q+sakWSRKoRur5y9HhGEw3ZyIwXDFsE1jIKenXaulNYJTPUQ==
X-Received: by 2002:a17:90a:cb87:: with SMTP id a7mr43118004pju.135.1578322352345;
        Mon, 06 Jan 2020 06:52:32 -0800 (PST)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id u26sm75372510pfn.46.2020.01.06.06.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 06:52:31 -0800 (PST)
Date:   Mon, 6 Jan 2020 22:52:27 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, qais.yousef@arm.com,
        morten.rasmussen@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/fair: fix sgc->{min,max}_capacity miscalculate
Message-ID: <20200106145227.GB15532@iZj6chx1xj0e0buvshuecpZ>
References: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
 <20200106102341.GM2810@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106102341.GM2810@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 11:23:41AM +0100, Peter Zijlstra wrote:
> On Sat, Jan 04, 2020 at 09:08:28PM +0800, Peng Liu wrote:
> > commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
> > sched_group_capacity") introduced per-cpu min_capacity.
> > 
> > commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
> > introduced per-cpu max_capacity.
> > 
> > Here, capacity is the accumulated sum of (maybe) many CPUs' capacity.
> > Compare with capacity to get {min,max}_capacity makes no sense. Instead,
> > we should compare one by one in each iteration to get
> > sgc->{min,max}_capacity of the group.
> > 
> > Also, the only CPU in rq->sd->groups should be rq's CPU. Thus,
> > capacity_of(cpu_of(rq)) should be equal to rq->sd->groups->sgc->capacity.
> > Code can be simplified by removing the if/else.
> > 
> > Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> > ---
> > v1: https://lkml.org/lkml/2019/12/30/502
> 
> Please (for future use); use the form:
> 
>   https://lkml.kernel.org/r/$msgid

Peter, thanks, I will.

> 
