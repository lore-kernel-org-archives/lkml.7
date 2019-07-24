Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0815C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2FC22ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TRaYNt6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfGXNTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:19:18 -0400
Received: from mout.web.de ([212.227.15.3]:49939 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfGXNTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563974320;
        bh=RMWJ28ZCfKdNbSYVaUUBJOU66iPoYHkyNH1NYJHPWVs=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=TRaYNt6cJtnfwUwchVc/7UNWNj0C9a8nN3bSu/TB3ZfZ9dMbOlrwrt7tR5YwM7SZC
         8Hfa+KKBlYSyY850Cb5eAqKp98jInAwAwoekwHrsqSIbt2bpmbNdA7toW4ValVnIlh
         vpgtaJ7gq+guVHlWyM4dE6YY13cBEyUmLPlEffLI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.51.56]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiUVY-1iOVSO09Ua-00ce0a; Wed, 24
 Jul 2019 15:18:40 +0200
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
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
Subject: Re: [PATCH v4 3/3] coccinelle: Add script to check for
 platform_get_irq() excessive prints
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Stephen Boyd <swboyd@chromium.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr
Message-ID: <9b5d8470-dd6e-4358-141f-6b6c40774de1@web.de>
Date:   Wed, 24 Jul 2019 15:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723181624.203864-4-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lg0bH29JAMS62N1veEu8qnTCsl/1nUFcnBAV+U6fQpeJxpoa4ws
 EIZJK93GCEYRwOSPDa7cx6b5znl7IKq8jAEZCLI5TeNUHCoRfJVm6oQzK9v5E0rus6RcwWa
 PK5hgeUhkL/O1/f7srtKLGtWtejx2qDE0+K5nrbBCks2GYX93THtTB1upIWSjg4my3FeLLg
 EufTGBm9Y+TnJbmsnOuFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKtxc3p1bwE=:5RdzYnSrZ03XG5tuPCxmbm
 Xo2875GdCw792pNdnh9p//QLSjFOzXeKAjxJwlxQBuNd6g233/otcwM/A07bz89LpeDkK4sOF
 s1CZLX9l5VbqqREHAR6uOSYnYNPCxsDREBPvAOiwTD7vYNrGhl4TxoaorY38F8whZS3umhUjx
 rQrYP9bNbtDqzdzWaVYl9JNw9XBqyycoEL83eAaKJfEcgHaI3PmQwRQbMV9KqJNZmRsiRkSKO
 FesM8HN5KEnGY7AnVVAlpq8qaFq2TCbghXrjJYuqAl0GU0QWfMsdlxgpqtJ4uL+t152YHbm9r
 +oFr8tw2CD0ErfzO634OMpTZg8woc+v+mg+SB+YiSrmzTWwZ/yjggfFCRPqDKBaWn+zIkwOdm
 c9CWRhp73iyQIhlhdtf7b+f3fSsJPnlQFO3nZqgGqymIQ1KIxFa1fFieVXG7NlZE2J6q6CHMY
 xDzmHyCNGagShGAD1TWeJbohSsOGgqBDOx6bq407BGCxc+Sou5rhTg8IljQztf9QOsW36KeNI
 J+n4KxPY0qtEppVV+fTjgK5NgnMd+H7252NZLVIAZ7Hj5MH3aCEtgLI2WyPkVdsm0eQQ1Y4K5
 BBNm/GiZpTwjqmjMhFwV/yxgZgaAlyjQu4HYANIYgTCVLM8xPsR/1unsAyvsVrVjWtWm+Sfj4
 7qmaq2EihliFllJb80LqL7Ts5zvWj+1Ka8Gz7ltxdWW0htV39FGIvtzt4qdUGlliL5vX062M9
 hksEEWPseeFkUDm3NPTm0a0AqVXGC5KAnx23Wmwq91t7H9nlslsvIYt6VXBD2ujthxHqEFXqK
 syFU+ftDlnCY0vtx1DVn1FPtPqsr6//MQxRyhtkK04yKylT0ZuUf2YWxtEGn9G7C60iGeE9fa
 eFjV8jPOFYoCWWPsdRVWzYbOpnTODCm6or+RtFfh5utTolOL+6dDx3nulg7s9ObTqndRH2d5g
 3bkkh+dMo0KGSsLmlxWgM5WOnVOV/YxxK/SjpQ+K+UHWma47ggphcE88XD4nW9SWTC240b+hs
 zzmWLQ+C+94tCaqcIXUWi8pa9S9eiupYAHghJ8jLBeuPr2k4I8A5Ca6KGBI+W+4gebFCXOSrA
 CHLz9z5EQMlsRXrKwLwkaOr374RvW3VqUTk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@script:python depends on org@
> +p1 << r.p1;
> +@@
> +
> +cocci.print_main(p1)

Will an additional message be helpful at this place?


Will further software development considerations become more interesting
also around a contribution like =E2=80=9CCoccinelle: Add a SmPL script for
the reconsideration of redundant dev_err() calls=E2=80=9D?
https://lore.kernel.org/lkml/2744a3fc-9e67-8113-1dd9-43669e06386a@web.de/
https://lore.kernel.org/patchwork/patch/1095937/
https://lkml.org/lkml/2019/7/1/145
https://systeme.lip6.fr/pipermail/cocci/2019-July/006071.html

Regards,
Markus
