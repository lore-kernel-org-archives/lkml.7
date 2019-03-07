Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55925C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3041720851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfCGR7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:59:46 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:58056 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCGR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:59:45 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992362AbfCGR7mRY61K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Thu, 7 Mar 2019 18:59:42 +0100
Date:   Thu, 7 Mar 2019 17:59:42 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alexandre Oliva <lxoliva@fsfla.org>
cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, Tom Li <tomli@tomli.me>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
In-Reply-To: <orlg1ryyo2.fsf@lxoliva.fsfla.org>
Message-ID: <alpine.LFD.2.21.1903071744560.7728@eddie.linux-mips.org>
References: <20190208083038.GA1433@localhost.localdomain>        <orbm3i5xrn.fsf@lxoliva.fsfla.org>        <20190211125506.GA21280@localhost.localdomain>        <orimxq3q9j.fsf@lxoliva.fsfla.org>        <20190211230614.GB22242@darkstar.musicnaut.iki.fi>   
     <orva1jj9ht.fsf@lxoliva.fsfla.org>        <20190217235951.GA20700@darkstar.musicnaut.iki.fi>        <orpnrpj2rk.fsf@lxoliva.fsfla.org>        <alpine.LFD.2.21.1902180227090.15915@eddie.linux-mips.org> <orlg1ryyo2.fsf@lxoliva.fsfla.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

 I'm away on holiday and also connectivity is so-so here, so just a quick 
reply.

> >  Is there an MMIO completion barrier missing there somewhere by any chance 
> > causing an IRQ that has been handled already to be redelivered because an 
> > MMIO write meant to clear the IRQ at its origin at handler's completion 
> > has not reached its destination before interrupts have been reenabled in 
> > the issuing CPU?  Just a thought.
> 
> I've finally got a chance to bisect the IRQ14 (nobody cared) regression
> on my yeeloong.  It took me to MIPS: Enforce strong ordering for MMIO
> accessors (commit 3d474dacae72ac0f28228b328cfa953b05484b7f).

 Thanks for looking into it.

> I've only just started trying to figure out what exactly in the change
> leads to problems.  So far, I've determined that changing both uses of
> __BUILD_IOPORT_SINGLE so that barrier is passed as 0 rather than 1
> removes the undesirable effects, both on top of that patch, and on top
> of v5.0:
> 
>  #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
> - 	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0,)			\
> - 	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p)
> +	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 0, 0,)			\
> +	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 0, 0, _p)

 So this seems backwards to me, port I/O is supposed to be strongly 
ordered, so if removing the ordering guarantee "fixes" your problem, then 
there must be a second bottom here.  Offhand either there is a race 
condition somewhere which the lack of ordering here covers somehow, or 
there is a silicon erratum of some sort somewhere that the SYNC 
instruction triggers.

 A further investigation is required I'm afraid.  Does your platform use 
`war_io_reorder_wmb'?

  Maciej
