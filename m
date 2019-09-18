Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2323C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45C021848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568825659;
	bh=tpAlTzvpZ/90Mi6REw190HsgXG1VRy+RT6l9swKF6Ok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CCskKkS6P93lNevGVzDuLE3ZHDJVY+3mgtpfeegNKueeTS9UkS3s8o3G4GW9LpW67
	 acer+oXx+9PZCgPe4/8+/htlLNyuEyqaLbf9uEhE0LpSHqYftsSkANx/NdqfSFyWjn
	 ALfP7nbKt+xm2AMNgBi3dCDeziSO2LQCLPLZ800o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbfIRQyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:54:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42939 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbfIRQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:54:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so180427lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VwfblmZ+e4fyFQouNlegNYvYNoRSmskQXhNh9EkLBA=;
        b=hTbF/x1sm3Jzq49oZHqZoPNaFRwFunpf+5C65yxk9Rufw+9lbUdhUCNI9WxNFqYDhI
         rEB8phARLo8Z30aVvWYY34efW+2WUH/E6AMzHD5MXBWOPqrWzUnOCMyObhZnc3yIs0ku
         858p8fUsW9juBx8tfEpR6YaCHicSskxD1u2Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VwfblmZ+e4fyFQouNlegNYvYNoRSmskQXhNh9EkLBA=;
        b=a64TALkyD4K8j7Q0zyocbqqR1Y7yV3OyKe1oEVjbUn9KAGMbX/jYc9uZUl/zJDXpSI
         oLDAE/68G+PZXSfpiZYWmAlY83RhFb9cYnlBN3Pcq/IvGN4Wl1nOTp8lD0OW9mrXuR5F
         Pu8+nBhE8U26cbwKjcnWLo9yrKxADwPv3z9JVNVyTTXR+4W+q4s+OJqpxMThpjJxoEKP
         1lBqmFUbGogrtEl2tmc8P1+mBiCyDSux2oXB0IiayFm3qjOhdwkQLrooaFo3S2re7VYi
         iAt/nz4Z+bI/HUrIHJWwL0FsU8F/GkBRf2tcSx9Z14b7N/4DAD9UyHb2et9grGuEQDQq
         gGJw==
X-Gm-Message-State: APjAAAWKbYyiZ2OJ387ntt6C7l+Vl3UVL0rYqDAWy+8Jde+OJgrNADuC
        HBzgNmLcUQgMtN0DTAx3s02lIBIPt4A=
X-Google-Smtp-Source: APXvYqy6jFcoXA0unvUBTXQPH5xT8k5mViKe+iRgMqeav/HqYud70PuvoTZxreSwuMCX7enpfFN0kw==
X-Received: by 2002:a05:6512:4dd:: with SMTP id w29mr2631832lfq.2.1568825656153;
        Wed, 18 Sep 2019 09:54:16 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w30sm1081671lfn.82.2019.09.18.09.54.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:54:15 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id t8so160828lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:54:14 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr2656966lfp.134.1568825654331;
 Wed, 18 Sep 2019 09:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190916222133.9119-1-jacek.anaszewski@gmail.com>
 <CAHk-=wgxNj_RBpE0xRYnMQ9W6PtyLx+LS+pZ_BqG31vute1iAg@mail.gmail.com>
 <CAHk-=wjAVTCZ9-X6ETA7SASNhrOyJuCgn792E_Wmn+JaEQ8N0Q@mail.gmail.com>
 <CAHk-=wjm422bg+ZPuKkjU6NffbAyysY2n8iLRFyiNKin4cvWgg@mail.gmail.com> <CAHp75Vdn5_U3rCvuK1_P_nf5gEO63r342dgp_wk77diPU8k06Q@mail.gmail.com>
In-Reply-To: <CAHp75Vdn5_U3rCvuK1_P_nf5gEO63r342dgp_wk77diPU8k06Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 09:53:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whg7WLb8mriT46iuMXCSj34FheRxGRPcifNsaLGuowiGw@mail.gmail.com>
Message-ID: <CAHk-=whg7WLb8mriT46iuMXCSj34FheRxGRPcifNsaLGuowiGw@mail.gmail.com>
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
        nishkadg.linux@gmail.com, nstoughton@logitech.com, oleg@kaa.org.ua,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Lindgren <tony@atomide.com>, wenwen@cs.uga.edu,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 12:30 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> I hope you have a chance to read my previous email.
> We still need that function.

Your email came in after I did the merge with the fixup, so the kernel
now has the broken code (but without the warning).

I think (hope) the fixup commit is in one of Greg's pull requests that
are now pending in my queue.

              Linus
