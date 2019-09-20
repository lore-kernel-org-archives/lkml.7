Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65070C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370CA208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FO4VR2MD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oriZ9Ook"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393608AbfITKds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:33:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393568AbfITKds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:33:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6A976155D; Fri, 20 Sep 2019 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568975626;
        bh=g58L+Xw7ZxKEMW+27JOU2VAvjhj6honkdYBe73Hc2fI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FO4VR2MD4jSeCuOErInP2yjCbwvVUCVyKXh9z6mtTxhRezGnt4LItZ7yIFirTTLMV
         ituFDJcsKxlCHET1OB9i6dCK1xPmn8s9kb5ywyD94C08dJKWVZa53MdVRjcAIjTfBR
         uYhZYmTZ5Qt3I02sc4cbmd7xaUgQ4hbdlf78ifn4=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C037A60240;
        Fri, 20 Sep 2019 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568975625;
        bh=g58L+Xw7ZxKEMW+27JOU2VAvjhj6honkdYBe73Hc2fI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oriZ9OokT5cb1zy5Ejzj97EBIgF0MO6QIrEx4q/AUzS+Iy6b0JJDJY0mVUQJ5vsnr
         OMBfxUtGdaq8cLBxjuLAj1RX4nsm1GGoDm0nn0bEvFvbT2NKr2qUI5ZH+CSo7R5Eo9
         MtBWGcvZwyB49TZNgVXmb3L4NfEjNAFcuzQckUp8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C037A60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 20 Sep 2019 16:03:38 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <qperret@qperret.net>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, rjw@rjwysocki.net,
        morten.rasmussen@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, tkjos@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Speed-up energy-aware wake-ups
Message-ID: <20190920103338.GB20250@codeaurora.org>
References: <20190912094404.13802-1-qperret@qperret.net>
 <20190920030215.GA20250@codeaurora.org>
 <20190920094115.GA11503@qperret.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920094115.GA11503@qperret.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Fri, Sep 20, 2019 at 11:41:15AM +0200, Quentin Perret wrote:
> Hi Pavan,
> 
> On Friday 20 Sep 2019 at 08:32:15 (+0530), Pavan Kondeti wrote:
> > Earlier, we are not checking the spare capacity for the prev_cpu. Now that the
> > continue statement is removed, prev_cpu could also be the max_spare_cap_cpu.
> > Actually that makes sense. Because there is no reason why we want to select
> > another CPU which has less spare capacity than previous CPU.
> > 
> > Is this behavior intentional?
> 
> The intent was indeed to not compute the energy for another CPU in
> prev_cpu's perf domain if prev_cpu is the one with max spare cap -- it
> is useless to do so since this other CPU cannot 'beat' prev_cpu and
> will never be chosen in the end.

Yes. Selecting the prev_cpu is the correct decision.

> 
> But I did miss that we'd end up computing the energy for prev_cpu
> twice ... Harmless but useless. So yeah, let's optimize that case too :)
> 
> > When prev_cpu == max_spare_cap_cpu, we are evaluating the energy again for the
> > same CPU below. That could have been skipped by returning prev_cpu when
> > prev_cpu == max_spare_cap_cpu.
> 
> Right, something like the patch below ? My test results are still
> looking good with it applied.
> 
> Thanks for the careful review,
> Quentin
> ---
> From 7b8258287f180a2c383ebe397e8129f5f898ffbe Mon Sep 17 00:00:00 2001
> From: Quentin Perret <qperret@qperret.net>
> Date: Fri, 20 Sep 2019 09:07:20 +0100
> Subject: [PATCH] sched/fair: Avoid redundant EAS calculation
> 
> The EAS wake-up path computes the system energy for several CPU
> candidates: the CPU with maximum spare capacity in each performance
> domain, and the prev_cpu. However, if prev_cpu also happens to be the
> CPU with maximum spare capacity in its performance domain, the energy
> calculation is still done twice, unnecessarily.
> 
> Add a condition to filter out this corner case before doing the energy
> calculation.
> 
> Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
> Signed-off-by: Quentin Perret <qperret@qperret.net>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bbf68c3161..7399382bc291 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6412,7 +6412,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		}
>  
>  		/* Evaluate the energy impact of using this CPU. */
> -		if (max_spare_cap_cpu >= 0) {
> +		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
>  			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
>  			cur_delta -= base_energy_pd;
>  			if (cur_delta < best_delta) {
> -- 
> 2.22.1
> 

+1. Looks good to me.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

