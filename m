Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EAFC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A601E222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rEvcZ0jU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfIZJNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:13:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33288 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfIZJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BGPhPyMbHoebOhIkHTRXWvaIOkpqxXAHdN2RhBHXYjE=; b=rEvcZ0jUhImUckRmdoNi3iLEt
        6PWl8cSmcbBhqXrmINJ9AOwQxAqRUH3kwSfkiI0rb0T+fEwnGRey7Pdl8Jk0BIRAqJ8sOcaYgvGDz
        tkaTxgE6CjmbcLf/VXK28BMxzk1CeGRmIgpsaznfYk+o4PRilAhcNRzQUWIXhpZlOdzcEh+BdwVSD
        pQLwwdIqRcdARE4Xmt8GbnDd8b4qAZh8q8nfk8W98Y+zYoddxevYNJ+Y47VJd4bMV9pj8yDlorvQw
        +DwnvIHw7hzWAZk6PmnDXHCmh6hLSYo+/ul4Q6I+neKqejFbPekhN1/YldMA0YqvS3XHybAUXOtIl
        bj/IVhDtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDPqC-0003Dh-UP; Thu, 26 Sep 2019 09:13:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30CEE306089;
        Thu, 26 Sep 2019 11:12:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E90820138CC0; Thu, 26 Sep 2019 11:13:35 +0200 (CEST)
Date:   Thu, 26 Sep 2019 11:13:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     wangxu <wangxu72@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rfontana@redhat.com, allison@lohutok.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sample/hw_breakpoint: avoid sample hw_breakpoint
 recursion for arm/arm64
Message-ID: <20190926091335.GI4553@hirez.programming.kicks-ass.net>
References: <1569226175-101782-1-git-send-email-wangxu72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569226175-101782-1-git-send-email-wangxu72@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

> This patch provides a chance to avoid sample hw_breakpoint recursion
> for arm/arm64 by adding 'struct perf_event_attr.bp_step'.

This patch also lacks justification for why this needs to come with ABI
changes. There is also a distinct lack of comments.

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

This is just _wrong_.. it says that every event with bp_step set always
is a 'default overflow handler', irrespective of what the overflow
handler actually is.

>  	return false;
>  }
>  

