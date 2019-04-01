Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFBCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52414208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfDAXIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:08:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbfDAXIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:08:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3676AAFF9;
        Mon,  1 Apr 2019 23:08:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue, 02 Apr 2019 10:07:45 +1100
Subject: [PATCH 0/4 v2]  Convert rhashtable to use bitlocks
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155416000985.9540.14182958463813560577.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts rhashtable to use a per-bucket bitlock
rather than a separate array of spinlocks.
This:
  reduces memory usage
  results in slightly fewer memory accesses
  slightly improves parallelism
  makes a configuration option unnecessary

The main change from previous version is to use a distinct type for
the pointer in the bucket which has a bit-lock in it.  This
helped find two places where rht_ptr() was missed, one
in  rhashtable_free_and_destroy() in print_ht in the test code.

Thanks,
NeilBrown

---

NeilBrown (4):
      rhashtable: use cmpxchg() in nested_table_alloc()
      rhashtable: allow rht_bucket_var to return NULL.
      rhashtable: use bit_spin_locks to protect hash bucket.
      rhashtable: add lockdep tracking to bucket bit-spin-locks.


 include/linux/rhashtable-types.h |    2 
 include/linux/rhashtable.h       |  271 ++++++++++++++++++++++++++------------
 ipc/util.c                       |    1 
 lib/rhashtable.c                 |  161 ++++++++++++-----------
 lib/test_rhashtable.c            |    2 
 net/bridge/br_fdb.c              |    1 
 net/bridge/br_multicast.c        |    1 
 net/bridge/br_vlan.c             |    1 
 net/bridge/br_vlan_tunnel.c      |    1 
 net/ipv4/ipmr.c                  |    1 
 net/ipv6/ip6mr.c                 |    1 
 net/netfilter/nf_tables_api.c    |    1 
 12 files changed, 271 insertions(+), 173 deletions(-)

--
Signature

