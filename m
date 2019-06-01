Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76827C04AB6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 02:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3795925841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 02:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QbCkLEA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfFACCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 22:02:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:47359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfFACCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 22:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559354552;
        bh=XZNh8PrGgmF3y2pjWQbVYuQtQJgoz62KYsyOPS1YvSs=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=QbCkLEA6QyGvZp4mec1kILiWpQMwoDlXGZ+Gro8DopdNKf07lNxPqyhu6G37gDhay
         YhD3vgpoVGdL+i2apVDzijM8n9h0spDpmYNNpbKd+6N9UflA3aFVgbQd5P4lgic1xP
         et8nFlrrR3lLzr/GrMfDx2p9Fs6g0SWy1JmYM5mI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MN0jA-1hUfMN0alc-006iyq for
 <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 04:02:32 +0200
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: [5.2-rc REGRESSION] Random gcc crash for 'make -j12' when low on
 memory
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <33122d28-b85c-6d75-07c7-dfbdc6e101fb@gmx.com>
Date:   Sat, 1 Jun 2019 10:02:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YMFgnb5ARuqf2F3RYsiwdx6hW0sZItfNG"
X-Provags-ID: V03:K1:RqwCj4sicdehsM8bZHdV1zXJ3wtRfB2RR5Qud02E5dYqEb/lD0Z
 dhbrGhNev1QI3g0vb1O3YkbdYyhsF+DkkAglAQKtIshGSsYLlolkbfEhteAj9gBvc9XNqOS
 XgjH776rJ/HvqdgSj7KXTGjzShCG4pesnMx4li2q3c4MXq0gG2dpK6FhHnpVHMJu52QZNFD
 ABYn2T8tdoPH1AHUG6zGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hTK5ryLbrfY=:duXp6UxUdSdHBcKx0iLCaY
 fSnTYGyP8lHWTxke5cNMcE9O5PCtQAX0SqnTr/oNHZXAdoVniSBVSGczUhfkLWpxlKiRBj5i5
 m/6aUyax73wV4LoRtKOccqG63KPJ5Jpf0OJUFFH4YkAnP/89s6TLNNmg/VTdGqN1RVR9LpyQ7
 ILH/9X0wiygnq0PzNOkrgqoYcGkretUWfsP0KAxplzMYpI363kNcSiOw2TZ7gAd6kw6kogD2V
 3VVVv3aPMVhOUAsdQ6R+M1uTHMlkwcMr79pIDefHfHNRNLhzKdIfKhBLDYaXAf8JSOxfcRkTx
 UX2ELkLagYXq5htv7tT/iUR9TP8qZIxTRmnlCeYc5omZiBC+G2DUtu72v47g2OCmzlL+Gei/W
 TNdXHp93VGyxHwUm9KSCpGFtC5Mu9wFpq9Cbpqe+Wg1Dwut8eubVCdzn1yFvW/xbJzCXuJDnW
 1w4FfePFVcBfkiCb/Fv40pY3+SH3oKmhG3mLv/VYBX9DxC3UjlvSD7Hj/Lly7uH/4M3h4j48P
 lm340P+6RsNJCGFvcAQyG0/mjazsvc6ZTIwkwC6PXWhsci0b3Hnl/pZIy3HCBKH6+qa5GeDsl
 t+AhpP4h8RzN0uEmiuI6mQPr99eN4/Jq7Rhffju9SPWm3i0UKVtOEFHfJyYgG0zwdB+IT4qkW
 o1/h7tjjALOITP/j9Npj3w1i95c2p0DXsoECUGm/FWXZyKgRJyYt75QYK2NBAx80j7GT4tlA6
 /CnE9ZUruOEtRWCXW3lmSJuKCi914b/bXiotXw7ENTcDXlNmWG+v7X1efAzoWYkJevmIJAAAa
 c+6rUe8MioUsKliPDBx/JANXm6V9xFViW+dQK6ojmLINJPRmr6LWNOovfNmUO3mIYguwL9dit
 oapscdF1ZX9IP3UEwv6seIVU4W9KnrndTlIIXr4kLS5b6ARHwOoExdhDl8thobctAqgsRMkh/
 MxrXMhdYSj4QlFVJy2e/YUFKeYuELnkg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YMFgnb5ARuqf2F3RYsiwdx6hW0sZItfNG
Content-Type: multipart/mixed; boundary="knlOWPXv7MhPiirMqex0qGrXgdbiOMFq2";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <33122d28-b85c-6d75-07c7-dfbdc6e101fb@gmx.com>
Subject: [5.2-rc REGRESSION] Random gcc crash for 'make -j12' when low on
 memory

--knlOWPXv7MhPiirMqex0qGrXgdbiOMFq2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

When compiling the kernel on v5.2-rc (both rc1 and rc2) with "make
-j12", the gcc will randomly crash with segfault, while on v5.1-rc7
everything is OK.

The crash only happens when the VM has only 1G ram, when given 4G ram it
no longer crash.
However according to dmesg, there is no OOM triggered.

Thus this looks like a regression.

The environment is:
VM hypervisor: KVM
vCPU: 8
vRAM: 1G (crash) 4G (OK)
Distro: Archlinux
Tried kernel: Upstream v5.1-rc7 (good), v5.2-rc1 (fail), v5.2-rc2(fail)

Host CPU: Ryzen 1700 (no gcc crash on host)

Is there something related to OOM changed?

Thanks,
Qu



--knlOWPXv7MhPiirMqex0qGrXgdbiOMFq2--

--YMFgnb5ARuqf2F3RYsiwdx6hW0sZItfNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzx3LMACgkQwj2R86El
/qhI1Qf+Po0MPMh19esypYEV8K8hzL3PJuEjAtYaAbsAB69D59QXiiX0SaY+9OsY
kycZlQTO0BgtJobVR+01sLthGhfLbDrcevuF563nwA4SMsKspbPKpo+RXS14T0Jd
UwUW+EnrOb06/NH3aUe2itxQwuVLCNE4XXz3MfPY1X8yK3C/+IPEXEG1re1eUXhQ
JIZasu9UvBYZGtm4hT4yeSg4MwzDK5o8QG0+CIxmvMZd0ir0jheMkgRJlA0p8zN3
fbdyAZN5w5HPUIvhRpDIZudaTSwBFlwtyIgq2xY3JqeFkq4t2jpQ37/HxQjJrp/p
ps5cf8ssAUhTxxl42UTMSk6wtwTYNA==
=WBCX
-----END PGP SIGNATURE-----

--YMFgnb5ARuqf2F3RYsiwdx6hW0sZItfNG--
