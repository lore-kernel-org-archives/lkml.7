Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D924C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1752081B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hlw78MeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfHaJSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 05:18:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHaJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 05:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3eFAuIavvhkkXpaoSObdJRD+mB6l5THOKa3OP4PCgVA=; b=hlw78MeSadjwLy0PloSqG9Ser
        9SJyTf8YOUD7Dnt1e/0ENTLCNRIUFnhrKJPDIdo4fX+N8C2P+kbjjXYZEqh2OnoLSF8wJwHLX6pG5
        C1xHmeq+irT3+zbK/CB5QMMPPM9D+YLndA+rnQzRo+GJScoEiKPW6CEpRdzzAX1KmZhhtwq0uy2nH
        vNkLzhNdRS1eGsgCgue3E1oP9pxa9ZVPU843RAMWOrI0XjwWUFsGiV3SlGDWW3cGQ3WvgtxlEuaNQ
        QrCW6fIpLChDvEFDkm/bV9YQlqbmTE92U1RIF9+vKEc9Q5FOhi4j4nuaYT65n2tqRvNJuvoIoi69t
        kS6pAstfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3zWG-0001jL-NR; Sat, 31 Aug 2019 09:18:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08733301A76;
        Sat, 31 Aug 2019 11:17:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF24329B2CD15; Sat, 31 Aug 2019 11:18:02 +0200 (CEST)
Date:   Sat, 31 Aug 2019 11:18:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190831091802.GI2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828151921.GD17205@worktop.programming.kicks-ass.net>
 <fd95a255-4499-2907-8af9-d340f157da68@linux.intel.com>
 <20190829135256.GW2369@hirez.programming.kicks-ass.net>
 <cc2ee16d-b10f-a31e-7411-320e90413ceb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2ee16d-b10f-a31e-7411-320e90413ceb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:56:02PM -0400, Liang, Kan wrote:
> On 8/29/2019 9:52 AM, Peter Zijlstra wrote:

> > What what? The PERF_METRICS contents depends on the FIXCTR3 value ?!
> 
> Yes.
> 
> For current implementation, PERF_METRIC MSR is composed by four fields,
> backend bound, frontend bound, bad speculation and retiring.
> Each of the fields are populated using the below formula for eg:
> PERF_METRIC[RETIRING] = (0xFF *
> PERF_METRICS_RETIRING_INTERNAL_48bit_COUNTER)
> / FIXCTR3

So it really depends on the actual exposed FIXCTR3 _value_ to compute
the PERF_METRIC field? *mind boggles*, that's really unspeakable crap.
And this isn't documented anywhere afaict.

I was thinking they've have an internal counter for the SLOTS value too,
so the PERF_METRIC fields are indenpendent; which would be like 'sane'.

Exposing the internal counters would've been _soooo_ much better, just
add 4 more fixed counters and call it a day.

> The METRICS_OVF indicates the overflow of any internal counters.

OK, but I'm thinking that by that time the fraction in PERF_METRIC will
be too coarse and we're loosing precision. Reconstruction will be
inaccurate.

> The internal counters only start counting from 0, which cannot be programmed
> by SW. But resetting the PERF_METRIC would implicitly resetting the internal
> counters.

The only possible option given the choices.
