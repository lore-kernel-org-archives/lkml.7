Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A67723407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TmdCTuad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfH3HTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:19:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfH3HTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w1SF78Kk0E6HLyNwS5UYNieyf6tAgGpx5WCCw58u+14=; b=TmdCTuadbEDWKBDjPAR48Zg9k
        IvIl/cF5dZhNltgANev4nrj8oAQmTddvp3eLwX3tLVmDYIV7fB4Hy3dzVP+oQPg7udwTsgl8ov94k
        UelhkrFj+kxkoTwq+fKHHUWLVhaZfq+K9l0wJjZ6xup/HwZv8HL18gky+vkDe+Ns0fiy78WC+ENyu
        UVJdO/sQsu+7SmF0zsYBNzjNFok/bxyqzDViZz/uQ5EcfhcjjQidZJYBLXOP1zl6e8WOJ5s3Kn/kn
        ZO4MNXBeMFzjqdK9KKCpmZXGiOR0+QLLvjU1vcjsVuZbMWwOoin0UABc6PYcxG02SRZ8htQc5u/fK
        kjTVIKLcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3bBf-0000Qt-AB; Fri, 30 Aug 2019 07:19:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D53C305615;
        Fri, 30 Aug 2019 09:18:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A47A4202411AD; Fri, 30 Aug 2019 09:19:08 +0200 (CEST)
Date:   Fri, 30 Aug 2019 09:19:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-ID: <20190830071908.GY2369@hirez.programming.kicks-ass.net>
References: <cover.1567118001.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567118001.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 05:41:17PM -0500, Josh Poimboeuf wrote:
> It's kind of silly that we have *three* identical copies of the x86 insn
> decoder in the kernel tree.  Make it approximately 50% less silly by
> reducing that number to two.
> 
> Josh Poimboeuf (4):
>   objtool: Move x86 insn decoder to a common location
>   perf: Update .gitignore file
>   perf intel-pt: Remove inat.c from build dependency list
>   perf intel-pt: Use shared x86 insn decoder

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
