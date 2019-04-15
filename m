Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E31C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E8B20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lecSp0+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfDOPZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:25:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfDOPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CPQA+mNJvI1vGfPejlJ8PSoFXrtpz7wLC6wSJjdw80Y=; b=lecSp0+jbSDLNuY1XH/WF4NRT
        qSiuQI4ukq+CxnkNt6xwabapyPjMpyOiwwZmUIjtl5+q0nLyuFqkGEmSi1xByb+fSGx6tUDSBhFrd
        alUJIsogDD58b1UjSxEoyBM5yrsUU0HlMp4jDpA3qHgdLPXoDOyYmemhq/uNLFetye0e/P9YT9qu8
        IKbkUYu3E+lUnGIZ/thC2SbmP36iBx+lAQEt6a91uBh+uxfui8B/ee8wWmulXMn8XCFfHfcFf9YGq
        4aKXa+PHRKY17okZ7NrrDIr9Ib+3q3/eoLlkvqJW09XGRCz6kNTYD+e1sWrF5AeV5gNRzCyWUK0v7
        lAmV7Q15w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG3UV-0003Wm-TK; Mon, 15 Apr 2019 15:25:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E64B23925996; Mon, 15 Apr 2019 17:25:49 +0200 (CEST)
Date:   Mon, 15 Apr 2019 17:25:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     huawei.libin@huawei.com, xiexiuqi@huawei.com,
        yangyingliang@huawei.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Use 'unsigned long' for
 group_shares,group_runnable
Message-ID: <20190415152549.GQ11158@hirez.programming.kicks-ass.net>
References: <20190413033234.30002-1-cj.chengjian@huawei.com>
 <20190415124617.GP11158@hirez.programming.kicks-ass.net>
 <eb7dede4-9668-9252-b95a-e20e313c5890@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7dede4-9668-9252-b95a-e20e313c5890@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:20:31PM +0800, chengjian (D) wrote:
> Hi, Peter
> 
> 
> On 2019/4/15 20:46, Peter Zijlstra wrote:
> 
> I write a demo about this, which I described it as overflow.

I'm not saying there's no overflow, I'm saying there's nothing UB about
it.
