Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC77C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447652184B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="I2gwE73m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfE3UrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:47:23 -0400
Received: from ionic.de ([87.98.244.45]:53091 "EHLO mail.ionic.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfE3UrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:47:22 -0400
Received: from [10.30.16.13] (178.162.222.41.adsl.inet-telecom.org [178.162.222.41])
        by mail.ionic.de (Postfix) with ESMTPSA id 840C84F001AB;
        Thu, 30 May 2019 20:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ionic.de; s=default;
        t=1559249238; bh=DJ/Qrw+jGl9dFLovI8Le1qoBnis8G8pL7CzfNmgKuug=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=I2gwE73mb4RjY1AJ+woe8B/xNyKFNY13N7JGFnk4mLBHq+P3ZhcM2Nym6HNDOzcLZ
         ICotAggtgNkz3zbe1Z8waNYa/s4BKjN8n9EG3ZqvDrW6rMSVzezWRg6zuSEMF6rkwG
         kr4CrokkfVXkCVH4N3rFHiaMQoN0JAEXCeYaQKv4=
From:   Mihai Moldovan <ionic@ionic.de>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ying Xue <ying.xue@windriver.com>
References: <4ad776cb-c597-da1d-7d5e-af39ded17c40@ionic.de>
 <CH2PR15MB3575BD29C90539022364B8719A180@CH2PR15MB3575.namprd15.prod.outlook.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ionic@ionic.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: Userspace woes with 5.1.5 due to TIPC
Message-ID: <1780dd6a-9546-0df5-7fb2-44b78643b079@ionic.de>
Date:   Thu, 30 May 2019 22:47:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CH2PR15MB3575BD29C90539022364B8719A180@CH2PR15MB3575.namprd15.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zyLlXX8SlJ8AH1FiTisb3lYuLdlFGZsxs"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zyLlXX8SlJ8AH1FiTisb3lYuLdlFGZsxs
Content-Type: multipart/mixed; boundary="TRssMDNyKLF4ADjzvz6JU03XVypUOr7Tp";
 protected-headers="v1"
From: Mihai Moldovan <ionic@ionic.de>
To: Jon Maloy <jon.maloy@ericsson.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Ying Xue <ying.xue@windriver.com>
Message-ID: <1780dd6a-9546-0df5-7fb2-44b78643b079@ionic.de>
Subject: Re: Userspace woes with 5.1.5 due to TIPC
References: <4ad776cb-c597-da1d-7d5e-af39ded17c40@ionic.de>
 <CH2PR15MB3575BD29C90539022364B8719A180@CH2PR15MB3575.namprd15.prod.outlook.com>
In-Reply-To: <CH2PR15MB3575BD29C90539022364B8719A180@CH2PR15MB3575.namprd15.prod.outlook.com>

--TRssMDNyKLF4ADjzvz6JU03XVypUOr7Tp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

* On 5/30/19 9:51 PM, Jon Maloy wrote:
> Make sure the following three commits are present in TIPC *after* the o=
ffending commit:
>=20
> commit 532b0f7ece4c "tipc: fix modprobe tipc failed after switch order =
of device registration"

This *is* the offending commit, as far as I understand. Merely rebased in=

linux-stable, and hence having a different SHA, but mentioning the origin=
al SHA
(i.e., 532b0f7ece4c) in its commit message.


> Since that patch one was flawed it had to be reverted:
> commit 5593530e5694  ""Revert tipc: fix modprobe tipc failed after swit=
ch order of device registration"
>=20
> It was then replaced with this one:=20
> commit 526f5b851a96 "tipc: fix modprobe tipc failed after switch order =
of device registration"

Okay, these two are not part of 5.1.5. I've backported them (and only the=
se two)
to 5.1.5 and the issue(s) seem to be gone. Definitely something that shou=
ld be
backported to/included in 5.1.6.


Thanks for pointing all that out! Unfortunately I didn't add anything use=
ful but
noise, since you obviously already knew, that this commit was broken. I'd=
 urge
Greg to release a new stable version including the fixes soon, if possibl=
e,
though, for not being able to start/use userspace browsers sounds like a =
pretty
bad regression to me.



Mihai


--TRssMDNyKLF4ADjzvz6JU03XVypUOr7Tp--

--zyLlXX8SlJ8AH1FiTisb3lYuLdlFGZsxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Using GnuPG with Thunderbird - https://www.enigmail.net/

iQIzBAEBCgAdFiEEbhHQj3UzgcdE8cg8H9Yu2W4lOocFAlzwQVUACgkQH9Yu2W4l
OodLRA//RLcEzuCZDRNZ52081FRJVHdPp+yNs3orS7lHIE8xKjq47GExuv5TgL7h
+9pdlQnJjz6XZr3vgyNVBqQiuAgxEUwGB0eTnPJpHq23e5QjQTzsC+CcyJr7Qqgw
Xwxr2/qyk7rWho50h65svzPYjKf7EeHA3mR/oIWvP8W+1+R8e+ulQXP0rhfIYVQn
IM1bPadLryS9WGo2/fT5tNGq2+AFCzp41AM+DlIWRGwBu3hGgZpiGZCzEeMk6tkt
jkunZ0dnqMUjONDrpW2+vFlmbUCTJ2+qZCNbpFCurYNuY8HsnBMqTTX7ucaL7afY
1ZGF79OC2lLsitbCtU5nMNK3FwkzIod3wMbCfzmDGFF0FyN4IliJ0JyUzbu2Nbc5
vEytKkwQAii3Y2AtA6WUdoCKdgr2oQjXaQD89em5aKi+ZW9zbz8ZiJFJG4ktCrjx
RgE2UZ34IvJChDsHqbj8PONjeFxHA6qExsjBZUJJ2/rSxipD4sVgU66r21Bk8uuH
l7we7hZvlt2i5OXa8dSLuhAta3PUmjOC+IZaiX82fXJ8GUVZl0LNeUcFylKg+K7f
1BbGaQxnDlkaCD3k5Q/Z7nZcG32s+qjiVy4BVOUtRoX0fwrAHd9md/G1ZZeIoBjE
XllKg3/WzmUX6a50PDxjUQyh4ir/yCqa5PmemcpFX0eNN5e62y8=
=BcLY
-----END PGP SIGNATURE-----

--zyLlXX8SlJ8AH1FiTisb3lYuLdlFGZsxs--
