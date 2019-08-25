Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3212C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A6206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 15:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="j0lFIlop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfHYPbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 11:31:14 -0400
Received: from mout.web.de ([212.227.15.14]:46093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfHYPbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 11:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566747059;
        bh=72qMHww2wefKgAECOasnK+HqNyjIfA2p8ZUpIBUT3bY=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=j0lFIlopum+7QxKcTuJB3iOwlpOGSN5xfBz3ls2C7FqSfU6cOeHPbHBFzrXd8Vluj
         Lnv7/GEXuMuBgPjxoRsYGh2g75X4ri0Ud4+plFH07b1v69E4efTCIPgqzsA5BhL8dy
         AVAiFPGv9Zt3EX3FRSTzenwhe8MgUyvJgx3mGLw4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.160.204]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFcPd-1hys460GCD-00EbLA; Sun, 25
 Aug 2019 17:30:59 +0200
To:     Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org
References: <20190825130536.14683-1-efremov@linux.com>
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e87c12f2-40ab-69b7-2f55-f1fcc980e784@web.de>
Date:   Sun, 25 Aug 2019 17:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825130536.14683-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/wtSSiLyjBW4ncUQjmEnd9vOthARRoywz+ab2p2q/toY8aLb4qV
 rV+l9gn5wYKgg5NnIJLuhMgcJU/NtAMehlkYPUFiDFxEBu5kQ421FYO5XXLvtP/mI2WOQPq
 0pDUqgPUcLQtjAiwbME3dZNVXvQWmYHMHPaLw6WfqSC22OspnVl96ueqorAw28zstE95NYz
 UH9A4j76/zx0/goxdtd3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YqL7mzDXKzk=:9maM8wmKSyJ+euLcSftA6j
 vZ5HPn61tq3yvvGiI+dldeLryX0aYbIjpc2Mh4eR0iIkr/4t/3p0L50bxwUoIstvx5IJr/4OA
 cpj2GfBvbuV53CQwm53L7hII6R+pmCDKY1mUK7TE7qyuvUEBg99aHrrjv9k4rWmsbUCO7VBmf
 Y8UyrB1+uWh+EoZt7QQ209Uo8+ehisETIlPQaXMsn73lXjhjY44ABJ2rq8o7qbqH28waxp8Um
 6rJcb63jB9YI9oJ+qm2MK40ddZrSHbsPPNn73Hwrhz4UK4qAZT27m4jX00gZp1YaPxLl/daTF
 fnh4sgBNgkGZiiVXIDpzFuwE4T8ymG1bntJu0x59xHHeLOpo+DwuwpyHVd8LXAUBn2rHwIJZP
 ivlP1RiOHW4/8R8D6mcUJur1SJqUiBa0rBsroiKB5LrV3KutuPyObOztXdN17J5qX19W0Z129
 Q8DwJJnEAcL/oXQSo/yAzaSf+f784grcvx+8vu00MFAv/hqvIo6qCbzhXdrxEaVaTob/ETKSO
 Y8Y0fA0XjhSUO0foBEnpatG4zCrE/jFnjn/HLrCxUUBhUkjpzc+tYnimBdZ1OcdRky3oVdauE
 fNBt6mkzO0/gTnXxfxtSRjizQppv8L1Mu3rNeJc3h/6oTJqOjgxYfVrKvCjJLlaiJPKE5t5Md
 +riZNms2+Plz3hmw9dWJcXoN4XHi7eIFo7tiDwYjO/HrO1DRjnJ6RL7YBGZMPgF3c5e5+Qq8A
 eM9a3ZR1Rp+APm0sGVFm485W3KyZwG+QQxfGrTQ2eJzoKJ3259xBivUbQrIIUMmmaGX2xYmoC
 outA+FiD01uFUMUDkmNIO72yU7ENBm74LWtwodKXgKa12lfw6b7u7/K92GZtCKuBD8Yil/77E
 ZYB+7L9aaG8UaRnqW6U+w3UtCO1obZhd8zAUeUCe+oJ92JLg6cv2bqKiV+NfigqPvP36dPcyZ
 7WHHz2XlSi6DzrnyjAA/oQ8CozE7mkLlujo84Jj4LjacAia0EOCL08+Nfr2nH/LevZoHI6M0h
 IPN6e0749GpbeJ9SAVMPR7XiT68wXUsWmedNgmz/5Wz2XZy8zAi2cN8/T1i302UTXp76XDGki
 mCKRX7Efq/qL1i7lMbdQ6355QRtIbtIJOA/LuPLPygbDTdASYV5ZtkFzoxZ36uMea1njpuu33
 uYXhk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +(
> +* !likely(E)
> +|
> +* !unlikely(E)
> +)

Can the following code variant be nicer?

+*! \( likely \| unlikely \) (E)


> +(
> +-!likely(E)
> ++unlikely(E)
> +|
> +-!unlikely(E)
> ++likely(E)
> +)

I would find the following SmPL change specification more succinct.

+(
+-!likely
++unlikely
+|
+-!unlikely
++likely
+)(E)


> +coccilib.org.print_todo(p[0], "WARNING use unlikely instead of !likely"=
)
=E2=80=A6
> +msg=3D"WARNING: Use unlikely instead of !likely"
> +coccilib.report.print_report(p[0], msg)

1. I find such a message construction nicer without the extra variable =E2=
=80=9Cmsg=E2=80=9D.

2. I recommend to make the provided information unique.
   * How do you think about to split the SmPL disjunction in the rule =E2=
=80=9Cr=E2=80=9D
     for this purpose?

   * Should the transformation become clearer?

Regards,
Markus
