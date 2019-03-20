Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D9BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E62186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9QDC1MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCTPsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:48:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfCTPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yIV/CqdM2K4P3aYr3Az75saF2I7GZs2msAV2eZYu8Zw=; b=V9QDC1MJMhZKVI723uY7pqqd7
        K8BY8QSRf6AAYRsWFCtu2HAKlGi+jGZgc7F0IoFVQmZ1cqSoVV4mK4sQSahZ7O1uR7tDb9wcG50kp
        vTxCIXCU2UI5NVNNWg/0IAt0lazwSHGBooIFTyjuV/HRsMOFxbyGs5r9WEYWoUTKXoFKSbAizQr1T
        lKKUSyDRB3q60xqe/YFLvXKhH64tBp1/oGSUoMr9DQcrez6FP3JSQu2QDV1rkAtcB6UmabFeCk8QE
        ZJrBf1B+K5YgY/nwG0vwS4Ij2OYdqGdn/JNYyn+u46O81UOsDxJsI6ZC8Ryq7xAgc/CQN9SlDI2hd
        fYz1FXZrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6dSG-000461-TZ; Wed, 20 Mar 2019 15:48:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD5AA2847D055; Wed, 20 Mar 2019 16:48:33 +0100 (CET)
Date:   Wed, 20 Mar 2019 16:48:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/8] perf/x86: Add msr probe interface
Message-ID: <20190320154833.GH6058@hirez.programming.kicks-ass.net>
References: <20190318182116.17388-1-jolsa@kernel.org>
 <20190318182116.17388-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318182116.17388-2-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 07:21:09PM +0100, Jiri Olsa wrote:
> Adding perf_msr_probe function to provide interface for
> checking up on MSR register and add its related event
> attributes if it passes the check.
> 
> User defines following struct for each MSR register:
> 
>   struct perf_msr {
>        u64                       msr;
>        struct attribute        **attrs;
>        bool                    (*test)(int idx, void *data);
>        bool                      no_check;
>   };
> 
> Where:
>   msr      - is the MSR address
>   attrs    - is attributes array to add if the check passed
>   test     - is test function pointer
>   no_check - is bool that bypass the check and adds the
>               attribute without any test
> 
> The array of struct perf_msr is passed into:
> 
>   perf_msr_probe(struct perf_msr *msr, int cnt,
>                 struct attribute **attrs, void *data)
> 
> Together with:
>   cnt   - which is the number of struct msr array elements
>   attrs - which is an array placeholder for added attributes
>           and needs to be big enough
>   data  -which is user pointer passed to the test function
> 
> The perf_msr_probe will executed test code, read the MSR and
> check the value is != 0. If all these tests pass, related
> attributes are added into attrs array.
> 
> Also adding MSR_ATTR macro helper to define attribute array
> from single attribute. It will be used in following patches.

Somewhere along the line you lost the explanation of _why_ we're doing
this; namely: virt sucks.

Also, recently GregKH had a chance to look at perf code and we scored
fairly high on the WTF'o'meter for what we're doing with the attribute
stuff.

He pointed me to sysfs attribute_group::is_visible functions to replace
some of our 'creative' code.

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/events/Makefile |  2 +-
>  arch/x86/events/probe.c  | 36 ++++++++++++++++++++++++++++++++++++
>  arch/x86/events/probe.h  | 22 ++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/events/probe.c
>  create mode 100644 arch/x86/events/probe.h
> 
> diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
> index b8ccdb5c9244..ec29a466444a 100644
> --- a/arch/x86/events/Makefile
> +++ b/arch/x86/events/Makefile
> @@ -1,4 +1,4 @@
> -obj-y					+= core.o
> +obj-y					+= core.o probe.o
>  obj-y					+= amd/
>  obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
>  obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
> diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
> new file mode 100644
> index 000000000000..0052b730c55e
> --- /dev/null
> +++ b/arch/x86/events/probe.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/export.h>
> +#include <linux/bits.h>
> +#include "probe.h"
> +
> +unsigned long
> +perf_msr_probe(struct perf_msr *msr, int cnt,
> +	       struct attribute **attrs, void *data)
> +{
> +	unsigned long avail = 0;
> +	unsigned int bit;
> +	u64 val;
> +
> +	if (cnt >= BITS_PER_LONG)
> +		return 0;
> +
> +	for (bit = 0; bit < cnt; bit++) {
> +		struct attribute **a = msr[bit].attrs;
> +
> +		if (!msr[bit].no_check) {
> +			if (msr[bit].test && !msr[bit].test(bit, data))
> +				continue;
> +			if (rdmsrl_safe(msr[bit].msr, &val) || !val)
> +				continue;
> +		}
> +
> +		while (*a)
> +			*attrs++ = *a++;
> +
> +		avail |= bit;
> +	}
> +
> +	*attrs = NULL;
> +	return avail;
> +}
> +EXPORT_SYMBOL_GPL(perf_msr_probe);
> diff --git a/arch/x86/events/probe.h b/arch/x86/events/probe.h
> new file mode 100644
> index 000000000000..42dd666533c3
> --- /dev/null
> +++ b/arch/x86/events/probe.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ARCH_X86_EVENTS_PROBE_H__
> +#define __ARCH_X86_EVENTS_PROBE_H__
> +#include <linux/sysfs.h>
> +
> +#define MSR_ATTR(__n)				\
> +static struct attribute *msr_##__n[] = {	\
> +	&__n.attr.attr,				\
> +	NULL,					\
> +}
> +
> +struct perf_msr {
> +	u64			  msr;
> +	struct attribute	**attrs;
> +	bool			(*test)(int idx, void *data);
> +	bool			  no_check;
> +};
> +
> +unsigned long
> +perf_msr_probe(struct perf_msr *msr, int cnt,
> +	       struct attribute **attrs, void *data);
> +#endif /* __ARCH_X86_EVENTS_PROBE_H__ */
> -- 
> 2.17.2
> 
