Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ADAC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3689E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OEK/IdtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfGSIMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:12:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50502 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGSIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XwgdwCME2zahFchrEFYrI+Nh5dkMVpF2Ut0IUwgjsh4=; b=OEK/IdtF1FDSiPeGIwnXMIw3P
        kW2TNSm/ll6i7z628R78+foJNrMUo8reB8O0dp+k3rK7oZKak/I5m3kvOegNvebT09TRjX1CCMJc/
        rX2auXuKqykxHfrDWhZBznKGQ8FvP5AocT8rk28ZMevyfBl1+Rh7XogKuNJzskNEwTrsLUuEdA/oc
        H+HCfCHqPfgQalZfaBhPCLQXe+IW3eBmkHv8Gd8sIoo2rO2Hat7+IwWNO5HHptn9rqlO1LVOEZ3ZQ
        Zoj45IkfoA8W9ggfxTFy3XFAywTgwmJVzW05i3SjtEJs3S9iGa1JRnyn9xIWoRN2LLVWmyVERthxs
        wfIRhGUsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoNzk-0004uj-Iy; Fri, 19 Jul 2019 08:12:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE95220BA53FF; Fri, 19 Jul 2019 10:11:56 +0200 (CEST)
Date:   Fri, 19 Jul 2019 10:11:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cputime: remove rq parameter for
 irqtime_account_process_tick func
Message-ID: <20190719081156.GE3419@hirez.programming.kicks-ass.net>
References: <20190719024242.249429-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719024242.249429-1-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 10:42:41AM +0800, Alex Shi wrote:
> Using the per cpu rq in function directly is enough, don't need get and
> pass it from outside as a parameter. That's make function neat.

Please look at code-gen; I'm thinking this patch makes things worse.
