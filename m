Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACDCC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE5B23431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfH3VzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:55:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42560 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfH3VzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:55:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A1D85154FF691;
        Fri, 30 Aug 2019 14:55:16 -0700 (PDT)
Date:   Fri, 30 Aug 2019 14:55:16 -0700 (PDT)
Message-Id: <20190830.145516.687207471361740034.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/7] rxrpc: Fix use of skb_cow_data()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <156708405310.26102.7954021163316252673.stgit@warthog.procyon.org.uk>
References: <156708405310.26102.7954021163316252673.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Aug 2019 14:55:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 29 Aug 2019 14:07:33 +0100

> Here's a series of patches that replaces the use of skb_cow_data() in rxrpc
> with skb_unshare() early on in the input process.  The problem that is
> being seen is that skb_cow_data() indirectly requires that the maximum
> usage count on an sk_buff be 1, and it may generate an assertion failure in
> pskb_expand_head() if not.
> 
> This can occur because rxrpc_input_data() may be still holding a ref when
> it has just attached the sk_buff to the rx ring and given that attachment
> its own ref.  If recvmsg happens fast enough, skb_cow_data() can see the
> ref still held by the softirq handler.
> 
> Further, a packet may contain multiple subpackets, each of which gets its
> own attachment to the ring and its own ref - also making skb_cow_data() go
> bang.
> 
> Fix this by:
 ...
> There are also patches to improve the rxrpc_skb tracepoint to make sure
> that Tx-derived buffers are identified separately from Rx-derived buffers
> in the trace.

This looks great, thanks for reimplementing this using skb_unshare().

> The patches are tagged here:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 	rxrpc-fixes-20190827

Pulled, thanks again.
