Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12330C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D203120675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C5VC77CT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfFTMvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:51:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfFTMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7yjxKkslIpoQDavtSiAROwpDIQ1ErOWdHf7wTrGdGuE=; b=C5VC77CTtPXVAIahK4q0qvngEm
        ZJn3O7gzyI/zT0cfBbFXho1EzBMvQ79SjbCt47ceeOFL0msX6evYrc7UJSoEY9jxiskmjVxs9CdVM
        1ocJ4wQDvJNVeZROTcDrrWsiTuX/b1XiyBztxkbWS7eEk+rplkCOv/6kotXCPlEz7DPi+zQcd7dbE
        rR2hGA3aUW+BW0ix7oBK5MxI7RL+WOa2jxaluWePLA86RHaVniF+wjPpdEPzeu0AksvUudaGyo0GZ
        RbTUxnKiDd6OrcsnUZdR95xwHXk8MI+r4ycALbrN2SPmavL2T+W/LfnM2rLBrn3Tu97qrVxWo87iA
        9cnhuhsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdwWq-0000st-LZ; Thu, 20 Jun 2019 12:51:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 204F6205E1079; Thu, 20 Jun 2019 14:50:59 +0200 (CEST)
Date:   Thu, 20 Jun 2019 14:50:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH] perf/rapl: restart perf rapl counter after resume
Message-ID: <20190620125059.GZ3436@hirez.programming.kicks-ass.net>
References: <1560778897.10723.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560778897.10723.6.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 09:41:37PM +0800, Zhang Rui wrote:

> After S3 suspend/resume, "perf stat -I 1000 -e power/energy-pkg/ -a"
> reports an insane value for the very first sampling period after resume
> as shown below.
> 
>     19.278989977               2.16 Joules power/energy-pkg/
>     20.279373569               1.96 Joules power/energy-pkg/
>     21.279765481               2.09 Joules power/energy-pkg/
>     22.280305420               2.10 Joules power/energy-pkg/
>     25.504782277   4,294,966,686.01 Joules power/energy-pkg/
>     26.505114993               3.58 Joules power/energy-pkg/
>     27.505471758               1.66 Joules power/energy-pkg/
> 
> Fix this by resetting the counter right after resume.

Cute...


> +#ifdef CONFIG_PM
> +
> +static int perf_rapl_suspend(void)
> +{
> +	int i;
> +
> +	get_online_cpus();
> +	for (i = 0; i < rapl_pmus->maxpkg; i++)
> +		rapl_pmu_update_all(rapl_pmus->pmus[i]);
> +	put_online_cpus();
> +	return 0;
> +}
> +
> +static void perf_rapl_resume(void)
> +{
> +	int i;
> +
> +	get_online_cpus();
> +	for (i = 0; i < rapl_pmus->maxpkg; i++)
> +		rapl_pmu_restart_all(rapl_pmus->pmus[i]);
> +	put_online_cpus();
> +}

What's the reason for that get/put_online_cpus() here ?
