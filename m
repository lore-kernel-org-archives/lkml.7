Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89AAC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924A622CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CgTpuOsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfIDMCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:02:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbfIDMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GsVa4yBAwzmv4Q60UbCa2vOPmiuB6G1uChzTAMk5k7Y=; b=CgTpuOsYCDrY2EiDKKfsx+W3p
        0NqRvwq2ZFunMq46iPRUlz1WguNNOCGRjKWo8MYrW6OXfyaEnb/u9QQoJSvaXQ5G2xbv8nKMryr1T
        rY6SekaoFp8ZIBQJr/pf78ixfls+HMMdjKfxRk1/ih5Bqk1wLfiNaz3WV6anRkbeHXwMv3tMu85vg
        BKJUXqsXLTbv0aqiY0GQA5GnaobxwYx2PcoYqb19oXj5YyoYXL2gg8FO15Ox4/fgzfuYnaoxp7owI
        HwSYdVRSJlrEtcz12WQ8TwqUztWEth573Ba/RdCC/UWiukINgItRv6cU6lu4S3qjLSf92Cq1NnZta
        S3PDJga1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Tze-0004tb-HJ; Wed, 04 Sep 2019 12:02:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 079F5306024;
        Wed,  4 Sep 2019 14:01:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FFFC29D8830A; Wed,  4 Sep 2019 14:02:32 +0200 (CEST)
Date:   Wed, 4 Sep 2019 14:02:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip 0/2] x86: Prohibit kprobes on XEN_EMULATE_PREFIX
Message-ID: <20190904120232.GH2349@hirez.programming.kicks-ass.net>
References: <156759754770.24473.11832897710080799131.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156759754770.24473.11832897710080799131.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:45:47PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> These patches allow x86 instruction decoder to decode
> xen-cpuid which has XEN_EMULATE_PREFIX, and prohibit
> kprobes to probe on it.
> 
> Josh reported that the objtool can not decode such special
> prefixed instructions, and I found that we also have to
> prohibit kprobes to probe on such instruction.
> 
> This series can be applied on -tip master branch which
> has merged Josh's objtool/perf sharing common x86 insn
> decoder series.
> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       x86: xen: insn: Decode XEN_EMULATE_PREFIX correctly
>       x86: kprobes: Prohibit probing on instruction which has Xen prefix
> 
> 
>  arch/x86/include/asm/insn.h             |    2 +
>  arch/x86/include/asm/xen/interface.h    |    7 ++++-
>  arch/x86/include/asm/xen/prefix.h       |   10 +++++++
>  arch/x86/kernel/kprobes/core.c          |    4 +++
>  arch/x86/lib/insn.c                     |   43 +++++++++++++++++++++++++++++++
>  tools/arch/x86/include/asm/insn.h       |    2 +
>  tools/arch/x86/include/asm/xen/prefix.h |   10 +++++++
>  tools/arch/x86/lib/insn.c               |   43 +++++++++++++++++++++++++++++++
>  tools/objtool/sync-check.sh             |    3 +-
>  9 files changed, 121 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/include/asm/xen/prefix.h
>  create mode 100644 tools/arch/x86/include/asm/xen/prefix.h

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
