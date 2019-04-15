Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B22C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A50F20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfDOJsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:48:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDOJsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:48:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52D01C05E76E;
        Mon, 15 Apr 2019 09:48:10 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0ABF460FCD;
        Mon, 15 Apr 2019 09:48:06 +0000 (UTC)
Date:   Mon, 15 Apr 2019 11:48:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Bandan Das <bsd@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] perf/x86: descriptive failure messages for PMU init
Message-ID: <20190415094806.GE13124@krava>
References: <jpg5zrjavmq.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jpg5zrjavmq.fsf@linux.bootlegged.copy>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 15 Apr 2019 09:48:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 03:09:17PM -0400, Bandan Das wrote:

SNIP

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

hum, why can't we have just one pr_err for both virt and bare metal?

jirka

>  	}
>  
>  	return false;
> -- 
> 2.19.2
> 
