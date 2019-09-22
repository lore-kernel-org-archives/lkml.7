Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1B3206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbfIVRFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 13:05:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18199 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387814AbfIVRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:05:16 -0400
X-UUID: 49212885924945968eca7b064bffa9b4-20190923
X-UUID: 49212885924945968eca7b064bffa9b4-20190923
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 264843363; Mon, 23 Sep 2019 01:05:09 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Sep 2019 01:05:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Sep 2019 01:05:04 +0800
Message-ID: <1569171908.9436.55.camel@mtkswgap22>
Subject: Re: [PATCH] mm: slub: print_hex_dump() with DUMP_PREFIX_OFFSET
From:   Miles Chen <miles.chen@mediatek.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 23 Sep 2019 01:05:08 +0800
In-Reply-To: <20190921160018.GF15392@bombadil.infradead.org>
References: <20190920104849.32504-1-miles.chen@mediatek.com>
         <alpine.DEB.2.21.1909210207240.259613@chino.kir.corp.google.com>
         <20190921160018.GF15392@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-21 at 09:00 -0700, Matthew Wilcox wrote:
> On Sat, Sep 21, 2019 at 02:08:59AM -0700, David Rientjes wrote:
> > On Fri, 20 Sep 2019, Miles Chen wrote:
> > 
> > > Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> > > The use DUMP_PREFIX_OFFSET instead of DUMP_PREFIX_ADDRESS with
> > > print_hex_dump() can generate more useful messages.
> > > 
> > > In the following example, it's easier get the offset of incorrect poison
> > > value with DUMP_PREFIX_OFFSET.
> > > 
> > > Before:
> > > Object 00000000e817b73b: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 00000000816f4601: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 00000000169d2bb8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 00000000f4c38716: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 00000000917e3491: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 00000000c0e33738: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 000000001755ddd1: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > 
> > > After:
> > > Object 00000000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 00000010: 63 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 00000020: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> > > Object 00000030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
> > 
> > I agree it looks nicer for poisoning, I'm not sure that every caller of 
> > print_section() is the same, however.  For example trace() seems better 
> > off as DUMP_PREFIX_ADDRESS since it already specifies the address of the 
> > object being allocated or freed and offset here wouldn't really be useful, 
> > no?
> 
> While it looks nicer, it might be less useful for debugging.  The point of
> obfuscated %p is that you can compare two "pointer" values for equality.
> So if you know that you freed object 00000000e817b73b from an earlier
> printk, then you can match it up to this dump.  It's obviously not
> perfect since we're only getting the pointers at addresses that are
> multiples of 16, but it's a help.

Thanks for the reply.

The value of 00000000e817b73b dump and the value earlier printk should
be the same, Otherwise we have a serious problem because:

printf("%p", bad_ptr);
print_hex_dump(bad_ptr);

and we see a different hashed address of bad_ptr in print_hex_dump().
I think it's a rare case but we still have a chance to see that case.
DUMP_PREFIX_ADDRESS is useful for that case.


On the other hand, DUMP_PREFIX_OFFSET is useful for finding the offset
of incorrect poison value easier. 
Maybe I can print the offset of the bad poison value in 
check_bytes_and_report(). e.g., 

@@ -736,6 +736,7 @@ static int check_bytes_and_report(struct kmem_cache
*s, struct page *page,
 {
        u8 *fault;
        u8 *end;
+       u8 *addr = page_address(page);

        metadata_access_enable();
        fault = memchr_inv(start, value, bytes);
@@ -748,8 +749,9 @@ static int check_bytes_and_report(struct kmem_cache
*s, struct page *page,
                end--;

        slab_bug(s, "%s overwritten", what);
-       pr_err("INFO: 0x%p-0x%p. First byte 0x%x instead of 0x%x\n",
-                                       fault, end - 1, fault[0],
value);
+       pr_err("INFO: 0x%p-0x%p. First byte 0x%x instead of 0x%x,
offset=%tu\n",
+                                       fault, end - 1, fault[0], value,
fault -
+                                       addr);


and we can see the offset printed out:

=============================================================================
BUG kmalloc-1k (Tainted: G    B            ): Poison overwritten
-----------------------------------------------------------------------------

INFO: 0x(____ptrval____)-0x(____ptrval____). First byte 0x63 instead of
0x6b, offset=7052
INFO: Object 0x(____ptrval____) @offset=6272 fp=0x(____ptrval____)

and we can get the offset by: 7052 - 6272 = 780.

