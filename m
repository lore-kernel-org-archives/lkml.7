Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D32C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277C121473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pfLpWSgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfFNN0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:26:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfFNN0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M218YfQrH0sAPl5Jq0lBSqCW0t/8A3esRHJYs85pj9Y=; b=pfLpWSgY2w4I8UkOmIfszDV4I
        KyUdeayGqCj7TYU3HnrYgxf4ezb7ZGkMKwW3XnNkqhrQFwVwj5iThwVKyc/W5W/LHPfU/3NRBibZJ
        J+YfWNpW6NK13QQupPwy7KQCtujmm040YlgL8OehXCPnH1HKSFswv9Hto6zaXwwoHzwxNa8mHdbgM
        I8najIdzHFembekK7SpHyRXutP5hr20HQza4hSzGQEPjDxblM+y/HtCXgaI+WTVQ0BgUimQfxLsN5
        RNj+7my/obgAlL0DgTk3/ZCo4ypZ1P4gUxEXzt8O1c9qZlKmAi3NjZk9EBnXWzoasj/kOdP36thdR
        hEw6Mo2fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbmE5-0002Cb-7U; Fri, 14 Jun 2019 13:26:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3DF22013F72D; Fri, 14 Jun 2019 15:26:39 +0200 (CEST)
Date:   Fri, 14 Jun 2019 15:26:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
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
Subject: Re: [PATCHv2 0/8] perf/x86: Rework msr probe interface
Message-ID: <20190614132639.GS3436@hirez.programming.kicks-ass.net>
References: <20190531120958.29601-1-jolsa@kernel.org>
 <20190614102046.GB4325@krava>
 <20190614123715.GN3436@hirez.programming.kicks-ass.net>
 <20190614132122.GA3629@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614132122.GA3629@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:21:22PM +0200, Jiri Olsa wrote:
> On Fri, Jun 14, 2019 at 02:37:15PM +0200, Peter Zijlstra wrote:

> > I was waiting a new post because you mentioned something about some
> > people not being happy with this, something about a wonky BIOS failing
> > this on native.
> 
> ah, nope, that's unrelated.. I sent RFC about that today:

Oh, my bad then, I thought they did relate.

>   [RFC] perf/x86/intel: Disable check_msr for real hw
> 
> but while checking on this one, I realized I need to send v3 ;-)

I'll await that then.
