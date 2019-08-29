Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D62C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BA022CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwuTR8XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH2U4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:56:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36263 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2U4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:56:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id p13so5217346wmh.1;
        Thu, 29 Aug 2019 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5OTD/ZF052UijPlaWHCU7Ea6/DP3zSnIydnyfbQXH7E=;
        b=CwuTR8XUyaLrdcjJY8/b566IfEuB1F8FTncyUSw/jAoq8v+gWEvkj7YHi47i1uX/eq
         a0OuCmIDRaosbb3VIoSMbiy/1/MdDR0H1cnkr/IhTXridpk2ZWFNLil18EUcIXrsXDU7
         LMoVbc3C6/mRCWWjKN0MgWfhMCA7v12O7FJvXN6UHKZkKa8eAF5iwVcZCxSPfqE/stRn
         J+WaL22jPUxTXElwUyjVHuXfqvwMVwyQjkq2TXn1BXC81WOjLzMFLWfGiFxVj04pb71l
         NMp/yG8LRyqU9hR2bzSGDsTBWGwayFAsbpHhHeqer+JVT+j/zmno0ijiyEQxdOAutwkH
         CqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5OTD/ZF052UijPlaWHCU7Ea6/DP3zSnIydnyfbQXH7E=;
        b=dTykIR+A0iNlXGLX1htXvIEMU735PE7ZmARPovdil5Xko542elSh/FOhEt0NfYKziz
         cLcRaq/ZzOtKhDIB68nimfLP8f6ZOM4yof6f0GlqGWL5f1QYA05XxMEgP420Ns6Frkuy
         d1g5hZ3t8imcFzho9fSw5wp/QVJ9zhyXgxmykk+zbNTkxqScjmlcCISw+vA40/tenCVB
         HKvL13pdFuCbOQQ4ssby0NKyWMUuNZpSSrkb7w/jQ50RHu6rNQUJVnqv/xF9O9f3Gc+k
         8f52+nFeu4wN7GyMTEQrGeAf61lggHFbRsUjijTxY95bxdDSIwlGaZP+sfFqZyzgHUql
         XSpA==
X-Gm-Message-State: APjAAAVDz83qWStviJOOl0goPI10+0aKU/yPgOIWWQ4ZvSWRsp7ddX9x
        gy3X7KuP5vNiBNUPhJlRi+91oyNckeM=
X-Google-Smtp-Source: APXvYqygssWtVylOkfeDXUlxBM6Q63NK3RvJdvkErdIKchX1tJ0I8+1y3Yzz+aHslkBbBxKFZdcCYw==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr14634755wmk.90.1567112193854;
        Thu, 29 Aug 2019 13:56:33 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e14sm3883812wme.35.2019.08.29.13.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 13:56:32 -0700 (PDT)
Date:   Thu, 29 Aug 2019 22:56:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829205631.uhz6jdboneej3j3c@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="22htbofgnb45e3kb"
Content-Disposition: inline
In-Reply-To: <20190828160817.6250-1-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--22htbofgnb45e3kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 28 August 2019 18:08:17 Greg Kroah-Hartman wrote:
> From: Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu>
>=20
> The exfat code needs a lot of work to get it into "real" shape for
> the fs/ part of the kernel, so put it into drivers/staging/ for now so
> that it can be worked on by everyone in the community.
>=20
> The full specification of the filesystem can be found at:
>   https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specificati=
on
>=20
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg!

I'm not really sure if this exfat implementation is fully suitable for
mainline linux kernel.

In my opinion, proper way should be to implement exFAT support into
existing fs/fat/ code instead of replacing whole vfat/msdosfs by this
new (now staging) fat implementation.

In linux kernel we really do not need two different implementation of
VFAT32.

So I'm a bit sceptical about usefulness of this exfat code/driver, if it
makes any sense to have it even in staging.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--22htbofgnb45e3kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXWg7/QAKCRCL8Mk9A+RD
UscXAJwPPJqKcOQjnAYTGn7FOoM5do7AtgCfVuTe+I2XcSSZjydWed7Afnz64cs=
=Xup+
-----END PGP SIGNATURE-----

--22htbofgnb45e3kb--
