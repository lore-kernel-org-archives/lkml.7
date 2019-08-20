Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C045BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8887B20673
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hgKdt0P1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfHTJjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:39:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34840 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfHTJjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aP7YVXFpDNQcxH+rVOzu1yptj8ZkIgU2FgwQQZibl+g=; b=hgKdt0P1DD3mZ+BKU2LYDAoWF
        786hK7vhHqfPFXT13TPQoAUO0gj6XJ5HKdH3ATpIQuCrBtTQAlLK3BB+Mwqa6l+0VASGsSWfqlPWi
        uAxGMo3t2sNV9tVYrrVXM94gadC6ROFX9Uvevyr8ViFv8L9i9lPtKJtp8ACTapJC6JQyDtXBKPtIh
        +lENen5l42kkNVFSmXunJRpJ3UHwxw2bV7Ojo6XEYHdwnM7M+nYGZRE800V44QfV1yFwT4MGukJQB
        Wx4NlUTTjq7u0D9ytpUospPZIp4StFs0kQhIlcWTyQT/WUwEj9RRMLWWIyy615d/hV8u7gcW69kJ4
        qzRiaUu4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i00b1-0005wW-9B; Tue, 20 Aug 2019 09:38:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CE3B307603;
        Tue, 20 Aug 2019 11:37:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B047020CE7741; Tue, 20 Aug 2019 11:38:27 +0200 (CEST)
Date:   Tue, 20 Aug 2019 11:38:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     longli@linuxonhyperv.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH 1/3] sched: define a function to report the number of
 context switches on a CPU
Message-ID: <20190820093827.GF2332@hirez.programming.kicks-ass.net>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-2-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566281669-48212-2-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:14:27PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> The number of context switches on a CPU is useful to determine how busy this
> CPU is on processing IRQs. Export this information so it can be used by device
> drivers.

Please do explain that; because I'm not seeing how number of switches
relates to processing IRQs _at_all_!
