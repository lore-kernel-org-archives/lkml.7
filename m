Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F747CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5809121655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="G9ubtSSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392482AbfJXHHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:07:09 -0400
Received: from mout.web.de ([217.72.192.78]:49737 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfJXHHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571900801;
        bh=TpHiSzxCEIcAvar3A4yeKF3u8As5hzD8I+DOTDKwT5o=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=G9ubtSSlv9b8l/CVhirUvglEu7nB3uh6Ntn6a3TKtjfTBHtcmnTaDEHA9ePh6hmhB
         JRrusH8GjF6nnvuH7Ui8xOSgtVEmdM5GaPlxGzLekXoN9I1l5euaxdwh+bsgfaGE5T
         NihT8/lHEny15gbZbo0dan5e40Sf76k7fXHz4BCA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.110.199]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McWj6-1if45Y0KrQ-00Hiba; Thu, 24
 Oct 2019 09:06:40 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>
References: <1571897060-32374-1-git-send-email-zhong.shiqi@zte.com.cn>
Subject: Re: [PATCH v2] coccicheck: support $COCCI being defined as a
 directory
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
Message-ID: <5762844f-2c39-2106-21fa-65e8297d4235@web.de>
Date:   Thu, 24 Oct 2019 09:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1571897060-32374-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z5Cz3dlOtdVoGDAFiUwZTRszL4aVafnN1BRC72MSMqg9BTm1Kxg
 oYTIg9Nx2K7tlbFzocCpcp9gX8rwdfr/rujQgGUFdYZi1QOpR7ygZtanIEdZqVBNyVsL+Gn
 VBoFyWOtUH2bzvEmal0je9Ok4W6dLmg4ZTvacptDp3IV7hGFLqhWjbLjah0Uj8d5/b9/Ued
 QpFatQvVNVTAaw5+tOz/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8fmZgCwGmRU=:49cATmb4XR3EEFi3d4Ng9W
 S1IsFp9q4xdL6cbzsLNzq1HOaZJ+jpK+BhcOOBRoKwHvSBXhE9VD0ME7ehP5F1pRBq6XJQA+g
 0wXJgMhX+guQ0UnamUla/6XyvQOUsPveOcs1VN4wrhhQwcaFQgdOyRj6OHLF9MyHsEyRaf4s7
 asfAMjLlY0KvtUj6vxt3VegyaLqJZPsGVs1tM7qJJOYva+RjhSz3JpogTAgRHTC6QMtgunU3r
 IUt+5lywGnLj6zKcLjUsvRkwVLuh8CIor+wqe9eAHhH6jk1cLRyBD7NHet6fjmnx4rDxftLsg
 gy+Qhx5iwdP4FNPyVsiwd0C5XMBalG6C7tf4uHnp/iMYMNmRDSwU5r05WEmZvmszMuqgpy7No
 t8R119enSu8pPqA3pw+fNPc4HkEEZ+ox2R+yJubBhUzfivb67c78wdWERJe4CR5obQoqpXLA+
 4/lome3/Phi7MyVMengrUB72q4ZaXEOov0nd20Ztwa9jNm0KdKyhjd96HI+nEjSmOiewhxV/3
 W0cnKipuEg52vcmoExU3xARIup3j8ugKI0dOdPqbZTXHrstUa5NPinNkOjAlmk1HoPN4Djdnx
 /cgZ9fSaW+bnq9nZC1f36AcvyN0bXBg2euv2zfoHdMRZx+miBNZdBMkRpSFl+4cIEWI3bXZKv
 7QxGu5WkQQMzjwK5vPDmkouarqPfTe8n3UB6d7QDO/gUps4hkPvgI5fC6ot7BriYi0BTqvy0M
 ipYH7n7Olq3PK9qPgPdYQicxqRz3IIirQpeCGg3iEbD8i8wPWkK8bbhACyRpFAGCoSNbh+LQf
 Gg/BnvKOolMvFi7s0pfKo4LRaozralXerkUOxr7KblhMMmO43ZsD03dYjR1kG8+S9wiQIw2pc
 NxfqXd7QCfc5HrUWvK6Mk8fviX7f1a5sssf3HYxHGr4rZXRPWcQgdpcIWdweAUoXz8aZ19UiL
 MdYPQ/OU4/WWvfvTYNhuP/IfWW6gTgNS3JeG0PXo6lNBYiF2RVDA5Q8eBLf9UrS10XKW/vuDX
 2nEXtjfcVlgp4617tnGxgzG5ctwWYnsEnqKU4vZraNLcp18L1wn2EP8u0uEOG+GlkNrpBfTwl
 wGTK1ZVE59FE0uSP5pnuyt8M+5JcADY3jEIj9P/l5cjU7+kvLq4wTzHPI9Ja9GoZbcz33rTDZ
 14+BBwBuH3mf6PVVwDitNKZM2Dr8z7puJbmH8FY+/F3dEOJ4cNVZa58PgMwOpwLHyN6wfz1xg
 9uIPFAcN0kvkAxdz8BT04CJKnH4SK3c+uTVZTr5pIB5V0n3emonA5rX2q3MM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find that the commit message should still be considerably improved.
How do you think about to use the subject =E2=80=9C[PATCH] coccicheck:
Support search for SmPL scripts within selected directory hierarchy=E2=80=
=9D?


> Put a modification in scripts/coccicheck which supports users in
> configuring COCCI parameter as a directory to traverse files in
> directory whose next level directory contains rule files with Suffix of =
cocci.

* Please avoid a typo in this change description.

* Would you like to integrate a wording approach like the following?

  A search can be performed for SmPL scripts within a directory hierarchy.
  Start a corresponding file determination if the environment variable =E2=
=80=9CCOCCI=E2=80=9D
  contains an acceptable path.


Regards,
Markus
