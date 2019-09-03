Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25F9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF3421883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX6nK37a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfICRn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:43:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44065 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfICRn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:43:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id l79so6089977ywe.11;
        Tue, 03 Sep 2019 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkzCzWZdwY9YRvyCQrLHOqur3MwEa+eAUkba8HeCg3A=;
        b=DX6nK37anfy/XDoDwQV473k4kV5nrc/zEfy2AWff3qCzONv3MqxXpmYv16UQZHMWXo
         zm5cyKD9Ttiqd4mlAZNScpruWhWEpvb0NJizqgnupGhuQm2BUYup+6vMtzr/k2ZgchYR
         xnw/9xf+dkJqIk9S+jN3yQu2k79p/FclB2aGys/rRPS+Um1r46dJWQsOw0J9LTR5tXND
         BlJXcZD4QxJR3jWuZIP74ZJGkU0GLUfGztD2TtpQgdMEPCKLfRBfRdYKsk46O6Cav1lE
         yKy3AnT0YhUqnAUZ9v2Xc49l9ZD8YFkn5dgDIQY1jmz78aWRDu6bZGQQ8ZLSG+2VVcx4
         SDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkzCzWZdwY9YRvyCQrLHOqur3MwEa+eAUkba8HeCg3A=;
        b=WD2UqBVmunquGgIDyoTgfd4eIoq0UZgUzZBbsCG0jN/5zDBKm+iMN+BSC9yywHypKj
         co88esEvohh+zvl9kPgpWeMsBnDN5jBboc+tB49/INsU0xxze4jZ27rGsLiWIMgJe/eg
         qI0NoNczEIgYTAITevklzGQTyin/+010hb7atOgFnJMSR0I0TAV6KFMapIQRTH5ygUnu
         Zh6uwRmGEeaOWJ9+fOTvoa5inqG7g15FZKj51frJd2ZoVjgrj2Q92Q4zqY+SG6j0L2vS
         nIjkUCmZ5S7E2TCzKqB0481a9zvpQ0zSC1WCvmlADnzX0oSq0rdv2XutwA0EflJs7Sh7
         Ji7w==
X-Gm-Message-State: APjAAAUvXwPayOcmun1AlCtRSebyxw5URDMRaY6wnkpPq05WLNjiYyF7
        mAtSEsrfbI+IYViCJoX0/srsPlHMz3TnrT84NqurEKa2YEo=
X-Google-Smtp-Source: APXvYqwl2DyYKj2kH6PtoIT7gboOJHRCYF+78gWr+KUUSecBNhxzV3qwyqgiFBGFbJnRQiA4U//XJ894f97eT3kdyEk=
X-Received: by 2002:a0d:d596:: with SMTP id x144mr24395707ywd.69.1567532637176;
 Tue, 03 Sep 2019 10:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190830095639.4562-1-kkamagui@gmail.com> <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca> <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com>
 <20190902135348.3pndbtbi6hpgjpjn@linux.intel.com> <CAHjaAcR4H6CnHxzR3NHLpMCgdafVHYuKCp4qxUd8b+K0SN34BQ@mail.gmail.com>
 <f73c8da9fe417eb07137baac9c96dc0e0b6f63a3.camel@linux.intel.com>
In-Reply-To: <f73c8da9fe417eb07137baac9c96dc0e0b6f63a3.camel@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 4 Sep 2019 02:43:43 +0900
Message-ID: <CAHjaAcQvQ9UY=LCuoB4Qrsd5wvxtWrKesieV-1pKp2S7dvKEmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Tue, 2019-09-03 at 07:42 +0900, Seunghun Han wrote:
> > I have a question. Do you think this patch is not enough to handle
> > AMD's fTPM problem? If so, would you tell me about it? I will change
> > my patch.
>
> I have no new feedback to give at this point and no absolutely time to
> brainstorm new ideas.
>
> You've now sent the same patch set version twice. The one that was
> sent 8-30 has the same patch version and no change log so no action
> taken from my part.
>
> Please version your patch sets and keep the change log in the cover
> letter.
>
> /Jarkko
>

Thank you for your advice. Then, is it enough that I change the point
the kbuild test robot told me below and resent the patch with
versioning?

coccinelle warnings: (new ones prefixed by >>)
>> drivers/char/tpm/tpm_crb.c:457:29-32: WARNING: Suspicious code. resource_size is maybe missing with res
vim +457 drivers/char/tpm/tpm_crb.c

   452
   453  static void __iomem *crb_ioremap_resource(struct device *dev,
   454                                            const struct resource *res)
   455  {
   456          int rc;
 > 457          resource_size_t size = res->end - res->start;
   458
