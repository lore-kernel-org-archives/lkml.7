Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C28C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92A4208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GxUQo4N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439036AbfFLMlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:41:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39454 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437124AbfFLMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CJ0kAWx2t5ZsPNEx9cJy2uFhX/oECkRLjy4BfZjgLq4=; b=GxUQo4N/Hj5p74ptLoAYnpHOr
        T7HIAz/qOXDbceHdhZdWbZu4BEaPbHhPlmz40obgh5klymVS+PBgy4ccWWU8gTzQlHj2u8saQT4+H
        zT0yNa+qArI9k7pwrJDVuh9OTjTotnJbP0s1YS9cZxy1Q8d1+xCna4nlSJDcndPL5s+cx8cPkmvVE
        p/eGIl/NwgCPN+NOcYxjCoZMyOp+Y8GbsgborNh7ZJe3PA81UO44iymiceYA4VD1WxAh33sv7rOiE
        vg+1nANOm+NT38Z5hDGz2CZn6F6NBxuWpoBhxZRD3oSyr9lqCUIzUITtcLRQyp/11bHFd4YN8jjiz
        SwHmTVtng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb2ZF-000691-AT; Wed, 12 Jun 2019 12:41:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 806F8203BF963; Wed, 12 Jun 2019 14:31:51 +0200 (CEST)
Date:   Wed, 12 Jun 2019 14:31:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>,
        arnd@arndb.de
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
Message-ID: <20190612123151.GL3463@hirez.programming.kicks-ass.net>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net>
 <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 02:28:43PM +0200, Peter Zijlstra wrote:

> AFAICT only: alpha, h8300, hexagon, m68knommu, nds32, nios2, openrisc
> are lacking any form of sched_clock(), the rest has it either natively
> or through sched_clock_register().

Scratch nds32, they use drivers/clocksource/timer-atcpit100.c

Thanks Arnd!
