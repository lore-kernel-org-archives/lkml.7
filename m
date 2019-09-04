Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ACBC41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EB922DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hiesufd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfIDOhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:37:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38079 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIDOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:37:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id b2so21132113qtq.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0VTPW60ciEzDbSTuQuRbRvDT6v3yNxk5P0Eu/d/VEY=;
        b=hiesufd9dof37ty41zVV23FsDbb6EdAGKoci12L+sx2fwRtB7zuTMNJNGKxb5jCwz9
         DHzP8baEkLMKZv0R+vOxPlQHHayCkkRabTRxE9tGv8GBrtCggPbrv9ZneGvLVdciye0W
         oKJ2yS/yMcGJtYnDMEcxkcx3yEjhGETyZ9MZu7+djjYmUlzMqVrfPpacFQSd9195K0Yk
         mzKwBohACfM1r3cNGvit0KpTACzAZaRlCp8vck6+4Czvy9UzZGxwoDAUW1UE9QTSacTp
         1v9NfrdGanfNnPILfIvtEzagXy8O4LjEy7mQ3Bfk9PNhEOIwk3xsV5QiVUDi0i3zAIKi
         FSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0VTPW60ciEzDbSTuQuRbRvDT6v3yNxk5P0Eu/d/VEY=;
        b=TGp/qBUJcaxd2R1n5gSKRytSiKS+ijziWc+HzaGxcnz09/pD6moOsUeTd0FNVxng7q
         BDonWstGVIULR/qO6jspXs7A7vbt9udkUtUKeZoLobEgqgq/YP6Bs3rDemc10lNF47Lp
         U0UarAu3dvQMhJw2K0FWH5VmagYZXMvHpU5InO9G0NYFnU5uZbrASjVDzCtVUVBgf6AM
         /0m6ZYwctb174lpj9Reh0ocZjHFLbA6AgLn1ub4zJBvI5xF080+21696hm7nJqYYBkXV
         JR8CoyWbCyL7dV61kRe+nXKFDADwTiuU2M3I8YIrEsgC8XusgbvAnJXDwnPdrb/P/MTF
         3lUw==
X-Gm-Message-State: APjAAAVg17RsXj0AuSHccyn17zh0hKPJgscQt4CTiGRP5kn5KAlLKDCr
        onWoU1jXIAOGMn1PmYujouaEsw==
X-Google-Smtp-Source: APXvYqydJPB93Rq3tw9fCKkC0CyDiSk4cXDU16sZXbMdZsRfW6glWdDAFI3nQyAxZg890Jq23AVzJQ==
X-Received: by 2002:a0c:c15d:: with SMTP id i29mr18468496qvh.5.1567607826937;
        Wed, 04 Sep 2019 07:37:06 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x5sm4919859qkn.102.2019.09.04.07.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 07:37:06 -0700 (PDT)
Message-ID: <1567607824.5576.77.camel@lca.pw>
Subject: Re: [PATCH 1/2] mm/kasan: dump alloc/free stack for page allocator
From:   Qian Cai <cai@lca.pw>
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Date:   Wed, 04 Sep 2019 10:37:04 -0400
In-Reply-To: <1567606591.32522.21.camel@mtksdccf07>
References: <20190904065133.20268-1-walter-zh.wu@mediatek.com>
         <CAAeHK+wyvLF8=DdEczHLzNXuP+oC0CEhoPmp_LHSKVNyAiRGLQ@mail.gmail.com>
         <1567606591.32522.21.camel@mtksdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 22:16 +0800, Walter Wu wrote:
> On Wed, 2019-09-04 at 15:44 +0200, Andrey Konovalov wrote:
> > On Wed, Sep 4, 2019 at 8:51 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > +config KASAN_DUMP_PAGE
> > > +       bool "Dump the page last stack information"
> > > +       depends on KASAN && PAGE_OWNER
> > > +       help
> > > +         By default, KASAN doesn't record alloc/free stack for page
> > > allocator.
> > > +         It is difficult to fix up page use-after-free issue.
> > > +         This feature depends on page owner to record the last stack of
> > > page.
> > > +         It is very helpful for solving the page use-after-free or out-
> > > of-bound.
> > 
> > I'm not sure if we need a separate config for this. Is there any
> > reason to not have this enabled by default?
> 
> PAGE_OWNER need some memory usage, it is not allowed to enable by
> default in low RAM device. so I create new feature option and the person
> who wants to use it to enable it.

Or you can try to look into reducing the memory footprint of PAGE_OWNER to fit
your needs. It does not always need to be that way.
