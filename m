Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F51C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4A7206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XuoqGSLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfLPOgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:36:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C06wFH+resGir12/3toS1utlMTXCu7z7ClbGkasoxeE=; b=XuoqGSLuNfwTM8ej3lRxjNLzN
        gzxRn99pYbXmIaj9DHcVdQajmJbSYMIYIv3k/EtEVTMptCG+n18ycsit4Q5sSkwSQgSgvfMgp9gmE
        MvI6pk8UUD7eFk1V1teFnHOkyru4zqPHxh78VpOJ9Fy1w1ay2PKkRf4Rgyi2WLJXAXrG3OSPwv+J6
        3FPgvNJ/2KP24L8B+v7gTC/VBz49oo4DdkcVThReAaufiex0SeKx6pghIZfxlOMc9TotkEODdWbfA
        /0HZ/GdAw5rRgqgQ+s6p5oE0R7eCtIi5O3CnouelUsH5GvIyErHP0Ge78ekGh7oXpUsepNvHiykkP
        AVfS+QnLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igrTK-0007vw-8Y; Mon, 16 Dec 2019 14:35:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4961A301747;
        Mon, 16 Dec 2019 15:34:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 791B22B2A00ED; Mon, 16 Dec 2019 15:35:39 +0100 (CET)
Date:   Mon, 16 Dec 2019 15:35:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 2/7] sched: Add hook to read per cpu thermal pressure.
Message-ID: <20191216143539.GR2844@hirez.programming.kicks-ass.net>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-3-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-3-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:11:43PM -0500, Thara Gopinath wrote:
> Introduce arch_scale_thermal_capacity to retrieve per cpu thermal
> pressure.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  include/linux/sched/topology.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index f341163..f1e22f9 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -225,6 +225,14 @@ unsigned long arch_scale_cpu_capacity(int cpu)
>  }
>  #endif
>  
> +#ifndef arch_scale_thermal_capacity
> +static __always_inline
> +unsigned long arch_scale_thermal_capacity(int cpu)
> +{
> +	return 0;
> +}
> +#endif

This is confusing, the return value is not a capacity, it is a reduction
in capacity. Either a comment of a better name would be appreciated.
