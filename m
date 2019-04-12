Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59041C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3032120674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDLBwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:52:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:48834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfDLBwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:52:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BD85ACF8;
        Fri, 12 Apr 2019 01:52:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Fri, 12 Apr 2019 11:52:07 +1000
Subject: [PATCH 0/5] Fix rhashtable bit-locking for m68k
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Message-ID: <155503371949.17793.8266195008003399968.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Guenter Roeck, the new rhashtable bit-locking
doesn't work on m68k as it only requires 2-byte alignment, so BIT(1)
is addresses is not unused.

We current use BIT(0) to identify a NULLS marker, but that is only
needed in ->next pointers.  The bucket head does not need a NULLS
marker, so the lsb there can be used for locking.

the first 4 patches make some small improvements and re-arrange some
code.  The final patch converts to using only BIT(0) for these two
different special purposes.

I had previously suggested dropping the series until I fix it.  Given
that this was fairly easy, I retract that I think it best simply to
add these patches to fix the code.

Thanks,
NeilBrown

---

NeilBrown (5):
      rhashtable: fix some __rcu annotation errors
      rhashtable: reorder some inline functions and macros.
      rhashtable: move dereference inside rht_ptr()
      rhashtable: replace rht_ptr_locked() with rht_assign_locked()
      rhashtable: use BIT(0) for locking.


 include/linux/rhashtable.h |  226 +++++++++++++++++++++++++-------------------
 lib/rhashtable.c           |   24 ++---
 lib/test_rhashtable.c      |    2 
 3 files changed, 142 insertions(+), 110 deletions(-)

--
Signature

