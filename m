Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57562C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2713D2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ErYDw41F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfDELEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:04:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35420 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbfDELEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tK5zfbhT5Ego+Q1oTlHmUvYN1T2+Z3c1MXEukS68Ees=; b=ErYDw41FD1rT+GRbS/TQbd13C
        CP85240gX2TnV+2suNGgIrXjDdLEgw7BaMGg2/A/eQl0aPNj8OO50aS5tVaL8FB9IJA7JX9/hbcQo
        2Gdm5e+0DOt4/wrSGAgc8Aa6YndhtP9z1hU1F4nVmYrVT5n6sbsJX6AgS1jORdNNo2NaV4y2lBjGU
        2bV2z4lwSsnso3iVioxfgj8JbhWyAbl5gUH753OS/EOkzsbsEc3PdBhhGAGwQ1L+etMecLly+8vzR
        U++kGSq72hhTTkZOeGKzEa6m0li216tQC/+fn9F0dC68Xv4ltYD2KG8BHfOo8NsfbmApaqEo/U6v9
        I1ShJ8psw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCMds-0003aV-OY; Fri, 05 Apr 2019 11:04:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A28521AA0DE9; Fri,  5 Apr 2019 13:04:15 +0200 (CEST)
Date:   Fri, 5 Apr 2019 13:04:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] sched/core: expand sched_getaffinity(2) to return number
 of CPUs
Message-ID: <20190405110415.GP12232@hirez.programming.kicks-ass.net>
References: <20190403200809.GA13876@avx2>
 <20190404084249.GS4038@hirez.programming.kicks-ass.net>
 <87wok83gfs.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wok83gfs.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 12:16:39PM +0200, Florian Weimer wrote:

> > True; but I suppose glibc already does lots of that anyway, right? It
> > does contain the right information.
> 
> If I recall correctly my last investigation,
> /sys/devices/system/cpu/possible does not reflect the size of the
> affinity mask, either.

Strictly speaking correct; the bitmap can be longer than the highest
possible cpu number, however the remainder would be 0-padding and could
thus be stripped without issue.

So a bitmap sized to fit the max possible cpu number, should for all
practical purposes suffice.


