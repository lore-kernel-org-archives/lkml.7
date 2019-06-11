Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9D1C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3225120896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/UefZzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbfFKOYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:24:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387486AbfFKOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cAwSoiNOjCh49XGhHGTBldRGbI70g1E7SnqPU+lO6OU=; b=I/UefZzZ15oOLWR50UMcG5FNb
        iiYmKkNDb/n9nOmfZnhv8mi7zJfX4MQ0akqHNzFkWe0rRdlb4nMljwDJ11NDXcFQhCz+PU18p8B5V
        I2qFeRr+SuguvulKq4O/fIbqqwJIZfliCjGFvkU1EJVZiHQrxaDE5LDcfLgSI4M+O8PO/2BloC9Gn
        7IcIb36/OFnJIhTDIhZqp/ezbkh0GtlsUg43c9UxphBlGJy6MesB8TSJLjLk0UmwHV58N59d+qOMv
        d1HqA30hdpchxbWEW3f6CfnbArSviT8DPOon6BiG0ApRGaPzTjwxUO9UtckVjlz+SJLh6qibK3hWx
        0Lq3PUOSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hahhd-0003Gr-0m; Tue, 11 Jun 2019 14:24:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 168842023E4C7; Tue, 11 Jun 2019 16:24:43 +0200 (CEST)
Date:   Tue, 11 Jun 2019 16:24:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     bsegall@google.com, linux-kernel@vger.kernel.org,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] sched/fair: don't push cfs_bandwith slack timers
 forward
Message-ID: <20190611142443.GZ3436@hirez.programming.kicks-ass.net>
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
 <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
 <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
 <20190611135325.GY3436@hirez.programming.kicks-ass.net>
 <20190611141219.GD15412@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611141219.GD15412@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:12:19AM -0400, Phil Auld wrote:

> That looks reasonable to me. 
> 
> Out of curiosity, why not bool? Is sizeof bool architecture dependent?

Yeah, sizeof(_Bool) is unspecified and depends on ABI. It is mostly 1,
but there are known cases where it is 4.
