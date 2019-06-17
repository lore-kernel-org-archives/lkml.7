Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04531C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C161A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fZJ4kwXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFQNyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:54:55 -0400
Received: from mout.web.de ([217.72.192.78]:48731 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfFQNyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560779682;
        bh=5n3+5UD5r4ugUTJekYIPb/IynWjGUo7epgkudfZ3ze8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fZJ4kwXuRZhjW/RcZc+4ud62hJOuFesq07iVCLKztz50J5yao1Tumscr26+3YIn+e
         UwJzPSBPM2aKL8f59q/NR7t2Y/x9qf7gcdB7U8d6SsiAQzZSsv3gXkkXmnpi1OM+Bw
         KD/2M4iAay7aLPlby3x109ivM9m9TdJgV2bCuUzo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.164.208]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZlR4-1hv5Ch3gqc-00LWb7; Mon, 17
 Jun 2019 15:54:42 +0200
Subject: Re: drivers: Provide devm_platform_ioremap_resource_byname()
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jack Ping CHNG <jack.ping.chng@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Enrico Weigelt <lkml@metux.net>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <39e46643-d799-94b7-4aa5-d6d99d738f99@web.de>
 <20190614133840.GN9224@smile.fi.intel.com> <20190614141004.GC7234@kroah.com>
 <CAJZ5v0iBSq+DHqkevbLS0kYbaKGM0zYjg0KAzNhqYjCXvrQ-RQ@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3ca31684-ac8b-441a-d736-5f30b7ee2229@web.de>
Date:   Mon, 17 Jun 2019 15:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iBSq+DHqkevbLS0kYbaKGM0zYjg0KAzNhqYjCXvrQ-RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w86hGSUeJKn9ZFzoXgHBtEx6V41mlFFbI/Z9shx37bIY1mGYoa4
 t4oMtsE/3/rkfDFuf/Dbyoz40xijMCgWHygqQv+L40U26zF8V2GO08HtTSFHKUR1SGdKqDd
 AWmpG+f4xCSaG3XE5NiHfArf2ig96E4JAL3Djdsg2uhetkOoX3xNpIkjrGdtfJX7L0d/O3C
 j09DevuQPPzNZCQ8ri4HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A9fsfG06pgw=:/mWZ5Dx58Jj7yhWXkGKEmf
 4BPteRRyAJS34urBCXSPthIGUsv5JqQfqmddjlySORGGX2H1d7fHcxoFTCUvQ3RrsHH8btIUf
 jugi50SGXnyNbdWw7QVl5mI9MPBvu+chwCxctgyo6DARvrmygAZsvae6+B2jD6itg+ikgUXYD
 vzIMO4TkiSCsM6K3f6ag4lc78VmMygNBUKS1DQ7AuDJZsST3IITpJKXaY+udXIuLFioOgIlMM
 Z11bzRbd9Bsz7nPDBJzAdOL6CFs02o6VLuY8f9qUaARqLGLEhM+HvR1xvZDCAso4KflfZE8vI
 ueKHx5M+PUz/vMpzQEor88BU1d2qj39Hbf5FDCMnzUXTNB2srkW6vlS3kjjv2HND4mmx2abLU
 KqwSJUQ9GjC9/F8RQG679FNA0OMzMsoTpp04qemaAF7HDUi90nWrrvVr/AgnW0R2QpADc86Lv
 X0SbWFbVqw5DSkp2mcw4WS2vX8Ma40e4SLJn+IlQXTfW8FMvkGpy99tD7wGz1xnKj4T+ASCLo
 POY/1zvP+YDVY7V1F7sJfjzEfQwLxEjOXGmLKc+DDhwrOksvRm0O3xwu4ZZmsugla7+ALHENl
 g6FvNlQDKCA+mQ7HwmMt+mYzvqAO8joGxiKISXhQi/YA0Rftcda9yhNHOChzduYyG6qWdiIK4
 o9BY2BwhWxrVzYkW8/H4CD4EvY7ijAAFUDOddnSTZg6rvqXrhj9c/b8tVn9yV9RR7fca5hyv2
 tkZz+H3cGTmuGGg8jnsUVY84cKTzo5TcmhdH9XKiLpmJI6053S1GEDKkL14mQ+XfA3EW2MNzy
 o9q/qyIYoWTslpVVgroQqLSqrQq1+6yjj0X+sN0ckijDTz8XDpT5TslKXOWvCDqMU1YEYa0h7
 zArUQE/XzQ9GMJFUnvgkdLmCOLNMvaXWbr7am27wWE4+DPY2BROl58rShi4pW0P9NHE0LTjFm
 gpUfJQ9vGNkNw7zxQQKFwWJHC6I2WQs3SqA0Uhp0qurVYmyJwPYPW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't like adding new apis with no user.
>
> I agree with that too.

How do you think about the possibility to let an improved script
for the semantic patch language (Coccinelle software) perform
the desired software transformation so that the usage of
an additional function would get introduced by a known algorithm?

Can an agreement be achieved for the function name before?

Regards,
Markus
