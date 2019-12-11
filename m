Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB5B20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfLKNKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:59324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729475AbfLKNKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:10:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A480B188;
        Wed, 11 Dec 2019 13:10:04 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] drm/shmem: add support for per object caching
 attributes
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org
References: <20191211081810.20079-1-kraxel@redhat.com>
 <20191211081810.20079-2-kraxel@redhat.com>
 <0b64e917-48f7-487e-9335-2838b6c62808@suse.de>
 <ed9142da-ce10-7df2-8a85-ba9ad0c26551@suse.de>
 <20191211123635.GY624164@phenom.ffwll.local>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 mQENBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAG0J1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPokBVAQTAQgAPhYh
 BHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEGgNwR1TC3ojR80H/jH+vYavwQ+TvO8ksXL9JQWc3IFSiGpuSVXLCdg62AmR
 irxW+qCwNncNQyb9rd30gzdectSkPWL3KSqEResBe24IbA5/jSkPweJasgXtfhuyoeCJ6PXo
 clQQGKIoFIAEv1s8l0ggPZswvCinegl1diyJXUXmdEJRTWYAtxn/atut1o6Giv6D2qmYbXN7
 mneMC5MzlLaJKUtoH7U/IjVw1sx2qtxAZGKVm4RZxPnMCp9E1MAr5t4dP5gJCIiqsdrVqI6i
 KupZstMxstPU//azmz7ZWWxT0JzgJqZSvPYx/SATeexTYBP47YFyri4jnsty2ErS91E6H8os
 Bv6pnSn7eAq5AQ0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRH
 UE9eosYbT6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgT
 RjP+qbU63Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+R
 dhgATnWWGKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zb
 ehDda8lvhFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r
 12+lqdsAEQEAAYkBPAQYAQgAJhYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsMBQkD
 wmcAAAoJEGgNwR1TC3ojpfcIAInwP5OlcEKokTnHCiDTz4Ony4GnHRP2fXATQZCKxmu4AJY2
 h9ifw9Nf2TjCZ6AMvC3thAN0rFDj55N9l4s1CpaDo4J+0fkrHuyNacnT206CeJV1E7NYntxU
 n+LSiRrOdywn6erjxRi9EYTVLCHcDhBEjKmFZfg4AM4GZMWX1lg0+eHbd5oL1as28WvvI/uI
 aMyV8RbyXot1r/8QLlWldU3NrTF5p7TMU2y3ZH2mf5suSKHAMtbE4jKJ8ZHFOo3GhLgjVrBW
 HE9JXO08xKkgD+w6v83+nomsEuf6C6LYrqY/tsZvyEX6zN8CtirPdPWu/VXNRYAl/lat7lSI
 3H26qrE=
Message-ID: <7554edf6-ff53-b00f-8abb-dfeb80bfacbe@suse.de>
Date:   Wed, 11 Dec 2019 14:09:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211123635.GY624164@phenom.ffwll.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CBwKnaRxmLU0TFwDIfYhb3p7aGBERXNVD"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CBwKnaRxmLU0TFwDIfYhb3p7aGBERXNVD
Content-Type: multipart/mixed; boundary="ejTXnzi7o17JEhc1I7A6Jfnq27MpLyFWg";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 gurchetansingh@chromium.org
Message-ID: <7554edf6-ff53-b00f-8abb-dfeb80bfacbe@suse.de>
Subject: Re: [PATCH v2 1/2] drm/shmem: add support for per object caching
 attributes
References: <20191211081810.20079-1-kraxel@redhat.com>
 <20191211081810.20079-2-kraxel@redhat.com>
 <0b64e917-48f7-487e-9335-2838b6c62808@suse.de>
 <ed9142da-ce10-7df2-8a85-ba9ad0c26551@suse.de>
 <20191211123635.GY624164@phenom.ffwll.local>
In-Reply-To: <20191211123635.GY624164@phenom.ffwll.local>

--ejTXnzi7o17JEhc1I7A6Jfnq27MpLyFWg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 11.12.19 um 13:36 schrieb Daniel Vetter:
>=20
> The udl use-case should be covered already, simply set the flag correct=
ly
> at create/import time? It's per-object ...

The original udl gem code did this. It was additional state for
something that was detectable from the value of import_attach. So udl
now overrides vmap and mmap.


> btw on why udl does this: Imported bo are usually rendered by real hw, =
and
> reading it uncached/wc is the more defensive setting. It would be kinda=

> nice if dma-buf would expose this, but I fear dma-api maintainers would=

> murder us if we even just propose that ... so it's a mess right now.

Yeah, in some way it's a variation of the discussion around fbdev memory
access that we had before.

Best regards
Thomas

>=20
> btw the issue extends to dma access by devices too, e.g. both i915 and
> amdgpu can select the coherency mode at runtime (using e.g. the pcie
> no-snoop transaction mode), and we have similar uncoordinated hacks in
> there too, like in udl.
> -Daniel
>=20
>>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>> if you prefer to merge v1.
>>
>>>
>>> Best regards
>>> Thomas
>>>
>>>>
>>>
>>
>> --=20
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
>> (HRB 36809, AG N=C3=BCrnberg)
>> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>>
>=20
>=20
>=20
>=20
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--ejTXnzi7o17JEhc1I7A6Jfnq27MpLyFWg--

--CBwKnaRxmLU0TFwDIfYhb3p7aGBERXNVD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl3w6qcACgkQaA3BHVML
eiNU/wf8CyBkP8OlV5JVi0gEs3zbEqTfnaf3lfuufKawUjzGWvwwLDwt0A30yStP
odxnzXWntR3vp7ZYlO8A9ynyXKespM97DwbXVG1Z7jP2NHFCggW5xXtVC7eOSXRN
pF8yAe3q4hf8Cd2Bp7FHRUR+o5dbbT6kVpNrAERFZmIZXOe1UkG1EVDx8w4VbR73
PfCHjbwE3yVOGKCu5cDDRTRQZ9k3RSYKOF3syN6Jt5KsDHgMXOzOpBk4e703MvMd
H39cfCP2fAXrL+TJZHOtixP7IDh3cOL42qQPgjbGm5oxTjr+yilyXb6whtlblnX5
8iGI49gs36/uLOQ43UoCCsfby568pA==
=YDL9
-----END PGP SIGNATURE-----

--CBwKnaRxmLU0TFwDIfYhb3p7aGBERXNVD--
