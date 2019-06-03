Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C585C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C3B27DDB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mtixJZSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfFCI6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:58:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfFCI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=17b1gothQ8VFCXdOlPSVMYFIBBaXDbn+dxNijniYIa0=; b=mtixJZSbzdIMKrZK9d+siJSny
        qMy5RpuukZzSYIGxEMkFX+veQLIfZeceOxjra5IOFZ77ra5qAbmNMYqd2QZSLw7r5IuEDTcQcNEA0
        hv72eM1zt2l7tXwW+uhOC2/PNLa9aENiXbze/daKLJufqWAhry0BN4+ha7V8lv86pNC2l437Ye+5Q
        S1a5R5vIFolkmZThp442BA0PboN26kgJYuO0Xt9+lO2eeMoOBnv5PD0R7haJEKK0c+g7ptXYYdnUS
        YOt/G8TaLmJxULzJRKjx7f9V2lwIYPWZg6+UOd3YT53tiJ7Jh8fYeBeX2WeMeNHP9Irxy+UwugjHS
        GnM7pQj6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXine-0001hu-1i; Mon, 03 Jun 2019 08:58:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CA5E2029F880; Mon,  3 Jun 2019 10:58:36 +0200 (CEST)
Date:   Mon, 3 Jun 2019 10:58:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sched/core: add __sched tag for io_schedule()
Message-ID: <20190603085836.GD3436@hirez.programming.kicks-ass.net>
References: <20190531082912.80724-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531082912.80724-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 04:29:12PM +0800, Gao Xiang wrote:
> non-inline io_schedule() was introduced in
> commit 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")
> Keep in line with io_schedule_timeout, Otherwise
> "/proc/<pid>/wchan" will report io_schedule()
> rather than its callers when waiting io.
> 
> Reported-by: Jilong Kou <koujilong@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

This is lacking a Fixes: tag.
