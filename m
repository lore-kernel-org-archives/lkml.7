Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1717C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 00:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE70D2342E
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 00:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfHaAnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 20:43:22 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:46622 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728251AbfHaAnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:43:21 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7V0hJqu001563
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 20:43:19 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7V0hE0D016062
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 20:43:19 -0400
Received: by mail-qt1-f197.google.com with SMTP id l22so8952348qtq.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 17:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=XFBHH54+3ZzAcvBGzpCHat8WRpPliDlxuP5sjSOAoEE=;
        b=eyWoVsnGkrxpqN5G4SF6Fy62v9qO8IH+G/2hONdVxnCW6WRvw4+F6yxgCeiT5un4GK
         6L+7CRvo8XIBZXxOsbIq6lk3RpxPpcCxq0E5nM3F9K37GBtINmzJ6KcpBEgA2DsF9LR3
         TYMpYmaZadok352r/KEB8c+Y05m5qNvPXAoOuh8YGmlPJbPCqUl1a1cvH/2uAwSdxso3
         8cOaQF6vXrmhXw8qVo8teTh/O19KYuur6VjX6CHO6m9DPjZfYx1umJRw2GyfBrVb0wZr
         /YtBxgt/yN1oytXc0zm/WoAJzHAtaCG5HJrc7Te8aJPPbPj1AIk386xodX85aUvhghaa
         KaYw==
X-Gm-Message-State: APjAAAUI0idVV+J4wOkOxygp3yHaPc1zOGsc3nhjDnb7um/ZQz8qRD3s
        P/1EDvNwIcJhBvTPe7iEwYqhk3qiOrs2tgRwO0ZPlnlyw+ygJId3o5G2LfsokOkrmE5iyVBLGcl
        kWuN8BGBMu1pGgT/+ZtUesfR42tFrgOxRzvs=
X-Received: by 2002:ae9:e90a:: with SMTP id x10mr18129150qkf.392.1567212194525;
        Fri, 30 Aug 2019 17:43:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEJKukI1TSTm7w80vUWRep4DXRbiZaP5lYn/CK/s4Vokrau1EEUkE6Nbuat3rFOod0XUEznw==
X-Received: by 2002:ae9:e90a:: with SMTP id x10mr18129133qkf.392.1567212194286;
        Fri, 30 Aug 2019 17:43:14 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id n187sm3734502qkc.98.2019.08.30.17.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 17:43:12 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: Tree for Aug 30 (exfat)
In-Reply-To: <8ef40504-ba29-5325-9cb6-0c800a7b03ce@infradead.org>
References: <20190831003613.7540b2d7@canb.auug.org.au>
 <8ef40504-ba29-5325-9cb6-0c800a7b03ce@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567212191_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Aug 2019 20:43:11 -0400
Message-ID: <267483.1567212191@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567212191_4251P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Aug 2019 09:52:15 -0700, Randy Dunlap said:

> on x86_64:
> when CONFIG_VFAT_FS is not set/enabled:
>
> ../drivers/staging/exfat/exfat_super.c:46:41: error: =91CONFIG_FAT_DEFA=
ULT_IOCHARSET=92 undeclared here (not in a function); did you mean =91CON=
FIG_EXFAT_DEFAULT_IOCHARSET=92?

Thanks.  I'll fix this tonight....

--==_Exmh_1567212191_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWnCnwdmEQWDXROgAQIU5w/9FKqubpI3arBOt6EHREOF5sp2IfpJPOww
UWzmjO1MWpYdcVzI8/1fx35oOpA3IMsfSrVuX4v5ctoM6s4P6ut1EKs7O5eTt+UB
2mlhMGupqvpfClS7GMXNYeDaGJ4Br8N69W19+z0A7YHHJYFpHUYNfYwsPsi3tFrn
LTOx486+FHopNDwRdx5cHpriY2AlHMuuu6R8cGzMCzyOV9BWkZecWR33BO2cv4qa
TShEj/tnPqDa4rKePG94bmHExpsHh4l8sI0vPT2Mji4t7zVji0PcdpiEwaRcNCle
IBUVYHdrrSYftj1m2ja1xeXmRXYofTOldoPIZ/6LOkFKalDhC0CN+zyOlDeXuGW2
GgLWqmATH5+Fqsv/2IL0OYRN9zxrbzQYz/kZApYdj09VqzA5u0YyiZTFYxNGPWhp
mOhCCrwOxo0FieehscjqIEA3sYu/OefMqfRWnPdU4+/7D3au2wpMS0sdB7PiBcoD
ry54HxlrWiMCuGQR+jwRm20b4QJz4RPOoYYalID7R3/2jLYpn+zKytHenYMrFT7U
iIyAe5OcTf45e8avSNy8VZk8qLU3HEPbsWKWBeW0kUa9pqQxmaXN8Ld3EVncz5Zl
GOKQqNbZunHN9J8St6KYB2evsd3U1YlE7kz9cU9Ux96RIgEN7RWZBiPlhuhsWwOR
CgEF3NPkIzM=
=dqqB
-----END PGP SIGNATURE-----

--==_Exmh_1567212191_4251P--
