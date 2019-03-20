Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D411EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AA420857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCTFlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:41:18 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:47156 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfCTFlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:41:17 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1h6TyQ-00058K-Tx; Wed, 20 Mar 2019 13:41:10 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1h6TyP-00078o-W0; Wed, 20 Mar 2019 13:41:10 +0800
Date:   Wed, 20 Mar 2019 13:41:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rhashtable: use cmpxchg() in nested_table_alloc()
Message-ID: <20190320054109.6abodcm4yyhacc5w@gondor.apana.org.au>
References: <155253979234.5022.1840929790507376038.stgit@noble.brown>
 <155253992824.5022.10318044793639169265.stgit@noble.brown>
 <20190315051029.waqb3ohztl7w6zep@gondor.apana.org.au>
 <87lg1gocj8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg1gocj8.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 05:51:55PM +1100, NeilBrown wrote:
>
> I hoped the patch could be justified on the basis that the current
> behaviour is fragile - the dependency that a single spin lock covers a
> while slot (and all children) in the top-level nested table is not at
> all obvious.
> 
> I do have a stronger reason though - I want the replace the spinlocks
> with bit-spin-locks.  With those we will only hold a lock for the
> particular chain being worked on.  If you need that extra explanation to
> justify the patch, I'll hold it over until the other two patches land
> and the rest of the bit-spin-lock series is ready.

I think it would make more sense to combine this patch with your
bit-spin-lock patch in a series.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
