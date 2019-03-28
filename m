Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8600C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B6C217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OBcGMsbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfC1A3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:29:30 -0400
Received: from ozlabs.org ([203.11.71.1]:44311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfC1A3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:29:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44V5N661DDz9sP2;
        Thu, 28 Mar 2019 11:29:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553732967;
        bh=2HDfh37B3oTaWYridyQIivww1MgZ/2YCDwF8F2ZOxAs=;
        h=Date:From:To:Cc:Subject:From;
        b=OBcGMsbfIm1ckJgyNVza/xcOsXDc0QhS2mur7EizDirqRa8uipuKju4CQHKWjSiXg
         DvGXU9ekYbhQflHtUi0UW0c5WupZo8RP8cuo3i1hFs6gcGzHO8xO4sxJlZwfhAPNB5
         AEZt6L5dQb7CH/x2Awo6qthZR7J2fcfm24N7cWU+CPjbi5w78xX+dp7BFF/Oem53AX
         SIZrNA3dtRTNqsqvxcAyqUEmW3OdZNxIH4s2o6bze6KWZQnCboKqieNjd4SXsSAb9o
         viaGHP8dmHYLX/3/DaMNy1lG/1oQIewvYaQZZPdXM9ba3uVAI5+ULwpmFEBrpWd9Q0
         AIR0NCx6mvEqw==
Date:   Thu, 28 Mar 2019 11:29:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: linux-next: build warning after merge of the phy-next tree
Message-ID: <20190328112925.0fbe34e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A75oY2WFi94l+5SHUQy+Dbz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A75oY2WFi94l+5SHUQy+Dbz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

After merging the phy-next tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from include/linux/phy/phy.h:19,
                 from drivers/phy/broadcom/phy-bcm-sr-usb.c:10:
drivers/phy/broadcom/phy-bcm-sr-usb.c: In function 'bcm_usb_phy_probe':
include/linux/device.h:1138:19: warning: 'phy_cfg' may be used uninitialize=
d in this function [-Wmaybe-uninitialized]
  dev->driver_data =3D data;
  ~~~~~~~~~~~~~~~~~^~~~~~
drivers/phy/broadcom/phy-bcm-sr-usb.c:289:26: note: 'phy_cfg' was declared =
here
  struct bcm_usb_phy_cfg *phy_cfg;
                          ^~~~~~~

Introduced by commit

  a3b96057577c ("phy: sr-usb: Add Stingray USB PHY driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/A75oY2WFi94l+5SHUQy+Dbz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlycFWUACgkQAVBC80lX
0GyCkAf8CwUajFzg0df2VEAQ2KqWX9pxxk3XEx1Gegym0hh9Q9OOOwf089BZvHdk
OqVLeWCWxjYbpXHy9qILwrFMEBtHY8XSFglD2M6A/XEhxjb47gjf+nb7csGpKZ2s
y8amVjDBDhc+adXHOw9e90L4qRR5npCrjJYTodbzlDtfwTvi8VWpsLmKAiAyU3fd
vctKk5d0+Nod166EaqY879SOzGdAdgMzmfrzZ0S3S6sz1sSh7RutojhIAUCyUIf3
/AD3MuZkKw/g1YvdtHuEa8rq/tP3ISgfANW4oMefdYJLdsyOCBZb4p9rXpfxt3n0
El2QQ1lKfhQZ+XQR1XL1zd4zurtoPg==
=Lzh8
-----END PGP SIGNATURE-----

--Sig_/A75oY2WFi94l+5SHUQy+Dbz--
