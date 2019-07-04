Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C67CC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FD021850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="d28ylkG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGDGYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:24:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDGYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:24:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fSch0vTyz9s8m;
        Thu,  4 Jul 2019 16:24:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562221476;
        bh=Pg+hHwo3P90SWdyoPK+T5JnXAuflVOT3Ua+ayT2IaWs=;
        h=Date:From:To:Cc:Subject:From;
        b=d28ylkG/e1CtCgQHs2d5qnIJgPxXjQZoK1AN09BGTzWrlk/lYASu/aKAyDFglH5zt
         RFCdQ0UdtkYI23r5FxpgEQajslJYPh9xiZPbEFEE1dJA1Dtb7JSUkwZgRv804GmcBn
         Jgk/TCg3JeLmgk0vC/8Au63GC4Te8ujWCqtn71psYpI2br/aVXWcNbRr6jyAARkZ8l
         wIr1ZT/Fyz4VSW6DkgDl/mXVcIWFvKH/DaF9efcLT8ASdJ3AvThHj6jWJ3nyPqCYPJ
         D8ENe+8IMFiXt+B/6urLPWAnT8g09Jdpso/PEYSskvqCbTW4CNCXWx8PcVwGIxnfel
         +DbmbhXsVkYgQ==
Date:   Thu, 4 Jul 2019 16:24:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the driver-core tree
Message-ID: <20190704162435.17f405b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FqycEoYp6=XAIhAU85_Yojy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FqycEoYp6=XAIhAU85_Yojy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

fs/orangefs/orangefs-debugfs.c: In function 'orangefs_debugfs_init':
fs/orangefs/orangefs-debugfs.c:193:1: warning: label 'out' defined but not =
used [-Wunused-label]
 out:
 ^~~
fs/orangefs/orangefs-debugfs.c: In function 'orangefs_kernel_debug_init':
fs/orangefs/orangefs-debugfs.c:204:17: warning: unused variable 'ret' [-Wun=
used-variable]
  struct dentry *ret;
                 ^~~

Introduced by commit

  f095adba36bb ("orangefs: no need to check return value of debugfs_create =
functions")

--=20
Cheers,
Stephen Rothwell

--Sig_/FqycEoYp6=XAIhAU85_Yojy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dm6MACgkQAVBC80lX
0Gxy1QgAkxwPQfTPO2fMrkE/7J/WbNZPWQM3rAB3gXp0PpjNOi4GZdjX/lt/TYgL
VF3n9OIpSTh6zS9+0Bv/G4bR0KF3SvPpzTsMq5ELiv5xTGjm5Kmv54EJ/8oe3FL4
VouRbJs6ApBTe3hxbkZJf/RlRqMXRiSqs6caVORPD4BEmaMNPg4WqViPInJ1oB6m
wGQFuTeKiNG3KdSxw7JNBjxpdkkQzt2RFKqOTuox+Ww5dk2278XPuMa8hppDE2dW
bzJqeC19vkc1bLBYUN1twYwdEkfo/zRX766YbMVCQXSYIxPUpLurAb9XijVXz32b
3m5SrVa0HmoozP5iQJSMDHV7D3kTbg==
=zWsG
-----END PGP SIGNATURE-----

--Sig_/FqycEoYp6=XAIhAU85_Yojy--
