Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2F5C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1615B20665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dDHD2ywN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfHBSuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:50:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfHBSuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4FKpdVqJ6x4ipIPagFBQljiwNMfp0DvGjLMeeuRcH8A=; b=dDHD2ywNsssRnL5ii/df4tYig
        D3ALda+Rih2dKJmSzMKcZtVeekdAr6rLQlyWeDYNAodYDwZCcq1MjFSDSS1NFOUSO482/Y0i/fYFC
        2IiqBNwW2N0YNUsj8Yx3VBoDkjkZCZc9bBCvpMZIwoEuTMK0eoIkvcWVGeyWZhL8d1QSwxUMjuGt5
        p3ws1orng4avDhJYSwVrrbuOqCzSvSr01VZy/xxLaNfkNuvqcUzHHnIcIAMurN4H7+fF7CZM0UR9a
        g9hgXaWENs9inVcSHFLRT+UGJwdr/s6LSeIQ6E80OMVl6Wk25R3ItbiY47onej027TxwekAQBoEOr
        /dnveekLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htccg-0005aF-1p; Fri, 02 Aug 2019 18:49:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C43620293161; Fri,  2 Aug 2019 20:49:47 +0200 (CEST)
Date:   Fri, 2 Aug 2019 20:49:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH 0/6] Rework REFCOUNT_FULL using atomic_fetch_* operations
Message-ID: <20190802184947.GC2349@hirez.programming.kicks-ass.net>
References: <20190802101000.12958-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802101000.12958-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:09:54AM +0100, Will Deacon wrote:

> Although the revised implementation passes all of the lkdtm REFCOUNT
> tests, there is a race condition introduced by the deferred saturation
> whereby if INT_MIN + 2 tasks take a reference on a refcount at
> REFCOUNT_MAX and are each preempted between detecting overflow and
> writing the saturated value without being rescheduled, then another task
> may end up erroneously freeing the object when it drops the refcount and
> sees zero. It doesn't feel like a particularly realistic case to me, but
> I thought I should mention it in case somebody else knows better.

So my OCD has always found that hole objectionable. Also I suppose the
cmpxchg ones are simpler to understand.

Maybe make this fancy stuff depend on !FULL ?
