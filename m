Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D0C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71963206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iLTj9CW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFQOO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:14:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45142 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:14:28 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so21369475ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JohzNFDqmktDG38rF4I6wEqhVEhI+kZN53amqkDtO9w=;
        b=iLTj9CW1lG44z6zG4g72qDio7OVGQ1qANRuf1odp+rHFRdGUwpC/crqtmZviZTJjha
         UtbuW0PlSUt3tPiVOOOGTLydHXo9gGuO4n6AjAd9Ui2JaV31NFPjV2LvjHM7Lc94hAj3
         2NoQNsPbAu20BCZqt728HIJTa2HSnRFbDzZ5I8vHPDybVf1pkrTRlkIQTt7rthVHXrAM
         lHS78Ey4P/EiXWCuhSzCFdoxrAgtO7jORwoA76aPcjYfK1cFsylabCMWL2k6C+IUbYR4
         GFg6aCzi53pHsNhbAN3fRtSC15Up6LfUVSf/tWR82B4diNQ+xrqBZiH+dX91u+09QU+k
         cDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JohzNFDqmktDG38rF4I6wEqhVEhI+kZN53amqkDtO9w=;
        b=ck1o2VbyJskBr1wDeJhqaWNMJEyMJ8hGQMVxGxnX6xMDBTP9o7fFPzBXZ/IxFKNhzK
         3Rhfma/2Wg6/2wpvUCHJlTdX64kSABtvHSxcEbr40rXuq+bak3VxzLRdnyQV0+4mBDIX
         vKUAwuRksTIPVa6ba4CP0mKmCDrNe1G9+9KPsnHPIPK9WIXjRcRLS7uwzyCOcfJmsEXZ
         F50qtBxEUrwMDqBzBJr+JmK60JIc/Qzx/xBK8y7x8PWCvC+Yyx69al9ikkH59nGtGd6H
         VVAs/d5QzjCZye7Dw09xk4L6lJkc+8SIp8lyutqvCZ0D53v3rLYneS12qkxH89HAzgQk
         MGLA==
X-Gm-Message-State: APjAAAUOCk/I1YMBQ/qr/qZawH+Pt5ebBHbYKtxcV+VRQY+xeaTxQuv2
        q3KOC4FT8P4QShC68gZO0K5ZuA==
X-Google-Smtp-Source: APXvYqzNuUBfwfuXW1mSryelHWlKsBM9fYoJ3JGS5e7VGKacU4dkepDULY1G4gM/fW95GIKtGZpt+Q==
X-Received: by 2002:a6b:fb02:: with SMTP id h2mr14476535iog.289.1560780867625;
        Mon, 17 Jun 2019 07:14:27 -0700 (PDT)
Received: from [192.168.1.196] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id c2sm8811901iok.53.2019.06.17.07.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 07:14:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906170419010.19994@viisi.sifive.com>
Date:   Mon, 17 Jun 2019 09:14:25 -0500
Cc:     Andreas Schwab <schwab@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        netdev@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.ferre@microchip.com,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org,
        ynezz@true.cz, linux-riscv@lists.infradead.org,
        davem@davemloft.net, Jim Jacobsen <jamez@wit.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F48A4F7F-0B0D-4191-91AD-DC51686D1E78@sifive.com>
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
 <mvmtvco62k9.fsf@suse.de>
 <alpine.DEB.2.21.9999.1906170252410.19994@viisi.sifive.com>
 <mvmpnnc5y49.fsf@suse.de>
 <alpine.DEB.2.21.9999.1906170305020.19994@viisi.sifive.com>
 <mvmh88o5xi5.fsf@suse.de>
 <alpine.DEB.2.21.9999.1906170419010.19994@viisi.sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 17, 2019, at 6:34 AM, Paul Walmsley <paul.walmsley@sifive.com> =
wrote:
>=20
> On Mon, 17 Jun 2019, Andreas Schwab wrote:
>=20
>> On Jun 17 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>>=20
>>> On Mon, 17 Jun 2019, Andreas Schwab wrote:
>>>=20
>>>> On Jun 17 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>>>>=20
>>>>> Looks to me that it shouldn't have an impact unless the DT string =
is=20
>>>>> present, and even then, the impact might simply be that the MACB =
driver=20
>>>>> may not work?
>>>>=20
>>>> If the macb driver doesn't work you have an unusable system, of =
course.
>>>=20
>>> Why?
>>=20
>> Because a system is useless without network.
>=20
> =46rom an upstream Linux point of view, Yash's patches should be an=20
> improvement over the current mainline kernel situation, since there's=20=

> currently no upstream support for the (SiFive-specific) TX clock =
switch=20
> register.  With the right DT data, and a bootloader that handles the =
PHY=20
> reset, I think networking should work after his patches are upstream =
--=20
> although I myself haven't tried this yet.
>=20

Have we documented this tx clock switch register in something with a
direct URL link (rather than a PDF)?

I=E2=80=99d like to update freedom-u-sdk (or yocto) to create bootable =
images
with a working U-boot (upstream or not, I don=E2=80=99t care, as long as =
it works),
and what I have right now is the old legacy HiFive U-boot[1] and a 4.19
kernel with a bunch of extra patches.

The legacy M-mode U-boot handles the phy reset already, and I=E2=80=99ve =
been
able to load upstream S-mode uboot as a payload via TFTP, and then=20
load and boot a 4.19 kernel.=20

It would be nice to get this all working with 5.x, however there are =
still
several missing pieces to really have it work well.


[1] https://github.com/sifive/HiFive_U-Boot=
