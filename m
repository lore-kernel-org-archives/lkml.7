Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FFE2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfIDDlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 23:41:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12532 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727692AbfIDDlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:41:14 -0400
X-UUID: 307026c154a34123ae996d4f0cac5f5a-20190904
X-UUID: 307026c154a34123ae996d4f0cac5f5a-20190904
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1655979396; Wed, 04 Sep 2019 11:41:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Sep 2019 11:41:06 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Sep 2019 11:41:06 +0800
Message-ID: <1567568466.9011.34.camel@mtksdccf07>
Subject: Re: [PATCH v5] kasan: add memory corruption identification for
 software tag-based mode
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Konovalov <andreyknvl@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Alexander Potapenko" <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 4 Sep 2019 11:41:06 +0800
In-Reply-To: <CAAeHK+xO-gcep1DbuJKqZy4j=aQKukvvJZ=OQYivqCmwXB5dqA@mail.gmail.com>
References: <20190821180332.11450-1-aryabinin@virtuozzo.com>
         <CAAeHK+xO-gcep1DbuJKqZy4j=aQKukvvJZ=OQYivqCmwXB5dqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  const char *get_bug_type(struct kasan_access_info *info)
> >  {
> > +#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> > +       struct kasan_alloc_meta *alloc_meta;
> > +       struct kmem_cache *cache;
> > +       struct page *page;
> > +       const void *addr;
> > +       void *object;
> > +       u8 tag;
> > +       int i;
> > +
> > +       tag = get_tag(info->access_addr);
> > +       addr = reset_tag(info->access_addr);
> > +       page = kasan_addr_to_page(addr);
> > +       if (page && PageSlab(page)) {
> > +               cache = page->slab_cache;
> > +               object = nearest_obj(cache, page, (void *)addr);
> > +               alloc_meta = get_alloc_info(cache, object);
> > +
> > +               for (i = 0; i < KASAN_NR_FREE_STACKS; i++)
> > +                       if (alloc_meta->free_pointer_tag[i] == tag)
> > +                               return "use-after-free";
> > +               return "out-of-bounds";
> 
> I think we should keep the "invalid-access" bug type here if we failed
> to identify the bug as a "use-after-free" (and change the patch
> description accordingly).
> 
> Other than that:
> 
> Acked-by: Andrey Konovalov <andreyknvl@google.com>
> 
Thanks your suggestion.
If slab records is not found, it may be use-after-free or out-of-bounds.
Maybe We can think how to avoid the situation(check object range or
other?), if possible, I will send patch or adopt your suggestion
modification.

regards,
Walter

