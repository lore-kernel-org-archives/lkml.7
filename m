Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA0C2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfCOFKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 01:10:49 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:51656 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfCOFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 01:10:49 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1h4f76-0006Y1-U4; Fri, 15 Mar 2019 13:10:36 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1h4f6z-0000Ud-G0; Fri, 15 Mar 2019 13:10:29 +0800
Date:   Fri, 15 Mar 2019 13:10:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rhashtable: use cmpxchg() in nested_table_alloc()
Message-ID: <20190315051029.waqb3ohztl7w6zep@gondor.apana.org.au>
References: <155253979234.5022.1840929790507376038.stgit@noble.brown>
 <155253992824.5022.10318044793639169265.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155253992824.5022.10318044793639169265.stgit@noble.brown>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil:

On Thu, Mar 14, 2019 at 04:05:28PM +1100, NeilBrown wrote:
> nested_table_alloc() relies on the fact that there is
> at most one spinlock allocated for every slot in the top
> level nested table, so it is not possible for two threads
> to try to allocate the same table at the same time.
> 
> This assumption is a little fragile (it is not explicit) and is
> unnecessary.  We can instead protect against
> a race using cmpxchg() - if it the cmp fails, free the table
> that was just allocated.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  lib/rhashtable.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

You probably explained it to me before but it's been long enough
that I no longer remember why we need this change.  So please
explain in the commit log why this change is needed.  Because
on the face of it you are adding locking/sychronisation and not
taking it away.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
