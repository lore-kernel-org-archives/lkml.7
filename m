Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6750C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD2721739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574967721;
	bh=Gh5Fit5zM2KRuKwsnEnkMfIt8gIXsZkzjUVJHGHbn38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MfregpwprxCJ4dVJ6P7Coi8yd2pLjfLsQ7n0zpadIeV3vik+NAxXq6/dN953O05ee
	 Ztc3TcKl2XJacMR06AsNmbjUichz6egvuaQTxcUc9W2tGaPk3kXiTq7J3L1INmDGwH
	 SOSpnaqGgTE1LuXWAaZ/rjJ62cXMi2CqmwCODfMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfK1TCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:02:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35172 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1TCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:02:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so20475896lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kms9D4Zy2ihiCy7HMi5BOaZjm7P5PFIIQbQR9jGbStk=;
        b=b5g5gSwguERR/Nzen1eoEVefV7DQz4Lx1FYfgDbApKGYFioIssfoXka7xt7f8cMGpx
         zbgrhxRAEeH/y7eqEcigSJYRkrQYH1zj8Y5N1Co6NZqY0n/bEF12spFmD2GYEp4LQsnK
         urSMJtjl5ImIPkpHpxPAqBgA4Z4umOZAT9ikU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kms9D4Zy2ihiCy7HMi5BOaZjm7P5PFIIQbQR9jGbStk=;
        b=CnW1PeeRZAkewVQUI95jGmzj/EOppgs8K5xPnECnoSpwrKDnWtS8cOT5MFy2tVDjo/
         /oLH/gLnDvtC0RLELvS9VDh9mFKqkWSw+HTZxFRbwTwGne6hBslYx38wG6LgF2dGfL7i
         p9YkZuI04+tHhgTHHq6LMjTHKrqESVXnScn6j+Exsw+PrFPQ433BIPO03yQXTLBCCjA9
         4pMsTJgQ8LP/NSQjTym0dxEKDNKS55/4pnFWa6oy0KbNf+JcOZHrg9yyelev9IZDGYLd
         YW6rD1Vg+kUZGFNDAJHYrhrAhv/MZgj3D4fSmhIacMMZSNcs+VQ8YwzJjDQB7tMxolZ+
         JDyQ==
X-Gm-Message-State: APjAAAUpAuBfKtWlJKeMcKPfjYQJDhJ5w2//qgknrhISKQgDxYsMNnjH
        Yc91Xc+Yffjg0coUi9gx6JsKBmXCx84=
X-Google-Smtp-Source: APXvYqzhaXnnESk5XmraP1QGOLW+umRMJ4+AHlVAPd7cJ7xw1hBcJnqSZHQqxMKIcl+1/BptF4MKcg==
X-Received: by 2002:a2e:80d9:: with SMTP id r25mr9779965ljg.8.1574967715727;
        Thu, 28 Nov 2019 11:01:55 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e20sm1962996ljk.44.2019.11.28.11.01.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:01:54 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id j6so20475799lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:01:54 -0800 (PST)
X-Received: by 2002:a2e:b4c7:: with SMTP id r7mr3273388ljm.82.1574967714127;
 Thu, 28 Nov 2019 11:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20191125192758.GA13913@infradead.org>
In-Reply-To: <20191125192758.GA13913@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Nov 2019 11:01:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpKDQze+kcCw5e-TK2J4T9-qACQ_o7XAtTO+dD+FJOsw@mail.gmail.com>
Message-ID: <CAHk-=whpKDQze+kcCw5e-TK2J4T9-qACQ_o7XAtTO+dD+FJOsw@mail.gmail.com>
Subject: Re: [GIT PULL] generic ioremap for 5.5
To:     Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Added PaulW ]

On Mon, Nov 25, 2019 at 11:28 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> There are two conflicts with the riscv tree - one is a trivial makefile
> context one with the nommu support, and the other is the split of the
> riscv <asm/io.h> which means that the removals in this pull request need
> to be applied to the new location that they were moved to in the riscv
> tree.

The conflict was trivial to fix up, but since I don't do RISC-V
cross-builds, I'd like PaulW to please check that there weren't any
surprising semantic issues too - or that I didn't mess up.

Paul? (It's not actually pushed out yet, it's still building, but the
ioremap merge should be there in a moment)

              Linus
