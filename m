Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC83C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07B9206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DY7yobci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfKRMVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:21:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKRMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EudFgAgyvCEn3d/X553VPoW4NwCn8WogRGd0g565CnI=; b=DY7yobcimM7gBj89fDnaFgx7i
        JUQ7wTvnok2cXZNhABnBvvgzIA+MTdoKTvSasajk9lLzjlaKe+oEVwfX8N31ZNEVxRXLYK6TM0EyT
        96BeeMMRRosp4MmUum/6J5PrkgN9LDyDWjj9dYeKezjZ2ymHGs8df+low+FHIkEkUpv35tP4aOsAP
        V1ewBzVgVPROVfJ8IE/dad06jILpC0DPO8Cql/K22FJ9ZvrhmU+yDR/lHfRHLSf0aMPNIW43oZLQA
        FOWBKFepf3uS+/Yox9W2Y46n0ZzY/ckhN182zH1WwueiQKgqTis3CDsKbcEup+DppREoRg6MXI+8Q
        zgN6VJo0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iWg2F-0006HX-6b; Mon, 18 Nov 2019 12:21:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6FE9300606;
        Mon, 18 Nov 2019 13:20:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09C712B133324; Mon, 18 Nov 2019 13:21:35 +0100 (CET)
Date:   Mon, 18 Nov 2019 13:21:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 02/10] lib: introduce generic min max heap
Message-ID: <20191118122134.GW4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-3-irogers@google.com>
 <7d369058842123c3038d10a631f5fa4c3e7472ff.camel@perches.com>
 <20191118084059.GU4131@hirez.programming.kicks-ass.net>
 <a2254d81e165b8516638ff8d2c89762ad295c30f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2254d81e165b8516638ff8d2c89762ad295c30f.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 03:50:33AM -0800, Joe Perches wrote:
> On Mon, 2019-11-18 at 09:40 +0100, Peter Zijlstra wrote:
> > On Sun, Nov 17, 2019 at 10:28:09AM -0800, Joe Perches wrote:
> > > On Wed, 2019-11-13 at 16:30 -0800, Ian Rogers wrote:
> > > > Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > 
> > > Perhaps some functions are a bit large for inline
> > 
> > It all hard relies on always inline to have the indirect function
> > pointers constant folded and inlined too.
> 
> Then perhaps __always_inline is more appropriate.

It is.
