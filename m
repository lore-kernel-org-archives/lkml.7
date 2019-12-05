Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3169C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68CA24655
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vjvNicES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfLEKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:33:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41230 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfLEKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GQf+rnNFuRmLYQiBswud5Lup/z9TY9QZpcCJ3hoxq8A=; b=vjvNicESJqr5AY6NlaHJa6rea
        cnuqKiDYZOs3IGOuIFyjtR+mAkH9jYuoeiDrxZykggmCO6aT+Ud+hR3UxAanfEgYoFrSchej3FDRo
        s2IDNhjYVpb6obg/o25jt0RLXfptkZKEPg8zTT6qWZBZiKExrtZuJEKBBl9CpT6LZnlYOeJwBj4t8
        aQPQe2aKgXGWTssi2TfIuYGelIZq5ghE0h+J9Yg5POuYFD6kemx0hq9jg37LUax/1Q4bsffuAU2HG
        VoSNvd4DE/7uGUvvfMtsfiVpoIHwm6w+f3mAT+oEP3V2d/DOko4MA/4qbOWwd69IKVIjvxVg6VQxL
        0oWr+4lWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icoRv-0003Hz-9v; Thu, 05 Dec 2019 10:33:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97E1E3011E0;
        Thu,  5 Dec 2019 11:32:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9991B2006F795; Thu,  5 Dec 2019 11:33:29 +0100 (CET)
Date:   Thu, 5 Dec 2019 11:33:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     liu.song11@zte.com.cn
Cc:     fishland@aliyun.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] psi: Only collect online cpu time in collect_percpu_times
Message-ID: <20191205103329.GH2810@hirez.programming.kicks-ass.net>
References: <20191204123500.GT2844@hirez.programming.kicks-ass.net>
 <201912051005599522735@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912051005599522735@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:05:59AM +0800, liu.song11@zte.com.cn wrote:
> >On Mon, Dec 02, 2019 at 09:09:28PM +0800, Liu Song wrote:
> >> From: Liu Song <liu.song11@zte.com.cn> 
> >>  
> >> Tasks can only run on the online cpu, so only need to
> >> collect the time of the online cpu.
> >>  
> >> Signed-off-by: Liu Song <liu.song11@zte.com.cn> 
> >> ---
> >>  kernel/sched/psi.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>  
> >> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> >> index 7acc632c3b82..605f02facb7b 100644
> >> --- a/kernel/sched/psi.c
> >> +++ b/kernel/sched/psi.c
> >> @@ -316,7 +316,7 @@ static void collect_percpu_times(struct psi_group *group,
> >>       * the sampling period. This eliminates artifacts from uneven
> >>       * loading, or even entirely idle CPUs.
> >>       */
> >> -    for_each_possible_cpu(cpu) {
> >> +    for_each_online_cpu(cpu) {
> >>          u32 times[NR_PSI_STATES];
> >>          u32 nonidle;
> >>          u32 cpu_changed_states;
> >
> >And who collects the deltas that remain after offline?
> 
> Hi,
> After the cpu goes offline, there is no activity on the cpu and no time will be updated.

But there might have been activitiy before it went offline.

> So the value of deltas is 0 and it will not contribute to the total time.

No, the value will not change, but it need not be 0.


