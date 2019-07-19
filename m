Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D235C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4389521852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ICnJ3RNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfGSMsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:48:38 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38632 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfGSMsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:48:38 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x6JCmW6I009843
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 21:48:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x6JCmW6I009843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563540513;
        bh=0qpHUtufjLE2Zht/Y2B4RKQAO0L/g1Zo9WaeV3lBtFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ICnJ3RNFfFPrNodbEkbdMDdGTp5jW/r9qV7mMEHuFzPhMkQ+G5OeemKkxXgj/0wxq
         5fJ+H4kucUOwxTKhTptH3mV9n/UmaPYlX/Xd6KbrVBCNWLfTNXbdvw/P4nM89LCJ5q
         ENmy/FBfkIuzKjfnwCmx8I+Ck764qnnE+N7OvRfYJg9xwKrRirrZKlQ7v8ZPtPT4Qt
         To8f3h2+z1QIDxJnNpRzCIbr1/KaQyUnxjJOZq9etoVduw5vXeEMmtoSl+J22iIZ4A
         PIhOt8jrl3XK+OQn6yzOEgWkDoOMCD+AHqwr+ppeObwxOm7FD8c8gcBgw4OIs8CRbU
         8krrWl39qgDkw==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id z13so12514705uaa.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 05:48:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXLsNSjYbGN3hxoV2eKS5m90QkY61e9+XnmkfZJddVhuxZq8nRF
        S4NV6jjpS3jMHjx11ctMDagO7gnh8a+4ubsog6s=
X-Google-Smtp-Source: APXvYqxOyWum8d8aY9+9Dr7DtLlXKz2YSlhp6ZMGjkRPpk6HL2DkyJda99rECBEPf7yVSnsipgh62d6QeUv24pwtGI8=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr33134716uag.40.1563540511666;
 Fri, 19 Jul 2019 05:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190719113139.4005262-1-arnd@arndb.de>
In-Reply-To: <20190719113139.4005262-1-arnd@arndb.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Jul 2019 21:47:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS49O=v8tJe+NauzsexVeg5hWNzFMFuWbCJbqc_qRv3dw@mail.gmail.com>
Message-ID: <CAK7LNAS49O=v8tJe+NauzsexVeg5hWNzFMFuWbCJbqc_qRv3dw@mail.gmail.com>
Subject: Re: [PATCH] [v2] blkdev: always export SECTOR_SHIFT
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Jul 19, 2019 at 8:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_BLOCK is disabled, SECTOR_SHIFT is unknown, and this leads
> to a failure in the testing infrastructure added from commit c93a0368aaa2
> ("kbuild: do not create wrappers for header-test-y"):

I think this should be

commit 43c78d88036e ("kbuild: compile-test kernel headers to ensure
they are self-contained")

Thanks.


>
> In file included from <built-in>:3:
> include/linux/iomap.h:76:48: error: use of undeclared identifier 'SECTOR_SHIFT'
>         return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>
> If we want to keep build testing all headers, the macro needs to
> either be defined, or not used. Move it out of the #ifdef
> section to ensure it is visible.
>
> Fixes: db074436f421 ("iomap: move the direct IO code into a separate file")
> Link: https://lore.kernel.org/lkml/20190718125509.775525-1-arnd@arndb.de/T/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The discussion about the build testing is still going on, but I promised
> to send this version anyway for reference. I see no other header-test
> failures in randconfig builds with this patch.
> ---



-- 
Best Regards
Masahiro Yamada
