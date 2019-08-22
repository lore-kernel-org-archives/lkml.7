Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397B1233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCs+e7Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbfHVPvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:51:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58316 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfHVPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mphAHqGMfote5PJqLqpE9cHsYiAfStB4m//vfSN73+w=; b=sCs+e7JkKz0elOXDlbM+7uXis
        cmrLP7YMN9WyitReDyhu3kxWFp8T32/0BsIIH8EaJBXWHZfzkf1+JTvkiwpwWyjiInJF+XwyOrRuy
        8x/YqCDQjH5id5NetGVF+s3XcrWRxO23yYHwrqNOTAnxO0YpaqENa2HXhW9iM5FkyTjd4dbFDE7co
        tYUD0b2eIx5AJTgc+pkKXj83jlSCxj8Pgv92MQxZCEF13WBAC5ZqpUfh0CgKagmEOuaNH+WlwwK9H
        EfqdvRQCOsV5piFnrXUeXQPVmsM2XA3EFd0dFTl4rnQSGMfEzkJC+tGu+ukHe0EAF0krsHXzH33xS
        8MfoWyxoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0pMo-0005Y9-6s; Thu, 22 Aug 2019 15:51:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20E18305F65;
        Thu, 22 Aug 2019 17:50:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 391CE2029B0A2; Thu, 22 Aug 2019 17:51:12 +0200 (CEST)
Date:   Thu, 22 Aug 2019 17:51:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Satendra Singh Thakur <satendrasingh.thakur@hcl.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] [semaphore] Removed redundant code from semaphore's
 down family of function
Message-ID: <20190822155112.GU2369@hirez.programming.kicks-ass.net>
References: <20190812053014.27743-1-satendrasingh.thakur@hcl.com>
 <20190812134859.16061-1-sst2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812134859.16061-1-sst2005@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 07:18:59PM +0530, Satendra Singh Thakur wrote:
> -The semaphore code has four funcs
> down,
> down_interruptible,
> down_killable,
> down_timeout
> -These four funcs have almost similar code except that
> they all call lower level function __down_xyz.
> -This lower level func in-turn call inline func
> __down_common with appropriate arguments.
> -This patch creates a common macro for above family of funcs
> so that duplicate code is eliminated.
> -Also, __down_common has been made noinline so that code is
> functionally similar to previous one
> -For example, earlier down_killable would call __down_killable
> , which in-turn would call inline func __down_common
> Now, down_killable calls noinline __down_common directly
> through a macro
> -The funcs __down_interruptible, __down_killable etc have been
> removed as they were just wrapper to __down_common

The above is unreadable and seems to lack a reason for this change.

AFAICT from the actual patch, you're destroying the explicit
instantiation of the __down*() functions through constant propagation
into __down_common().

