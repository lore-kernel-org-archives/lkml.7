Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBACC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC8B204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ik+nILnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfDCEOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:14:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38491 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDCEOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:14:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so13540716ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXMYr8XOulVCkNYfy+jpJ4ir/8UpzS0he/ToEImGw30=;
        b=Ik+nILnTbBjtqveUr3TWxBGdZBuzoE2R1YqxmAfIqZyZG7S1o3s22jeaRFVPCOQyBA
         LujCk8v+atgarmUlYfB0pDN/aQrVd1qH3yjvEZxBVbht9gf7rplmHD+u3tutdgqdPYQQ
         G4jhlgo7qw68hL+awXCPSmpB3fwUYszlcHTRfhiTcGCuk7/Q1woB0pOqLONexG+HMzFb
         TCOh4SpYmV8d7U5FpxsWKUFyRKrsjTN+AK3qiZuvJkx2RAV/D+kBhXU7zGJ5AofABMWY
         /Xm1HoCzQ4rRKI1DhZ778RNSeY1uVP9yaoLgnEtGgHBR8AwOnnhPwOH2sfhAS8BDajZW
         BQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXMYr8XOulVCkNYfy+jpJ4ir/8UpzS0he/ToEImGw30=;
        b=ecF5ZJe3sSOq+zgiXlKTpVDE3O5P0nKmFALOXivaxRWG3bPldWx8hK1gNx3e50mXHe
         uwZ0ImrGmAFrBGtlPkJbfzFByHKHwgJBPamv7qEkPk8RjHqF+J4uq1eMXKu10MMU+puk
         +pdbm1biuj9i3ZWEM63mY0KIPkO9xqPzZZQP79YROcUrYzz5ARw+xl8/fuxVxFDHAyVv
         +f09qkT+JKu82WFfex7ueLRUSGZxAP05UAF8oHQyumEqxB3X4V6FRTrQtc6ydTd754b1
         swPjX355SbTya2bVlnMB2a/8v9mxMHp315hnPpB40ykGIJHniIuh2M73rFfCqmzLTZWA
         Q6Xw==
X-Gm-Message-State: APjAAAU5hX4kJnQb1dH5VxaTc8mQa5YFF/N4cszUwQ0mhj0f3c3Bmqtt
        Xg4PO6NEQHLvcUL07YrudCmhXADX9artGN7dBa9WYw==
X-Google-Smtp-Source: APXvYqxuvHPo+3QR/FzBTDZc3EVPj5llZlguyWiIvutgie3op2fVLuirRagEbYREyCkgsJjBMUnv0JVIAXe5lRqSQlQ=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr23145645ljg.103.1554264846907;
 Tue, 02 Apr 2019 21:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com> <20190321092330.GK9224@smile.fi.intel.com>
 <140c6ec0-7c11-6aa9-8434-f14d77be9a8c@metux.net>
In-Reply-To: <140c6ec0-7c11-6aa9-8434-f14d77be9a8c@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 11:13:55 +0700
Message-ID: <CACRpkdZ1xPJ=NS=o=-PYqCO4d-VVZM1=f=xBZa5Dwx78LFPYtA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        zhuchangchun <zhuchangchun@cvte.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hendychu@aliyun.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 1:32 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 21.03.19 10:23, Andy Shevchenko wrote:
>
> > ...and on top of that GPIO sysfs interface is deprecated.
>
> I don't like the idea of deprecating this. It might not be enough for
> all usecases, but for a lot of usecases, it's a very easy and simple
> interfaces.

Yeah it is deprecated for years.

It is not like I don't see the simpleness and utility.

The reason why it is not good for anyone is simple:

Export some GPIOs in sysfs. You script crashes. Who is going
to unexport them now? (Answer: noone. Restart machine?)

Two scripts at the same time try to use the same GPIO. Such as happen
to start the same script twice. What happens
now? (Answer: both, with interesting results.)

Sure you can make more elaborate scripts that check for stuff already
being exported etc.

But the chardev on the other hand will protect you from all this.

If the program crashes, the lines will be free:ed.

If two scripts try to access the same GPIO, they will be denied.

And to spice things up, I only add new stuff like open drain and
driving several lines at the same time only to the chardev.

Yours,
Linus Walleij
