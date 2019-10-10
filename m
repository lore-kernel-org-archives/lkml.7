Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF851206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZPkFQitf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfJJJqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:46:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58424 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sTRhFKvn0glVeC9mpJ0ol8xV4CtebwGWcwgq8iAIB/k=; b=ZPkFQitfoTicBpUlrGCAHIgyB
        NgqXJzWuoebSOlXlPHneEHlEK8iP38ulBLQ7xpUryw3FSrtoTLXd6xQxpNJTFU5KpTrxvwI/LD/Es
        ry4N8Od7qHRhJkkiRZ1TdybR3MVwIv0UppEr7Sly5aXACIIrctsU30/de/G/wRR36WvYi8GWj+PIS
        IgN7/ZzB4CQvbCXokCHILiF4jfm/bd1lfXhhnh8ech6UiCcpSTE8yImz+xXsBQgS0uQNn6kQIk1hz
        X9bvAg3UJxnUpcYpbTezcjr1liSlRTYto0eraFROPxY9q2iz7+C7ELcJ8FFZTPKWTSjm1B6EMS0tm
        d1UxbHCKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIV1q-0001e8-Si; Thu, 10 Oct 2019 09:46:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F9093013A4;
        Thu, 10 Oct 2019 11:45:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B8E2202F4F54; Thu, 10 Oct 2019 11:46:37 +0200 (CEST)
Date:   Thu, 10 Oct 2019 11:46:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] perf/x86: avoid false-positives hard lockup
Message-ID: <20191010094637.GN2328@hirez.programming.kicks-ass.net>
References: <1570696898-13169-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570696898-13169-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 04:41:38PM +0800, Li RongQing wrote:
> if perf counter is used as nmi watchdog, and twice nmi in soft
> watchdog sample period will trigger hard lockup
> 
> make sure left time is not less than soft watchdog period by
> compared with 3/5 period to skip forward, since soft watchdog
> sample period is 2/5 of watchdog_thresh, nmi watchdog sample
> period, computed by set_sample_period
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/events/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 7b21455d7504..1f5309456d4c 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1196,7 +1196,11 @@ int x86_perf_event_set_period(struct perf_event *event)
>  	/*
>  	 * If we are way outside a reasonable range then just skip forward:
>  	 */
> +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> +	if (unlikely(left <= -(period * 3 / 5))) {
> +#else
>  	if (unlikely(left <= -period)) {
> +#endif

NAK. This is 100% the wrong place to do anything like that.
