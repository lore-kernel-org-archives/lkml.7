Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D4C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAF52793A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFBRCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:02:55 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35266 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726830AbfFBRCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:02:54 -0400
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x52H2rkv012471
        for <linux-kernel@vger.kernel.org>; Sun, 2 Jun 2019 13:02:53 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x52H2mxX015435
        for <linux-kernel@vger.kernel.org>; Sun, 2 Jun 2019 13:02:53 -0400
Received: by mail-qk1-f198.google.com with SMTP id u128so12911227qka.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 10:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=dkLtz3qX93mMx92Eb/n3By/2VJ7VfjtWNR7VLhCJQzs=;
        b=eB8wU9YNQrubN1WVYn/eS1XRgswSFXwUPubjsBSGjzDo9wLN7lgKDlILlRx+9HFU01
         dJOdoZSQpr9jccgLBILNWdPnk2i+Dt3DwKxV2R24jUp35LunQWOV1zafs4OKfxT/EFXK
         hRymtN43BotYNHEAZhaId5MWyxHouNSG0GyODDb17sKgniS70H9jQGqUxfuTYK3D0XPL
         jabEVEGPjj0IVIQwHZXLZ3tp1Yln0QZebJg+83ju8dqIe3mhHT/IAT5kkNgcmlFDw5/B
         QFABQ6lo2Xjt202sFIYqYCQo0zCSo5H9V+uGbIuKLTW7PujP2xj/jiInxtlaXDMg3KtF
         VFvg==
X-Gm-Message-State: APjAAAX9Tm5G7WHWGPvKodB8r7ztERBhfJFuP96ahOPU55/JU0NNhZFn
        Nfq/41B016Ox0V2IhI/neYsIDr/3Iz5IuMEqt35GaYfe0CSYIBRHkrXBuY60+AVW1l6oWxjmhfv
        6yBQti6xhV+lvwAL6nhzKuD/Eq76d1o4xr+w=
X-Received: by 2002:ac8:2d6e:: with SMTP id o43mr18810878qta.195.1559494967793;
        Sun, 02 Jun 2019 10:02:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+ozByIcoy5To9pJWZT6xf9LPR0WNPyTubvYnojsv67CYOywtzE5g9m+WgPGa1v01KaxGGiQ==
X-Received: by 2002:ac8:2d6e:: with SMTP id o43mr18810860qta.195.1559494967512;
        Sun, 02 Jun 2019 10:02:47 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id a16sm3040410qtj.9.2019.06.02.10.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2019 10:02:45 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Rob Herring <robh@kernel.org>, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: checkpatch query regarding .c and .h files..
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1559494964_3146P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 02 Jun 2019 13:02:44 -0400
Message-ID: <25942.1559494964@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1559494964_3146P
Content-Type: text/plain; charset=us-ascii

scripts/checkpatch.pl contains this code near line 3070:

                               if ($realfile =~ /\.(h|s|S)$/) {
                                        $comment = '/*';
                                } elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
                                        $comment = '//';
                                } elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc)$/) {
                                        $comment = '#';
                                } elsif ($realfile =~ /\.rst$/) {
                                        $comment = '..';
                                }

Was there a specific reason why .h files have /* */ and .c files have C89 // on
the SPDX comment line?

Would anybody like a patch that fixed checkpatch to allow either flavor on .c and .h files?
(I know I would, I just blew close to an hour trying to figure out why it whined about a
SPDX in a .h file I'm getting ready to upstream...)


--==_Exmh_1559494964_3146P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXPQBMwdmEQWDXROgAQJyzQ//SijFxhTCNYwUnuzQwJyrC+LonRncqQVa
u480XkfjalSQLnCNOr3eXmx5sdUypwSyYOfdPn1X/axF0YqjLap93Gsw7Y/Ic4OX
kDbYdzcF0mWi0zzgPenjZR8zWPB0N0OXvNCnW4caP5YJioY/M2kZ+JQfEHROOfiK
Z4m2oUGnbLfThZudyt+wTAJOmv4zZkv9hHUEzi3WS7RFPKsp6/I3orL5nAPHY8PX
VGiVKrxAi60Fb+MHh0aNxgKmbMllor8krd+gFJql9UUalsFuiG+e/lN6dKcnObdk
mnWmHGJ0VYdwqOG3YjTCf5gdQXQGLiiAVrSR2dSnAWt1J97O2IJ/1hTCTSmSf+bf
SBcO8/pZfDzpUJeXbeKsBkNuqs86iXVaBxD3k/XhoOakW9IK2RMZ5VgD94K6E2Qo
8tlsF17MtYjnvQ0aP5/OchmVTcbdcMNwKChLRJjUqg1x2e/mQ1ras6VjBQplyoWx
iQGuPH3Qlz0ogKuTtXxKdtFJ9Ne+b2Gr6JaSC1HJQo+wBInJ2InXL8COkxmSCmuw
YKLkB3YyVH6og3IfslZN0ohiWij4rHJI2vnThXjoOe68SEzyxgrdHqGkprP2Oepr
B7V21dOe6UlhTUk2Sm5k2qkgXQUDiV9/0wcUQO41a7ZpFzJX3pPb3C/Mc4bwiOio
3zXtSQs/pwc=
=wYVs
-----END PGP SIGNATURE-----

--==_Exmh_1559494964_3146P--
