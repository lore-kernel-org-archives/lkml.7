Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AE4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A75A20644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DOSB80d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfH1Q3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:29:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfH1Q3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=znSnT974Vl4Y8YOZ/9zd4iEg86qp19ImyyCFqmd1BbA=; b=DOSB80d13xppS27hBHrvl2LGe
        VXKSlGeI0uYu7QVgeyr5PX8IaC2NTe40s1TTceDqN1HVNJTeEoMTyVhRQHTAqkvvxAcgW3DjUO0aK
        1n6pm9QlBtX9AsCXmGF2JM/mSUCGRl09Az7xCAxD/pjQel/Xz1g00Pi2sec9vPurYBbB965WlYEDk
        ytUP37p1XyezPqwXTOnBy/W3vJ5+4KjIRIoz70DMvMK/0gssE7HjXOZVs3poeaD91/xafISQlala2
        KSzTixuF1/6vF/dPef4UDuUO+3SFNB5UUD9qvbkCxYCTmUzahopr3pBoojjoOD8YULatUEGRsg7/I
        vYkookxeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i30oc-00066Y-Pm; Wed, 28 Aug 2019 16:28:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C41A300B83;
        Wed, 28 Aug 2019 18:28:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14FAE20C3AB21; Wed, 28 Aug 2019 18:28:57 +0200 (CEST)
Date:   Wed, 28 Aug 2019 18:28:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190828162857.GO2332@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828151921.GD17205@worktop.programming.kicks-ass.net>
 <20190828161754.GP5447@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828161754.GP5447@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 09:17:54AM -0700, Andi Kleen wrote:
> > This really doesn't make sense to me; if you set FIXED_CTR3 := 0, you'll
> > never trigger the overflow there; this then seems to suggest the actual
> 
> The 48bit counter might overflow in a few hours.

Sure; the point is? Kan said it should not be too big; a full 48bit wrap
around must be too big or nothing is.
