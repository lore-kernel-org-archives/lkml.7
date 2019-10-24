Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7059CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6920684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mq98I3fG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393275AbfJXKS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:18:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56058 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392678AbfJXKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1lwGcpbN8M6WZ6gKLWBoke01kFAviE7JTyirzjF13f8=; b=Mq98I3fGbM6CVFiZq/q0G3JXB
        e8UjFZi1KNKdA0RWPk4Bgpk6t0+73lCcG2M87fzq2n7KK31DYyoddL9ihEVFeSQhJAegtMDFmWSwK
        QnRi2cYvVUIrw/JtGYIS3tnrxOsfJ+J/uump3RnugsMsAJUTWAtDq9yhAKXmhzFql1bXQPAIDqsQl
        BzDVN/lH8K1Rt5XxpkqNFYbZysVj5heYK+fZTVJYmm66FyisFMzj0nYzeJcO82iFcJHnWGay7/5QY
        PV1iDuaakoVZMaMMAjc2lFiQRx8pu+Jp1ySTiZVuOKcTCmL4X28t2wFZcvpbh5XIP5ZccHFdT1R92
        SkVDyKHPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNaCC-0006Vp-Ex; Thu, 24 Oct 2019 10:18:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C1E33006E3;
        Thu, 24 Oct 2019 12:17:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA5832100B874; Thu, 24 Oct 2019 12:18:18 +0200 (CEST)
Date:   Thu, 24 Oct 2019 12:18:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191024101818.GA5671@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021222110.49044eb5@oasis.local.home>
 <20191022202401.GO1817@hirez.programming.kicks-ass.net>
 <20191023145245.53c75d70@gandalf.local.home>
 <20191024101609.GA4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024101609.GA4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:16:09PM +0200, Peter Zijlstra wrote:
> +struct trace_event_fields {
> +	const char *type;
> +	union {
> +		struct {
> +			const char *name;
> +			const int  size;
> +			const int  align;
> +			const int  is_signed;
> +			const int  filter_type;

FWIW, I suspect we can do:

			unsigned char size;
			unsigned char align;
			unsigned char is_signed;
			unsigned char filter_type;

And save us some 8 bytes per entry (12 on 32bit).

> +		};
> +		int (*define_fields)(struct trace_event_call *);
> +	};
> +};
