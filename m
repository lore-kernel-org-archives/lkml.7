Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50032C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1750A2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RPrlWsA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfDXHG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:06:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:37885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbfDXHG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556089597;
        bh=5Pcg3miEY8cRIVR/oWWvd176fLBS1+up6CquOR8epnM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RPrlWsA1Ow24YOW3elQyM8BdtwHwFcdO57EJVz7UrX78al0mPtjiE8E/5uSmSm+sc
         f2fyMQh8rtTD/amBmVR6RZzDFG3h5pWLLCE1lmex02AY2MQMtvTq/La9irWx42xN7N
         dX4cJUAMQS3QzmhX3SXiS2RogJHtc+8qH/bfg1Cw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([185.220.102.7]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpgew-1gqCUN1X4Y-00fVfe; Wed, 24
 Apr 2019 09:06:37 +0200
Subject: Re: [PATCH v4] tpm: fix an invalid condition in tpm_common_poll
To:     Sasha Levin <sashal@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Tadeusz Struk <tadeusz.struk@intel.com>, grawity@gmail.com,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <155371155820.17863.10580533125620125669.stgit@tstruk-mobl1.jf.intel.com>
 <20190328123428.GF7094@linux.intel.com>
 <b29aaf62-2ea0-d6c6-32ee-44bc3fe8f03f@intel.com>
 <20190408120138.GA951@gandi.net> <20190409134421.GD9759@linux.intel.com>
 <e9cfa3db-42d7-4e1c-a371-2c810f911dab@gmx.de>
 <20190424004326.GX17719@sasha-vm>
From:   Jonas Witschel <diabonas@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=diabonas@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67b3e631-f31f-f5dc-f468-09f8c3afa9f3@gmx.de>
Date:   Wed, 24 Apr 2019 09:06:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424004326.GX17719@sasha-vm>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ESv7J03fyXARGVeYSSGHx5LASL0ZUEm5e"
X-Provags-ID: V03:K1:kPeaAlv1NxB7kO5pUCYbrDgtaetLnbcuMs3PGNGZ16c/5Loherr
 MfwFm0DA9NDI4DIMSQZAFYllX0xXbjvcUYzmaggSXv4v/fWo476W4mkXfIHzFOQ4Cf2ffix
 7UzHVAY25678xcM+fwv5PCZMw5K70CAgoibIBCn2NxEdIBCXGMazE/znfXGdwCzUhdTAd5O
 tIV9RWYoRjM9+nJ/qT8nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iOjj2GUi9Lk=:6kKnEQLXV4uGTdN9gN9WDB
 MkOvMAcXmYfG/Ar2VVGYi/GF/CZQyvaEnr2lypjWhunpgrs51xFL7xI6ha5NeO8XM/q/m5FqI
 6k0KGQdW2Z2Wdr6ZBWvnd+SELU43kBjtc4VMfd3/MqsO7LiSG8Mx4UDPV7Zcty5zxkUyNLhjL
 hPRegWQvYeJwXkz4eoeHasDuJ5Y7Z+XVtBu6W0wY6EHR7u59pSfMeeLfAgJenT3KA1vgYUT2A
 gFLZ/cOPHp4xTrp8KNhbTbwlJm4F4xng/sio7h5uWGN5jt98iSSLIfRSCoFTxQWm1KuzpkNkJ
 SN9wx16zdCgQUA7UJS4IM5clN0QWsp6OjgOqZPpOYSi+1hOa8Q4XVflgs0IKCY1yioFR1r2cT
 ZOYNaOYA8YT4uq3w/UmHfyeHTWW8AMJ2+DP4LGGuoJjJkYPEn58Q3T95ggm1EAjZ3hbGByMNp
 ZUJumC6vZiah9iDgqxnh2uqYPTdNrBcGvVgqdjamOBAdDUZHqjES+OJGkp5u98triQe3EoYFe
 x+Xo/bu8STqLPx/zBwgJIISe1hwSPD9RvVI0MT9wPzl/GuNI0iKIiwL8fx6fsV3B6GN3bhow0
 rv1cCQyeUszyUm7w6LxjmtvbsU2ABlWM6CJKgXiUw1Dh84BX/58jzWYOfHdFLhT/NNWREaa4a
 6A+8tCOu3IYxycZbgA4LPNi4VHRtebQGZ8mixS6ZJe1rRhEpSjPN143i6WbafuK071Zb51sUn
 LaBH+Omi59AZ7jf7LvDJXFJQycWAwq+Ts206cmpVLBl2cVHipUwqKpJPiPKDIGT4zE4AGg1gP
 3CyBhlwVaO4p84iVLr6waFbHy1jlVPJfwm0NkKgLE6gGlOZTPLbRUeE1sYmXSln/mGG8pAJ75
 lGHe2KClDG+cwBxPHZbu42UqEKqJ8GsJDXahYLd7BWzozrKkPRvO28QXPABpTc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESv7J03fyXARGVeYSSGHx5LASL0ZUEm5e
Content-Type: multipart/mixed; boundary="SXwie9VQmJPQNVumwk2xmy8xmhu4NJd0b";
 protected-headers="v1"
From: Jonas Witschel <diabonas@gmx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
 Tadeusz Struk <tadeusz.struk@intel.com>, grawity@gmail.com,
 James.Bottomley@hansenpartnership.com, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <67b3e631-f31f-f5dc-f468-09f8c3afa9f3@gmx.de>
Subject: Re: [PATCH v4] tpm: fix an invalid condition in tpm_common_poll
References: <155371155820.17863.10580533125620125669.stgit@tstruk-mobl1.jf.intel.com>
 <20190328123428.GF7094@linux.intel.com>
 <b29aaf62-2ea0-d6c6-32ee-44bc3fe8f03f@intel.com>
 <20190408120138.GA951@gandi.net> <20190409134421.GD9759@linux.intel.com>
 <e9cfa3db-42d7-4e1c-a371-2c810f911dab@gmx.de>
 <20190424004326.GX17719@sasha-vm>
In-Reply-To: <20190424004326.GX17719@sasha-vm>

--SXwie9VQmJPQNVumwk2xmy8xmhu4NJd0b
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: quoted-printable

On 2019-04-24 02:43, Sasha Levin wrote:
> On Tue, Apr 23, 2019 at 10:54:47PM +0200, Jonas Witschel wrote:
>> On 2019-04-09 15:44, Jarkko Sakkinen wrote:
>>> On Mon, Apr 08, 2019 at 02:01:38PM +0200, Thibaut Sautereau wrote:
>>>> [...]
>>>> What's the status of this patch now? It's needed in linux-5.0.y as T=
PM
>>>> 2.0 support is currently broken with those stable kernels without th=
is
>>>> commit.
>>>
>>> part of a PR.
>>>
>>> https://lore.kernel.org/linux-integrity/20190329115544.GA27351@linux.=
intel.com/
>>>
>>
>> It appears that the final version of the patch that was merged to
>> Linus's tree [1] does not include the "Cc: stable@vger.kernel.org" tag=
=2E
>> If I understand correctly, this means that the patch will not be
>> automatically included in the -stable tree without further action. Is
>> there a specific reason not to apply this patch to 5.0.x, or did the t=
ag
>> just get lost in the merge process?
>=20
> Good catch; I see that Jarkko had the same comment on v3 but v4 ended u=
p
> being without the -stable tag without any explanation. I've queued this=

> for 5.0, it doesn't seem relevant for older branches.

Thank you! Correct, the regression only affects 5.0.

Regards,
Jonas


--SXwie9VQmJPQNVumwk2xmy8xmhu4NJd0b--

--ESv7J03fyXARGVeYSSGHx5LASL0ZUEm5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+oqpV8ZJ8iys7pAHlhNtxbvrJkFAlzACvcACgkQHlhNtxbv
rJlxzQ//WJiPvKSLNypC5XSbaRrivvjNbZrCXAumImbb9K4BwA+xPxjKS2sfENvs
gvg7Dfqef16w7xZ59CmaOY1u68tacFzI9pergp1iTicCUWWX//llMOmWHNFJ1B8E
p8aEngeifPYpz50j9nA+MfiTXh/2KIwvJG/JD6RIw7zItz72J/6bQYYdkeZc5XV3
kfgoEQN6uyFZj6hneTjt/OzT3DPn3gD8ZzADYG64HRkPts0eRBKzeYg1y+Gu4Z0e
RUf0uBWUQkb2fPVMl+S3pW+CNb035F1ZJmE61c9KTE384+ueJFzLvR6+ywCt4Z8y
oIHJnJwNKATdivWFKJD7wgLGeSgoy2wBnYfuP3sRGvDgYl+XfvPHUPJ6XcJ6eSyO
XFythGoYSPJtQyLwuHW0WD+fw61WZ9RCQXwWQgzrWTq0x5QJKFg2Oq28K6TGGdOg
fyHH9g5yL5zBy5vKG2LrURlw644tyCBHcAthG6yXcLvYHcMBWZb9AncIpEvq6AR+
SrzuZCNKMZ4YQmldg2+IJclqF0xvIsCW5w7ZNFvdr6fC4ZsVN1z3arOAA2ji/zb0
dmeEtN/aLv9KUGmL2HMYhhzowP5+jQtCTmdcdHTaNpuZPs+Fr0Iy/McXdWQaHjUU
snZiSlztaBCipISGAukOt2ldlw25T+bLz93qdGx3Ay/9yZt/NEw=
=bMxL
-----END PGP SIGNATURE-----

--ESv7J03fyXARGVeYSSGHx5LASL0ZUEm5e--
