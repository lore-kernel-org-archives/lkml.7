Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B731A20684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zua/r/g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfJVJjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:39:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfJVJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=acThF1bOk9bXuRmVcW3q6i/cux2dGk4YpzGP0gYc/pc=; b=Zua/r/g6FcRHhw875UEh/xUmD
        b/V3n7hztHkZ0XScW3lFHBsdV3dFEbEBhL3F85pSzU8IK0XIRQ/GEMedqGUcE5hOtbPu+eP8bPQuI
        VW9jmRfjR/QDyiHImwUqXXTuOZLh5zhCicwiYWPgbbNfcrL8FOBsOd4mOq0PrOjL+7+s8CaPmR0vm
        gJqgE7AvT6MXd3xwLVw1qHjb+hy265N14PKc6hMxHdRpy1PxvpR5r3lN/Dwt/AWe2ynW9Lh1M2D7R
        4TYEOLNcxTySA4ni1CTLnH1obO0/YLLWd833j5ah9yvPzo9JATrk1FtcNh2Av3XxcROAyALgyAK07
        439wjsIHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMqdT-0002lX-U5; Tue, 22 Oct 2019 09:39:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C557F300EBF;
        Tue, 22 Oct 2019 11:38:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E8CF20977B04; Tue, 22 Oct 2019 11:39:26 +0200 (CEST)
Date:   Tue, 22 Oct 2019 11:39:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V2 01/13] perf/core: Add new branch sample type for LBR
 TOS
Message-ID: <20191022093926.GH1800@hirez.programming.kicks-ass.net>
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
 <20191021200314.1613-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021200314.1613-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 01:03:02PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> In LBR call stack mode, the depth of reconstructed LBR call stack limits
> to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
> perf tool may stitch the stacks of two samples. The reconstructed LBR
> call stack can break the HW limitation.
> 
> Add a new branch sample type to retrieve LBR TOS.
> 
> Only when the new branch sample type is set, the TOS information is
> dumped into the PERF_SAMPLE_BRANCH_STACK output.
> Perf tool should check the attr.branch_sample_type, and apply the
> corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
> Otherwise, some user case may be broken. For example, users may parse a
> perf.data, which include the new branch sample type, with an old version
> perf tool (without the check). Users probably get incorrect information
> without any warning.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h      |  4 ++++
>  include/uapi/linux/perf_event.h | 10 +++++++++-
>  kernel/events/core.c            | 10 ++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..0cebc8ec44fa 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -972,6 +972,10 @@ struct perf_sample_data {
>  	u64				stack_user_size;
>  
>  	u64				phys_addr;
> +
> +	/* PMU specific data */
> +	u64				lbr_tos;
> +
>  } ____cacheline_aligned;

Last time you put this in perf_branch_stack, that was a much better
place. Can't this work now?
