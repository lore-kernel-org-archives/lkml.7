Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA81C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0E20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfCZFEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:04:00 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59040 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfCZFEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:04:00 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1h8eFh-0004xj-Q7; Tue, 26 Mar 2019 13:03:57 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1h8eF6-0001xE-IO; Tue, 26 Mar 2019 13:03:20 +0800
Date:   Tue, 26 Mar 2019 13:03:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Message-ID: <20190326050320.gwk3tgtqwl5csivt@gondor.apana.org.au>
References: <155349021177.1111.15681654355431465791.stgit@noble.brown>
 <155349033961.1111.18247269615646768227.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155349033961.1111.18247269615646768227.stgit@noble.brown>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:05:39PM +1100, NeilBrown wrote:
>
> + * Sometimes we unlock a bucket by writing a new pointer there.  In that
> + * case we don't need to unlock, but we do need to reset state such as
> + * local_bh. For that we have rht_unlocked().  This doesn't include
> + * the memory barrier that bit_spin_unlock() provides, but rcu_assign_pointer()
> + * will have provided that.

Hmm, are you sure that's enough? IIRC rcu_assign_pointer only
provides a write barrier compared to the more complete (but one-way)
barrier that a spin-lock provides.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
