Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E918BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDC82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfHLJO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:14:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46211 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfHLJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:14:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id j15so8517086qtl.13;
        Mon, 12 Aug 2019 02:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+QmBXKd4KiupJ4fDt80NErMgwwgr7EoZ3yCYi1lzc4=;
        b=QNDtVIrto0/8rdLE2mD0Tvfvur8CZunJa0DN/tflpzfZssXH+jMfD7s5Kvzg/KaVAS
         2vHpoi49nPlYD5xslAsE+EQ2Zwnaoq3iMKSIRTlznA4CwmFVStaAd95kz9kqAKdH4ZhG
         OAVhqrLNx/TemVcEtmcdvanSJY203XCgnViooaj3T/bFbb/fwyhJGxvfEf1u7N8YlkmV
         v5YmpH5eYNT4khkTKLcHaf5HnnHmV5YkoVwoOlNS+XZzkkNXqewtmIe+3fiZhHHA3ytD
         LaznqNSC9V+Ggpo8oeolqpoiWAO4G27BlOxbgmjX8WqnIU9mp6XHnmcFyEkaF3VUZKMj
         +g3Q==
X-Gm-Message-State: APjAAAUY0NmS54wogZO8JMjT47fw/GQOOSwEapb3OYd5KugblhabwqNO
        MBpO/ZySclsoVJM6hHrb+Eet1T4Nise0W+ly90E=
X-Google-Smtp-Source: APXvYqxo0LVujo776H9ip+YOmiuWCuWHH5PhAK7mGqEizCOd7M9TnAGpH7cMD/PULwUpm4ilmxGp5E/S1SSYR+gfTQU=
X-Received: by 2002:aed:3363:: with SMTP id u90mr29147026qtd.7.1565601264709;
 Mon, 12 Aug 2019 02:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190812171411.31ec6ae3@canb.auug.org.au>
In-Reply-To: <20190812171411.31ec6ae3@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Aug 2019 11:14:08 +0200
Message-ID: <CAK8P3a0eOyD2iTFeLC1J95WMAwyzBJJ0S5nOb+Z_y9nUy=8=qg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the slave-dma tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 9:14 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the slave-dma tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> WARNING: "omap_dma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL_GPL
> WARNING: "edma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL
>
> Introduced by commits
>
>   9c71b9eb3cb2 ("dmaengine: omap-dma: make omap_dma_filter_fn private")
>   d2bfe7b5d182 ("dmaengine: edma: make edma_filter_fn private")

The warning is valid, I will send a fix.

I have never seen this message though, I guess the build system just introduced
a check for this? I don't see where this would come from in next-20190809
(only checking with grep, not actually trying to build right now).

      Arnd
