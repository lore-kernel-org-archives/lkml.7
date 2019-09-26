Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50BCC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CB0222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfIZKPp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:15:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2427 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfIZKPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:15:44 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id AC3958B5311B5DB79B6C;
        Thu, 26 Sep 2019 18:15:41 +0800 (CST)
Received: from DGGEML525-MBX.china.huawei.com ([169.254.1.34]) by
 DGGEML402-HUB.china.huawei.com ([fe80::fca6:7568:4ee3:c776%31]) with mapi id
 14.03.0439.000; Thu, 26 Sep 2019 18:15:40 +0800
From:   "wangxu (AE)" <wangxu72@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sample/hw_breakpoint: avoid sample hw_breakpoint
 recursion for arm/arm64
Thread-Topic: [PATCH] sample/hw_breakpoint: avoid sample hw_breakpoint
 recursion for arm/arm64
Thread-Index: AQHVdEq1BGsSxRYj+0SlJ3i2DIl9n6c9rv+Q
Date:   Thu, 26 Sep 2019 10:15:39 +0000
Message-ID: <FCFCADD62FC0CA4FAEA05F13220975B01717C7F7@dggeml525-mbx.china.huawei.com>
References: <1569226175-101782-1-git-send-email-wangxu72@huawei.com>
 <20190926091335.GI4553@hirez.programming.kicks-ass.net>
In-Reply-To: <20190926091335.GI4553@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.61.27.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Peter Zijlstra [mailto:peterz@infradead.org] 
Sent: Thursday, September 26, 2019 5:14 PM
To: wangxu (AE) <wangxu72@huawei.com>
Cc: mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com; alexander.shishkin@linux.intel.com; namhyung@kernel.org; gregkh@linuxfoundation.org; tglx@linutronix.de; rfontana@redhat.com; allison@lohutok.net; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sample/hw_breakpoint: avoid sample hw_breakpoint recursion for arm/arm64

On Mon, Sep 23, 2019 at 04:09:35PM +0800, wangxu wrote:
> From: Wang Xu <wangxu72@huawei.com>
> 
> For x86/ppc, hw_breakpoint is triggered after the instruction is 
> executed.
> 
> For arm/arm64, which is triggered before the instruction executed.
> Arm/arm64 skips the instruction by using single step. But it only 
> supports default overflow_handler.

Where is the recusion.. ?

For arm/arm64, hw_breakpoint is triggered before the instruction executed.
When instruction_A is triggered, watchpoint_handler() will deal with this exception, and after return instruction_A will be triggerd ...

One using samples/hw_breakpoint/data_breakpoint.c in arm/arm64 will meet this problem.


> This patch provides a chance to avoid sample hw_breakpoint recursion 
> for arm/arm64 by adding 'struct perf_event_attr.bp_step'.

This patch also lacks justification for why this needs to come with ABI changes. There is also a distinct lack of comments.

I agree too. but have no better idea... 
This problem is really a big pit, especially for one not familiar with implementation differences in hw breakpoint for different architectures.



> Signed-off-by: Wang Xu <wangxu72@huawei.com>
> ---
>  include/linux/perf_event.h              | 3 +++
>  include/uapi/linux/perf_event.h         | 3 ++-
>  samples/hw_breakpoint/data_breakpoint.c | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h 
> index 61448c1..f270eb7 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1024,6 +1024,9 @@ extern int perf_event_output(struct perf_event *event,
>  		return true;
>  	if (unlikely(event->overflow_handler == perf_event_output_backward))
>  		return true;
> +	/* avoid sample hw_breakpoint recursion */
> +	if (unlikely(event->attr.bp_step))
> +		return true;

This is just _wrong_.. it says that every event with bp_step set always is a 'default overflow handler', irrespective of what the overflow handler actually is.

Thanks for comments.

Function is_default_overflow_handler() was introduced in 1879445dfa7bbd6fe21b09c5cc72f4934798afed , which is only be called in arch/arm[64]/kernel/hw_breakpoint.c, and will never be used in other arch/ (I think). 

But keeping is_default_overflow_handler() unchanged, changing ' if (is_default_overflow_handler(bp)) ' to ' if (is_default_overflow_handler(bp) || unlikely(event->attr.bp_step) ) ' will be better in arch/arm[64]/kernel/hw_breakpoint.c.

>  	return false;
>  }
>  

