Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757BC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BE7213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xy+sxyCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfFYOFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:05:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58558 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zn67bOgx/yGyt5Kgig66jXIawpMbj+RGBw0dbpIFDgM=; b=xy+sxyCAVmFzD+2lzRR3iS452
        7iSUCzn4c9s651iZLMXGmDoD84uuj61bicxTKn5K86mUuv19IeN5DbO1T7Hh9aW/wQvb/bnHEvCk8
        dkL7dP0HONdKqMx+fFVE6/EmAgNeYYxMkv5cmlibjGsmYFyCOtfjFuNAyiONA9ueBlx9izruYr+Ax
        +x5nq8BuRS2QEKAT+ngbd60xwoLVxcXNX70mpN3nJK4pPPhRllIp3F5ecdA/Y1YP1lB9q55VmXl8S
        1V/lpKdAQ+iqLSIej3IlU3i52D4iH4UpdRI64KI1cBEDe0s9Q61lAh3MllERaMUlyNVNnqnLsMmnN
        6Y2kHWEoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfm4q-0001bU-C2; Tue, 25 Jun 2019 14:05:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0668209FD685; Tue, 25 Jun 2019 16:05:38 +0200 (CEST)
Date:   Tue, 25 Jun 2019 16:05:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190625140538.GC3419@hirez.programming.kicks-ass.net>
References: <20190621133414.GF26519@linux.ibm.com>
 <20190621174104.GA7519@linux.ibm.com>
 <20190621175027.GA23260@linux.ibm.com>
 <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
 <20190625004300.GB17497@lerouge>
 <20190625075139.GT3436@hirez.programming.kicks-ass.net>
 <20190625122514.GA23880@lenoir>
 <20190625135430.GW26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625135430.GW26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:54:30AM -0700, Paul E. McKenney wrote:
> And it allows dispensing with the initialization.  How about like
> the following?

Looks good to me!
