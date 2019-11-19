Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF1AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5155420722
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ogifftDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfKSVdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:33:54 -0500
Received: from mout.web.de ([212.227.15.4]:43603 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfKSVdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574199220;
        bh=JIZlx2xADhR44OpL9SkZ4uG9PrdcPP0WdD2iX0/LZb0=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=ogifftDmRXe+oXBsUcb6CjR0hrX58N9uoWc7No1gQqEaQRAJJYCA7+dAWrTcteiBq
         ixB85vvLHyN+qzKMXHLoUBnBYJEoNwlxdD2EBKOU0W4MRN730J5nJ/bdLAq68YfpjB
         TE14eMd5JHzzWbl/yP2IfJ7AuGi2ZQoVjc3+E0Kg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.93.164]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeScR-1iD0FI34cp-00Q8BE; Tue, 19
 Nov 2019 22:33:39 +0100
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <1574184500-29870-3-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 2/4] coccinelle: platform_get_irq: handle 2-statement
 branches
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d178b6b3-7ef1-4ad7-a747-d65249a9667a@web.de>
Date:   Tue, 19 Nov 2019 22:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574184500-29870-3-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OepehyRGi7F5J7FrZtrEPMM1D8UtAt9MEOIPMYKUO7gEN08FeLv
 nhyrZ4JqRppGjQ5/mmidk8JnGYlkeZFSVUJZVJantumMhk+ryktbcO9uK8+XB0opYVHTaSi
 4dwxW56kF6qUDcIT+pgCMRsMha0M/0C/wM30HMzmQyIRiDIq1aOZ2pVC4KzutjbTYtqF4J0
 MiwVx8KJCZ0I0tTh4Wa5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Yf9EyEE+Ks=:L0UUkeNSjFelhEOEfODGXf
 rHX13H3K31J+Ai5T5iO2ir0fVA7tvDIClIuLOtqkF/YOUY13azCopLZMPEH3nPcNr6S9hxHG4
 PSlobqJbKkM2ufna/Qoqb6GDgnYH8gpi28Qb086RQb2L1u2hDT0yx3cxxFt7ZSKZHxzvgaYgf
 oQRn4TyRWeetgGvreBrXi5yFJK/taIdDoyBFLPC5YYfJJHttbrlR2g6/NhQJCEcSdmtMYBWrQ
 6wo31n9iC+VFRTO7nKDK4sS3wv3Vn82DFbd7CR62EeIBwgU/fPTXjgTxpxJvTmZpoNtEBfagJ
 lqfm24anvDs5+/Cl/P489xdtkqADscuFUu4PKnL3DtFtt7VKWNQ43SKVoI9UNKWStUs0Z5bX4
 wKVB3OdN7BqgDeuiSMy+aNt3VPM1pPAGQhmanLq9h15d40G0v5N/fR8jpZivcmNZV64rAWcVa
 LOsD/Ib9hrdX77TitQGPzuQL2GLUA0w42WHJ27pvi6o15f2/sztXLk+6lHi6vAszRxGg7tuFO
 j5ES0Fzdsp6ea2qJ8eB+30SWAuZ7+ArGfz+IjfjrYG7m3rmvQZZab9Nfc3k/LQpFFcU1fYZ9v
 qrQo8bx2Pjki4iApC79UEMmruAIMxTx43Of5STSxSJL7nqO5Qsh7fWDz7/+MhyCuewWMWGxKx
 SRdd/sMkvbshV0vlXIQML6o9hEPiB/3QM0fMmIgzwYofc/qAAOFrdc2klfWBkaq+7MMLqCbvq
 yJC9minKjZRe3I/RZ8jaGkDlLzYIW+8GROA5UTjcFcSAUxVCxhwXAnTho4Tw0ttgoNVTqfxL1
 /MeXBjyMAn+GxIfZMKLOagY0n+pS6rhPcHaqIZzHc2YNTSKdy7iYCrbN5zKaHWOmCF3Lc4PKw
 qwGTmsMHLgnjOdlq7s8p4jtA9uJmjhCRF0wOFcfAH3wjU7KtWhmXKDcQP9fqrx1EAzr5Jw7Pc
 DKv9XXjFoeN6U5zEHpHdMhAxcyCQXS6d71e5pE9jowcwv2fIRScts8srRvRs2HLswJkLhW/l1
 bbN2ZZJOnThtbZW48CrQR3gNRAWWWV/UrD33ws5mM/Zcm+c4kFbUB///48OM67TCY8qv5W4+N
 rcv0xVA2H2Qv0X9IcqQadjWz4cNawLtnW5uZJHzvH/CW15mPPe8UBA/4RpxdBqvuYnlcxDKxg
 Rww+TAQwvGLmHtCjfxVPrUj/6Sg54Gt42rDIZ4Aq5c7niA0EB3LX4v4Qz2N18TuhO/fVLGDAB
 clSHfOppQc7VLxsNwnlzP6Fk7iwZPdq97Qv0sJDNUfj//r3VKt8xqVbi4G6Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Masahiro Yamada <yamada.masahiro@socionext.com>

I wonder about this information.
Would you like to use the tag =E2=80=9CSuggested-by=E2=80=9D instead?


=E2=80=A6
> +++ b/scripts/coccinelle/api/platform_get_irq.cocci
> @@ -31,6 +31,25 @@ if ( \( ret < 0 \| ret <=3D 0 \) )
=E2=80=A6
> +ret =3D
> +(
> +platform_get_irq
> +|
> +platform_get_irq_byname
> +)(E, ...);
> +
> +if ( \( ret < 0 \| ret <=3D 0 \) )
> +-{
> +-dev_err(...);
> +S
> +-}

How do you think about to use the following SmPL code variant?

+ ret =3D
+(platform_get_irq
+|platform_get_irq_byname
+)(E, ...);
+
+ if ( \( ret < 0 \| ret <=3D 0 \) )
+-{
+-dev_err(...);
+ S
+-}

Regards,
Markus
