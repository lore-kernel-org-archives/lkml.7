Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D63ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48310207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437626AbfJPVx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:53:59 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59078 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389156AbfJPVxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:53 -0400
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9GLrplf030290
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 17:53:51 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9GLrkXM020699
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 17:53:51 -0400
Received: by mail-qk1-f199.google.com with SMTP id r17so69841qkm.16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=gqUpgmdxzpasd7pMU+uxnneMl1+ktu9g6I4Qah8EhxI=;
        b=tkVjxlaXzcB52o3yX3IM08eYw1AAzhjHItCiakF6hZ3C2eyF/vlr5Jr7bhDM275CJ0
         4Tv0buZyJCrGxtH332TrwFupss2zxKsnA2UQQX7NqL4qSK//MtcThgdIHVue+ULfXOm5
         D3O2Fnq/EoSZzsazF5nAuWWGiKopONdWc73j0TlGrzcb9H0dMzdHn7I8G5JzrUNmLUtk
         Ljji6hMZ9CZvBQdqJklqVKvu33Rjz2UAIW2Q5fyWnneR+CLnjO9KKYLE/8aDlOj2jwxN
         ntq7IOzOB++aYpcD4EEYU3vKauBaOsl5PjC6Cd9sFJCt1a2ujj4a9VTeWQwoAeZCch3H
         iOYg==
X-Gm-Message-State: APjAAAVDIXPCn/QsXIdLlZEaS++V4vU7bWuoCW8TRase1wI6RtWRMwiv
        zr22fEqFbU6Q19vPXEaUU3zzRHsyom9neI9bz/GFIpbtIumpZitbkLM0g0u6f4ohOJnADdUCky4
        v3KqV08Bgdyb5cSNWGDc7vdR4C8jvDg8VKoE=
X-Received: by 2002:ac8:24d4:: with SMTP id t20mr347284qtt.114.1571262826712;
        Wed, 16 Oct 2019 14:53:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpCWG1Ma5xOzqYk3ZIkraUe0CS6rlGbWN/U3tPDHeSWZQKr532KeiINo5Te24b9bVE4E5nZA==
X-Received: by 2002:ac8:24d4:: with SMTP id t20mr347249qtt.114.1571262826283;
        Wed, 16 Oct 2019 14:53:46 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::9ca])
        by smtp.gmail.com with ESMTPSA id a9sm79794qkb.94.2019.10.16.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 14:53:44 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Sasha Levin <sashal@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20191016203317.GU31224@sasha-vm>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org> <20190829205631.uhz6jdboneej3j3c@pali> <184209.1567120696@turing-police> <20190829233506.GT5281@sasha-vm> <20190830075647.wvhrx4asnkrfkkwk@pali> <20191016140353.4hrncxa5wkx47oau@pali> <20191016143113.GS31224@sasha-vm> <20191016160349.pwghlg566hh2o7id@pali>
 <20191016203317.GU31224@sasha-vm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571262823_33600P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Oct 2019 17:53:43 -0400
Message-ID: <207853.1571262823@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1571262823_33600P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2019 16:33:17 -0400, Sasha Levin said:

> It looks like the reason this wasn't made public along with the exFAT
> spec is that TexFAT is pretty much dead - it's old, there are no users
> we are aware of, and digging it out of it's grave to make it public is
> actually quite the headache.

Ahh.. For some reason I had convinced myself that base exfat implementati=
ons
used at least the 'keep a backup FAT' part of TexFAT, because on a teraby=
te
external USB drive, losing the FAT would be painful.  But if Windows 10 d=
oesn't
do that either, then it's no great sin for Linux to not do it (and may ca=
use
problems if Linux says =22currently using FAT 2=22, and the disk is next =
used on a
Windows 10 box that only looks at FAT 1....)


--==_Exmh_1571262823_33600P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXaeRZgdmEQWDXROgAQJPCA//crwtbuFdEHDJcuk9rjqzuC30MRUzo20V
1S7m1bIEl21fh/qg/JhUagKwHZxImRyN3u5Jy+J5iiq3zpQzAIGxRhqYX3e+6ykB
b+/DlAUjv0S8YNpqDpqsYaafnCOsc0omfbYNPfxFGZWOyJWdsP+II3DsxUGTKyui
TaQXR9s0ErjATdZ0kWr72Ap5HcrQ4ixI+poANMobYyq/k9Pjw50oyGCvJR2ErZSw
B9Sm246KwHBFzwSDXrxbLggNx5+uE0B7/nvMPYzSrBBeqmvDxTcOSAygfwQSK0UT
FvLmHIJiGkYHpFIY7zwa0Fs55nexKj4Rz+Uy8e05aohAOBGOTV9QxkcCSJhIf/Zw
h9KZ2tyMcsXsDOh/0lGR8DCGxCE6sqo3KK7kuxPnAzNTbh9wli98tX3sQacr0E4D
HhUYTGfeOaP12qa3ije8SZRo1yqdxs3KIyQtRhNWWZaIYL84BtFo8G4d1RSts/AH
t+rkhtsmEytHdFY32qYMkD2NSCU3FOaM90Zz/zWBr5rMIhiw1WIySVH6P1ZOr1U6
C1+TtuMeV9g1SS80ik35GX4h5wYeEWXr/vrBD8mw2HSfj78lin2d0aLAxnaHEc+H
wmfB72ECZ9Mq6SKblhcvRqhpNBHsX7WiLj1hVE8HSxufaEfT0A3Iz1Y8+oQKbX7I
8etTqEg46ZI=
=oSaw
-----END PGP SIGNATURE-----

--==_Exmh_1571262823_33600P--
