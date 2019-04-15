Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5659A20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X2sL0cDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfDOMqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:46:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YNMB8U0jsVuYMHRIrnpj6p3QotqRN11Np57Z/trdroM=; b=X2sL0cDVYLOuWe5PRv3ClFlN+
        DnVhWUr7Iye0aKnOirRVc+x+8QUB6es515/9jCuskITTPSceyRyU1jNHogb0d/ZiKmSV16CDXYchL
        ob6DKJ+ZxXRes9Lklv+MhAA2pJEAYoQgZB0nkfUJQJCdyHlesW9dogoi0MparPTaD31vUpP+HOgls
        4NPON+zIko3E+eLaiaQwZRQkyDcKtu8YjwZUeA8U4NOAmj3Ic/4fcn+d0y5cenrGlwgmQyHYH25Qe
        BL/r8+FZolB4isq9coOc7yWHMTHH0gkPBDGYkRYgDToIAA8eOJUd0jGbwob300H+jmIlrEkzS4grK
        hDGWjoGdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG106-0002JJ-RR; Mon, 15 Apr 2019 12:46:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35E4528B6D259; Mon, 15 Apr 2019 14:46:17 +0200 (CEST)
Date:   Mon, 15 Apr 2019 14:46:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     huawei.libin@huawei.com, xiexiuqi@huawei.com,
        yangyingliang@huawei.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Use 'unsigned long' for
 group_shares,group_runnable
Message-ID: <20190415124617.GP11158@hirez.programming.kicks-ass.net>
References: <20190413033234.30002-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413033234.30002-1-cj.chengjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 03:32:34AM +0000, Cheng Jian wrote:
> group_share and group_runnable are tracked as 'unsigned long',
> however some functions using them as 'long' which is ultimately
> assigned back to 'unsigned long' variables in reweight_entity.
> 
> Since there is not scope on using a different and signed type,
> this change improves code consistency and avoids further type
> conversions. More important, to prevent undefined behavior
> caused by overflow.

There is no undefined behaviour due to overflow. UBSAN is broken,
upgrade to GCC8 or later.
