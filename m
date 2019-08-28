Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B44CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB6D22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DESqQHh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfH1QQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:16:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1QQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ICJAa08tadoxVPLwvjSEX3IwJxKlsW5cqkoOWAu/x8M=; b=DESqQHh2cNViea0m7r8+H3fu4
        1dFucgAEMAvngpKuOByQxETWWcVYF63MS9s/79ByDMlJnv6qVLGka3yxIR5TK2iA2KU5rmNEouNTS
        8NG7VowmDv2KNIew7s0qLUb9qUexQOyNvqDGS/eCN0echuCOdJRrn6xZCsZqW/jRAzw4oSJTmHbmh
        kr117gOELOdhx6Xo3ultpIVg5PbXH/2dYFYcUwdVWshiYLPYs+FLR93/QefbbERy+AcAP1Z0nyMqL
        p6rJekQVD/8egGLC9IiSLimuDDhsZq60Y64g0+47/xSF8wFIaBHaZcl6/n7GTzfTu0Qfut1ZPb1fC
        1nb2DF8iA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i30cm-0005WW-LX; Wed, 28 Aug 2019 16:16:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA2C1307594;
        Wed, 28 Aug 2019 18:16:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E174C20230B32; Wed, 28 Aug 2019 18:16:41 +0200 (CEST)
Date:   Wed, 28 Aug 2019 18:16:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        subhra.mazumdar@oracle.com, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190828161641.GJ2369@hirez.programming.kicks-ass.net>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
 <20190827215035.GH2332@hirez.programming.kicks-ass.net>
 <c005e75c-0966-63ca-bce7-05f545702688@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c005e75c-0966-63ca-bce7-05f545702688@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:59:21AM -0700, Tim Chen wrote:
> On 8/27/19 2:50 PM, Peter Zijlstra wrote:
> > On Tue, Aug 27, 2019 at 10:14:17PM +0100, Matthew Garrett wrote:
> >> Apple have provided a sysctl that allows applications to indicate that 
> >> specific threads should make use of core isolation while allowing 
> >> the rest of the system to make use of SMT, and browsers (Safari, Firefox 
> >> and Chrome, at least) are now making use of this. Trying to do something 
> >> similar using cgroups seems a bit awkward. Would something like this be 
> >> reasonable? 
> > 
> > Sure; like I wrote earlier; I only did the cgroup thing because I was
> > lazy and it was the easiest interface to hack on in a hurry.
> > 
> > The rest of the ABI nonsense can 'trivially' be done later; if when we
> > decide to actually do this.
> > 
> > And given MDS, I'm still not entirely convinced it all makes sense. If
> > it were just L1TF, then yes, but now...
> > 
> 
> For MDS, core-scheduler does prevent thread to thread
> attack between user space threads running on sibling CPU threads.
> Yes, it doesn't prevent the user to kernel attack from sibling
> which will require additional mitigation measure. However, it does
> block a major attack vector for MDS if HT is enabled.

I'm not sure what your argument is; the dike has two holes; you plug
one, you still drown.
