Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D3DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2C233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWjRGi7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391585AbfHWIMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:12:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35904 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbfHWIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kI5WK91px+64kXMN00bUI+CfJxW4ak8hHid4cp1UDJ0=; b=rWjRGi7plTPo2QM9HWbbwsLT/
        B76KezZQBaEtVMBVOcOL951qS4mUcBWQqSqQ+rj66U9PAftrjQTXY0lQw4JfgchV/jw8bIiucfY0K
        VfSH6VuDTBag7RR4IoZ5p3joDQHn4PJRPoV7LHytUt44F1EDHtbT/KHy4qYCDr8a0Fcy0iERHrXT6
        cCAH2I3qdxHIwfEkAmyYC2jxS5EheF73A4z5RqN2l7JncHdkcViObIH6DzMzrlbYYDg1FvzSE3Dmq
        c4S/D7RMSzi6cQCZUPmb/QV72/cpl9aFgBaVnQaOA1SGWzAYqDaHCVFoWLtzMiqV+CrL+p037Bykl
        Br7icCcaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i14gj-00077V-Au; Fri, 23 Aug 2019 08:12:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DF19307764;
        Fri, 23 Aug 2019 10:12:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDF22202D580B; Fri, 23 Aug 2019 10:12:47 +0200 (CEST)
Date:   Fri, 23 Aug 2019 10:12:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Further sanitize INTEL_FAM6 naming
Message-ID: <20190823081247.GC2369@hirez.programming.kicks-ass.net>
References: <20190822102306.109718810@infradead.org>
 <20190822205312.GA10757@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822205312.GA10757@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:53:12PM -0700, Luck, Tony wrote:
> On Thu, Aug 22, 2019 at 12:23:06PM +0200, Peter Zijlstra wrote:
> > Lots of variation has crept in; time to collapse the lot again.
> 
> Conceptually good.  But I applied the series on top of tip/master
> and got a build error:
> 

> Looks like your scripts didn't anticipate the CPP gymnastics like:
> 
> #define VULNWL_INTEL(model, whitelist)          \
>         VULNWL(INTEL, 6, INTEL_FAM6_##model, whitelist)

Bah.. I'll go fix.
