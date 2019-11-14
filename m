Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5FAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90207206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFVyXwVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfKNNKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:10:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfKNNKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fWiCKNd8qqolkwWPpYS48TGmI6aZh6dg+5K5Y26jJuU=; b=oFVyXwVMI4YMjExNDNcMY8JmJ
        vwJJM9zngyfOVi+zLs0Hgyu9La4qk9lE3fs5ldidmrkRiO2XHUkUIZmRA5c5ZYZ/n/vP7JrI0ueMv
        iFABHjGe0hXdMDylhClKp5Xenxb8ofbJQXRhQpeoWBSerno9yxYu238qwGhflNJOqInlOgLikO2Sg
        ChdyM+sBImn4mqaH8fremM0elEvo8nJ8MZIWkNCi+/iICJbSGvas33FIKu6e0xmTAmx4g5M+S3EBq
        PBiFPJK4I7diUrvasiPTupU2C9/YPmFeZrnQfhsPiliINFG8lR+izix0kAooVwAtfi/fdzsJNHIrR
        21Ht9AQiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVEsM-0006rz-8x; Thu, 14 Nov 2019 13:09:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40AC9301120;
        Thu, 14 Nov 2019 14:08:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DABF229DEC948; Thu, 14 Nov 2019 14:09:26 +0100 (CET)
Date:   Thu, 14 Nov 2019 14:09:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
Message-ID: <20191114130926.GP4114@hirez.programming.kicks-ass.net>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.603030685@linutronix.de>
 <20191112091521.GX4131@hirez.programming.kicks-ass.net>
 <a0146b86073f4b9bb858d80b4a71683e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0146b86073f4b9bb858d80b4a71683e@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 11:02:01AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 12 November 2019 09:15
> ...
> > > +	/*
> > > +	 * If the bitmap is not shared, then nothing can take a refcount as
> > > +	 * current can obviously not fork at the same time. If it's shared
> > > +	 * duplicate it and drop the refcount on the original one.
> > > +	 */
> > > +	if (refcount_read(&iobm->refcnt) > 1) {
> > > +		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> > > +		if (!iobm)
> > > +			return -ENOMEM;
> > > +		io_bitmap_exit();
> > 		refcount_set(&iobm->refcnd, 1);
> > >  	}
> 
> What happens if two threads of the same process enter the above
> at the same time?

Suppose there's just the two threads, and both will change it. Then both
do copy-on-write and the original gets freed.


