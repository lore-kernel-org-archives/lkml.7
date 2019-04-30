Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B96AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1E320835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yyawsRFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfD3Ief (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:34:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34154 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfD3Iec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V1cm2gZOz8Lo0b6Ns70mAemkxqG1bfPxARMsSFPCS1g=; b=yyawsRFSctGJbp5kerTV0THbV
        hgDUOIPI6GZCmUnowsm0OxIOr0+iYwProTLc4IzyicgxqZcJbMCsVSndTZwimpj6xDrZO71dPcFcc
        xPQPnTCuw7OvOWaJsRgaarhmAL/eDq2sx9UcdTW3TpIBa9pQxMZ552jeP96SCWsqRtJxNnI5VyYCD
        iSHj5ogukm+xo7h3qAFQxd/ZkKQJmdfahuer5JDRpWeF9vBATiPbWG76BCIlWzxn80Z80PWjOiB/J
        uaa9WMvq/JQLyMv5+9DosCkMUkx/B4YpHFL9SyxHFyMZ9VDVE1bu4Fion/TKPMdWRGobXfUhokbXm
        1+OzT5X7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLODK-0007XM-I8; Tue, 30 Apr 2019 08:34:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5182E29D2D6D8; Tue, 30 Apr 2019 10:34:09 +0200 (CEST)
Date:   Tue, 30 Apr 2019 10:34:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/5] Fix improper uses of smp_mb__{before,after}_atomic()
Message-ID: <20190430083409.GD2677@hirez.programming.kicks-ass.net>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:14:56PM +0200, Andrea Parri wrote:
> Hello!
> 
> A relatively common misuse of these barriers is to apply these to
> operations which are not read-modify-write operations, such as
> atomic_set() and atomic_read(); examples were discussed in [1].
> 
> This series attempts to fix those uses by (conservatively) replacing
> the smp_mb__{before,after}_atomic() barriers with full memory barriers.

I don't think blindly doing this replacement makes the code any better;
much of the code you found is just straight up dodgy to begin with.

I think the people should mostly just consider this a bug report.

Also, remember a memory barrier without a coherent comment is most
likely a bug anyway.
