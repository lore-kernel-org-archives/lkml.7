Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748EE22527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jksB9r7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLMIKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:10:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tx0ZXrqD91cMc7eFMd/K/yknjRvGM17Okd5YIFyfuww=; b=jksB9r7kW8CRbrP+UyBMLysqCW
        NtmZ5y7tSGdfsDJzmP2h2olA+T0T9A0U2LzZZ/ZmwuB/l2qLzt5h3wHUX+/HP1+0VsVgkZ2pjrCvj
        oecZ3OWbIoGu3VRFW7WriDshglWIZJiTdJ8q5XJ6GmcMGa2sF+W0uIEAFklRKjvNCpQsU1PwkLfWZ
        jaCO+qPTMkTITspjkC5UjxkVb0h/UyBQS5ljkpMiyzx+9sNg/MKLLGyjGTB+FkiDLiE2P+XtRitsM
        JJl1ApwAkomKReqkEJrOoaZIyF32lkfvm52wntJMBpWnbr4ZXYSxwdctRmPYkrCIc3O1dzQMqCMTw
        5Z0FRESw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifg21-0000Hn-1n; Fri, 13 Dec 2019 08:10:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44605300130;
        Fri, 13 Dec 2019 09:09:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B949A2B199FDC; Fri, 13 Dec 2019 09:10:33 +0100 (CET)
Date:   Fri, 13 Dec 2019 09:10:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        chenwandun@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        huawei.libin@huawei.com, bobo.shaobowang@huawei.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
Message-ID: <20191213081033.GZ2844@hirez.programming.kicks-ass.net>
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
 <20191212150429.GZ2827@hirez.programming.kicks-ass.net>
 <52112146-a4ee-d09f-b61e-9aa35e2e5298@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52112146-a4ee-d09f-b61e-9aa35e2e5298@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 09:51:30AM +0800, chengjian (D) wrote:
> Hi, Peter
> 
>     I saw the same work in select_idle_core, and I was wondering why the
> per_cpu variable was
> 
> needed for this yesterday. Now I think I probably understand : cpumask may
> be too large,
> 
> putting it on the stack may cause overflow. Is this correct ?

Yes, for instance when NR_CPUS=4096, struct cpumask ends up being 512
bytes, and that is _far_ too large for an on-stack variable, remember we
have relatively small fixed size stacks.
