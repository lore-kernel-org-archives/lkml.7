Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E59CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BD521655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J7JzzEq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409728AbfJXPlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:41:50 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:51443 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409615AbfJXPlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:41:49 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x9OFfT9D030417;
        Fri, 25 Oct 2019 00:41:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x9OFfT9D030417
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571931690;
        bh=l4I3j33otfIQZSfw7zL4nNKREYId00X6FYw//AMabaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J7JzzEq9jjLw/A4o0vktjGoZM/o7nOPyZ8FJ0n8aolcVy3rE56fx7QD8thRLNPdul
         mnDh+esLCS0XIygkfjxyVUEmrfI67Ks/JVCIIjjR9J9dhTRAAIdAWj7a0m5mWJ255Y
         W76ZVDt21NQ5YpFO9usnpk7YY/YERETFjeDQ8DWSpGQbROFdWil1E1vKtBCrh+JLQU
         E4GkkVdSdsoaCkWHzMWamdBpvGD2t65EVEaeiJdH+oRM/Zf7rgSUAgE9ZzpniLbdn3
         Aby5i/iYIdpGmZEbLsmF0l5JBAGizqtLGrTlzsgvNSsWaOatg/Kmb0a24xTyXnDE1a
         Cox9VvptnGKUg==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id 70so5405055vkz.8;
        Thu, 24 Oct 2019 08:41:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXNjydu3jidSu95JZarNCINHp/QuAJm2bx+Q3zTqU7VmPi3Wt8l
        wWw+Ru0gS3qo1gUa2PpZ+hlkltsK1hY3CeAfhjk=
X-Google-Smtp-Source: APXvYqzECnMU+WoRoqmpGp2qCaUvuGA+5Jc8kg37Z+KgqZpCHvCQICZwcWI/5OzGByPm5gI//L5m5unfHNDIvbYQnaM=
X-Received: by 2002:a1f:a349:: with SMTP id m70mr9104948vke.26.1571931688982;
 Thu, 24 Oct 2019 08:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr> <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de>
 <868spgzcti.wl-maz@kernel.org> <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
In-Reply-To: <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 25 Oct 2019 00:40:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
Message-ID: <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
Subject: Re: coccinelle: api/devm_platform_ioremap_resource: remove useless script
To:     Joe Perches <joe@perches.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 7:13 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2019-10-19 at 21:43 +0100, Marc Zyngier wrote:
> > Providing Coccinelle scripts that scream about perfectly valid code is
> > pointless, and the result is actively harmful.
>
> Doubtful.
>
> If the new code is smaller object code and correct
> than the conversion is worthwhile.

I agree.

We use multi-platform defconfig.
I always appreciate the code refactoring
that reduces the object size.



> fyi:
>
> There are already ~450 uses of this function and maybe
> ~800 possible additional conversions.
>
> > If said script was providing a correct semantic patch instead of being
> > an incentive for people to churn untested patches that span the whole
> > tree, that'd be a different story.
>
> Right.
>
>


Alexandre Belloni used
https://lore.kernel.org/lkml/9bbcce19c777583815c92ce3c2ff2586@www.loen.fr/
as a reference, but this is not the output from coccicheck.
The patch author just created a wrong patch by hand.

The deleted semantic patch supports MODE=patch,
which creates a correct patch, and is useful.


-- 
Best Regards
Masahiro Yamada
