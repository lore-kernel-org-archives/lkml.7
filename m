Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37120C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F12E20656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLCKvw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:51:52 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:49850 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfLCKvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:51:51 -0500
IronPort-SDR: CL1oci0CjYpmV82W31UJYtyw/2xDAlTlhLPJWfJKDaukkWCmWwVw8POQJELNydo6bYvC2uTeRq
 zDSRH6iqRuceDNHvmOxTRciJHRsqOulBtrekVML3xNxDgWYi9C4sbTx7mRh8sJjh+a1rWOSx3k
 DfrIdZYRg/peJ0Dj90qqmMxodB5hDaZ4PNvx698BD9tNpdjYyUnqDomyYD7covl6R89aaxwhm+
 6N7rqOmJXfjYs4+IKUFLWYjpgZwUt7agJwb8s5D/S/VpoPdyczNzGhVy4xb4SOxojSuOg+kKeo
 XKc=
X-IronPort-AV: E=Sophos;i="5.69,272,1571731200"; 
   d="scan'208";a="43654481"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 03 Dec 2019 02:51:51 -0800
IronPort-SDR: p4sJTNOtKCKtqUJ6AZsYjOR3ERGgpk48uCLfiUzzIsS6vs7gp0Pdo5JmeHk4C8lCnwKceE/m8b
 Hg6o4GoyvKjTmQKDyOfKVH+pED7eTt79/Y/Ec19aK/wUByPvoj9OEYBQkvJo4Xly4494eMiwnG
 tQjsm9WdIuZEM8X1gFFGBACyF/0xKL/sX7gCLoCmLNOOQb+L14Gyz4nHXdci5/1tJzCVLsVuQ2
 H89tfV0eUw0/vqWs5egiLKLKUNhzd/OUBdb2xFKRfNWTBv+uTeBZmyzc/mtjmQRZmSC4sShg+y
 0zY=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: Crash in fair scheduler
Thread-Topic: Crash in fair scheduler
Thread-Index: AQHVqbfg64Wqju89WkedWbWijDxswKeoNgIAgAADvAA=
Date:   Tue, 3 Dec 2019 10:51:46 +0000
Message-ID: <656260cf50684c11a3122aca88dde0cb@SVR-IES-MBX-03.mgc.mentorg.com>
References: <1575364273836.74450@mentor.com>
 <20191203103046.GJ2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191203103046.GJ2827@hirez.programming.kicks-ass.net>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > we had a crash in the fair scheduler and analysis shows that this could
> happen again.
> > Happened on 4.14.86 (LTS series) but failing code path still exists in 5.4-rc2
> (and 4.14.147 too).
> 
> Please, do try if you can reproduce with Linus' latest git. I've no idea
> what is, or is not, in those stable trees.
> 
unfortunately a once issue so far ...


--- snip ---

> > include/linux/rbtree.h:91:#define rb_first_cached(root) (root)-
> >rb_leftmost
> 
> > struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
> > {
> > 	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);
> >
> > 	if (!left)
> > 		return NULL; <<<<<<<<<< the case
> >
> > 	return rb_entry(left, struct sched_entity, run_node);
> > }
> 
> This the problem, for some reason the rbtree code got that rb_leftmost
> thing wrecked.
> 
Any known issue on rbtree code regarding this?

> > Is this a corner case nobody thought of or do we have cfs_rq data that is
> unexpected in it's content?
> 
> No, the rbtree is corrupt. Your tree has a single node (which matches
> with nr_running), but for some reason it thinks rb_leftmost is NULL.
> This is wrong, if the tree is non-empty, it must have a leftmost
> element.
Is there a chance to find the left-most element in the core dump?
Maybe i can dig deeper to find the root c ause then.
Does any of the structs/data in this context point to some memory
where i can continue to search?
Where should rb_leftmost point to if only one node is in the tree?
To the node itself?

> 
> Can you reproduce at will? If so, can you please try the latest kernel,
> and or share the reproducer?
Unfortunately this was a "once" issue so far; i haven't a reproducer yet.

Thanks,
Carsten
