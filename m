Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A1521883
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xZw6Yyz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfH1Iwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:52:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45662 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1Iwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5Q83mTglAkKXyC+Y0UqudjISX6lQKt8C4Ce1Rh9Mo7Y=; b=xZw6Yyz+SBp/TTHSm2OAqYA1N
        iQIpVvzMm3GLqfBQMI+e+QRKsJ9+sFcvFokXh2vhghnvO71dljYSIjUorFy2rtDMSKAcMy+nYuJms
        A/7B6g1SZO674ckCBmRMLf4m/P6lc3h6qAhqKOe/QQ6AR9sJ6tD8+49NiHaqT+1QecMLAqEQqFsR3
        khp4yzyF0yT5gLbEirr9zZPqOgpwtoBJmOp+dHrbWXkSGrSVPSLgBDVzaVMWmryd0I51K0HEXreC/
        zTPiA2cNwWpbY/4oq3dF1hcYVuEAy/qorvxlIHWCNhdUvNevkzzh8De6w53TxSdavTETtL93Cxa42
        1AGITfjBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2tgi-0007oh-9Q; Wed, 28 Aug 2019 08:52:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 577DC3074C6;
        Wed, 28 Aug 2019 10:51:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C9F820230B0B; Wed, 28 Aug 2019 10:52:17 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:52:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 2/8] perf/x86/intel: Basic support for metrics
 counters
Message-ID: <20190828085217.GD2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826144740.10163-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:47:34AM -0700, kan.liang@linux.intel.com wrote:
> +#define INTEL_PMC_IDX_FIXED_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 16)
> +#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 0)
> +#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 1)
> +#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 2)
> +#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_FIXED_METRIC_BASE + 3)
> +#define INTEL_PMC_MSK_TOPDOWN			((0xfull << INTEL_PMC_IDX_FIXED_METRIC_BASE) | \
> +						 INTEL_PMC_MSK_FIXED_SLOTS)

> +
> +#define INTEL_PMC_CLEAR_TOPDOWN_BIT(bit)	(~(0x1ull << bit) & INTEL_PMC_MSK_TOPDOWN)

That thing is a clear misnomer; it is OTHER_TOPDOWN_BITS(). Fixed that
too.
