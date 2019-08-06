Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6938A2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565075489;
	bh=J4N5lnXWpDXT9JqaahBuM8YWglXlyfMSplL895YamMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZOsJSyQvNwBXNmuUTxHgOcR7XNInuWGEnWtnQTD5dwRgFCRUrbVLnPd4zHLPgQg/5
	 kw7OIEOm2GdHuv1nq7gVAuTpMFmbibmG8DT/IlDL72a3o8y15UVcGrlbZBQFeuwA5y
	 mkZsrJIOziY6Mlon3siSPjylkoZslq5kgrHjk3zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbfHFHL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbfHFHL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:11:28 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10163216F4;
        Tue,  6 Aug 2019 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565075487;
        bh=J4N5lnXWpDXT9JqaahBuM8YWglXlyfMSplL895YamMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gWdwarr/4ZOEaXlXOoVNLfcon5HZrxtHVoWJYjSuYymEIpNxWL2YzeaGQzOUbAsP0
         Rsp+PDlJqUzmi4ceSJ/Esdyz4risX3PqrfV+DzYznsB1h4APax4H41nKefPZMXTCU8
         q9R5xFdubDJ0vw4FWL/OhAqgjxtGjGJxcEAs7TiY=
Received: by mail-wr1-f54.google.com with SMTP id x4so33567567wrt.6;
        Tue, 06 Aug 2019 00:11:26 -0700 (PDT)
X-Gm-Message-State: APjAAAWtV6mwiHdu5pxKauB6wAht07qE5yTPQlMe+be+8Mc8OkciKFhm
        +9m1bvgt/InasqPKgRjiqp0b4b9vHD0If1ZOC5Y=
X-Google-Smtp-Source: APXvYqwWdFrBgnlrPvQM+PFNKRmvVdIqQwvU9zvSBwF4qHNlCpk8f5KcSnWsmpuAORokS4MOJFLQhAc4k0uQgRWy98Y=
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr2715775wrp.38.1565075485547;
 Tue, 06 Aug 2019 00:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-3-git-send-email-guoren@kernel.org> <20190806064933.GA2508@infradead.org>
In-Reply-To: <20190806064933.GA2508@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Aug 2019 15:11:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR1vCz504X20rBnQkAXGhJ-QbL4pORxnJTRVJqXx2t4uQ@mail.gmail.com>
Message-ID: <CAJF2gTR1vCz504X20rBnQkAXGhJ-QbL4pORxnJTRVJqXx2t4uQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] csky/dma: Fixup cache_op failed when cross memory ZONEs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 2:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jul 30, 2019 at 08:15:44PM +0800, guoren@kernel.org wrote:
> > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > index 80783bb..3f1ff9d 100644
> > --- a/arch/csky/mm/dma-mapping.c
> > +++ b/arch/csky/mm/dma-mapping.c
> > @@ -18,71 +18,52 @@ static int __init atomic_pool_init(void)
> >  {
> >       return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> >  }
> > -postcore_initcall(atomic_pool_init);
>
> Please keep the postcore_initcall next to the function it calls.
Ok. Change arch_initcall back to postcore_initcall. :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
