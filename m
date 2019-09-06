Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D5AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B49320842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QKiLERF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392467AbfIFGxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:53:35 -0400
Received: from mout.web.de ([212.227.17.11]:38793 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390346AbfIFGxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567752775;
        bh=QHWEmCEV1uEQ6kB/P0KhdzXXSmijmsx719NXEEDq9to=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=QKiLERF0g3uYZz4pIwzMZc4wdXXKxGfpSouzm8/oEsas6XFJqYKAtvb7ciw8hbMoL
         K5hAlvVreOzV6JVHen6Sol7lxFtfbqmgnhYR6iEr/IyYQve7OQBNPMM5sqHTdJqsDP
         KLQM9ZG5pUlaJddhBXT4g7xTF4us+cG/BAYtMV5s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.58.4]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxOQ2-1iCRbR1WV0-016ujc; Fri, 06
 Sep 2019 08:52:55 +0200
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <5d71eb6f.1c69fb81.31bc8.da2d@mx.google.com>
Subject: Re: [PATCH -next] coccinelle: platform_get_irq: Fix parse error
To:     Stephen Boyd <swboyd@chromium.org>,
        YueHaibing <yuehaibing@huawei.com>,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7818ad20-615c-2ce9-c0d1-3f7a09bedf34@web.de>
Date:   Fri, 6 Sep 2019 08:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <5d71eb6f.1c69fb81.31bc8.da2d@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:06OkBcAqOWHauxvj8fegukN2Uw5YI63qzVyeJVjZ8AdAkIeEcp2
 OCor7w1ZlU/czhJ4mse592qGufqPGg5TcPEPfw6bzECxeAR2I+Ha9CnW7bZ6zWCokCHO31H
 cu8NwBax6+HVD1AlOL6sfULvyNM4fqja5AGRpOllIThF6FkGDhb0NBaIHIXbugtz09HMKte
 rxYcvakeMFrXIcDQpXk3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H9uYAEOu1LI=:MEvEep6bXU1oFe7QXFS5Up
 kUIXLAohBa7MVUDs97pXd4HTBOUPJNsW3UlcPJXJ7MRKYDUpPl3045bcUwQKqRs7dYH8UWpAr
 WDx5gkdHJgYWdRMvA/4JBLpRytlu3aJ7V9w+0Yl2QHKWtyjf3r6RlWaTThJyHW0r5+IzUhsQK
 TJ8qia6CIBHOn9sy8aAZz6id6bpqfiw17NGlZzmkQwx/49HqZCbup72JTeIj+ZWfi25m/iXl+
 rlcXy0wQv2wqJs5/jTAukqjTIVC/ac8kh7gearArjrRHPy7574V7mJynjGKgEWMZ+oRkGTK54
 P/Kvyw1vkkEz2Xopm+vmCueACCxJQPlXNTPqRAcP2NVVS/GCnJYGCycQwSMtImEfWolAvc4lK
 0dYvGYH0Dp3CbVaIUbEDk5MpfHut+Uzkv06RjLcEmN0BtRgeFzUH+XDm+gMzYOoH/DJFEqijJ
 bOuAmiu6WkT5Crba9HPMvo7v4aiDeHBfJTvwyc91zrGiERPeTMA0qGZneyRCRGiPooGRr1cYo
 enwu8KYiqNJlOcB97NVCngU8hvhHce4kV5E/GDqXBQOdF3wl8osn8H/hWqPuBRUzEqFK3hASL
 qPXB3wTtu2x9RKPqCxKypcLyCFbYCZjQJskKvNsY9iN0YsPILVy2cd1H+lv9bZsBp7cpYROYp
 mRnNtph3PY4Ql/VjsYYJdKu3phNj/NlIsIQPVHVGrAqglHP3nG9R/VaX5STysaGV3tYX2+OpW
 KjHQsMA5aLPQZyOpnNBlbERQqro85s69fuQKAV2cTLlUpl+jTRLLy7ms3s0L+FI4B/Y54NjQE
 iapY6wj6XjeXaJCf57ZScK6sgyS8J1Hkblt8MqVtLAlluQ3DGcCA4MKh4UTVaVYkeSKxuzf8Z
 pNXghot6KE878ZVKhMM5EynNBETRSYcBfNLZlbo7DMnE4z666RLVq8QmYT4046edYHOSzAoXM
 MCv2y04DXmS2Gv5jPwmHHG2mQFieS09rXD46CXvpVrICgiDEDV3IO7Gnvq1fDiiZZF/q2KU4c
 TK8TxiPrFtxIY5W2YmhXwmUVaNSf4SVqKH5QbJvPi6q3sk650Rxh8PZaYNr3kVKTAA7LcfH7u
 +SBcIKubpkFv+1rS7DioZ/uwQtzrsKSo3osma1yI3h9framzd1IDlwB+Jb/igI0IN/MfOKi86
 c83XqZNDL6U7s+mHPFyaugDy2qcNOxAlAQguavh/BqGyZ/kLzHhoVyXXXGtix4S1ENObjPIGX
 SPlgNNUYWVckN5qrE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > minus: parse error:
> >   File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, col=
umn 9, charpos =3D 355
> >   around =3D '\(',
> >   whole content =3D if ( ret \( < \| <=3D \) 0 )
> >
> > In commit e56476897448 ("fpga: Remove dev_err() usage
> > after platform_get_irq()") log, I found the semantic patch,
> > it fix this issue.
> >
> > Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get=
_irq() excessive prints")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
>
> Hmm I had this earlier but someone asked me to change it.

I proposed something also during the development for this SmPL script.
https://lkml.org/lkml/2019/7/24/274
https://lore.kernel.org/r/c98b8f50-1adf-ea95-a91c-ec451e9fefe2@web.de/


> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Should disjunctions eventually work in the semantic patch language also to=
gether with
comparison operators?
https://github.com/coccinelle/coccinelle/issues/40


Will any additional software adjustments be taken into account?

Regards,
Markus
