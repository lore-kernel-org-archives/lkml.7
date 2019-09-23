Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13248C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C53208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UPuXtBmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfIWJHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:07:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfIWJHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AjuKs2CX8YZOaZpDdYn464XH+IGUCzon57YKAFj2bE4=; b=UPuXtBmuKBTIoDbRHzW020qs4
        bpZ5pOwRuM2jaAsZQlWMbIlj8LdsZV3W16eWXWMKgscrdPbg9VxZj9lfSgr3qzEVebE1ae7Po2w69
        HFoM8xqgsyaWY0VWBmvuZod40xPSovIimc4lL5IunH3JcFlSTZKTSMuRDI5D+CVc8yLQkOe5er/yC
        8WLSATSerjr27Q+baLLt0W87woenejlsOszCwGWR9ZpBeLCfJQfNtFvGsTxpPkBoqowZ7sJKzOmAR
        OOoIrdYcLKissVkbUhJcLPpOeDNGzPynkNPhjDz/6KTWqAQshVSH4C+ZdUoptOTmEA/LOXwuj5qho
        eCeeA4TeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCKIp-0001hv-1D; Mon, 23 Sep 2019 09:06:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5BDC3060D5;
        Mon, 23 Sep 2019 11:05:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 772822B1204E2; Mon, 23 Sep 2019 11:06:36 +0200 (CEST)
Date:   Mon, 23 Sep 2019 11:06:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH for 5.4 0/7] Membarrier fixes and cleanups
Message-ID: <20190923090636.GH2349@hirez.programming.kicks-ass.net>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 01:36:58PM -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> Those series of fixes and cleanups are initially motivated by the report
> of race in membarrier, which can load p->mm->membarrier_state after mm
> has been freed (use-after-free).
> 

The lot looks good to me; what do you want done with them (them being
RFC and all) ?
