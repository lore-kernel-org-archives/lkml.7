Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF587C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F5820880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDHCM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:12:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55824 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDHCM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:12:58 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2D197133E976D;
        Sun,  7 Apr 2019 19:12:58 -0700 (PDT)
Date:   Sun, 07 Apr 2019 19:12:55 -0700 (PDT)
Message-Id: <20190407.191255.1243683680105907349.davem@davemloft.net>
To:     neilb@suse.com
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4 v2] Convert rhashtable to use bitlocks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <155416000985.9540.14182958463813560577.stgit@noble.brown>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Apr 2019 19:12:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Tue, 02 Apr 2019 10:07:45 +1100

> This series converts rhashtable to use a per-bucket bitlock
> rather than a separate array of spinlocks.
> This:
>   reduces memory usage
>   results in slightly fewer memory accesses
>   slightly improves parallelism
>   makes a configuration option unnecessary
> 
> The main change from previous version is to use a distinct type for
> the pointer in the bucket which has a bit-lock in it.  This
> helped find two places where rht_ptr() was missed, one
> in  rhashtable_free_and_destroy() in print_ht in the test code.

This looks good to me and I haven't seen any major objections.

I think however the thing is encoded, an unsigned long or a pointer,
the cleanliness is basically a wash.

Thanks.
