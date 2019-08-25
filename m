Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F53C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA84206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 15:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pKfAMt8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfHYPbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 11:31:19 -0400
Received: from mout.web.de ([212.227.15.3]:40663 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfHYPbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 11:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566747060;
        bh=72qMHww2wefKgAECOasnK+HqNyjIfA2p8ZUpIBUT3bY=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=pKfAMt8EX7YOr///3CtsQy/8kN8WT1HgZj6fjyGT8mj6lOwVsUA5OXafd38ToJh7r
         lHJ/tjiSR5XWaF1HJ1qdkh55eFoKQLhZJz7esHoBUECJM0b7bzF1i806t2ofzZnOV+
         +bk5zkzOZRLLwDwzpb6ixcxJqldQjCfBNFE7MUPM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.160.204]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmcRH-1iahCS3viF-00aA43; Sun, 25
 Aug 2019 17:31:00 +0200
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
Message-ID: <73d8cc3d-d0e0-aa97-053f-2012fe450924@web.de>
Date:   Sun, 25 Aug 2019 17:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825130536.14683-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G8uaR6yQHW0ptclz5V3Qhn/RLsJuuugAf30dC6nsPgb5ISMQXZd
 OGUPlo2G2MK3KWEim3Ssam7OcomunmIL7MJoWPieKVXxQBhMcs2yoyVWCbZ+60njb8rZ++1
 4PSFGiAKw8gY8XybWxqWFsGX1k9ecyRhSv2DZMrs7atz1MHGqO7dSegspxkG52DYIRJfoQp
 /czF5BYDXAIJedfLh/qQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zhN+pro9W/0=:pOQC9Tr8IkZOzF6Xkk67Wj
 5GSckA9zslyPQLGGDS0/u3OtifY5B/0PsAKzvx4CvtXVwhhijUsryo+XYw2iTQyNJm0QrKcp7
 euxb4lzCdjpvxHkva8iiRSNqWXKt46DCCavkrsEGhwhRAVDa/fstHbgkPIXREQ6E+Oqhkx1fq
 AenyWiHJjvyIiZofdYlJRTjTPb8YueNChv5an7iVFs8zq7at9RquE2sq5TZeeb4xRCwKfBRqj
 3bCl13tddGVu+yP5RVwYVijJBHGKmwcmnvLMPJMzteGf2WK/IBC3t33+RhvJRbd3HmUhoZ61E
 ROIyJAcHH96v6QP0ozlhWKC1JKTDCyKMamFgYBwVSeaeJSKLWyl2VxuzhjJeaR26gnfB5t6W/
 2rfqOIztcEHBpaFE78IW6tSNvCULBGBlcmGTwd5wA7mA/2DUlDIcjWS7ZwR9u0S11CcRyUSzq
 1EAEZF//RGBJDp4Hr3DNrP0sMqlL0IEaWeRiEeFnmC15nSoBw5a0bctEmx+3SP37Z7aMmQXtU
 gXc6Io5qvT//7n3vvlpqRx05wkC6ACd+nYKaKn33yZUELwTJE7Pm57+o87V8jTP+hM62Ffobx
 C6XE2wBA9ueXRWkSvr6Ayi1wyg4IjpU70Y2cvpReRJHiBB6hIrVFloCdVrrAEHFdZmqABfcNm
 ueJjrJWgwnNJM5LmG5ACT4ewQ0XD4ChLR+hbCV5Kq8ZXYgjZOim3Q0hAvIpjen3JAdtuYG/R2
 cJ8eSrUYS/fXkgmSOIvC2ck2RxTeNaYwwC3Zu6as2C4UddAY2P6239pcn9YnxPVpO1ZtStdqx
 1a2MmQWMUTtG9JGcqeZ02W1E2/gIyKm0Z2WZYA8H7GaK3iu7LDZ41AWQqrbgD/gI6gbjfUGpN
 W17Aj6QrFmbUHkq/WzzLhDn4pYJHQpbVGO+5gIwqxHkYVKLFXRqR+B5dqoXxYs9dkAzFR0cOm
 FIl7ov/M9WMVaHhH6MFzmFOZlhbLh0rG7Li2ObnQVtiPCr3LF91Gghsn2IiOC+QsSnGJAE8c5
 nXhdkw1msInfMOkm/H8dhmEP9sRn7EB/4D1mKVlSLhpxu8dpsyRd2n2Hh14tOzqalyzgz48/A
 02sNadZZf4kVJu6nrwOtgPWzPj1YGbGsxd62czOKN+g0jQtjoVxczbQbKViL5nbn5hzYu/mz9
 Pu7vNJbnhffdmpQbfMpYpDPkOFymHyI4LndpMQM8wyriYKEA==
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
