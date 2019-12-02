Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD4EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA642214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRs58BNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfLBCB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:01:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44078 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfLBCB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:01:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so847155pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 18:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pfq98NxsZEAY/y/R+bO+qIkbGC1mkCn6FgQ1AilED9w=;
        b=GRs58BNPJS8nsY2SVE4e0b2MjTuGAUY/qFuATdgZKYvkeQ0YTPVWBxbZKwmYNk5tcd
         geDNGxEPS9pSGPWrW4UkG9jMgL1SgqV+X+RDEZwxQgTX8n4qXcZ5BLePuQ3/GhTCZ5D/
         MrcHfkWfp54CUnZfpoOaflMAZeDSAUz9yWG1wXvW6wAKxrRTdB1J2UVs8mwjV+HT16uN
         0ScDJ+bfle4xYHatsiQKEma40e9d9yzahsrC7xjkTD2D9z78UNL1EllHQULkrSvrcFsL
         eO8c5XEmd/YqPjRlw9flnjuTz4kZp+ZICZCRX8DZ5izfhn0g88o3/uUH5rbMd81XO7CY
         INlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pfq98NxsZEAY/y/R+bO+qIkbGC1mkCn6FgQ1AilED9w=;
        b=EUctMJWMBSlEywFE581EUTJTM80l44LMk50d8a1rphn8dv3K8AFycch8xCzIHTiGjW
         SMpXXCR8/xe9t1AIYVQ5FspHjSF9xArukI5/E5N6qinkIoXqHhArgPmaF62YU436RBbK
         hpjPR7mqqIJTXYemshTq6pAXJoxV5TxZW6Y7ed+xBqGN1/6QRNMO2MSTsVW4xVUy+S6s
         JsYyS9lHe/SnhPMzfz8jxKga71diCu7wlT6TKiF7prwYYqe1LadUkUC8tn+TmVjNJohN
         n9lVOnVjueHQZysehJvJMJpiY6gVFbsUe3q//2WdD7ZWFsB16z4sTXVSLzOL1UcFbcJT
         XB7w==
X-Gm-Message-State: APjAAAVL02saNs3EBg2UXtgJ8q36tOV9O1sGZ/miFwhRAQHpnl8IJPsO
        cwV8xRspepN27SSjrX7tB63H2A==
X-Google-Smtp-Source: APXvYqya3nEtHgktObKfp6/gawhI8tTCK1taxn0PybdJ0SIw9J6BCR+60OgcquyLfMaJ3QG/Jqd8gg==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr28724370pgb.177.1575252115441;
        Sun, 01 Dec 2019 18:01:55 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id i68sm8032624pfe.173.2019.12.01.18.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Dec 2019 18:01:54 -0800 (PST)
Date:   Mon, 2 Dec 2019 07:31:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: vexpress-spc: Switch cpumask from topology
 core to OPP sharing
Message-ID: <20191202020146.pzjq2gtgo7rzzorx@vireshk-i7>
References: <20191128101547.519-1-sudeep.holla@arm.com>
 <20191128101547.519-2-sudeep.holla@arm.com>
 <20191129114926.GA24793@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129114926.GA24793@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-19, 11:49, Sudeep Holla wrote:
> Hi Viresh, Rafael,
> 
> On Thu, Nov 28, 2019 at 10:15:47AM +0000, Sudeep Holla wrote:
> > Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> > functions.") the core cpumask has to be modified during cpu hotplug
> > operations. So using them to set up cpufreq policy cpumask may be
> > incorrect as it may contain only cpus that are online at that instance.
> >
> > Instead, we can use the cpumask setup by OPP library that contains all
> > the cpus sharing OPP table using dev_pm_opp_get_sharing_cpus.
> >
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> 
> This can go independently via PM tree and I can take 1/2 via SoC tree
> (as the file is being moved). The problem will be fixed only after both
> lands, but this alone won't break the build.

Yes, but it will break cpufreq for sure as shared-cpus won't be set by anyone.

> Or if you guys provide
> Ack, I can take both together via ARM SoC team. Let me know.

I was planning to take them through cpufreq tree, but that fine if you can do
that.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
