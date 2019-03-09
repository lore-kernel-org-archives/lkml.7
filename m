Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72972C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A6420857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfCICZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 21:25:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfCICZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 21:25:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D856614051B14;
        Fri,  8 Mar 2019 18:25:36 -0800 (PST)
Date:   Fri, 08 Mar 2019 18:25:36 -0800 (PST)
Message-Id: <20190308.182536.2245581706498467239.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix client call queueing, waiting for
 channel
From:   David Miller <davem@davemloft.net>
In-Reply-To: <155209139894.21860.5649266453556857318.stgit@warthog.procyon.org.uk>
References: <155209139894.21860.5649266453556857318.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Mar 2019 18:25:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Sat, 09 Mar 2019 00:29:58 +0000

> rxrpc_get_client_conn() adds a new call to the front of the waiting_calls
> queue if the connection it's going to use already exists.  This is bad as
> it allows calls to get starved out.
> 
> Fix this by adding to the tail instead.
> 
> Also change the other enqueue point in the same function to put it on the
> front (ie. when we have a new connection).  This makes the point that in
> the case of a new connection the new call goes at the front (though it
> doesn't actually matter since the queue should be unoccupied).
> 
> Fixes: 45025bceef17 ("rxrpc: Improve management and caching of client connection objects")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Applied and queued up for -stable, thanks David.
