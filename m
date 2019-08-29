Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32EF206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDdLEFNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfH2Me4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:34:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfH2Me4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jyG+3RbyVo0ge5+B2Y+V/QY+BuDVjerDhPABGwRD/k8=; b=qDdLEFNf19MzqQplwE2CVjWaV
        YGbIsu6DDcp2lK4ohdBUKOh9yKReu33yIgqDpVz+AP6BzfUnpKO6zm8g9jzgGQ2GTsD/q6NmihmPZ
        TwjWvFOU8hqXpOrYVvYdhAP3eHV9rhAjwhSkG7cXnw2TpKVJRja02sE7nDy1WzZ37AOf4pkWRG/4C
        CFjjSC6/ZXgKKiWOzl5zkqcR03Xy22jH2gWVjtVx9BH60RnyWQzzSss/1eBh7A9Z4m4DOgko8FXZ7
        DvRKd3oRsBAh6dKNU6U6uESHhzepPSD0KSzV0rbq6UMgFZV5D7x0fLe6dAMQiQOyP+inv9rNzhhiB
        DZ2LiKoZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Jdd-0002SG-Od; Thu, 29 Aug 2019 12:34:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 755DB300825;
        Thu, 29 Aug 2019 14:34:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B283B20C9570C; Thu, 29 Aug 2019 14:34:50 +0200 (CEST)
Date:   Thu, 29 Aug 2019 14:34:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] sched: Replace strncmp with str_has_prefix
Message-ID: <20190829123450.GP2332@hirez.programming.kicks-ass.net>
References: <20190809071051.17387-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809071051.17387-1-hslester96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 03:10:51PM +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.

I'm thinking that is exactly the easy case for compilers/semantic
checkers to verify. Now granted, GCC doesn't seem to do that by itself,
but still.

I'd buy your argument if the prefix is variable, because in that case
you can do prefix matching cheaper than strlen+strncmp, but as is, not
really.
