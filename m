Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C063320665
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568826620;
	bh=O6wcp0Te0H6D8XPp3zg5eH1+coWjQ0Ga/IYcfKBcfk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ktnuvTBJHV/QwOp0NU8KUruZWYVfeMWWcpKtaatLQamVPmMtWWV86CSg7+xJyf6lH
	 11HpnULkHfbnmFaPHolQLGHMcUXByzSfYBGZyfyelsVr9RLVdDPBSi8FhORTR20hfl
	 gFvkHhIqX8tSOtjUHpUanE4PE8y/UIbHp3MbZi1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfIRRKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:10:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44125 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbfIRRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:10:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id q11so205879lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drcDcqj4KDDXGJKr6wejeR7kG1o047hONACm2WK24V0=;
        b=Xm+EKOIf7gY8Lht4lxteOIc8tLcVkeM5+f2m7l34dDTGKP1poNujvqM5z2/t3tLLqi
         r0Lt9a5hW8elneXXf+OUNcuOTJo2yJNwp7uNGGOS5d3XWKTaRRJy01+ugVTpoA2MJKm7
         u9UdC41LiWVuqBY1TJ9E6tEuZzGgycTPdiImE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drcDcqj4KDDXGJKr6wejeR7kG1o047hONACm2WK24V0=;
        b=jVEbe2ZdFlFTxi6RW9/Maq1sZl5BlZb0iI5vQ+tNEVDs2oSH75vNf6ZCIhq0zayc4/
         CCJceokexnc5KMbbaGt3lOOFo1bqo0KjR7JN9i9TvSxmGzlEIQ4aT5inI9WJ7HQGa1q6
         fpZSYJtLChQr0oOS/xfPzBO4lzBtXRKEbXhQ50bvbdmx7gNtwFg36xeC/5reNmJHJvzl
         K2HLs7zuoDH1cEOkmw0Wmfba24BOcw7qgy6QN51ArKhhlOucwkgajmAcBawUiOgioPEY
         PhKd2IRsTdq4osE3QLtayTe5HrjRYXhmEQIaGNt2Zcvjzpd+oWTSljeRSWLyJ5LZpDUL
         AKGg==
X-Gm-Message-State: APjAAAUYZUNucHGbivOaBP2hUCsLn1Uw2PsqmmD9xfq34Ja6ZIqbMoFt
        l0oIUW4ibzniWCTaNW0acA7daNbNal0=
X-Google-Smtp-Source: APXvYqxFSJDq17c2RaEEgEg/77KghrLXSJIVXK+3l/RCw7ox7KYXkz8w0gmSZH9f8l6M+s1SeKDGTg==
X-Received: by 2002:a19:2313:: with SMTP id j19mr2624851lfj.138.1568826617259;
        Wed, 18 Sep 2019 10:10:17 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f1sm1283127ljf.72.2019.09.18.10.10.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:10:14 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a22so740032ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:10:14 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr2923609ljj.72.1568826614107;
 Wed, 18 Sep 2019 10:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190916222133.9119-1-jacek.anaszewski@gmail.com>
 <CAHk-=wgxNj_RBpE0xRYnMQ9W6PtyLx+LS+pZ_BqG31vute1iAg@mail.gmail.com>
 <CAHk-=wjAVTCZ9-X6ETA7SASNhrOyJuCgn792E_Wmn+JaEQ8N0Q@mail.gmail.com>
 <CAHk-=wjm422bg+ZPuKkjU6NffbAyysY2n8iLRFyiNKin4cvWgg@mail.gmail.com>
 <CAHp75Vdn5_U3rCvuK1_P_nf5gEO63r342dgp_wk77diPU8k06Q@mail.gmail.com> <CAHk-=whg7WLb8mriT46iuMXCSj34FheRxGRPcifNsaLGuowiGw@mail.gmail.com>
In-Reply-To: <CAHk-=whg7WLb8mriT46iuMXCSj34FheRxGRPcifNsaLGuowiGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 10:09:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0J3Jn+gHJAitQ3cDzPi6Z4JQHdtf9ruW8g2NnFhGD-w@mail.gmail.com>
Message-ID: <CAHk-=wg0J3Jn+gHJAitQ3cDzPi6Z4JQHdtf9ruW8g2NnFhGD-w@mail.gmail.com>
Subject: Re: [GIT PULL] LED updates for 5.4-rc1
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        ada@thorsis.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Murphy <dmurphy@ti.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Joe Perches <joe@perches.com>, kw@linux.com,
        Linus Walleij <linus.walleij@linaro.org>,
        nishkadg.linux@gmail.com, nstoughton@logitech.com,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Lindgren <tony@atomide.com>, wenwen@cs.uga.edu,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 9:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think (hope) the fixup commit is in one of Greg's pull requests that
> are now pending in my queue.

Yup, confirmed.

I was planning to do them later today, but I'm doing them now to get
that regression out of the way.

              Linus
