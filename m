Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB814206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="R67zYE6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfG3Itk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:49:40 -0400
Received: from mout.web.de ([212.227.17.11]:45451 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728432AbfG3Itk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564476542;
        bh=udk/4DiKcVzXKfu8rZxOBGfmVl1dsR4NnNq0mHljcLg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R67zYE6Zv/FsW8uMTVzATrlebMsiCosyd/GuRAirzvSf9yO3V1s+wzgCS2PevCOXc
         RGPl6glYrp61Hp4xmjsPscxNMRL+0+9n6DrAdyGoa7mf//cLgH/kB13Igyz2eHmTTY
         wpQK+01iSpTAP1x4lNth0MX0e6aT1L+Tq6G6PGHU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.24.141]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MV4fx-1hrgQa3paH-00YQ4y; Tue, 30
 Jul 2019 10:49:02 +0200
Subject: Re: [PATCH v5 3/3] coccinelle: Add script to check for
 platform_get_irq() excessive prints
To:     Stephen Boyd <swboyd@chromium.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190730053845.126834-4-swboyd@chromium.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7debc03d-0bed-e0d7-a793-089fcc85c9ee@web.de>
Date:   Tue, 30 Jul 2019 10:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730053845.126834-4-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OCF3C0lcfWYjWEDBmfvnDA8RhhJEy91vMb12hxaIrorlbWRJARm
 k6totR05fNL3BcvN8pKBvus3rJ3PixEhWewY8RqxsLtm18CaQvX0hwV5pxt5Pi3/WvuvMbm
 WEBkhGKXh6dCUqu585QfLAMj6uqd0qIdGrseb6dEeJyctQJOSn1vubh0ftCDZm2e0D1EN+/
 zAMO6CTJ+AGhdb4ASzEoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:buCdTcSCens=:lWBFEtRNfzg3ZAf7voRRLm
 7orqc/iPa0X4hquPqsqO8hyFsE2qsaxxCVjwjzWr4AGLbqySmL2HoxAbBUHRNR3v36HYo5XcE
 NkG4Kwnz0an0JWRkLTAw/GQrds4MU+9ffh4W/rsOaoRi3JQJ4ZcjWORtl+n86M9CXsUjFLbdI
 TWvEuKx5wXqOrYZw01u/0cQB/jOafImHlYEnnSFDq67B+1Na13731t0+1FN12o0lqg3jM3Z49
 w2kowoyr1J9IkdHrvxpTVa9//ieJpHqrL2ktM8OO5at7CSQX9aFKXWIWt6woPVmmDiWZPo8IS
 5UdiB2bY0bS3JUttcGpUgO5azKB+AUC8/bWKzkBA4fzk2ObXZDWSt0BH3gdG6yDyVWyO7wX1b
 30T8bkSzmr7mgIswIKR++ePz3+k7hODILwl1vlE5imZj4wm9DTM1ZE00K8iQXubgfpGIiDmXM
 7Hbf7D5O0/UFVN3s0dH+tfbiEVmouHdZ4S3EzHUqTMXcoapBky7B4P+sxt/7V0B6B/gU5ZUW7
 UJme3XAxnoZfXbV3C5/NrqnKzRDouMbYKJtjSCeeLh4MbGYKEx+WGScAVzt9u3I69HWIUiGvk
 UdLnOtGkPQQKTLAyWcA/csaUHXkFBc78+lxKalkn2ebKxuGIGPYTUmSU/klZphno+Md0xZqOU
 E4+iPqjwtEqah2bb4eXa0wpP9q4PtQCqBS3ICzHSv+BHArlTvgVEfCITt1RJDiz0ZckParSkG
 w8ZXOgvKmyJEuRJeXDMaZwNDkiAgDoGi61hoG73Wvw85+RyTzFgzkO2n9Kw65CvEU/UyzI2dd
 +6j6UxTd/wOMzB2FwF4joa8AOQ3NBPOQD6qjR3p01d+5uLs8FxQ9ctTRlaYpmINge8IRBG2aC
 uKOsTrkFdsWCKevT4OnrwuPPudREQdSfIEdFoWR5OPmmnOb5MCjf6K9NJE2yUyfC54HPwXt2i
 +VDvSI0uz7NS3JypOz7YFZ+kVirLaSkTpPquSnxr0daf8rWwNXBoWSlsmRkMhqyAb2J6MyCb/
 grfp32QqvRcXgXFvT5I8/Haz+nAf55F8P2PE18HFXXRcteMNMJCl3vuJDtt0vtCk0dyoCBEZR
 nN+RffGHtyMl+fjFBCkhtvRZPmFgmWYoDo0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure this will be accepted or not

The patch review and corresponding clarification will become more interest=
ing,
won't it?

I am missing more constructive feedback to remaining software development =
concerns.
https://lore.kernel.org/patchwork/comment/1301194/
https://lore.kernel.org/lkml/3baa3e3c-c122-e868-55a0-597e279496ac@web.de/
https://systeme.lip6.fr/pipermail/cocci/2019-July/006143.html
https://lkml.org/lkml/2019/7/24/886


> given that Markus indicates a similar patch was made for other error mes=
sages

I am also curious how the acceptance will evolve around such change possib=
ilities.
Did you get any useful development ideas from this approach?


> that this may be able to be merged into.

I find it unlikely that a merge will be useful in this case because of spe=
cific
property differences in SmPL specifications.
But I imagine that improved SmPL script variants will be helpful.


>  create mode 100644 scripts/coccinelle/api/platform_get_irq.cocci

On which storage locations would we like to agree?


> +@depends on context@
> +expression ret;
> +struct platform_device *E;

How much does this specification matter for the parameters
of the mentioned functions (in the SmPL script)?
Will the selection of function names be sufficient for the discussed
source code search pattern?


> +@@
> +
> +ret =3D
> +(
> +platform_get_irq
> +|
> +platform_get_irq_byname
> +)(E, ...);

* Would you eventually like to extend the function name selection?

* Will the SmPL ellipsis be appropriate without the metavariable =E2=80=9C=
E=E2=80=9D?


> +if ( ret \( < \| <=3D \) 0 )
> +{
> +(
> +if (ret !=3D -EPROBE_DEFER)
> +{ ...
> +*dev_err(...);
> +... }
> +|
> +...
> +*dev_err(...);
> +)
> +...
> +}

I suggest to reconsider SmPL implementation details once more.

* Case distinction for curly brackets of compound statements

* Application of the SmPL construct =E2=80=9C<+... =E2=80=A6 ...+>=E2=80=
=9D


> +@script:python depends on org@
> +p1 << r.p1;
> +@@
> +
> +cocci.print_main(p1)
> +
> +@script:python depends on report@
> +p1 << r.p1;
> +@@
> +
> +msg =3D "line %s is redundant because platform_get_irq() already prints=
 an error" % (p1[0].line)
> +coccilib.report.print_report(p1[0],msg)

Will the message constructions be adjusted?

Regards,
Markus
