Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94B3C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D56E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jG6t86WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfHUKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:36:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45570 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfHUKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tldozir3hxCrQJu+NVCjOH2d97IbRf87LUeutIb5FiQ=; b=jG6t86WOSVCNMaVwDWUGZo2pL
        Ux37bTeG8CrV32myBhFEv6CAH0d1zEmj6bsdXlLKCMfo4PsBCY/kXY+3hIfnoHgFB7BnfsPY3YpZW
        T/qnYlRnJFfK3Ou2KHD4WUZHLvabb6fjd5IIPNtTx9bTcFh/QA0iIGizeimXpkSFCa1WUAcDhuvLT
        0m1oSxXBLjxmVcRiou6DBmxgGvSmUJ/22qCssvX0UctgH2YjM8y4tgDQSjRoXryTPPm7E7qoEJpsE
        WlXxCBlGpbdUpzaDiN3UHGzAhq1k1esOrDfvAqMkpgbXUEEPgFph7zDVq0mNX4etitjxggI83Jlzq
        YP5WL3Sjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0NyD-00052V-Ae; Wed, 21 Aug 2019 10:36:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D351D306B81;
        Wed, 21 Aug 2019 12:35:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EE1F20A21FCB; Wed, 21 Aug 2019 12:35:59 +0200 (CEST)
Date:   Wed, 21 Aug 2019 12:35:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Message-ID: <20190821103559.GZ2349@hirez.programming.kicks-ass.net>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
 <20190820095240.GH2332@hirez.programming.kicks-ass.net>
 <CY4PR21MB0741A817BEB880C8DC526ECFCEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB0741A817BEB880C8DC526ECFCEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 08:37:55AM +0000, Long Li wrote:
> >>>Subject: Re: [PATCH 3/3] nvme: complete request in work queue on CPU
> >>>with flooded interrupts
> >>>
> >>>On Mon, Aug 19, 2019 at 11:14:29PM -0700, longli@linuxonhyperv.com
> >>>wrote:
> >>>> From: Long Li <longli@microsoft.com>
> >>>>
> >>>> When a NVMe hardware queue is mapped to several CPU queues, it is
> >>>> possible that the CPU this hardware queue is bound to is flooded by
> >>>> returning I/O for other CPUs.
> >>>>
> >>>> For example, consider the following scenario:
> >>>> 1. CPU 0, 1, 2 and 3 share the same hardware queue 2. the hardware
> >>>> queue interrupts CPU 0 for I/O response 3. processes from CPU 1, 2 and
> >>>> 3 keep sending I/Os
> >>>>
> >>>> CPU 0 may be flooded with interrupts from NVMe device that are I/O
> >>>> responses for CPU 1, 2 and 3. Under heavy I/O load, it is possible
> >>>> that CPU 0 spends all the time serving NVMe and other system
> >>>> interrupts, but doesn't have a chance to run in process context.
> >>>
> >>>Ideally -- and there is some code to affect this, the load-balancer will move
> >>>tasks away from this CPU.
> >>>
> >>>> To fix this, CPU 0 can schedule a work to complete the I/O request
> >>>> when it detects the scheduler is not making progress. This serves multiple
> >>>purposes:
> >>>
> >>>Suppose the task waiting for the IO completion is a RT task, and you've just
> >>>queued it to a regular work. This is an instant priority inversion.
> 
> This is a choice. We can either not "lock up" the CPU, or finish the I/O on time from IRQ handler. I think throttling only happens in extreme conditions, which is rare. The purpose is to make the whole system responsive and happy.

Can you please use a sane MUA.. this is unreadable garbage.
