Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A416AC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696612089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUGNQZgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfHFOah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:30:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHFOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ORnpRyRB/Cnq+tky6y21/RB5sBnIUFs1FU8sW3or4Bg=; b=MUGNQZgTE/4cHkgWg/g9QctLi
        MIg3qmglK28E+5bgKLirhrTunDoxI5GayA6wGJCvomlHVdkHp4xqpwuBlnIBOwr1fyoWWgY58nft4
        HlaZx6XSxF2uAk6NuFZQ9cSdsyWCvqtyiaHuq1yRIdCk05stjjEIpv67A7BKNZXA30dLcXlb3D/+Q
        tHkuSoqc0Sshh9KQhYPWCRlVWKoAF4snptQViZT5gpJ/At/daBt7619R3KwXoEZduypD5IKUPkPnb
        kJZjSzAhQvfDzsW7cIItexT4+twCYTwaHUYds9pMWl54hix2gzYO0GdFHYoRUZmz1Eq0yFuny7JR2
        U547KRNkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv0Ty-0003PL-Gr; Tue, 06 Aug 2019 14:30:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98E573067E2;
        Tue,  6 Aug 2019 16:30:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F27EF201B3F8D; Tue,  6 Aug 2019 16:30:32 +0200 (CEST)
Date:   Tue, 6 Aug 2019 16:30:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v6 0/7] perf, intel: Add support for PEBS output to Intel
 PT
Message-ID: <20190806143032.GU2332@hirez.programming.kicks-ass.net>
References: <20190806084606.4021-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806084606.4021-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:45:59AM +0300, Alexander Shishkin wrote:

> Seventh attempt at the PEBS-via-PT feature. The previous ones were [1], [2],
> [3], [4], [5], [6]. This one finalizes the 'aux_output' naming in the code.

> Alexander Shishkin (2):
>   perf: Allow normal events to output AUX data
>   perf/x86/intel: Support PEBS output to PT

Thanks Alexander!, I've picked up the above two patches.

> Adrian Hunter (5):
>   perf tools: Add aux_output attribute flag
>   perf tools: Add itrace option 'o' to synthesize aux-output events
>   perf intel-pt: Process options for PEBS event synthesis
>   perf tools: Add aux-output config term
>   perf intel-pt: Add brief documentation for PEBS via Intel PT

Arnaldo, can you either ack (in which case I'll pick them up) or
otherwise take care of these?


