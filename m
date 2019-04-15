Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24ABC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707A0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJsspAKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfDOMEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:04:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfDOMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VmLFfbiaIcxEWV4kEBlZ0BMPymLpnk8TU9PQIRS9AOo=; b=qJsspAKowlGOwC6n3mabzISmE
        0kGla+MQ7pKk4zj4oSPamzisYvhl/K44Gjq+xY5rYDq7QtsxmbcqqtCaLzcvlWNuTqFETdsPQbbor
        a0r1ldAqhK3VpnA5UqdIv083vxZwKs6wmIBcsTly73vTdJQrCuSR/WlSUpjru74i+VIdsaeFPWb5U
        I1LQirgdWf7/RdmNunzOpqVsNMCQtHnjDYnC0pg72Ez9/21otYzfUI9Cx2fy6TM2tJDb27bM7Gbyv
        TcH8UaNkedUyaiC5mTZwExDDqBtiU4xSJ4locOaZZZA2HNqbHkvGbY+/047wqw/MZQ7VTSKVA40/J
        AeWh7RmTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG0Lu-0004Im-35; Mon, 15 Apr 2019 12:04:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A56128B6D257; Mon, 15 Apr 2019 14:04:44 +0200 (CEST)
Date:   Mon, 15 Apr 2019 14:04:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bandan Das <bsd@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] perf/x86: descriptive failure messages for PMU init
Message-ID: <20190415120444.GN11158@hirez.programming.kicks-ass.net>
References: <jpg5zrjavmq.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jpg5zrjavmq.fsf@linux.bootlegged.copy>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 03:09:17PM -0400, Bandan Das wrote:
> 
> There's a default warning message that gets printed, however,
> there are various failure conditions:
>  - a msr read can fail
>  - a msr write can fail
>  - a msr has an unexpected value
>  - all msrs have unexpected values (disable PMU)
> 
> Also, commit commit 005bd0077a79 ("perf/x86: Modify error message in
> virtualized environment") completely removed printing the msr in
> question but these messages could be helpful for debugging vPMUs as
> well. Add them back and change them to pr_debugs, this keeps the
> behavior the same for baremetal.
> 
> Lastly, use %llx to silence checkpatch

Yuck... if you're debugging a hypervisor, you can bloody well run your
own kernel with additional print slattered around.

The whole make an exception for virt bullshit was already pushing it,
this is just insane.

> @@ -266,12 +282,30 @@ static bool check_hw_exists(void)
>  	return true;
>  
>  msr_fail:
> -	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +	if (virt)
>  		pr_cont("PMU not available due to virtualization, using software events only.\n");
> -	} else {
> -		pr_cont("Broken PMU hardware detected, using software events only.\n");
> -		pr_err("Failed to access perfctr msr (MSR %x is %Lx)\n",
> -		       reg, val_new);
> +	switch (status) {
> +	case READ_FAIL:
> +		if (virt)
> +			pr_debug("Failed to read perfctr msr (MSR %x)\n", reg);
> +		else
> +			pr_err("Failed to read perfctr msr (MSR %x)\n", reg);
> +		break;
> +	case WRITE_FAIL:
> +		if (virt)
> +			pr_debug("Failed to write perfctr msr (MSR %x, wrote: %llx, read: %llx)\n",
> +				 reg, val, val_new);
> +		else
> +			pr_err("Failed to write perfctr msr (MSR %x, wrote: %llx, read: %llx)\n",
> +				 reg, val, val_new);
> +		break;
> +	case PMU_FAIL:
> +		/* fall through for default message */
> +	default:
> +		if (virt)
> +			pr_debug("Broken PMU hardware detected, using software events only.\n");
> +		else
> +			pr_cont("Broken PMU hardware detected, using software events only.\n");
>  	}
