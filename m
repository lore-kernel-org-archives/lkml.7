Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD5E214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gczC5kEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfE1OF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:05:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50562 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1OF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x9AREU78wDa9PBUDBxEftQKPg0c8hz4x/bLmf+9GcpQ=; b=gczC5kEji2unkiDt8TjEfNkqD
        nNiKfI9BuVAEgXXKhZerxf1jtCCxn7i9uYMRuyQQey4g7C4HOF7ZFdvWuYk57ps8tAH7p1tnwe7lL
        x3VCuu5K/55TpWeZrWVaWu4TOvXBuOFgoILR4hrTYBk/9JgGhiunTo7rEfKJqECJTFDf4wAtV3t4H
        /Gl+F75FbnKrAg+7jAafOUP4XoNV2pxjZG1D7mruxHsSic7y5c8xmjeRGEmTwMOdttGIGfeQJ9R40
        3Sa47u2yFVaGB1WF46gawc/hX4872Q/MgypI20+DkPwhe3jEUx0NGT/VwNuYoIDsUWsLPWIGttYC2
        iSr++QDyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVcjA-0004RZ-8V; Tue, 28 May 2019 14:05:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 088B420750761; Tue, 28 May 2019 16:05:19 +0200 (CEST)
Date:   Tue, 28 May 2019 16:05:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, acme@redhat.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, jolsa@redhat.com, eranian@google.com
Subject: Re: [PATCH V2 1/3] perf/x86: Disable non generic regs for
 software/probe events
Message-ID: <20190528140518.GU2623@hirez.programming.kicks-ass.net>
References: <1558984077-7773-1-git-send-email-kan.liang@linux.intel.com>
 <20190528085601.GL2623@hirez.programming.kicks-ass.net>
 <7c8d8998-4722-e059-d378-b8517193e32f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8d8998-4722-e059-d378-b8517193e32f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 09:33:40AM -0400, Liang, Kan wrote:
> Uncore PMU doesn't support sampling. It will return -EINVAL.
> There is no regs support for counting. The request will be ignored.
> 
> I think current check for uncore is good enough.

breakpoints then.. There's also no guarantee you covered all software
events, and the core rewrite will allow other per-task/sampling PMUs
too.

The approach you take is just not complete, don't do that.
