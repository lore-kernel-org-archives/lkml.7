Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9022C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B435621670
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfH2XS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:18:27 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58890 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727907AbfH2XS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:18:26 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7TNIPtY019115
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 19:18:25 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7TNIKVD004811
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 19:18:25 -0400
Received: by mail-qt1-f198.google.com with SMTP id j10so5085689qtl.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 16:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=DcLFLaAqEp29ZGYNoD8NLhDO1+i3Ahy1cBfneYPS5dc=;
        b=jtgMPQHxtSP+jw4HWZawiUUkeFhLj41xJAd9mnp2IF4KAIxHjvhofG8OUa4re6HJf1
         gVWBiIorhlsQdYPhLt55KNYRrdbT6tGmGdbUCfFaIawfZ9/s7ToI41UlUE+gM+eopKvy
         HEhatNepPG3YKBUShQNYqqzbsDTqK8kFSvh7D3oHhHB+/F5fitz3+ETtnshbXT+QaBvl
         /UYiRtmM1ZJqb4VSIhKtr4h1CXY6y9vWsqJwCysxwbWHW9X22iqz+K+v/DPhbOF2MlGl
         DJ92yUmiFaMHs1ZBCPrLzYtTlJeWoPjkvtV65PFVMu3qW9FmWkPI/52ENJgh90oKx3QU
         PZ6g==
X-Gm-Message-State: APjAAAWXlVhyS2ipXtnFO+fp8RDkdQ0stTuy7vs6B5Q92ozHRMkGVmFK
        OUOAjpty6DQ8xKLQcndJaqczTKEq1BThdqD0XDIj24QwwQnDgogmr2wNmbSXlkuHvRrD26x27TF
        d4OmlVosbyzEyovvcJ5V+ua/PJQH648PXCIs=
X-Received: by 2002:ac8:40cc:: with SMTP id f12mr12407873qtm.256.1567120699906;
        Thu, 29 Aug 2019 16:18:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwRfRQ8XctL68FBd61p6RkC4McNCSssT+S7q+CnkZYf4L9k+NRhYpVxkO19yp//P/cbraMTJQ==
X-Received: by 2002:ac8:40cc:: with SMTP id f12mr12407856qtm.256.1567120699589;
        Thu, 29 Aug 2019 16:18:19 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id h137sm1498736qke.51.2019.08.29.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 16:18:17 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20190829205631.uhz6jdboneej3j3c@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567120695_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Aug 2019 19:18:16 -0400
Message-ID: <184209.1567120696@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567120695_4251P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2019 22:56:31 +0200, Pali Roh=E1r said:

> I'm not really sure if this exfat implementation is fully suitable for
> mainline linux kernel.
>
> In my opinion, proper way should be to implement exFAT support into
> existing fs/fat/ code instead of replacing whole vfat/msdosfs by this
> new (now staging) fat implementation.

> In linux kernel we really do not need two different implementation of
> VFAT32.

This patch however does have one major advantage over =22patch vfat to
support exfat=22 - which is that the patch exists.

If somebody comes forward with an actual =22extend vfat to do exfat=22 pa=
tch,
we should at that point have a discussion about relative merits....

--==_Exmh_1567120695_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWhdNwdmEQWDXROgAQKwxhAAkSM5ieCfKxqUaqzZUaVmPpuahxnowIFR
eFxW+Tm+35kuld2GKKYZgRE4R8rm/JoklscOoVhrKxv/TSCOeKaWrGg3EDB8NKpB
6Zk3vvC39n/bADWzoDyYdN5h0nwUX15GsFiP1VHVTyjOEszXpgz1FDoZMwBP+e8b
wK/868C/mF1pbgMa2VMXa/ZVJbfzyNk3E9oUVTQukJZ2Pjj4p6v9TvTCOSuLahBq
xvz4ZcYx0v9GlVzmpGYWYF86dkzTq/UfnLnt1vcHzdGXsmbAqj0NjXGOUnVy9VxX
PjtUsR/0PkNkURAcMu52528LNfxYvhTKPxv+TuSpwFniW6bq8vh+AOm1BGCR+yPF
mhNASlvEaXRGh1lEWcFx34z0zaGzOsfJOoQEUtIkdri+pNjNMo+GjE31BtgPHToZ
VbOtbjdOXLTsVwW5v0rSyhZYYicN2Pd5nS/cw0K/OH1vq3p32X1IfNoS3/aPbh32
BDhSUvJ05USbLRFtTDRZ7TPRyGyUjAjPqHQ24AIDHNfi42XW8mmXs7CSEltgPWA3
Qm5hhAKt4l+UHoJ6DWJrxJc4Hpqj4HL3MVbqhc3J5LW8XEHXlUQQpqre1oaf5ZmT
XZqC5A7azJKudRo3ceswErH2uxM8Geib+uhcjIofduUk8cJiyBhK459A7Z7BxTMG
Rvrxs5lfh88=
=9MW/
-----END PGP SIGNATURE-----

--==_Exmh_1567120695_4251P--
