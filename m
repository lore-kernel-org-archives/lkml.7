Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEBBCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1E32190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfKCSSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 13:18:23 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49158 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727416AbfKCSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:18:22 -0500
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA3IILX2022384
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 13:18:21 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA3IIGpU016743
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 13:18:21 -0500
Received: by mail-qt1-f198.google.com with SMTP id u26so16570843qtq.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 10:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=8AL38a6nJyPHeAwNYJ+gkCOByLjMLoSRsdy7tEC6FCE=;
        b=kqiL3iNmUf4NBX/pBxtDPIojZQHdGkrSRLRIHb9AZKoVCmseR1g27z2KCY63yVvfu+
         atSKXtZAAMz9yojKHSgAyY2gvi4DKNit+TQ6Y2RAKSyjVCG9AIpDki5jjN32RG3USA4q
         4j6SxK7Y5/GD02/c8VVTBOty0MbKYc2DOuPG2r37iPnyUzirxb3uekzDQIrERcftKaWC
         grr1C8qz8X8aBOuT6IqqTtEI8HrC8DLm1adtpCaAyr346qGululG5Ac1yGXDTKAK6SSx
         eF8wRiW0+7VUTtJNG7cnZjjq0i1daHuiGTceyfqgw7XagcJBsYyL2RxsQsgtHRo8J84J
         OeZQ==
X-Gm-Message-State: APjAAAWQLatB6TPsm/M922G6fPh8t0y0vBsF9AVrPkZuPDBCJJcUsTa/
        a2lCj1Z0VV976VInEHzwDh8dlXsUah5KswEY2vBb64EcbPLNLxCq/mHhO+ft/KDyO8TI5fSTzWN
        joTxTpqdp2wInP9DEYAAuDAwU5uF49/ldW6s=
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr18657930qkk.272.1572805096129;
        Sun, 03 Nov 2019 10:18:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWIVZQygxI+LqAGuqaC257K40MqFYJhgfKKk5CXE1n6FnJe1jlYbqDk0H+uuG2EfmkbFSLNg==
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr18657905qkk.272.1572805095791;
        Sun, 03 Nov 2019 10:18:15 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id k6sm7132441qkd.38.2019.11.03.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 10:18:14 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat: Ensure we unlock upon error in ffsReadFile
In-Reply-To: <20191103180921.2844-1-dave@stgolabs.net>
References: <20191103180921.2844-1-dave@stgolabs.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572805092_14215P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 03 Nov 2019 13:18:13 -0500
Message-ID: <75389.1572805093@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1572805092_14215P
Content-Type: text/plain; charset=us-ascii

On Sun, 03 Nov 2019 10:09:21 -0800, Davidlohr Bueso said:
> The call was not releasing the mutex upon error.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Yeah, I missed one, thanks for catching it.

Acked-By: Valdis Kletnieks <valdis.kletnieks@vt.edu>



--==_Exmh_1572805092_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXb8Z5AdmEQWDXROgAQISBRAAiqmrcDXoatDlP1f/a/hg4uMYPPws/2jP
WCcaCQMvYa0x7XsEKjgS7pOha+huqXpuC2CsjMqlFQV26BOSIdtMCnF2qit99VOh
hbE0JmtGQXXfHrNA+3Flmm1ghrB1p+BppzDHs0eEYBweq2NIoblqDewbNFKHX0Sy
dxNlXn2VRDazGTfpZBPpgujfQGaZhxVjbcQXaKFh2Kw5Kr4rNQw7JwZKbMxkLUxu
beAYrAWn63NcNG7RtzH3pO5idnj6zUTUEaiG+zxj+jyCF0yzLVZAzVtbma54NXKu
TklaXalDfHFPsVf6Y/0gNiNVpxlwF1nBe22kgB0JxWalrgfGfKb85hkiOJPvFt+S
5WFh/OOXyVrLgH+H2YsKu9vq0BgqWz9UTMIFa0r7zbuBDrJE9P80lfZOJIK37uI3
+jFz+OBL3RLL6CP6rVUYVcm9n1jReY6ER5lq7n2+O1/ZFVat+Pa3Av8v+ZXVfQ/2
idATpuFgCpiW4Tsmr0pU7eVkhL0NULwNeM+MEVP6lbznWbanc8eR6n4R87Ga9sPg
hJ5ML0LLyy0OTOSWPnODCSVX4OWdZVOMIMkGYnW7gVUpeWI1kBAJxHab5eZes4y2
hs0S0wmQIMDZd4T2V46oLd6fKfPRa34t2KFu6GzvgY/foZLvv1xiNyWSKGsoA7WJ
Fy7PC4XRnl4=
=zLym
-----END PGP SIGNATURE-----

--==_Exmh_1572805092_14215P--
