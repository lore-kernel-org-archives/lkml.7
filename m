Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2CEC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF2B21783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406134AbfHIJRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:17:22 -0400
Received: from foss.arm.com ([217.140.110.172]:43982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfHIJRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:17:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A939F15AB;
        Fri,  9 Aug 2019 02:17:21 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D026B3F575;
        Fri,  9 Aug 2019 02:17:19 -0700 (PDT)
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b85f1f95-40e5-852b-f897-1379414354c9@arm.com>
Date:   Fri, 9 Aug 2019 11:17:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726161358.056107990@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 4:54 PM, Peter Zijlstra wrote:

[...]

> +void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> +		    dl_server_has_tasks_f has_tasks,
> +		    dl_server_pick_f pick)
> +{
> +	dl_se->dl_server = 1;
> +	dl_se->rq = rq;
> +	dl_se->server_has_tasks = has_tasks;
> +	dl_se->server_pick = pick;
> +
> +	setup_new_dl_entity(dl_se);

IMHO, this needs rq locking because of the rq_clock(rq) in
setup_new_dl_entity().

[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/sched/sched.h:1119
dl_server_init+0x118/0x178
...
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W
5.3.0-rc3-00013-ga33cf033cc99-dirty #10
[    0.000000] Hardware name: ARM Juno development board (r0) (DT)
...
[    0.000000] Call trace:
[    0.000000]  dl_server_init+0x118/0x178
[    0.000000]  fair_server_init+0x5c/0x68
[    0.000000]  sched_init+0x2c8/0x474
[    0.000000]  start_kernel+0x290/0x514

[...]
