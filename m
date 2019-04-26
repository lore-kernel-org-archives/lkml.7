Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BB4C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353782077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfDZN7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfDZN7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:59:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 209BD309D059;
        Fri, 26 Apr 2019 13:59:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9362460BF3;
        Fri, 26 Apr 2019 13:59:25 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x3QDxPOM005749;
        Fri, 26 Apr 2019 09:59:25 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x3QDxOW9005745;
        Fri, 26 Apr 2019 09:59:24 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 26 Apr 2019 09:59:24 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng HS1 Ye <yehs1@lenovo.com>
cc:     "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        NingTing Cheng <chengnt@lenovo.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH] dm-writecache: avoid unnecessary lookups
 in writecache_find_entry
In-Reply-To: <HK2PR03MB4418482EB0C2C73559FACD7F923C0@HK2PR03MB4418.apcprd03.prod.outlook.com>
Message-ID: <alpine.LRH.2.02.1904260955070.682@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190420162102.6460-1-yehs2007@zoho.com> <alpine.LRH.2.02.1904231140240.17390@file01.intranet.prod.int.rdu2.redhat.com> <HK2PR03MB4418482EB0C2C73559FACD7F923C0@HK2PR03MB4418.apcprd03.prod.outlook.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 26 Apr 2019 13:59:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Apr 2019, Huaisheng HS1 Ye wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Sent: Tuesday, April 23, 2019 11:44 PM
> > 
> > On Sun, 21 Apr 2019, Huaisheng Ye wrote:
> > 
> > > From: Huaisheng Ye <yehs1@lenovo.com>
> > >
> > > Only when entry has been found, that would only be necessary to check the
> > > lowest or highest seq-count.
> > >
> > > Add local variable "found" in writecache_find_entry, if no entry has been
> > > found, it is meaningless that having a useless rb_prev or rb_next.
> > 
> > 
> > Hi
> > 
> > I don't quite see what is this patch trying to fix.
> > Don't fix something that isn't broken
> 
> Hi Mikulas,
> 
> Thanks for your reply.
> This patch is not designed for fixing logical error. That is used for optimizing the behavior of writecache_find_entry.
> 
> Let me give an example to illustrate the point below.
> Suppose that is the case, here is a normal READ bio comes to writecache_map. And because of bio's direction is READ, writecache_find_entry would be called with flags WFE_RETURN_FOLLOWING.
> 
> Now there are two scenarios, 
> 1. writecache_find_entry successfully get an existing entry by searching rb_tree, we could call it HIT. Then the first 'while' will be finished by 'break'. Next it will move to second 'while' loop, because of the flags hasn't been marked as WFE_LOWEST_SEQ. writecache_find_entry will try to return an entry with HIGHEST_SEQ, if there are other entries which has same original_sector in rb_tree.
> For this situation, the current code is okay to deal with it.
> 
> 2. writecache_find_entry couldn't get an existing entry from rb_tree, we could call it MISS. Because of same flags WFE_RETURN_FOLLOWING, writecache_find_entry will get other entry, which's original_sector will slightly larger than input parameter block, with big probability.
> For this scenario, function writecache_find_entry doesn't need to enter second 'while' loop. But current code would still try to check there were other entry with same original_sector.
> So the additional rb_next or rb_prev is unnecessary by this case, also the code doesn't need to compare the original_sector of 'e2' with parameter 'block'.
> 
> My patch is designed to optimize the second case. so we could skip the second 'while' loop when the block is missed from rb_tree.
> 
> Cheers,
> Huaisheng Ye

So, it seems that we don't need the "found" variable at all, we could just 
return the variable "e" directly when we are in a position where "found" 
is false.

What about this patch? Could you test it?

Mikulas




From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] dm-writecache: a small optimization in writecache_find_entry

If we go past the condition "if (unlikely(!node))", we can be certain that
there is no entry in the tree that has the block equal to the "block"
variable.

Consequently, we can return the next entry directly, we don't need to go 
to the second part of the function that finds the entry with lowest or 
highest seq number that matches the "block" variable.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm-writecache.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/md/dm-writecache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-writecache.c	2019-03-18 10:28:50.000000000 +0100
+++ linux-2.6/drivers/md/dm-writecache.c	2019-04-26 15:49:18.000000000 +0200
@@ -553,14 +553,14 @@ static struct wc_entry *writecache_find_
 				return NULL;
 			}
 			if (read_original_sector(wc, e) >= block) {
-				break;
+				return e;
 			} else {
 				node = rb_next(&e->rb_node);
 				if (unlikely(!node)) {
 					return NULL;
 				}
 				e = container_of(node, struct wc_entry, rb_node);
-				break;
+				return e;
 			}
 		}
 	}
