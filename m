Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5D12175B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfFMRqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:46:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11945 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725852AbfFMRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:46:49 -0400
X-UUID: 1bc9fbe28e904bcf97072f05f18c0602-20190614
X-UUID: 1bc9fbe28e904bcf97072f05f18c0602-20190614
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 795620865; Fri, 14 Jun 2019 01:46:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Jun 2019 01:46:39 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Jun 2019 01:46:39 +0800
Message-ID: <1560447999.15814.15.camel@mtksdccf07>
Subject: Re: [PATCH v3] kasan: add memory corruption identification for
 software tag-based mode
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
CC:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 14 Jun 2019 01:46:39 +0800
In-Reply-To: <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com>
References: <20190613081357.1360-1-walter-zh.wu@mediatek.com>
         <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 73E573334F60FA682523A92B528AE4E79ADB9EB515874F36690B616CC9E25A672000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-13 at 15:27 +0300, Andrey Ryabinin wrote:
> 
> On 6/13/19 11:13 AM, Walter Wu wrote:
> > This patch adds memory corruption identification at bug report for
> > software tag-based mode, the report show whether it is "use-after-free"
> > or "out-of-bound" error instead of "invalid-access" error.This will make
> > it easier for programmers to see the memory corruption problem.
> > 
> > Now we extend the quarantine to support both generic and tag-based kasan.
> > For tag-based kasan, the quarantine stores only freed object information
> > to check if an object is freed recently. When tag-based kasan reports an
> > error, we can check if the tagged addr is in the quarantine and make a
> > good guess if the object is more like "use-after-free" or "out-of-bound".
> > 
> 
> 
> We already have all the information and don't need the quarantine to make such guess.
> Basically if shadow of the first byte of object has the same tag as tag in pointer than it's out-of-bounds,
> otherwise it's use-after-free.
> 
> In pseudo-code it's something like this:
> 
> u8 object_tag = *(u8 *)kasan_mem_to_shadow(nearest_object(cacche, page, access_addr));
> 
> if (access_addr_tag == object_tag && object_tag != KASAN_TAG_INVALID)
> 	// out-of-bounds
> else
> 	// use-after-free

Thanks your explanation.
I see, we can use it to decide corruption type.
But some use-after-free issues, it may not have accurate free-backtrace.
Unfortunately in that situation, free-backtrace is the most important.
please see below example

In generic KASAN, it gets accurate free-backrace(ptr1).
In tag-based KASAN, it gets wrong free-backtrace(ptr2). It will make
programmer misjudge, so they may not believe tag-based KASAN.
So We provide this patch, we hope tag-based KASAN bug report is the same
accurate with generic KASAN.

---
    ptr1 = kmalloc(size, GFP_KERNEL);
    ptr1_free(ptr1);

    ptr2 = kmalloc(size, GFP_KERNEL);
    ptr2_free(ptr2);

    ptr1[size] = 'x';  //corruption here


static noinline void ptr1_free(char* ptr)
{
    kfree(ptr);
}
static noinline void ptr2_free(char* ptr)
{
    kfree(ptr);
}
---


