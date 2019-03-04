Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB761C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756BD206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1cTu+zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCDRo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:44:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfCDRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WjkeZwxCup1+yg1lF/mNax5f4q18OsjiaJGhTkD9zyo=; b=f1cTu+zOlCXhs7ahpbfdooggW
        nbqdidWC2PUzz+3DIUv0LErO7+IRpWNrMYRNhcFQNsjNzOdjFOSzp+0Qvy3kzgzWi/M4hL+zypNa4
        h/VkeDl32nPKSX6FNXvuq6RsKgXN3prCy1udp85zJYpkj/RywNIQ4UCuUu5cn/lDeLKa2TA1DFN1K
        XR11SYmq27qeOLttBYrLkiXRAjTIBlar1R9lGY7RUBi7WILFGC5DdWcWjRrN8goPbQEN8S3EIhlqJ
        7mDUaW06B5yvRit0kP/fIaasxz6gD5P3Y2xaTpp7snBhhXPK6+5NAqz76sggBdGbdz756QpzMYsAu
        7VsEfw09g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0re3-0004SO-3p; Mon, 04 Mar 2019 17:44:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A53620288BA6; Mon,  4 Mar 2019 18:44:53 +0100 (CET)
Date:   Mon, 4 Mar 2019 18:44:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     =?utf-8?B?V2FuZywgVmluY2VudCAo546L5LqJKQ==?= 
        <Vincent.Wang@unisoc.com>,
        =?utf-8?B?WmhhbmcsIENodW55YW4gKOW8oOaYpeiJsyk=?= 
        <Chunyan.Zhang@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjRdIHNj?=
 =?utf-8?Q?hed=2Fcpufreq=3A_initializ?= =?utf-8?Q?e?= iowait_boost_max and
 iowait_boost with cpu capacity
Message-ID: <20190304174453.GV32534@hirez.programming.kicks-ass.net>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
 <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin>
 <20190304152616.GM32494@hirez.programming.kicks-ass.net>
 <20190304164816.4fnxxesjwzdoqria@queper01-lin>
 <20190304174028.GO32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304174028.GO32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 06:40:28PM +0100, Peter Zijlstra wrote:

> 	/*
> 	 * @util is already in capacity scale, convert iowait_boost
> 	 * into the same scale so we can compare.
> 	 */
> 	boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
> 	util = max(boost, util);
> 	return min(util, max);

Ah, I don't think we need that last min in this case; both terms should
already be <= SCHED_CAPACITY_SCALE.
