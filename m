Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDEBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C3921907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568832692;
	bh=oeWp7lfCoWw0oE4iU13dYp3evtRJSsa0sa7A0SpAIxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tpW/crHTXQT4/+De5FcSFxkA3Ueg0MZLOF0lTU9KPM2/+POmSfrkHRbLkUaYu3G35
	 nnMEQGjiz5hBwoFvNPcQqmODiAtB+csSD4iGZtu+bFZ9SK0OIUBjdUS72HtzTxlhwd
	 8zl7dbAoCztUKjv4lh4lRyadXcBAHRSD0bOrjD0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbfIRSvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387695AbfIRSvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:51:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6601208C0;
        Wed, 18 Sep 2019 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568832689;
        bh=oeWp7lfCoWw0oE4iU13dYp3evtRJSsa0sa7A0SpAIxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ldb5I/ZR15Cm2Z+R2i5JRA/uzkfQcWgsGCln3N7TzEPY2ldSJsjQXdTV9e9SCTn6Q
         gsVbFuqzb41SOOvClgCbRKb9qv7SCUgNUoMVWMQvWy67nkAK2xuI687/KLBHiEbTRi
         4TghrvJZVJzJRCjUlcAFDb2KZSXeEBX63Yv6NOiQ=
Date:   Wed, 18 Sep 2019 20:51:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
Subject: Re: [GIT PULL] LED updates for 5.4-rc1
Message-ID: <20190918185127.GB1933777@kroah.com>
References: <20190916222133.9119-1-jacek.anaszewski@gmail.com>
 <CAHk-=wgxNj_RBpE0xRYnMQ9W6PtyLx+LS+pZ_BqG31vute1iAg@mail.gmail.com>
 <CAHk-=wjAVTCZ9-X6ETA7SASNhrOyJuCgn792E_Wmn+JaEQ8N0Q@mail.gmail.com>
 <CAHk-=wjm422bg+ZPuKkjU6NffbAyysY2n8iLRFyiNKin4cvWgg@mail.gmail.com>
 <CAHp75Vdn5_U3rCvuK1_P_nf5gEO63r342dgp_wk77diPU8k06Q@mail.gmail.com>
 <CAHk-=whg7WLb8mriT46iuMXCSj34FheRxGRPcifNsaLGuowiGw@mail.gmail.com>
 <CAHk-=wg0J3Jn+gHJAitQ3cDzPi6Z4JQHdtf9ruW8g2NnFhGD-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0J3Jn+gHJAitQ3cDzPi6Z4JQHdtf9ruW8g2NnFhGD-w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:09:57AM -0700, Linus Torvalds wrote:
> On Wed, Sep 18, 2019 at 9:53 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think (hope) the fixup commit is in one of Greg's pull requests that
> > are now pending in my queue.
> 
> Yup, confirmed.

Good, glad the fixup is now handled properly.

thanks!

greg k-h
