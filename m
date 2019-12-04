Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878D22084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NI0Fvbud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfLDMfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:35:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfLDMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J/WQVy4sVaQLO7VIHTnenUpwaZjanvaxoH0c5Hwc9nw=; b=NI0FvbudZLi4D4imzicu27gs4
        9ia9drai1ik6o8TO554McoiXs1W8pzSzyYUlzhct+Xygw3ZCzZJz9CReyckDMe4k0LoWvoaNpjaid
        00gqF7Eg/fLDXqAZ9K472g8O4q+pDI+mpRRh14gzMTr2mGC3auFX9881Jzz2dyd+BjEQL50FhmoEj
        yT30m9e2O2VC2cGdCH9ve42N0dxmYp2EvQAxQILsbEiBTt9RjFlTkNzMXAOIXOyopFOMIuwh/drqF
        Prvh9QdNyU5YcdvnIw2n6NhgTH9Qb7LR+8GahKM3YEOLlRREIJbN5pLvxeHUCcdetnfwqwCqmJrXS
        xqSVJwCfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icTs0-00076q-Vu; Wed, 04 Dec 2019 12:35:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07FF03011E0;
        Wed,  4 Dec 2019 13:33:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A04C62B25FE23; Wed,  4 Dec 2019 13:35:00 +0100 (CET)
Date:   Wed, 4 Dec 2019 13:35:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liu Song <fishland@aliyun.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        liu.song11@zte.com.cn
Subject: Re: [PATCH] psi: Only collect online cpu time in collect_percpu_times
Message-ID: <20191204123500.GT2844@hirez.programming.kicks-ass.net>
References: <20191202130928.2971-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202130928.2971-1-fishland@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 09:09:28PM +0800, Liu Song wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> Tasks can only run on the online cpu, so only need to
> collect the time of the online cpu.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7acc632c3b82..605f02facb7b 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -316,7 +316,7 @@ static void collect_percpu_times(struct psi_group *group,
>  	 * the sampling period. This eliminates artifacts from uneven
>  	 * loading, or even entirely idle CPUs.
>  	 */
> -	for_each_possible_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		u32 times[NR_PSI_STATES];
>  		u32 nonidle;
>  		u32 cpu_changed_states;

And who collects the deltas that remain after offline?
