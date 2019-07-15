Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F93C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A99F20868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="faz9sI+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfGOJv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:51:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45220 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfGOJvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G5thOjUipBlrnjnEFLF9pP5Zg34jA7kM015Izj01eKg=; b=faz9sI+VPiLfQBNNUlhbhneHC
        e/wIa5vLfZ4pkf4dIp2ZYaHL6s1IJX/d8w5nhhjLI5MCNLZUjGj6GMVE7SdR31bCVNbtmizGmV9Z/
        Ub9FOSMpDOvtTA9KJelOrPkG6NDOtKmN82v4CO2/xLvkHpyBeNh+brbfm/XNNhb5aFJfpqLTFKdbv
        duT8ZMhrVueoyQ4UPPBGPWG11Fbx/4E11xupgZZfE+ZUDoZvTQ/rdyEOjhgJg17YzuGNM4gitHbY0
        SfF/ykN4U2WpGKhJNnOs25UtYCnaZ5locigZa2391ee3V9a+vpz6EZAjxIzOuBXzwvfTQdpGCrvvD
        n0KfEBDOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmxeA-0001a1-Em; Mon, 15 Jul 2019 09:51:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE0E220B29100; Mon, 15 Jul 2019 11:51:47 +0200 (CEST)
Date:   Mon, 15 Jul 2019 11:51:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: Re: [PATCH] sched/fair: fix coccinelle warnings
Message-ID: <20190715095147.GZ3419@hirez.programming.kicks-ass.net>
References: <1563158726-43940-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563158726-43940-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 10:45:26AM +0800, Yi Wang wrote:
> This fixes the following coccinelle warning:
> ./kernel/sched/fair.c:8688:9-10: WARNING: return of 0/1 in function 'voluntary_active_balance' with return type bool
> 
> Return type bool instead of 0/1.

I don't much appreciate these patches. I think 0/1 are perfectly fine
return values for a boolean function.
