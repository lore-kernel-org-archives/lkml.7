Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B383FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B822087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfCYFGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:06:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCYFGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:06:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8183AC61;
        Mon, 25 Mar 2019 05:06:04 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon, 25 Mar 2019 16:05:39 +1100
Subject: [PATCH 0/4] Convert rhashtable to use bitlocks
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155349021177.1111.15681654355431465791.stgit@noble.brown>
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
  slight improves parallelism
  make a configuration option unnecessary

Thanks,
NeilBrown

---

NeilBrown (4):
      rhashtable: use cmpxchg() in nested_table_alloc()
      rhashtable: allow rht_bucket_var to return NULL.
      rhashtable: use bit_spin_locks to protect hash bucket.
      rhashtable: add lockdep tracking to bucket bit-spin-locks.


 include/linux/rhashtable-types.h |    2 
 include/linux/rhashtable.h       |  204 ++++++++++++++++++++++++++------------
 ipc/util.c                       |    1 
 lib/rhashtable.c                 |  143 +++++++++++++++------------
 net/bridge/br_fdb.c              |    1 
 net/bridge/br_multicast.c        |    1 
 net/bridge/br_vlan.c             |    1 
 net/bridge/br_vlan_tunnel.c      |    1 
 net/ipv4/ipmr.c                  |    1 
 net/ipv6/ip6mr.c                 |    1 
 net/netfilter/nf_tables_api.c    |    1 
 11 files changed, 219 insertions(+), 138 deletions(-)

--
Signature

