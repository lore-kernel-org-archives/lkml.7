Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84898C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5496921738
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1+TwBCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCHSAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:00:37 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:43326 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCHSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:00:37 -0500
Received: by mail-pg1-f176.google.com with SMTP id l11so14718837pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHhtUTI6moSeHGZCkBti5CLe7rnmKv/kwsTsmsDCZRc=;
        b=b1+TwBCJTDwqZoE4E5JSmTrY3MNDpF92CAcltHxqewomrKpcqkXe7ldtKToKlABYfW
         //ujn/QjtyM/rxfux5eznYF8uXQ7Vbx0u9ucdjyLqQEy8nar4rvHLcIzKI7Z4KIOjouZ
         V6W6J01/zXTiW8QNHn7rjiKtfY3uhBHAKN4zDlU2cIOokIDKLct62JuO8SnxlgedR7Og
         z57rzoMUIaCuKvyhnWYdpcG6RLprwFHOr2O+4aNKOGRzrm71Kax4B/qf6bK8JO02GTL/
         uFZ9QEJ09KQdge2Swq4WezS/z2nn8IyPsy+b4bH40veN4L0vi1wBWAjKwQjWKlUUvH8E
         50Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHhtUTI6moSeHGZCkBti5CLe7rnmKv/kwsTsmsDCZRc=;
        b=FrYNw064QQoaKw2I/f4ZfUtMUFpY3gywMuly7V/pfLRNmDNwenMZJNwL4gpKlxk+XF
         wO8tsIieDIjkKxE7W2oZLWhA6I5nhxIJ4wk4EQxh0eQpsZjj+PZGl5XMxjJp9IzIZ2S7
         WxXN4t0Lmq13rU6v/10bi7RdhyxMnD9oEbBUaHcu/NRa6kHzlIwtipHOyDT5fNDvUSB3
         UPboKCXljRmlPb3JKTQjVbDmJEGrJXKhla4a/let7wxmS6ukB18pgXalzNeB+8DGujXH
         7imHl0h0JgFaVXJIghll8T+Zla2tiY2bHRxJ+DYrikeE33yvkL18x9v0ruAJn5xpUR1h
         H0EA==
X-Gm-Message-State: APjAAAUZdvSbHi8BztelGDp5NxARmJbGRdXxjE5YBTOg37/jtFovJC2K
        a2b7KnwXJ56P+IFb1qRx0zatOGuEtxb+RStKIPz+Sg==
X-Google-Smtp-Source: APXvYqzakjXo9uTV4i+Rs0mbn8CXETRhpmBmk6pMybokPWRPTNi80sYVqVaZDGnLtT1fvo/1ZZJxaM9B8soWKcEQ6vA=
X-Received: by 2002:a63:fe58:: with SMTP id x24mr17911187pgj.255.1552068036193;
 Fri, 08 Mar 2019 10:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20190307104900.2506657-1-arnd@arndb.de> <20190308152732.GA20294@lst.de>
In-Reply-To: <20190308152732.GA20294@lst.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 10:00:24 -0800
Message-ID: <CAKwvOdnvY2DbFv8-NHWF=MabKQwi80F3E+jZJYudJxJK8tELYA@mail.gmail.com>
Subject: Re: [PATCH] [v3] dma-mapping: work around clang bug
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 7:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> NAK on this whole patch.  Please fix the compiler instead of making
> a complete mess of a common macro.

Definitely on the TODO list; higher priority, but not highest right
now.  I'll see if I can get some help with it.
-- 
Thanks,
~Nick Desaulniers
