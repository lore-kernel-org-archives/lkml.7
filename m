Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965C4C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985F218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrMPndYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfI3JDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:03:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfI3JDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rngdFd20wpp6sF9aLvKyf+2Rn5LoVDE++JfjbkpBTdk=; b=qrMPndYk26lng7CmA762O/cZo
        oj+/ZU/UilZnZseg1biOXlpZqHlfxXbPZ5LqqheO3sjqLxk+z2YShagALkP/8jPSHF+ONQMLY+k0y
        lDmoT8SmS+2M/g0Z06JHXSKrjLC7LBrRgW3ARAfDbVqjcOdHjcBzx5GVOkx+6IIJyPkn1h0ZkLtFY
        53hr1dJ7GZcL+j1vwQP47WwF7dCFPmH+5FT54nMKRuplMTvxR30KQ2YfJdUApBI95WMM0ld/QF4GW
        LvH4OiS2C8G/BOXvGYdEtTcKRkacXcqC0Qm4DkMOOwWCXmM7xfouA6hmWhXUKA+iqW+GtruhHmjiE
        idyAzRneg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEra6-0006Hf-1J; Mon, 30 Sep 2019 09:02:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F10FB305BD3;
        Mon, 30 Sep 2019 11:02:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D45C125D6479E; Mon, 30 Sep 2019 11:02:53 +0200 (CEST)
Date:   Mon, 30 Sep 2019 11:02:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Jie Meng <jmeng@fb.com>
Subject: Re: [PATCH] perf: rework memory accounting in perf_mmap()
Message-ID: <20190930090253.GL4553@hirez.programming.kicks-ass.net>
References: <20190904214618.3795672-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904214618.3795672-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:46:18PM -0700, Song Liu wrote:
> perf_mmap() always increases user->locked_vm. As a result, "extra" could
> grow bigger than "user_extra", which doesn't make sense. Here is an
> example case:
> 
> Note: Assume "user_lock_limit" is very small.
> | # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
> | 0                    | 0                   | 0             |
> | 1                    | user_extra          | user_extra    |
> | 2                    | 3 * user_extra      | 2 * user_extra|
> | 3                    | 6 * user_extra      | 3 * user_extra|
> | 4                    | 10 * user_extra     | 4 * user_extra|
> 
> Fix this by maintaining proper user_extra and extra.

Aah, indeed.

Also, this code is unreadable (which is mostly my own fault I suppose)
:/

