Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E327EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF4920820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o7edWMP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfDDK3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:29:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54188 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfDDK3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bUfVMNqb74o/rYZDWwpLqrNml2glBxW72FelcAS65tA=; b=o7edWMP389+IuSXaCKcEix3er
        2FIU70Sh7JZZEJblsRDqKD+0tpBFEc6fdYe2kkwMGPNGwbV33r797aTEV+vP3ZD3SUTTLdDUKXoMa
        /+giyf3M95ZvvendMK2flJ0+NQxsp+Kk7G/tN+GEv0ltRsKD8iIxHsdjFog9QiGW3I66kdFYsasLs
        ds6Roo7gZDIANll0ceNDVkUvlq/F1Y8SMlTWGye/y7nbb4uQIhUk5EBFaU/S8tbvdEi8lZSb5U7jT
        iab/uaZ2H/hkvCEqshwI6cMfTIcVGwyz2hiAOwDjH8IsVQVZnN0Xy4yE9u9JOTM85C4skr2k+Cs3T
        galdYipmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBzcG-0002q1-GM; Thu, 04 Apr 2019 10:29:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB66E2038C23E; Thu,  4 Apr 2019 12:29:02 +0200 (CEST)
Date:   Thu, 4 Apr 2019 12:29:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     tglx@linutronix.de, David Miller <davem@davemloft.net>,
        ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH 0/3] locking/static_key: improve rate limited labels
Message-ID: <20190404102902.GW4038@hirez.programming.kicks-ass.net>
References: <20190330000854.30142-1-jakub.kicinski@netronome.com>
 <20190401112153.2f9e87ba@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401112153.2f9e87ba@cakuba.hsd1.ca.comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:21:53AM -0700, Jakub Kicinski wrote:
> On Fri, 29 Mar 2019 17:08:51 -0700, Jakub Kicinski wrote:
> > Hi!
> > 
> > This will be used to fix the static branch disabling in the TLS
> > code.  The net/tls/ code should be using the deferred static
> > branch type, because unprivileged users can flip the branch
> > on and off quite easily with CONFIG_TLS_DEVICE=y.
> > 
> > Second of all we shouldn't take the jump label locks from
> > the RX path, when the socket is destroyed.  This can be avoided
> > with some slight code refactoring in deferred static_key as
> > it already runs from a workqueue.
> > 
> > This the series (and a simple tls patch which makes use of it)
> > applied opening 0.5M TLS connections to localhost (just calling
> > setsockopt, no data exchange) goes down from 37.9s to 12.4s.
> 
> Once/if we get positive feedback from locking folks, would it be
> possible to merge these via net-next tree alongside the patch
> converting TLS to rate limited branches?

Looks good. If routed through the network tree because usage there:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Otherwise let me know and I'll carry them.
