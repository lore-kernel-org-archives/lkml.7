Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E94620644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="miyXfEN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfHAMiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:38:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51526 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfHAMiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bH3hTzzK8wCiqvY4xW3EPVXepMqBIOyt0Kx3x1aegwg=; b=miyXfEN8B3UsjIwBbezhY6o42
        DjkGYekMBPmWShjXfySYo3uYdfUEMYwN+sz5CJCfx9L0jeYj8cH4Y1ZQB4PH0bqVs6j36reDKOpsm
        tUjwVGryLDkjUGE7Boo85MkNWFATHmPP7ouvBdXSct1FOjH2AJWBk5GpfIXpLEViclbLL5rRm3mxw
        ksCdR5GHGIQhQtirmBA+yuWd8IHaz2qE2/0H39QSYUhqkh2zwuE2iHwsAUa7OGH71icKI7j/go95E
        VRkVfWUDg3p0sfUFENHxSIgskOKm3f5S5bMEHBeV6xs6vBQVOtttLEzIA6suh42b0lYbW/nkuta6U
        Sr4mYamzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htALP-0006Zx-O3; Thu, 01 Aug 2019 12:38:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 227242029F4CD; Thu,  1 Aug 2019 14:38:06 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:38:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Walls <andy@silverblocksystems.net>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] media/ivtv: Reduce default FIFO priority
Message-ID: <20190801123806.GA31398@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.858088180@infradead.org>
 <7970f0e30d1eb83e7067225d07b923863bf1ac50.camel@silverblocksystems.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7970f0e30d1eb83e7067225d07b923863bf1ac50.camel@silverblocksystems.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 08:24:22AM -0400, Andy Walls wrote:
> Hi Peter:
> 
> On Thu, 2019-08-01 at 13:13 +0200, Peter Zijlstra wrote:
> > The ivtv driver creates a FIFO-99 thread by default, reduce this to
> > FIFO-1.
> > 
> > FIFO-99 is the very highest priority available to SCHED_FIFO and
> > it not a suitable default; it would indicate the ivtv work is the
> > most important work on the machine.
> 
> ivtv based boards are legacy, convential PCI boards.  At this point,
> these old boards are generally installed in boxes dedicated to video
> capture (e.g. MythTV setups) or boxes dedicated to capturing VBI
> information, like closed captioning, for business intelligence.
> 
> For boxes dedicated to video or VBI capture, the ivtv work may very
> well be close to the most important work on the machine, to avoid
> dropping video frames or VBI data.
> 
> 
> > FIFO-1 gets it above all OTHER tasks, which seems high enough lacking
> > better justification.
> 
> I agree that FIFO-99 is the wrong default level.
> 
> However, in my opinion, threads responsible for real time data
> acquisition should have higher priority than the other kernel driver
> threads normally running at FIFO-50.
> 
> How about FIFO-51 as the default?

If the consumer of the data are RT tasks as well (I hadn't expected that
from a TV capture device) then I'd propose to use FIFO-50 as default.

The thing is, the moment you're doing actual proper RT, the admin needs
to configure things anyway, which then very much includes setting the
priority of interrupt threads and the like.

(that is exacty why pretty much everything defaults to FIFO-50)
