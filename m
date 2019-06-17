Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7B9C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD6920861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPDVRhlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFQLmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:42:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFQLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4uszJW00MODBjLK3L9wrcqUIoc45r8Ir10eLVpVl2Kk=; b=gPDVRhlClpc6vL5KHnB5+THL+
        dcvJSR3h1g6Xr1fwzhbaEHSG6u0i7bjNgmdjzykCcbWELfBs1OD78S/rzgEMplbIbyu42cAps1nyR
        oi9JzKNaWAA0ZfoTAT+UTq4ReQ1V2asfihQFgcsnyMaE96jpgRIToKBBOJ04jseQ+WXlBrc1X2U0c
        Ld5YBRbJ+F+VrBcCki0pBjCCbKqVIejMEpGNGnykLHJ/+ifilpov8Ud4BG4ryRZqlnNEqFQcfqBsu
        5HulMMsZJu7LJnWviuSAp24Lq5Fqm+BC9WAkzbaG8kFsQoBeYm4JbC7vVWZXAjdVt5t9yI3nCZ2Km
        90K56tu4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcq28-0006yv-1r; Mon, 17 Jun 2019 11:42:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49F5C201D1C97; Mon, 17 Jun 2019 13:42:41 +0200 (CEST)
Date:   Mon, 17 Jun 2019 13:42:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
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
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/8] perf/x86/rapl: Get msr values from new probe
 framework
Message-ID: <20190617114241.GC3419@hirez.programming.kicks-ass.net>
References: <20190616140358.27799-1-jolsa@kernel.org>
 <20190616140358.27799-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616140358.27799-7-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 04:03:56PM +0200, Jiri Olsa wrote:

> +	cfg = array_index_nospec(cfg, NR_RAPL_DOMAINS + 1);

This one fails to build on i386. Istr we had issues like that before.
This makes it build.

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index ddad45ef8757..64ab51ffdf06 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -349,7 +349,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
 		return -EINVAL;
 
-	cfg = array_index_nospec(cfg, NR_RAPL_DOMAINS + 1);
+	cfg = array_index_nospec((long)cfg, NR_RAPL_DOMAINS + 1);
 	bit = cfg - 1;
 
 	/* check event supported */
