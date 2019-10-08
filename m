Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D513C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5397B2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IVO5vCrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbfJHNCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:02:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHNCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c5W0KXIHh3DqvYs/GI5Y7PNEPT3XGVmPgm/T7mYn4QQ=; b=IVO5vCrJBRAp8yhZI1GsSXPll
        v0pnVUKtlkU1foytKKAv/EfRbW0FyQisjh14FY2Zq9EBQ0emTjuZHCta47Ro5vZyAHfq6f6h/c2AY
        0PUO6uvaQRAy79fMdlJrgbEgJ4Irr7jWSwBSfOvsPXTMPFo6bY6bQOtQUX4l8RfSRn187pCJYBxGP
        jOU0Z3wpUhlfzKtTPvwmZJUAYxVJvCpjbFF8BMByLA2c5KL+7ShziciTqKfUePolP0VzpwqYVcHti
        s8gSfZgunUDGzxDIWawcww9IzcsQ47596syT4xaLkt9BNtL9FNzFlF8i+h7NPypvl0uFU+9d0XASP
        3AqAZVOZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHp8P-0000ns-66; Tue, 08 Oct 2019 13:02:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF84D305EE1;
        Tue,  8 Oct 2019 15:01:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46AAF20245BAE; Tue,  8 Oct 2019 15:02:34 +0200 (CEST)
Date:   Tue, 8 Oct 2019 15:02:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
Message-ID: <20191008130234.GP2294@hirez.programming.kicks-ass.net>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <9bfb3252-c268-8c0c-9c72-65f872e9c8b2@arm.com>
 <CAKfTPtDUFMFnD+RZndx0+8A+V9HV9Hv0TN+p=mAge0VsqS6xmA@mail.gmail.com>
 <3dca46c5-c395-e2b3-a7e8-e9208ba741c8@arm.com>
 <CAKfTPtDGxX11=vgJsV-o-jOxgPmbr0VXWmR6LEVuD6WG=VRXyA@mail.gmail.com>
 <b2d10a98-6688-3909-1bd9-e5700c521d5d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d10a98-6688-3909-1bd9-e5700c521d5d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:21:20AM +0200, Dietmar Eggemann wrote:

> I thought we should always order local variable declarations from
> longest to shortest line but can't find this rule in coding-style.rst
> either.

You're right though, that is generally encouraged. From last years
(2018) KS there was the notion of a subsystem handbook and the tip
tree's submissions thereto can be found there:

  https://lore.kernel.org/lkml/20181107171149.165693799@linutronix.de/

But for some raisin that never actually went anywhere...
