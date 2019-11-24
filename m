Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C63C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D49207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 22:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKXWU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 17:20:56 -0500
Received: from foss.arm.com ([217.140.110.172]:42078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfKXWU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 17:20:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C426D31B;
        Sun, 24 Nov 2019 14:20:55 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DD393F6C4;
        Sun, 24 Nov 2019 14:20:54 -0800 (PST)
Date:   Sun, 24 Nov 2019 22:20:52 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity"
 checks
Message-ID: <20191124222051.kbb62phfsln5ixg4@e107158-lin.cambridge.arm.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
 <20191120175533.4672-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120175533.4672-4-valentin.schneider@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 17:55, Valentin Schneider wrote:
> +static inline
> +unsigned long uclamp_task_util(struct task_struct *p, unsigned long util)
> +{
> +	return clamp(util,
> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MIN),
> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MAX));
> +}

uclamp_eff_value() will check if a task belongs to a cgroup, and if it does
apply its uclamp. The funny thing about the cgroup settings is that they can
have a uclamp_max < uclamp_min. uclamp_util_with() does check for this
condition but this function doesn't.

I would prefer to teach uclamp_util_with() to accept a NULL rq argument, then
we can have 2 convenient function uclamp_rq_util() and uclamp_task_util() that
are just simple wrappers around it. It'd would be a lot better to keep the
intelligence of dealing with the correct details of clamping in a single
function IMO.

Cheers

--
Qais Yousef
