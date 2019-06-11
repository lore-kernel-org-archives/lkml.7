Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946B3C4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509D8214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VlJzJMTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391110AbfFKEw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:52:59 -0400
Received: from ozlabs.org ([203.11.71.1]:52693 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390229AbfFKEw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:52:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NHgX4x3Zz9s4Y;
        Tue, 11 Jun 2019 14:52:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560228777;
        bh=NxT9Po6P2dh2KWTTjv4NqvZafUGmR2kz7Eh+QY6FbBw=;
        h=Date:From:To:Cc:Subject:From;
        b=VlJzJMTCb7+aqgBP+MEO4f4M6uvIjxlThlBQ5S7a8JMIeTHmDE4PqkX8qmKw1deTM
         JDka1R02UVIk9aqaF3DTVXeG7q05su3WqphFlBKyQ9q7tOfeEVy3tGckwGH34duKMX
         KI5Lhlap+qvYiOlOI4iKmB42XmvDvToneZ5reGOVfJR0uH5V7sS8qJ4KVJD1hMFTUP
         PFurD+kRKWc+QKE1Q4vLv40mByC7cH4h3tVqBBCxU7XBqmpU+pr2f/kN6rkwF8GSIz
         mgYJmjmDiBsW30wKWpSP1eMg4Dk9gxNpIHIFQ1uVRk6ftvTfZ4RlUoDfSNB0zUdk/M
         0s+qzPj4OZiLQ==
Date:   Tue, 11 Jun 2019 14:52:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: linux-next: build warning after merge of the tpmdd tree
Message-ID: <20190611145255.68682629@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Fo4sukQFr7Es.fHMTnZiiX="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fo4sukQFr7Es.fHMTnZiiX=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tpmdd tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/firmware/efi/tpm.c: In function 'efi_tpm_eventlog_init':
drivers/firmware/efi/tpm.c:80:10: warning: passing argument 1 of 'tpm2_calc=
_event_log_size' makes pointer from integer without a cast [-Wint-conversio=
n]
  tbl_size =3D tpm2_calc_event_log_size(efi.tpm_final_log
                                      ~~~~~~~~~~~~~~~~~
          + sizeof(final_tbl->version)
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          + sizeof(final_tbl->nr_events),
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/efi/tpm.c:19:43: note: expected 'void *' but argument is o=
f type 'long unsigned int'
 static int tpm2_calc_event_log_size(void *data, int count, void *size_info)
                                     ~~~~~~^~~~

Introduced by commit

  a537b15c54a3 ("tpm: Reserve the TPM final events table")

--=20
Cheers,
Stephen Rothwell

--Sig_/Fo4sukQFr7Es.fHMTnZiiX=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz/M6cACgkQAVBC80lX
0Gy7oAgAgHOWIaqHWtNFZSc9uxqpAoo1ih+uRWdRRGYVfCPRdh+JaBHJU2Rkf7Pu
s/JD7G0l9Ca4hQEnowfkcF1fkcTEMV17NbSDvpvBzlSxH/Q14vrBlY0LiwRRP66p
1sqW1Z7wEcSPoqyMaY1fSgVS2yqAVF4zAaNSg7ytxxErOvpU6n7FzSDcS4dV5LIc
oXwbshV0nVGIq1peFAiuWYxvaBdn5ogaWq4iJXMWXO4s4lhAdSEqAkj70wETaIxI
hd6W7Psp0EuXqoX3QwKr/y2UkKST13uYe4oj/eMTgsEklLxUu2pAGxxsklfA+9y+
qLpNMgqrWKMZKWlBP49Aw3UFXdnvHg==
=ofY6
-----END PGP SIGNATURE-----

--Sig_/Fo4sukQFr7Es.fHMTnZiiX=--
