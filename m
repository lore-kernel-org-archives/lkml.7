Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A504C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C872067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vt+5CT31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgAHNzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:55:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgAHNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cUxWnFN2IySuWr46XuhL+3RFX50ZeyW0gT95pv2qmD4=; b=Vt+5CT3169Bv4qieYntJ8dZsR
        5UXeRErGTFM9eLeYncmOh994nX7RFT/t5Fw8URkRiJVTPFxpvdIH3KmLAb2VYvNHKhIGgltVFCFVR
        NpbWcFihWLa6xhMle3w37nbHLEuS0qXXweZSypIgZgxo2RFVt5Uoy4fDXD9IRhwKGMOBUdx+gYWgB
        lFpPTm23YIENiD4dpcJr4xx5R8e15yEIjhLMzJc17QKNfruyhZBEqv7e3/OXVrvTyy4QA4jFxUrCB
        1utFX6Jv+dEBQMBuhnBGqYyiZ+zcwfonpqP+b+tiwVG+mzhYuybla6N4ydbVnPRP0Qro7lFuGxYtL
        SDjgOgwmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBo2-00041l-6V; Wed, 08 Jan 2020 13:55:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E37B3012C3;
        Wed,  8 Jan 2020 14:53:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7FD520B79C82; Wed,  8 Jan 2020 14:55:26 +0100 (CET)
Date:   Wed, 8 Jan 2020 14:55:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wang Long <w@laoqinren.net>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH] sched/psi: create /proc/pressure and
 /proc/pressure/{io|memory|cpu} only when psi enabled
Message-ID: <20200108135526.GH2844@hirez.programming.kicks-ass.net>
References: <1576672698-32504-1-git-send-email-w@laoqinren.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576672698-32504-1-git-send-email-w@laoqinren.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 08:38:18PM +0800, Wang Long wrote:
> when CONFIG_PSI_DEFAULT_DISABLED set to N or the command line set psi=0,
> I think we should not create /proc/pressure and
> /proc/pressure/{io|memory|cpu}.
> 
> In the future, user maybe determine whether the psi feature is enabled by
> checking the existence of the /proc/pressure dir or
> /proc/pressure/{io|memory|cpu} files.

Works for me; Johannes?

> Signed-off-by: Wang Long <w@laoqinren.net>
> ---
>  kernel/sched/psi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 517e371..f12ade2 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1279,10 +1279,12 @@ static int psi_fop_release(struct inode *inode, struct file *file)
>  
>  static int __init psi_proc_init(void)
>  {
> -	proc_mkdir("pressure", NULL);
> -	proc_create("pressure/io", 0, NULL, &psi_io_fops);
> -	proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
> -	proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
> +	if (psi_enable) {
> +		proc_mkdir("pressure", NULL);
> +		proc_create("pressure/io", 0, NULL, &psi_io_fops);
> +		proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
> +		proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
> +	}
>  	return 0;
>  }
>  module_init(psi_proc_init);
> -- 
> 1.8.3.1
> 
> 
> 
