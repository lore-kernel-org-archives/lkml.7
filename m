Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17C7C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A172084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfIJNSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:18:48 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59022 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726188AbfIJNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:18:47 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x8ADIkSi002492
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:18:46 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x8ADIfLS029228
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:18:46 -0400
Received: by mail-qk1-f197.google.com with SMTP id q62so20782646qkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 06:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=7kNO9uDNvugTv3H3koO6iBR61aeWq1IakC0dWAwZ414=;
        b=tYgcPW8BzFtjTHdO5YCU/bidN5ylOXvRKsERqTq2CZy9r66mvh0omD/QmAQ/+7S2Uc
         MQ4AmTPte8eTq9ynbvXcBPAqTfSGs8h1xWMWtXPeJ6GdyczhtlJtes5jJAFTG7eDsB7M
         VW6L34ZOV4XQvdNpw+AQGiEhlT+BC/sb6oiayJ7dp3phIzJX8cryVwO/pa77T+YOfU6l
         O/9meMlXzAbWo/hKM49FCO0rUy38v0imWHO5ipmbVhKyv0tct+IaQTLl2TPummxu+nLy
         uUr307On4DQGnBx2Qrvs1vaMGY+ItKmCB9cPJig110ZXP2SU6ubN88zScUp5IyUMd0/O
         NCPA==
X-Gm-Message-State: APjAAAU0s8aik8VX2Mfn0H613mWnuT69hF663eUe8NanI6qPKIHdx9qy
        uyBuQ9qPfKam1JAIOj4JkIS5JcPI+KSZ+bTKHPcuCCnGd9owfVi5xMjCXTAomTNUePddhvR7mW5
        /4PjvCEvWeojOEod4FMMd1E+Wzdt5z6wnxkk=
X-Received: by 2002:a37:c0f:: with SMTP id 15mr23232181qkm.73.1568121520887;
        Tue, 10 Sep 2019 06:18:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHLmfoD+Kv5Ihhcunz/PPRO8HiNM4sdOJhK03/Lv6eRrYrNyPTStg6jFzCIG8lLRtsiz/hKA==
X-Received: by 2002:a37:c0f:: with SMTP id 15mr23232151qkm.73.1568121520625;
        Tue, 10 Sep 2019 06:18:40 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id g45sm2907548qtc.9.2019.09.10.06.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 06:18:39 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: staging: exfat: issue with FFS_MEDIAERR error return assignment
In-Reply-To: <20190910130934.GE15977@kadam>
References: <c569b04c-2959-c8eb-0d38-628e8c5ff7ac@canonical.com> <20190910124443.GD15977@kadam> <aefa4806-af3c-1757-59c2-72e7d1663d66@canonical.com>
 <20190910130934.GE15977@kadam>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1568121518_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Sep 2019 09:18:38 -0400
Message-ID: <1146681.1568121518@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1568121518_4251P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 Sep 2019 16:09:35 +0300, Dan Carpenter said:
> On Tue, Sep 10, 2019 at 01:58:35PM +0100, Colin Ian King wrote:
> > On 10/09/2019 13:44, Dan Carpenter wrote:
> > > On Fri, Aug 30, 2019 at 07:38:00PM +0100, Colin Ian King wrote:
> > >> Hi,
> > >>
> > >> Static analysis on exfat with Coverity has picked up an assignment of
> > >> FFS_MEDIAERR that gets over-written:
> > >>
> > >>
> > >> 1750        if (is_dir) {
> > >> 1751                if ((fid->dir.dir == p_fs->root_dir) &&
> > >> 1752                    (fid->entry == -1)) {
> > >> 1753                        if (p_fs->dev_ejected)
> > >
> > > Idealy we would have both a filename and a function name but this email
> > > doesn't have either so no one knows what code you are talking about.  :P
> >
> > Oops, my bad.
> >
> > drivers/staging/exfat/exfat_super.c ffsWriteStat()
>
> Yes, your solution is correct.

Actually, you can skip the else, because we initialized 'ret' at the start of the function.

The *bigger* issue - what should 'ret' be if dev_ejected is *false*?

--==_Exmh_1568121518_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXXeirQdmEQWDXROgAQL5wA/+PPHOGEmDV504BFRLn9srgqIa56tfpmot
Ja0n16HXiCIc/z1N2QQ1yTCN1HR387EPagxgMoiIcNV4rlJ8vKFDXzxg8BA4xUKK
8ikDLD0pwq5jR+ghYKYrjHxMs1OClbH0dUvlzra7TOOJpdaPL91MezH4fhJH5Ybj
MPjwNb+MjNLcC5rEYO6BY4TMVuBUES1w4BgQr0cpsvFZWfLoOHs6l8jHyHmnxJ8O
GeE0yMX4THplzc7pWAbyYnm08kXBc4spMcziXRWfJtNtg8JjTYBNC1jYAH41THGO
zf0Bp3n1BtdrIr93000EsmQNrdXTSoogIisJ6tg+5GauE1WbJAUSLuyWwqLKSQk/
gWd7aWO1COCNJS7887iKimSxntiCH4ExjoZigDStvWSMprqCPDefuSefOlkWU53Q
d6TLu3zqicuqiIqp/z9V+kkf3TUMedLHPosvzbhC2WQaHr5MiaBUjDDx8n4zJ+JS
vJyHuWeqFuoGxwdg8viDrPATRJOkgQFPGupGyfVZGQpTxBYu9Ooyl3XgNxtJJIbz
w6OOrrJm9PS9bllSVlEbKHQtiRi8eM2R4gNQQHow5klY6FNIV39dUiQHXwf+OAlp
2GQ63Cv6WLgJakMBRzHcpfpUVayLn2WozSD5TEJx8VsIwqTU2rswLtKpSF47j1hu
y21iQgn12Q8=
=gwNw
-----END PGP SIGNATURE-----

--==_Exmh_1568121518_4251P--
