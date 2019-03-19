Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB36C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9652A20685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RtzEoB9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCSBkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:40:41 -0400
Received: from ozlabs.org ([203.11.71.1]:51675 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfCSBkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:40:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NbNM51bBz9s70;
        Tue, 19 Mar 2019 12:40:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552959638;
        bh=Y5j6ROHawM0pecb+RB/gzAFZFTOOxrhe1b08ENnf0mA=;
        h=Date:From:To:Cc:Subject:From;
        b=RtzEoB9qAy1zptLlJQIO58Kpe1W+k1oOO2kz4z50IWlVOKdyXgx0NJ40epZ7ubGDs
         koNmCvdGP4/TfxZpkNyxmk8vD+SEUrZECoRK0fw0ME964i2jEYMCADeSyBMP+0cDN5
         suAIeJH4pHKXdRymWA7tERdddP6p5F2oK+psb5KZqlRj3HZPbSq+s69OzCtLLju9Ws
         u+IvdN29rXfyT/gw2TjVFCow2O8ehepAmEzFnZRID8q6a6YkiC2zklx0SASPdKJxVI
         nSw/+mlsIHncfN1o3bEBtN0lCOgYAQ6Lbq+O/rtebD5VYJs3k1g1gzo3pJVb6m5gRc
         pztGSNwOessmw==
Date:   Tue, 19 Mar 2019 12:40:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Dominick Grift <dominick.grift@defensec.nl>
Subject: linux-next: build failure after merge of the selinux tree
Message-ID: <20190319124034.13ff6044@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ky35U.Xly5mQAanE43DmKpK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ky35U.Xly5mQAanE43DmKpK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the selinux tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from /home/sfr/next/next/scripts/selinux/mdp/mdp.c:35:
/home/sfr/next/next/include/linux/kconfig.h:5:10: fatal error: generated/au=
toconf.h: No such file or directory
 #include <generated/autoconf.h>
          ^~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  e37c1877ba5b ("scripts/selinux: modernize mdp")

I have used the selinux tree from next-20190318 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ky35U.Xly5mQAanE43DmKpK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQSJIACgkQAVBC80lX
0GzVZwgAlQ516J43HIE13qa4LP9Sohe8B6vzwsb8i4ZMg8gxdAiuw4noquSkZsgV
v1EYe7QL5WvlBnh6CBucw2IXgveIaOs5Yi5D87P17eqxIcPadlmKRwyvSQDCzezI
RvWnNlbV2y/l6jNxuvNidCie7bnY0tVzwcyRXOhhfU2cHvbrUMMOqwYh51xW4LLb
eHRUzScL3p+eDiY5e2Nz5NP5eJNDJ3gYwKLqwFleihai3HR/adcEiBWQ0/p4Q24a
+DcO8nlhWDQ79vxjJvVJWkIrlXhhC7uqMs5/YfcLrs9cFVdz3FLCNe14f1VwRoB7
nvMkqkp+DwurodZLqnWD8yAp8bCJLg==
=Tj/j
-----END PGP SIGNATURE-----

--Sig_/ky35U.Xly5mQAanE43DmKpK--
