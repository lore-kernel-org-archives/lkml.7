Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F16BC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0447520665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lZ/ih76n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfFYHQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:16:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54068 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfFYHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ek+8zjVVNqNCck9ELy55SriRD5X2pM4qdyS7kz5qJA=; b=lZ/ih76nVxve2C5K2XWV1DMZu
        tPyxSyTpO7C3Dhp6Pz36BhPg/TiOTINDtqx/YXq4CIJoteSPlPKJsFvuBix6LHB/3iq4Z874OrUbm
        rcjjZCAwykXL+EwFuygfsRxOxDHR3jv0ah8ohblU6A6Wpj5yeb38yZjtXN48Q58htE6HfiAtaPFkR
        XY0lS5PEoROWQTF70DnpnvjX2ZIFK1e06rzht84GFTQgqqRmcyb0b/zbBr6nR1PZvkUWtkjgYiyuT
        eFff2MIQ4O4Oq/jNugN7rHpsaoMSI26FPF4YmGL2iju5mpgoI+7V85BdXQtoFA0MNZwyw0WcALN9r
        lGmG2Tn0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfffv-00020F-Qc; Tue, 25 Jun 2019 07:15:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEEB320A05DA6; Tue, 25 Jun 2019 09:15:28 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:15:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190625071528.GM3436@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:53:04PM -0500, Gustavo A. R. Silva wrote:
> Once the C++17 `__attribute__((fallthrough))` is more widely handled by C compilers,

From what I read that attribute landed in the exact same GCC version as
the warning. And last I checked clang wasn't there yet anyway.

> static analyzers, and IDEs, we can switch to using that instead. Also, we are a few

I don't give a crap about lousy IDEs. And coverity already supports the
attribute and other checkers are open-source and can be easily fixed or
ignored.

> warnings away (less than five) from being able to enable -Wimplicit-fallthrough. After
> this option has been finally enabled (in v5.3) we can easily go and replace the comments
> to whatever we agree upon.

Feh. Still an abomination.
