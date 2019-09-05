Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8392C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F39A2168B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfIEByp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:54:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:26599 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727156AbfIEByp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:54:45 -0400
X-UUID: e1c814d6fac6479dbb5a3b406a2fee58-20190905
X-UUID: e1c814d6fac6479dbb5a3b406a2fee58-20190905
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1846864118; Thu, 05 Sep 2019 09:54:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Sep 2019 09:54:34 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 09:54:34 +0800
Message-ID: <1567648476.32522.36.camel@mtksdccf07>
Subject: Re: [PATCH 1/2] mm/kasan: dump alloc/free stack for page allocator
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>
Date:   Thu, 5 Sep 2019 09:54:36 +0800
In-Reply-To: <1567607824.5576.77.camel@lca.pw>
References: <20190904065133.20268-1-walter-zh.wu@mediatek.com>
         <CAAeHK+wyvLF8=DdEczHLzNXuP+oC0CEhoPmp_LHSKVNyAiRGLQ@mail.gmail.com>
         <1567606591.32522.21.camel@mtksdccf07> <1567607824.5576.77.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 10:37 -0400, Qian Cai wrote:
> On Wed, 2019-09-04 at 22:16 +0800, Walter Wu wrote:
> > On Wed, 2019-09-04 at 15:44 +0200, Andrey Konovalov wrote:
> > > On Wed, Sep 4, 2019 at 8:51 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > +config KASAN_DUMP_PAGE
> > > > +       bool "Dump the page last stack information"
> > > > +       depends on KASAN && PAGE_OWNER
> > > > +       help
> > > > +         By default, KASAN doesn't record alloc/free stack for page
> > > > allocator.
> > > > +         It is difficult to fix up page use-after-free issue.
> > > > +         This feature depends on page owner to record the last stack of
> > > > page.
> > > > +         It is very helpful for solving the page use-after-free or out-
> > > > of-bound.
> > > 
> > > I'm not sure if we need a separate config for this. Is there any
> > > reason to not have this enabled by default?
> > 
> > PAGE_OWNER need some memory usage, it is not allowed to enable by
> > default in low RAM device. so I create new feature option and the person
> > who wants to use it to enable it.
> 
> Or you can try to look into reducing the memory footprint of PAGE_OWNER to fit
> your needs. It does not always need to be that way.

Thanks your suggestion. We can try to think what can be slimmed.

Thanks.
Walter

