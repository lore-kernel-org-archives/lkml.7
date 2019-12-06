Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2748C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C033D21823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFKLa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:11:30 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:43668 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLFKLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:11:30 -0500
IronPort-SDR: eqRiC5dtHiz8Bnh85YK/UtADo+XCpV8T4/SUPLiDU6t2XmtwYxIX/fEpmDnZ2vwQasNZIkOWfd
 xWexELFGWgOPL9uZScl6jCZrRBZXA00mTXb380IqeSUVv/8d0qaOGwg81/5iNkz+AjyDYCIwZp
 ck0NqTjecvPSM/5LmQXmexBtY4Sb+0ryc5Jin+qQZP9J2m5zWFswNgtWHv1csgcZR5T/POMiDm
 kX8BqAKGW6hnbakBgHQpxjZjpNZSxdPgeWRRbN3CNXZ6kOYa9OvM/k0DwH9oxfrJx9wx76uH6Q
 eD8=
X-IronPort-AV: E=Sophos;i="5.69,284,1571731200"; 
   d="scan'208";a="45727416"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 06 Dec 2019 02:11:29 -0800
IronPort-SDR: NQEWeS1aCttk1s3wQj/3m53ZoY/GNPcVpR5AeAUCXWcoBa6p4Xgf3TJZEaoET0+ySO6s6iduuI
 /XYG/N72stR3+X2gWDCLg+J5EZbf0/DY5Y4xAOMsKWOz6NRtGuTLZ6r21wcSsPvlZiGjsk8xyq
 UuIVsYnbSz1anIaYG1QyAGzk2mNVju7TXxQ29Y8kic/hXV28uA7bZvRh4IsUa6z6Q0mvryh1Br
 wLANnx/5L2I640YxozVCozUuArA7PQBaWmaEZheyBZ6TQV/NqFLqdtRnvKSUKBCMhq5B2WKXSc
 8HI=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "walken@google.com" <walken@google.com>
Subject: AW: Crash in fair scheduler
Thread-Topic: Crash in fair scheduler
Thread-Index: AQHVrBxnkeU0erWGx0aj8BTLdT17Gw==
Date:   Fri, 6 Dec 2019 10:11:25 +0000
Message-ID: <1575627084926.26450@mentor.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: Davidlohr Bueso [mailto:dave@stgolabs.net]
> Gesendet: Donnerstag, 5. Dezember 2019 18:41
> 
> Yeah I had never seen this either, and would expect the world to fall
> appart if leftmost is buggy (much less a one time occurance), but the
> following certainly raises a red flag:
> 
>     &cfs_rq->tasks_timeline->rb_leftmost
>   tasks_timeline = {
>     rb_root = {
>       rb_node = 0xffff99a9502e0d10
>     },
>     rb_leftmost = 0x0
>   },
> 
Meanwhile i am diving a bit deeper into the kernel dump.
I can see that for this rb_root we have a node structure with 2 nodes:
crash> p -x *(struct rb_node *)0xffff99a9502e0d10
$7 = {
  __rb_parent_color = 0xffff99a9502e0d10, <- points to SELF
  rb_right = 0xffff99a9502e0d10, <- points to self
  rb_left = 0xffff99a9502e1990 <- and we have a node left
}

The rb_left node:
crash> p -x *(struct rb_node *)0xffff99a9502e1990
$6 = {
  __rb_parent_color = 0xffff99a9502e0d11, <- points to the rb_root node (bit 0 is color)
  rb_right = 0x0, <- no leaf
  rb_left = 0x0 <- no leaf
}

I'm currently trying to extract the information what se (scheduling entity)
covers these nodes.
Anyway, the cfs_rq->tasks_timeline.rb_leftmost should point to 0xffff99a9502e1990
as far as i understand the rb_tree, right?

> >
> >I suppose one approach is to add code to both __enqueue_entity() and
> >__dequeue_entity() that compares ->rb_leftmost to the result of
> >rb_first(). That'd incur some overhead but it'd double check the logic.
> 
> We could benefit from improved debugging in rbtrees, not only the cached
> flavor. Perhaps we can start with the following -- this would at least
> let us know if the case where the tree is non-empty and leftmost is nil
> was hit, whether in the scheduler or another user...
> 
> Thanks,
> Davidlohr
> 
That's what i will do too, add some debugging stuff.
Add that to the project i'm on here, not upstream; and try
to log as much debug data as possible if a similar case occurs again.
But as rb_tree is excessively used i need to be careful where
to add debug code due to performance impact.

The approach you do with a configurable rb_tree debug
might help me here, yes; i would have taken a similar approach.

Thanks,
Carsten

