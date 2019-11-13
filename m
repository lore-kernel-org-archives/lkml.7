Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDF4C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04442206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKMVzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:55:44 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37970 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726162AbfKMVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:55:44 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xADLtgHN019433
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:55:42 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xADLtbDM008058
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:55:42 -0500
Received: by mail-qt1-f200.google.com with SMTP id k9so2496453qtg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=XsC/VidLuRZwcGmbDKBkNWKXowZ+ydYEVxm1XvF7haE=;
        b=Lujn6y+uwa4etX34TX+s068PtehtxpmXM4PBOFX/0ANyC8QhAQEU5OoD9fv+PvSLss
         p6tnLQ79i352S0u7meL9ZIVAHBZC3jbbwsw4cmoWNGY8LzJUsAe/R7hYFe+O59jIEzAT
         nuv926IbasBa3rQk7Dw2qKkvogCkOYrSsYo2B7by4wFxN9dHZh6/751+E4T8F1s/K+Pi
         zdAUpb761BYiIhmw2Az2GdulwFFOx62cHNtJimsNIsOg3RKbEjrEnxta4wnoepZ/60Ka
         MpNTB/AmF73JvbhvW3ls5ELENqYC4yU+iJiyfJPRKPdhd2FPyLCvN8jI9ep6gQDOwsYf
         /snw==
X-Gm-Message-State: APjAAAXDB3aTFbhUQDl6uJ+3RnVXRxy9BHcl71rUZCjfBjUlzHVsi8RQ
        zBhJCmB4mD23c3Jav87FRLYjF3p27mH+dvLw4kMOjM0pLsoCEG2CLrVRJRnPBijrxVtBxgxmivD
        CyY03HQ+aSIL57sVPacELTELz6b72sMZptqI=
X-Received: by 2002:a05:620a:13e2:: with SMTP id h2mr4790520qkl.114.1573682137391;
        Wed, 13 Nov 2019 13:55:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyou/rkXogkw7xzfJPta8g2dNqXUxD/Ej+zvWx6EZ1jy7Tob9ZSOeF8wtSePKOQ2qmGipj3ug==
X-Received: by 2002:a05:620a:13e2:: with SMTP id h2mr4790492qkl.114.1573682136957;
        Wed, 13 Nov 2019 13:55:36 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm1656524qkd.33.2019.11.13.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:55:35 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        hch@lst.de, sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH 00/13] add the latest exfat driver
In-Reply-To: <69d00c12-7b8a-1d47-0c18-58323f7ca60b@sandeen.net>
References: <CGME20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0@epcas1p2.samsung.com> <20191113081800.7672-1-namjae.jeon@samsung.com>
 <69d00c12-7b8a-1d47-0c18-58323f7ca60b@sandeen.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1573682134_10801P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 16:55:34 -0500
Message-ID: <367298.1573682134@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1573682134_10801P
Content-Type: text/plain; charset=us-ascii

On Wed, 13 Nov 2019 15:00:23 -0600, Eric Sandeen said:
> On 11/13/19 2:17 AM, Namjae Jeon wrote:
> > This adds the latest Samsung exfat driver to fs/exfat. This is an
> > implementation of the Microsoft exFAT specification. Previous versions
> > of this shipped with millions of Android phones, an a random previous
> > snaphot has been merged in drivers/staging/.
> >
> > Compared to the sdfat driver shipped on the phones the following changes
> > have been made:
> >
> >  - the support for vfat has been removed as that is already supported
> >    by fs/fat
> >  - driver has been renamed to exfat
> >  - the code has been refactored and clean up to fully integrate into
> >    the upstream Linux version and follow the Linux coding style
> >  - metadata operations like create, lookup and readdir have been further
> >    optimized
> >  - various major and minor bugs have been fixed
> >
> > We plan to treat this version as the future upstream for the code base
> > once merged, and all new features and bug fixes will go upstream first.
>
> Apologies if I should know this already, but where are the userspace tools
> for exfat located?

The upstream for that is https://github.com/relan/exfat

On Fedora, they're available in the rpmfusion RPM 'exfat-utils', not sure where
Ubuntu or other distros put it.

--==_Exmh_1573682134_10801P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcx71QdmEQWDXROgAQJn5g/+Pa2YnCRrnGNMpsimpV0xnYC/xT+HOXzb
EYdbogYESZubpM5MdLiNjVVrtB6O1STxd1j19tph1BRc9hgaaAgtOaq/lQiYKGFU
2sCbc5AAEiL8s2SB8hnR3Xwp2N4TTk5LRlMfBmP+5SCJ3aKR+S7fqcNHY0rvYD/8
ntq9ZOm4k89NDoUxxRtbZVJsVTbuIZJSZ0kIeODDTTHc+Dbqo0bt7/HLZJQdjJOm
jijF9mrsxb7j1wHABuuEVsb1tzFZFnBpLIKycRym2v+q3cXmK6zrS3XrqHw+VAi3
r62SZZpTfjX7xSGKXTqnzyBKokkVHa9f71sJTYKB4LpkKIKMglODr+JL/onlFkSR
FK6s9G6fPfCctYB8kIZMCwwFl1dQtvdiFswREpdxD0jSgYR/DULmsliStbJbsh9O
JCIytnhHrOs7z3lUT7MyQd1n8XigCLyrJwFfo2lQD6txQZkpYPpCsgbhJhlByAxM
oknWyTeoENEqNjiNk0laa1HKzJewzzhLYt4Np6hjaz56RY6LBdPVwKeJWRK3PeOG
vCEzeUxixwUitfg0D9kRpVMA9dIf1833VRedSNITl5giihOZH/vzo+HYQiIydLHa
5WgtH10LZJNtzT9RqjSV8LijnwEa2QMTkqm06I20cEMneMe2WahULysQD5SwYngt
0wuXp6lfE+Q=
=UaBW
-----END PGP SIGNATURE-----

--==_Exmh_1573682134_10801P--
