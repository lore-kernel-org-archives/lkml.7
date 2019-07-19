Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E985BC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0442184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Rwncvw6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfGSGRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:17:40 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:46295 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSGRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:17:40 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x6J6HVk3001345;
        Fri, 19 Jul 2019 15:17:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x6J6HVk3001345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563517052;
        bh=g7qmkAKf0h2p9IMccBMgNG4vVKdb1vGskpThs6++c68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rwncvw6SKxcnF+Rw7yUCT5TaXA+Dz25LwEYyAOFxlBPxAJiU4f8PUZt2czqilarhs
         H4zMGJbJgqaR1IWMQ50/33ChG2ldxRcXwM522Pz2gcm/ckm6lsRQGSXVDskzwiBNRK
         58S2F2QfPFf4DTiAwMGGnRkv9x43VZAOj0iILgdxugIHTnBMgGEEYeHUslhSyGcbZb
         4vFsqd17Zu2bNdYBrG62t3ESDEGfEobZkf2dVfPCE3i8TpuDya0y08lmODRrnNzxK+
         yndyr0xDi4HSbPdVHhliE3Fpuzp0JE2wDR/jKVR/wF95f/Um1AFt1Y9ltReA4us41M
         JKynfZyk4N6MQ==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id c4so12137981uad.1;
        Thu, 18 Jul 2019 23:17:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXI3vdmJLuIIi6QBAGUCerrVzoXCeMmGhIP/JMbWTKHS71Cz09A
        Amm+Aiv1NeQKO8mnoNul0h2v6VbML8MG7yJg/m0=
X-Google-Smtp-Source: APXvYqw1D6JM+1iX22o6Iv04cbALlH+CNQAUirtBc/sCgNFuESiOwV57r4ZRC8j6K8hFDLt3vIOuHpumc3OnzIpdLBs=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr17743665uad.121.1563517051033;
 Thu, 18 Jul 2019 23:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190718125509.775525-1-arnd@arndb.de> <20190718125703.GA28332@lst.de>
 <CAK8P3a2k3ddUD-b+OskpDfAkm6KGAGAOBabkXk3Uek1dShTiUA@mail.gmail.com>
 <20190718130835.GA28520@lst.de> <20190718142525.GE7116@magnolia>
 <CAK7LNASN5d_ppx6wJSm+fcf9HiX9i6zX4fxiR5_WuF6QUOExXQ@mail.gmail.com> <20190719055855.GB29082@infradead.org>
In-Reply-To: <20190719055855.GB29082@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Jul 2019 15:16:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrPRKUCbTY9pSWrUTw=kshhE2CSz5jqXOuD7ziChdsGg@mail.gmail.com>
Message-ID: <CAK7LNAQrPRKUCbTY9pSWrUTw=kshhE2CSz5jqXOuD7ziChdsGg@mail.gmail.com>
Subject: Re: [PATCH] iomap: hide iomap_sector with CONFIG_BLOCK=n
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 2:59 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jul 19, 2019 at 11:19:15AM +0900, Masahiro Yamada wrote:
> > I started to think
> > compiling all headers is more painful than useful.
> >
> >
> > MW is closing, so I am thinking of disabling it for now
> > to take time to re-think.
>
> For now this seems like the best idea.  In the long run maybe we can
> limit the tests to certain configs, e.g.
>
>
> headers-$(CONFIG_IOMAP)         += iomap.h

I cannot find CONFIG_IOMAP.

Do you mean

header-test-$(CONFIG_BLOCK) += iomap.h

?


> in include/linux/Kbuild
>
> and base it off that?

Yes, I was thinking of that.

-- 
Best Regards
Masahiro Yamada
