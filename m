Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E98C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B82054F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WI9aVGwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfJHRz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:55:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfJHRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XOAM8DrmdqvOxvYQbnHko0mZQJE/UmKN0IyZDI0K4rU=; b=WI9aVGwm7YTWXAmUw7I2TkGL7
        +3yNEppGPH7QWQJPxzileVld9tlJ18/mLs6Bl25ozl+v4BIjsA218S0lYCUCswRLLufiAc0B6rkK5
        oUKidiL8Srw8ncQhZw6r23fFR03KioL8SfO8L4hjp4sKjb/dIMBvqtZtk/YvVDRYjIzH/VrhC/31E
        Itpqly77Ro5XbRMTbqMcdp8JmL3QldO46NXdYPT2F1BNtXE4wEf+f+TG0WrMiFx/Eoo/vSq6zoNSb
        lMMvh6C7OESSWGH4E5E+kSuTlMw4BQQIC9URq4yg8uya8K+TjEceqR66PyikrL2h5t2puUHRuWPke
        MP07ddn6w==;
Received: from [31.161.223.134] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHti8-0004La-AY; Tue, 08 Oct 2019 17:55:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2721E9802E0; Tue,  8 Oct 2019 19:55:37 +0200 (CEST)
Date:   Tue, 8 Oct 2019 19:55:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
Message-ID: <20191008175537.GC22902@worktop.programming.kicks-ass.net>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 09:33:35AM +0200, Vincent Guittot wrote:
> +	if (busiest->group_type == group_asym_packing) {
> +		/*
> +		 * In case of asym capacity, we will try to migrate all load to
> +		 * the preferred CPU.
> +		 */
> +		env->balance_type = migrate_load;
>  		env->imbalance = busiest->group_load;
>  		return;
>  	}

I was a bit surprised with this; I sorta expected a migrate_task,1 here.

The asym_packing thing has always been a nr_running issue to me. If
there is something to run, we should run on as many siblings/cores as
possible, but preferably the 'highest' ranked siblings/cores.

