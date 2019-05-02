Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3781C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AFD20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="efZz3vRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEBIbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:31:38 -0400
Received: from ozlabs.org ([203.11.71.1]:55423 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfEBIbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:31:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vpQF72TLz9s55;
        Thu,  2 May 2019 18:31:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556785894;
        bh=DMfzUvGe1OmVYxaTmVHfjp1BzeSQSpcGDRjgM7qARvs=;
        h=Date:From:To:Cc:Subject:From;
        b=efZz3vRDDoYL5Kt0A+senS+bIMbmypGY3RSoGOe0wva5MgBTRkeqgZBzfzpHborol
         Uz97VpSSkwPK6bCCCLMggEEBMJ6rOCPge4e1Tz9irYzTpdd+uhMO/FYUAv63ncQp0A
         ukW3St9rRBWDq3T0XlFtXO7Q6FFXpRcywxc1XafyjxM/hzKV1LY63JaZ5t+9tZ7y4y
         SAX/Tw8TiJDw8+r7VN9kpakKTWXLSUxrEWcsv7aAtHkQoZ125F4sjaqa7FTV9jShLK
         8RmFcu/hKW4v8kUwFgGx7Q7hBHt6WlFqqumQdMuSn6CVL0+u97dD3kFKwsVHYEYEh5
         gOKeGYoCzDDng==
Date:   Thu, 2 May 2019 18:31:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the pidfd tree with the kbuild tree
Message-ID: <20190502183125.3b53300e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c7UPOCWZDr0blwyXwvs0FsM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c7UPOCWZDr0blwyXwvs0FsM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pidfd tree got a conflict in:

  samples/Makefile

between commit:

  a757ed09d672 ("samples: guard sub-directories with CONFIG options")

from the kbuild tree and commit:

  eb364bbe6791 ("samples: show race-free pidfd metadata access")

from the pidfd tree.

I fixed it up (iI did the minimal fixup - see below) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc samples/Makefile
index 0f2d70d785f5,fadadb1c3b05..000000000000
--- a/samples/Makefile
+++ b/samples/Makefile
@@@ -1,21 -1,6 +1,21 @@@
 +# SPDX-License-Identifier: GPL-2.0
  # Makefile for Linux samples code
 =20
 -obj-$(CONFIG_SAMPLES)	+=3D kobject/ kprobes/ trace_events/ livepatch/ \
 -			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 -			   configfs/ connector/ v4l/ trace_printk/ \
 -			   vfio-mdev/ statx/ qmi/ binderfs/ pidfd/
 +obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS)	+=3D binderfs/
 +obj-$(CONFIG_SAMPLE_CONFIGFS)		+=3D configfs/
 +obj-$(CONFIG_SAMPLE_CONNECTOR)		+=3D connector/
 +subdir-y				+=3D hidraw
 +obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+=3D hw_breakpoint/
 +obj-$(CONFIG_SAMPLE_KDB)		+=3D kdb/
 +obj-$(CONFIG_SAMPLE_KFIFO)		+=3D kfifo/
 +obj-$(CONFIG_SAMPLE_KOBJECT)		+=3D kobject/
 +obj-$(CONFIG_SAMPLE_KPROBES)		+=3D kprobes/
 +obj-$(CONFIG_SAMPLE_LIVEPATCH)		+=3D livepatch/
 +obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+=3D qmi/
 +obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+=3D rpmsg/
 +subdir-$(CONFIG_SAMPLE_SECCOMP)		+=3D seccomp
 +subdir-$(CONFIG_SAMPLE_STATX)		+=3D statx
 +obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+=3D trace_events/
 +obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+=3D trace_printk/
 +obj-$(CONFIG_VIDEO_PCI_SKELETON)	+=3D v4l/
- obj-y					+=3D vfio-mdev/
++obj-y					+=3D vfio-mdev/ pidfd/

--Sig_/c7UPOCWZDr0blwyXwvs0FsM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKqt0ACgkQAVBC80lX
0Gz0eQf+Kbg+tH0icN2dRRvQWMLlgOKX/9kxBiFC7qi47prbysX+cs7HmRiwp5gs
/1p3ro92jaoM9X1vHnVQHdVVwZ+eqZAdXeMwSsAScE3ifVQP69WCGo0Sm0On4X7z
7AKwmdZBsTc2RTel0gbnficnFYiTzDmNY9pP7oGbEXFx8WKOKJE/IyePdynE0BLm
6cZV7hxpYiIy2MeFXyeSOuRxaRuMTqMmO4oHPN2JFHS0J5bN/L4S4hNV6KQ6vgtC
RbgWhlZD5Ar440AAPM5wYcUPadIekJNlWXcwUCExaPYXf3x5Fa1Q/zWeOZnVj8Kf
IcsexXLWoO9F8WRuStyc4FFIf4S5UA==
=4Pn4
-----END PGP SIGNATURE-----

--Sig_/c7UPOCWZDr0blwyXwvs0FsM--
