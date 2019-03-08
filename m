Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2739320851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfCHT0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:26:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38854 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCHT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:26:34 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 747CD14AE4A60;
        Fri,  8 Mar 2019 11:26:33 -0800 (PST)
Date:   Fri, 08 Mar 2019 11:26:33 -0800 (PST)
Message-Id: <20190308.112633.1040548315975715311.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix client call connect/disconnect race
From:   David Miller <davem@davemloft.net>
In-Reply-To: <155204931903.22787.5981080627556318769.stgit@warthog.procyon.org.uk>
References: <155204931903.22787.5981080627556318769.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Mar 2019 11:26:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Fri, 08 Mar 2019 12:48:39 +0000

> rxrpc_disconnect_client_call() reads the call's connection ID protocol
> value (call->cid) as part of that function's variable declarations.  This
> is bad because it's not inside the locked section and so may race with
> someone granting use of the channel to the call.
> 
> This manifests as an assertion failure (see below) where the call in the
> presumed channel (0 because call->cid wasn't set when we read it) doesn't
> match the call attached to the channel we were actually granted (if 1, 2 or
> 3).
> 
> Fix this by moving the read and dependent calculations inside of the
> channel_lock section.  Also, only set the channel number and pointer
> variables if cid is not zero (ie. unset).
> 
> This problem can be induced by injecting an occasional error in
> rxrpc_wait_for_channel() before the call to schedule().
> 
> Make two further changes also:
> 
>  (1) Add a trace for wait failure in rxrpc_connect_call().
> 
>  (2) Drop channel_lock before BUG'ing in the case of the assertion failure.
> 
> The failure causes a trace akin to the following:
 ...
> Fixes: 45025bceef17 ("rxrpc: Improve management and caching of client connection objects")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Applied, thanks David.
