Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F813C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9D12084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfHOIZU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:25:20 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:49674 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbfHOIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:25:20 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2019 04:25:19 EDT
IronPort-SDR: vdvsQ8Iv0WG7sz1QV0nN5aS3OM7d3QEtNR3/Z3o7LWwt0fRCWkXxJvuLgQazXnA73A5OFItmt5
 0ldGMSM4K/7zuozjL6rb32sSm1wthHTf+CdXH96Ik/Z414gGHBHjPvtuTvc0mMIjAfHT9PXFKV
 FOMkH4FZGGuw9IOSxIxt0VQtIiuigxuOPWHMX05C495/BHq7mxZDOZNqRMJoK83hEWZfkNNGqG
 waPaSPHQ0/vwcI6LV/WQ88HociRQs0YSaPmIOjJTy5dUyJGcybIkON8qMTaZsnWVXEgzXCy4Gm
 Oto=
X-IronPort-AV: E=Sophos;i="5.64,388,1559548800"; 
   d="scan'208";a="40453435"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 15 Aug 2019 00:18:12 -0800
IronPort-SDR: htcRjcmG9l9zGnWMZ+4soCAXhpE2Zibe/ltCHmq+74d1fR0FdNoga33DgrUAk0Uq+YQ9Hi4Wyn
 sgJtbzWgBUbD6zg+QDNAkgOdd2PjrstZROoBjDV/wQ4r1IijKrpyGUh9i8NvPweyTNqcnKg3qp
 Z0Pr1LfQIF4tJhZqOCb7dQTusDqUheV2JBIuFyb5x2lQtrNjRwVkQKoFBGUWIRmRGbCfcRgnNv
 HLFrD1pLTEWB9k9qWw6B0+nCbVJW3c4lerAipRd5wYa07jIqv5/2R5f5O/dI8t7RqhofTcicvI
 WlM=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: AW: [PATCH v2] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Topic: [PATCH v2] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Index: AQHVUq5kcb5Ex7JpNUSktSjVjdFue6b6xMYAgAEUHnA=
Date:   Thu, 15 Aug 2019 08:18:06 +0000
Message-ID: <c925c7d1041f478c99863da56c24b8a7@SVR-IES-MBX-03.mgc.mentorg.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>
 <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
 <1565794104204.54092@mentor.com> <20190814162932.alwo7g4664c2dtp3@master>
In-Reply-To: <20190814162932.alwo7g4664c2dtp3@master>
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

>>When a resource is freed and has children, the childrens are
> 
> s/childrens/children/
>
oh, missed that. Too many children ... ;-)
 
>>+		__release_child_resources(tmp, warn);
> 
> This function will release all the children.
> 
> Is this what Linus suggest?
> 
> From his code snippet, I just see siblings parent is set to NULL. I may miss
> some point?
>
At the point we are here, there should be no children, and children of
children at all ...
So they are all more or less lost in the wild.
That was why i didn't copy Linus' code 1:1 but reused an already existing
function doing similar thing.
It's anyway worth of thinking about this.

What i have in mind here (example):
Parent: iomem map 0x1000..0x1FFF
  Child1: iomem map 0x1000..0x17FF
    Child11: iomem map 0x1000..0x13FF
    Child12: iomem map 0x1400..0x17FF
  Child2: iomem map 0x1800..0x1FFF
    Child21: iomem map 0x1800..0x1BFF
    Child22: iomem map 0x1C00..0x1FFF

When releasing the parent, how can children 11, 12, 21 and 22 still be valid?
They don't know about their grandfather died ...
Looking at the __release_child_resources, i exactly found that all children are
invalidated/released in the way Linus did for the parent's children list.
Doesn't it make sense to do the same for all?

Please comment.

> >+static void check_children(struct resource *parent)
> >+{
> >+	if (parent->child) {
> >+		/* warn and release all children */
> >+		WARN_ONCE(1, "%s: %s has child %s, release all children\n",
> >+				__func__, parent->name, parent->child-
> >name);
> >+		write_lock(&resource_lock);
> 
> In previous version, lock is grasped before parent->child is checked.
> 
> Not sure why you change the order?
> 
To hold the lock as short as possible.
But yes, you are right, this could lead to problems if releasing of the
children is done in a parallel thread on a multicore ...
I'll change that to cover the whole resource access within the lock.
Not a big thing ...

Best regards
Carsten
