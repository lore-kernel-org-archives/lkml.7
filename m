Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF5CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 06:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CDC22468
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 06:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="GXS2mzRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfJSGRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 02:17:22 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:16803 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfJSGRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 02:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1571465837;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=sbcwBRWbNmQCmaGaYkUnDbc4/AISoqZ+XLU5lXo3+NE=;
        b=GXS2mzRgqbNhTN0UBrH0b5d7p1xLC0aezDrUnIwgew84TMcfFoNWQpuHVOkk8gd1ZN
        70N5yATlwP6E+fqmmUKqxlDuHZ4Yw3avbtuVDjPBHX3GvIARF+OQcDCohZIcB9RDmUMs
        Xo4RdC5GUA/7OuIzzVhDnokMPq2WPKVFLJaH1A5w0KyG7Z/AxNR6WmNy/VgjCor4GvjS
        lszFqOUDCVATZP0Su21HxV2ufH7RTtPNRHNWegUMSBOB8jyQVJmMVM0LwDg1jnAw4j6q
        Eat/hO7F1S4Gugz0DSEGH/9ynCzb75zqzIuu9WHMMAslyt5i6MlPJ8DbedvxyYOVhTqW
        aRQg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmAkw4voSw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.28.1 DYNA|AUTH)
        with ESMTPSA id R0b2a8v9J6HGEIa
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 19 Oct 2019 08:17:16 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: ARM: add __always_inline to functions called from __get_user_check()
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAK7LNARFk--KYWNrrduiPgeBAu6T49brJXd_Nb8ZQOfYrbFmAA@mail.gmail.com>
Date:   Sat, 19 Oct 2019 08:17:15 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8798A27C-868A-4845-AF31-C25A38A30EC2@goldelico.com>
References: <1823C41A-3296-4DEA-B71F-5AD548335F8B@goldelico.com> <CAK7LNARFk--KYWNrrduiPgeBAu6T49brJXd_Nb8ZQOfYrbFmAA@mail.gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 19.10.2019 um 03:59 schrieb Masahiro Yamada =
<yamada.masahiro@socionext.com>:
>=20
> On Fri, Oct 18, 2019 at 7:06 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> Hi,
>> I wonder what happened to your patch. We were "hit" by it in v5.4-rc1 =
and
>> after finding, it made our OMAP based device bootable again (using =
our
>> own defconfig which optimizes for SIZE).
>>=20
>> But it does not seem to have arrived in linux-next
>=20
> It is in linux-next.

Ah, now I found it.

It has a "8908/1:" in its title so that search by (full) subject could =
not find it. Thanks!

>=20
>=20
>> and should IMHO
>> be fixed during the v5.4 release candidate cycle.
>=20
> I agree.
>=20
>=20
> Masahiro

BR and thanks,
Nikolaus

