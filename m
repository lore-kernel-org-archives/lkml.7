Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672BFC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 13:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C30218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 13:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404294AbfIGNy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 09:54:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45056 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388238AbfIGNy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 09:54:58 -0400
Received: from localhost (unknown [88.214.184.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C1D9B152788C9;
        Sat,  7 Sep 2019 06:54:55 -0700 (PDT)
Date:   Sat, 07 Sep 2019 15:54:54 +0200 (CEST)
Message-Id: <20190907.155454.629859380717886153.davem@davemloft.net>
To:     wang.yi59@zte.com.cn
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        cheng.lin130@zte.com.cn
Subject: Re: [PATCH v3] ipv6: Not to probe neighbourless routes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1567145476-33802-1-git-send-email-wang.yi59@zte.com.cn>
References: <1567145476-33802-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Sep 2019 06:54:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Lin <wang.yi59@zte.com.cn>
Date: Fri, 30 Aug 2019 14:11:16 +0800

> Originally, Router Reachability Probing require a neighbour entry
> existed. Commit 2152caea7196 ("ipv6: Do not depend on rt->n in
> rt6_probe().") removed the requirement for a neighbour entry. And
> commit f547fac624be ("ipv6: rate-limit probes for neighbourless
> routes") adds rate-limiting for neighbourless routes.

I am not going to apply this patch.

The reason we handle neighbourless routes is because due to the
disconnect between routes and neighbour entries, we would lose
information with your suggested change.

Originally, all routes held a reference to a neighbour entry.
Therefore we'd always have a neigh entry for any neigh message
matching a route.

But these two object pools (routes and neigh entries) are completely
disconnected.  We only look up a neigh entry when sending a packet
on behalf of a route.

Therfore, neigh entries can be purged arbitrarily even if hundreds of
routes refer to them.  And this means it is very important to accept
and process probes even for neighbourless routes.

I would also not recommend, in the future, reading RFC requirements
literally without taking into consideration the details of Linux's
specific implementation of ipv6 routing and neighbours.

Thank you.
