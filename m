Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1CFC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1412187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfFSQ05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:26:57 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59124 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725899AbfFSQ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:26:57 -0400
Received: from mr1.cc.vt.edu (mr1.cc.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x5JGQtkm027146
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:26:55 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x5JGQowa009382
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:26:55 -0400
Received: by mail-qt1-f197.google.com with SMTP id r57so16436586qtj.21
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 09:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=zf8D4/iHtP2cQ9qCWTeKz8g4gkGxClanrDvSj3UhfAg=;
        b=H4PuRQ8o9cL4YQCSBRRLh2sgQG/ea7f5zWehcG8Hb6nHf3TUVSBLUhgwipNSfFrcWy
         LRtwaCx733RbH0ZqxcQFU7BY8DJRT+hz17ZHFYfm2rPSxlfHzmn3+UziWa+edlH1zwnK
         5XwadJ8ncF9RgA3PZgdMc6BcKvGw7MeTbY++CODj934uGLKFQ+HyDVF4K712IlbT4TWX
         5ZFwGQFRexPFCkwYE2hAPQuaV4Db8nLAHOo532qsNzTad5QMGjNs80DmFvJQldvfcsd2
         mTf5xDH30k1LBdN6i3LM7whzKj1q6mvcExRfTfWde8ha29b3NCTLlrSGyJpUC0iEgnD1
         cQNg==
X-Gm-Message-State: APjAAAXGCZUiG7Kp83JGktFeQU8tUXW9/ppcjRkbpBlrwLKddzjosskL
        dgKjWT1S0c7YcQ8koAfLdqqM2BaFAChRjLTKYaGQB9aHWDsR7tX/YMRcR8XKhVIbbG3b5t7B+HE
        AYbT7/+bB2J8QqWVU/edfIyyy6sridl15qDk=
X-Received: by 2002:a37:90c2:: with SMTP id s185mr51576926qkd.161.1560961610377;
        Wed, 19 Jun 2019 09:26:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxH3bOZGy53aUzHFJaZeZ0VPGLDh7ReM6TxRcU6oSO7jcWufcggfBfs/wqUKe//XAKCkkKV1w==
X-Received: by 2002:a37:90c2:: with SMTP id s185mr51576904qkd.161.1560961610129;
        Wed, 19 Jun 2019 09:26:50 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id z126sm11285820qkb.7.2019.06.19.09.26.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 09:26:48 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Fabio Estevam <festevam@gmail.com>,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: [IMX] [DRM]: suspend/resume support
In-Reply-To: <CAOuPNLgYN3FDvNsaWqom45h7aFz=HczDdL-QoHOc_Sreqf8T2g@mail.gmail.com>
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com> <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com> <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com> <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com> <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com> <20190619150406.GB19346@kroah.com>
 <CAOuPNLgYN3FDvNsaWqom45h7aFz=HczDdL-QoHOc_Sreqf8T2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1560961607_1605P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Jun 2019 12:26:47 -0400
Message-ID: <22247.1560961607@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1560961607_1605P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jun 2019 20:47:34 +0530, Pintu Agarwal said:

> No I mean to say, there are lots of features and customization already
> done on this version and stabilized.
> Upgrading again may require months of effort.

This is what happens when you don't upstream your local changes.

And no, saying "But we're a small company and nobody cares" isn't an
excuse - Linux carried the entire Voyager architecture around for several years
for 2 machines. Not two models, 2 physical machines, the last 2 operational
systems of the product line.

(Not the Xubuntu-based Voyage distribution either - the Voyager was a mid-80s
SMP fault-tolerant system from NCR with up to 32 486/586 cores and 4G of
memory, which was a honking big system for the day...)

https://kernel.googlesource.com/pub/scm/linux/kernel/git/rzhang/linux/+/v2.6.20-rc1/Documentation/voyager.txt

The architecture was finally dropped in 2009 when enough hardware failures
had happened that James Bottomley was unable to create a bootable
system from the parts from both...

So if your production run is several thousand systems, that's *plenty* big
enough for patches and drivers (especially since drivers for hardware you
included in your several-thousand system run are also likely applicable to
a half dozen other vendors who made several thousand systems using the
same chipset....

--==_Exmh_1560961607_1605P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXQpiRgdmEQWDXROgAQLgiQ//UFBElVIVrz2j6hgbDsxrSxbNiWZ78XOp
zPJi/jWSZmMEt4QpNByA1Ll6udI5h7c3MprYyiFm3YCToErjrV24+LgkCNqGzV3g
23AY8/bqTjLnA10eT87df7SOdHkfw5CKH89LCEeq1RqK7UYIAN2CMT0MRaPQriD2
NwoJipNt5YamEDZcZEiVqLWtw2mmLTLEt+kZRg57m9scTrSF96Rg10VFzvA9yi2J
4RUBNmnGNTh/2qXjkIWa126v/jaYrcktuoaMYgUuVQnvZxb8K8VzkawE0yvyVhsV
Xn0B3WpNmg61Z9C23hmjSTw/XCn9a0vVXckDeoWYEI1fQgT1okgMQegHvtcUAniN
Bilmu9+FxVCdus0s4SnjH2jE7dIUXj328ys4imgMidBXxsSMpA6Iht+50/vgxKLV
XOkdffMF7aw3IWiLvsKagEybyq/1VYGnbmAU+h4GrJphs5Qs55J1CDLTGDcrUKqj
QSlr48Bs4fGgqiPYs9G5U7e1KXRJdcn8zhmx2HxvDudAqnXVKonxj9cvFqdxHs83
wWB4Bvp+DCksNVefEXpSXbZddKqmiU51F2lH8WMZ5dxhA/WN+r/oiMRh28gzS0yR
0xVbWJWDnca0Mn+hp0RioICxIljGiEvQTiWK9IrDj8zJpQNPCntCuqmYQ82bj8yB
8YAja57nMkE=
=641k
-----END PGP SIGNATURE-----

--==_Exmh_1560961607_1605P--
