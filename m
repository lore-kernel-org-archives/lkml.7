Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA34C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C0E20659
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="wSBFCeel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKYULg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:11:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43359 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 15:11:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so7883868pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=ARYWqlkS9QHfZESyu1KBrBTXXqzp3nzYRz0JMjZfuDc=;
        b=wSBFCeelLA/gVNaD0m2jrt6AloUF1Ec+3Kq1ak0rzzT+olqIq5hIlkTY0NaASSjSLc
         FujfCAsJcHq5lcaiNFeAnNMaaloYH9PTS9asBeXpP8evFPOl9udVwdy7yc/+BYJ/zqKL
         z5qZK89mnA1SzeJ2OfEzHQsunEKJVjL8NO5OppOT1VoFLBFakb/GBb9lRSDz3ylxu5kt
         Ts7zo7z8xMv5olSIeeb0Bsln77d+ZqwcZ/hbbXXGTQfw5ZmP+MAN9p0CgVRoGd1QURsW
         qD5VzdemO4BEasqGc2+M0HJEHaoBgq0vQre18vyI6YPqdH/lojvREg2iQ6bv5DH96fMc
         87Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=ARYWqlkS9QHfZESyu1KBrBTXXqzp3nzYRz0JMjZfuDc=;
        b=dWGsfVUhnNVo66w5uQLhoc/imzrm/ZHx3F285UamDg+ayUa7xvRHluNkk7z7BXuiEZ
         RGMlU8VgqfNDIrWYl1jNjIeCPShRWZ1WpYtcU9Nvrm2iLZdqRJHCo4CmzlF9pgjj37fv
         H0murOEvNKYy3CLpntaTGZ/BhpVsjbLC+/rsDhkKBlNcLAgzZX7S9z2d/ZkfyI2ANRFF
         iZPkfEsyIF+4RI04CJ93liaINrXlqBOqNU6rTvMf3t42azeqDLkvq1EoBf0vMwHAa+5t
         sMaGD1d59SSvcK5jJxiihROth5H6N75uXmKdvtNvgIV58Dlljk1M0UM4t485HdDboVab
         GDmg==
X-Gm-Message-State: APjAAAXJ7C+o3shIH1/gPDynS33QTjUxrNJYXcaQL6gIVY2TYC/WTWZ6
        TYzAh5DAi3pMyquDBArXdD3dwg==
X-Google-Smtp-Source: APXvYqwNDyR3cGe0rgNGztXiGOxKRK+T2MMJkWz6tPY/v+T/qJgtZdZJYImHD6MDMVXfsTkvCBXZvg==
X-Received: by 2002:a65:47c1:: with SMTP id f1mr33469573pgs.393.1574712693905;
        Mon, 25 Nov 2019 12:11:33 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id v3sm9617299pfi.26.2019.11.25.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 12:11:33 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:11:25 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christian Hesse <list@eworm.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] iproute2 5.4
Message-ID: <20191125121125.3cae8724@hermes.lan>
In-Reply-To: <20191125202111.1bb32360@leda>
References: <20191125081737.2ff4a7ca@hermes.lan>
        <20191125202111.1bb32360@leda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wd7FgAUV4011kp3pA7M.Jkj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wd7FgAUV4011kp3pA7M.Jkj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2019 20:21:11 +0100
Christian Hesse <list@eworm.de> wrote:

> Stephen Hemminger <stephen@networkplumber.org> on Mon, 2019/11/25 08:17:
> > The 5.4 kernel has been released, and the last patches have
> > been applied to iproute2.
> >=20
> > Not a lot of changes in this release, most are related to fixing output
> > formatting and documentation.
> >=20
> > Download:
> >     https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.4.0.=
tar.gz =20
>=20
> The file is not (yet) available. Did you miss to push it to the servers?

Repushed, original transfer failed.

--Sig_/wd7FgAUV4011kp3pA7M.Jkj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAl3cNW0ACgkQgKd/YJXN
5H5lxxAAkqUjT90wDMhnYDr+7XlQU0hqKUtHihqQyZViFD9+dhJ5RanQxP2wD0QC
wgBNpeqGYAq3E3HC3TSPd55BxkEE5FUyzpikon9qDLVXntp8XP+hu/lhdNEKbGGy
9bfGA+WyKD3nYVooW7A2SeX4Lm9NQZz7Gy/UfEe0rDT2zAF75vUP/Btkw0OMgYgu
p63QttAyOfvDmXbmsL64m1FCWnyQmswrEtElagylHa4ZDiuAIkOV4BII52OPtAVd
ZEtnbGQ073e6J+Gxxfa9B1FjaPz0HRs1EqcYM4bXsoiWZTJ6vD49Qk+YczjWe4MX
cWXIB+YweqQTS+HaZ6DCzYaVgaTYqzf/XEuOhgjOMv073He2uHQtSroB61rBssR3
KHnwAgZ125lX+Th9rJdu+OAFyPmxK+rbJhLzDYQ/iWQ4Z6INbuSQkE9rLlt1/tw8
x7/q7v0JU6mQmyTVmS757ejLbK7pa3MwNNEpy1kMMkk0mIziPeU3hJsUDr/7+On7
f0qLi+jC6xOOyyeAYdpDylHJD/BoaADT2Ewkb+0C1CxzIzMBYm2H0nmPyzdWtoV6
TxE0RdsYfvtxDBQS3PBeQ+KTs46q1r6mLKLK6o7+nEna8Wu/MNNlYZCABkJKCtsg
eNoFKjh7WSKMabppB1RRtD+NbjdqnZYlxT+hNjrJOG6JIEO7H2M=
=gLhG
-----END PGP SIGNATURE-----

--Sig_/wd7FgAUV4011kp3pA7M.Jkj--
