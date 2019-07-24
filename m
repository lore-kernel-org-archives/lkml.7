Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EA3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9014C2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IJ1SRzEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfGXSjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:39:36 -0400
Received: from mout.web.de ([212.227.17.12]:38035 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfGXSjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563993541;
        bh=BiikwU8F+XZgq5sns0q8vWexs3UUi0ZrtVyVPoB53vw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IJ1SRzEBoX5UTBljkJo1DApCLLPbM20gYr3r2nVTkfo/19wdVr1BW3u5UEper9Dnr
         VnvaWm9VhVG3+DJ+HmyIVR1GprKc2PJ3my/E+rv4D7Jgi+7Y51KgL87OAcM/MUcF7g
         SXAzRYl5IkSOxgJ9wOkfPGieejBwegnhMHmZENSQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.51.56]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOzsZ-1hntas2ilL-006Pzv; Wed, 24
 Jul 2019 20:39:01 +0200
Subject: Re: [v4 3/3] coccinelle: Add script to check for platform_get_irq()
 excessive prints
To:     Stephen Boyd <swboyd@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <20190723181624.203864-4-swboyd@chromium.org>
 <c98b8f50-1adf-ea95-a91c-ec451e9fefe2@web.de>
 <5d38a1c3.1c69fb81.2b26a.b585@mx.google.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3baa3e3c-c122-e868-55a0-597e279496ac@web.de>
Date:   Wed, 24 Jul 2019 20:38:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d38a1c3.1c69fb81.2b26a.b585@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3w7UJ0vRXi4Bm7/c3lUCp5uN3q28BMdZpJCe1IyB3LPxQ/xPv1
 ux3r6uJ1OdrzvOedjJLT4MywGaTiEkzq0UDAX6NGrLotjdnyvFVSfFfT1LRBV+2kq3sI8hQ
 FrD6zHzrgP9JhGSUCOJ+ufyYUbt3hZFGH6DQw/1XeB96ynmkfQWjEJfUxMc5g8OMU2pKFY4
 zkSwRgi7g5mX3OMkBE/pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AbZD2mpTqEk=:GLd4x3GdbsmxXa7ITiFRQe
 tsVFDHcOwMEEmyf/vxraDbxqrTJRb0ZQXrUVdhUSntb+96BMUM1tuon14blKhMCVO4npayxjI
 UCABw/KSw72PACC+xURhomS+A+5Ku4fLME9glW+AA3GnTSGLE/F+ISTTi59NgWutGd+aLafCK
 aCngKbM4BiBfec+rnvichhaoP7fvfSylqhR8vPDOtIalIO36M+/v8EDKFnT1/4JCtzdcyGBQx
 n4HXWS8cosCGLfCqKCfSXCI1WkDRAvCCWzcMTiWh/xRnrvsW0/Y9AHm7HL5AU5DYHL8k4MNpn
 vmSu4HJVb5OEXtXKDnCcgJtBe8vfNBykyKdyV9sNZrtrEm4ljUxr+ROOx5GgLjcZr8a5f/0O0
 KxtXDkv22hsfWTTUiOY9oB2DHlq9A9YUU95fp+vjIJtgOouQZWjGsGzasbP3R7CrgHiIjAhCO
 YA9/eCUkXO4DCDhUk6p2l68CEyZHE4PPY5jE+Gh5G/vWl7Di08uAv5Cnp/oi2Idkf14Zhui34
 fqyWpJxF7CCGNUBA+Ye5Vyph14gaiy7KgU4BOeOnqemZRq/8FO9DGHm7vR8QJOxhOaQzzdW3k
 UPNrG4QNmnyLw5n75FED+2cwZvoXkc24XMnn+ZhCFV+VnqrV9+NiNnKJynoy82iUBTO0bK4ee
 K0q2PIjn28lCGQE9zTuktPXouJr/y7SgjF1LMSVi5LQiD5Xlj160np1wUBZJanhPB8PQLtMm9
 /ns6Luixjv011jObym6adVyZBAp+DEyJuURVh6fUnUsuOkVf/ajB3hbxMaieKfLVyRKCHS1dj
 X+fz2XBD2EB9bZMV8dHB5WNCRuun/ovvHSe61sonrzZtPBEgWYuYiSsCCWmIg9wHMzTSJWx6W
 juEv6UgKyt3rARxsjDK5F12BzfgXAGIz8qsg+gCsL/vrYMqEKJeGyr1DsrcadgTx9y6mOfHZn
 JFI0vA0OYcrT3/p7QdBh2saaG/mWlIPV3Vo2vq8LBUQIdEdxdPYJh4j53F3FqpKpQoApFn6CA
 WVtmbzGmOvst42tU7bhse+nbIZocKg9j/tuzvJwmr6ObPCxyZ8JAyPpqkaannrJh5rO2mDtYj
 cSR4zSoW/4Bwv4TzgRZEh6VVLCEt4iKVuS2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +if (ret !=3D -EPROBE_DEFER)
>>
>> Is it appropriate to treat this error code check as optional
>> by the shown transformation approach?
>> Can this case distinction be omitted?
>
> I don't know what you mean here.

I suggest to take another look at the importance and relevance
of this specific source code search detail (including SmPL disjunctions).


> Do you want me to drop this part so that EPROBE_DEFER checks don't get r=
emoved?

No, not at the moment. - But I am still looking for further clarification
of the desired software design.
So I am curious how a corresponding agreement will evolve.

Regards,
Markus
