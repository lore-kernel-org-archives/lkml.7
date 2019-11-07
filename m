Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503A4C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207FA2075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SsRfk6xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbfKGNME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:12:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbfKGNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r+oWhkAzpRy6WfnU7l9sRsKb3NK0JGxLsDSabun9rxU=; b=SsRfk6xtyoDRpBIx0scp64BWyz
        lDzzvlnni0IS2C5bGQ5Mtk/Fp8v6ieIlvtHJclRD9AzA9iLS96dHZ56auFFki1TIyxyhCSHwTS4UX
        ZPJ6AgIYm4AGsNm9qsGgUcez0VkE1OWDlBOm5Cpv18xBryGqfalerMrdn5xhtz6lPlI3RSdWauRX9
        8mOtilJdjdy1FGo6VPOfykeMTor9k9NzYjb0stiflzACFK3xcku8RKult17/YCQJXQJ6FxE1/q/Y2
        oE0KhCSyPHFbvIL3sMHiSm7gTyfmoSXWmH02lHqXyLcHwwWEG/hUuaeMAIiT9Qqd6rVcC239FYhpe
        EN0D7rtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iShZl-0006wl-7L; Thu, 07 Nov 2019 13:11:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66DB0300489;
        Thu,  7 Nov 2019 14:10:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C09462025EDA7; Thu,  7 Nov 2019 14:11:46 +0100 (CET)
Date:   Thu, 7 Nov 2019 14:11:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: core: fix compilation error when cgroup not
 selected
Message-ID: <20191107131146.GJ4131@hirez.programming.kicks-ass.net>
References: <20191105112212.596-1-qais.yousef@arm.com>
 <20191107072525.GA19642@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107072525.GA19642@darkstar>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 07:25:25AM +0000, Patrick Bellasi wrote:
> [ +Randy ]
> 
> Hi Qais,
> 
> On 05-Nov 11:22, Qais Yousef wrote:
> > When cgroup is disabled the following compilation error was hit
> > 
> > 	kernel/sched/core.c: In function ‘uclamp_update_active_tasks’:
> > 	kernel/sched/core.c:1081:23: error: storage size of ‘it’ isn’t known
> > 	  struct css_task_iter it;
> > 			       ^~
> > 	kernel/sched/core.c:1084:2: error: implicit declaration of function ‘css_task_iter_start’; did you mean ‘__sg_page_iter_start’? [-Werror=implicit-function-declaration]
> > 	  css_task_iter_start(css, 0, &it);
> > 	  ^~~~~~~~~~~~~~~~~~~
> > 	  __sg_page_iter_start
> > 	kernel/sched/core.c:1085:14: error: implicit declaration of function ‘css_task_iter_next’; did you mean ‘__sg_page_iter_next’? [-Werror=implicit-function-declaration]
> > 	  while ((p = css_task_iter_next(&it))) {
> > 		      ^~~~~~~~~~~~~~~~~~
> > 		      __sg_page_iter_next
> > 	kernel/sched/core.c:1091:2: error: implicit declaration of function ‘css_task_iter_end’; did you mean ‘get_task_cred’? [-Werror=implicit-function-declaration]
> > 	  css_task_iter_end(&it);
> > 	  ^~~~~~~~~~~~~~~~~
> > 	  get_task_cred
> > 	kernel/sched/core.c:1081:23: warning: unused variable ‘it’ [-Wunused-variable]
> > 	  struct css_task_iter it;
> > 			       ^~
> > 	cc1: some warnings being treated as errors
> > 	make[2]: *** [kernel/sched/core.o] Error 1
> > 
> > Fix by protetion uclamp_update_active_tasks() with
> > CONFIG_UCLAMP_TASK_GROUP
> > 
> > Fixes: babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> 
> Thanks for posting this again.
> 
> We now have three "versions" of this same fix, including:
>  - the original bug report by Randy and a fix from me here:
>    Message-ID: <8736gv2gbv.fsf@arm.com>
>    https://lore.kernel.org/linux-next/8736gv2gbv.fsf@arm.com/
>  - and a follow up patch from Arnd:
>    Message-ID: <20190918195957.2220297-1-arnd@arndb.de>
>    https://lore.kernel.org/lkml/20190918195957.2220297-1-arnd@arndb.de/
> 
> So, I guess now we just have to pick the one with the changelog we
> prefer. :)
> 
> In all cases we should probably add:
> 
>   Reported-by: Randy Dunlap <rdunlap@infradead.org>
>   Tested-by: Randy Dunlap <rdunlap@infradead.org>

Argh, ok, I missed them all too. Picked up this one for sched/urgent and
added the above.

Thanks!
