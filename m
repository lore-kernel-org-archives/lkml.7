Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93817C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C306205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbfIVQGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 12:06:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56934 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387471AbfIVQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 12:06:09 -0400
X-UUID: ac37638948e847a1bde229f1f10bc205-20190923
X-UUID: ac37638948e847a1bde229f1f10bc205-20190923
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1850422418; Mon, 23 Sep 2019 00:06:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Sep 2019 00:05:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Sep 2019 00:05:56 +0800
Message-ID: <1569168360.9436.17.camel@mtkswgap22>
Subject: Re: [PATCH] mm: slub: print_hex_dump() with DUMP_PREFIX_OFFSET
From:   Miles Chen <miles.chen@mediatek.com>
To:     David Rientjes <rientjes@google.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 23 Sep 2019 00:06:00 +0800
In-Reply-To: <alpine.DEB.2.21.1909210207240.259613@chino.kir.corp.google.com>
References: <20190920104849.32504-1-miles.chen@mediatek.com>
         <alpine.DEB.2.21.1909210207240.259613@chino.kir.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2019-09-21 at 02:08 -0700, David Rientjes wrote:
> On Fri, 20 Sep 2019, Miles Chen wrote:
> 
> > Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> > The use DUMP_PREFIX_OFFSET instead of DUMP_PREFIX_ADDRESS with
> > print_hex_dump() can generate more useful messages.
> > 
> > In the following example, it's easier get the offset of incorrect poison
> > value with DUMP_PREFIX_OFFSET.
> > 
> > Before:
> > Object 00000000e817b73b: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000816f4601: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000169d2bb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000f4c38716: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000917e3491: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000000c0e33738: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 000000001755ddd1: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > 
> > After:
> > Object 00000000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000010: 63 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000020: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > Object 00000030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
> > 
> > I think it might be worth to convert all DUMP_PREFIX_ADDRESS to
> > DUMP_PREFIX_OFFSET for the whole Linux kernel.
> > 
> 
> I agree it looks nicer for poisoning, I'm not sure that every caller of 
> print_section() is the same, however.  For example trace() seems better 
> off as DUMP_PREFIX_ADDRESS since it already specifies the address of the 
> object being allocated or freed and offset here wouldn't really be useful, 
> no?

Thanks for the reply. I agree not all caller of print_section() is the
same case. Converting all of them is not a good idea.

For mm/slub.c, let me explain with the following example.

The offset is useful for use-after-free debugging. I often trace the
"free track" and find the data structure used and compare the data
structure with the offset of the incorrect poison value and see if the
incorrect poison value matches some member of that data structure.


Assume we have a data structure "something" and it has a member called
"m", offset = 780.

        struct something *p; // sizeof(struct something) is 1024

        p = kmalloc(sizeof(struct something), GFP_KERNEL);
        kfree(p);

        (p->m) = 'c'; // assume p->member is at offset=780


When we see the log: (using DUMP_PREFIX_ADDRESS)
We have to "count" the offset.

INFO: Slab 0x(____ptrval____) objects=21 used=21 fp=0x(____ptrval____)
flags=0x10200
INFO: Object 0x(____ptrval____) @offset=7808 fp=0x(____ptrval____)

Redzone ____ptrval____: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone ____ptrval____: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone ____ptrval____: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone ____ptrval____: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone ____ptrval____: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone ____ptrval____: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone ____ptrval____: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone ____ptrval____: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
...
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 63 6b 6b 6b
kkkkkkkkkkkkckkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object ____ptrval____: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk


The log of using DUMP_PREFIX_OFFSET:
We still have to "count", but it is easier.

INFO: Slab 0x(____ptrval____) objects=21 used=21 fp=0x(____ptrval____)
flags=0x10200
INFO: Object 0x(____ptrval____) @offset=7808 fp=0x(____ptrval____)

Redzone 00000000: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone 00000010: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone 00000020: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone 00000030: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone 00000040: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone 00000050: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone 00000060: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Redzone 00000070: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
bb  ................
Object 00000000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000020: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000040: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000050: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000060: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
...
Object 00000270: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000280: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000290: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 000002a0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 000002b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 000002c0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 000002d0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 000002e0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 000002f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000300: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 63 6b 6b 6b
kkkkkkkkkkkkckkk
Object 00000310: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000320: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000330: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000340: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000350: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000360: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000370: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 00000380: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk


cheers,
Miles

