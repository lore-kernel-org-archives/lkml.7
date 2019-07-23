Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10537C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E637229F5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NF7JwupG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfGWXy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:54:26 -0400
Received: from ozlabs.org ([203.11.71.1]:44993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbfGWXy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:54:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45tb1B6S9qz9s4Y;
        Wed, 24 Jul 2019 09:54:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563926063;
        bh=+csTStzc+VV971RYhHdoELYkDFqttJbo99tUPeo/F/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=NF7JwupG+Aag1RqwRki/eF3C2T5UnK/6FHhCaGrUGtWnZSe2nXchcDAd9v6F8oTT7
         jwCQML4u2Ah5FKDUrgtNLqeH7WO0IeR0JeTHIjBaxVFaR8MeBtVNh02nCsrS1W/e1l
         WiJhhVa4dCJ3fISGymVeiBxfigvDSjf7aihaEoAzazl5KmMZfl5DqAAJxYJogFC8r6
         7hU6Bdnv2fTA10yUka+rbiJdCIP124EEvj+kHroz6/70jGoa4BOp1pf6RcoZvPB6uX
         ksvIo/CzFnVDzfdhmjX0vHn8b8TRBI1Zp4kVYK+OVL/eUXPpsmTEDapmU99BLEVt2w
         +glges1yr4WSw==
Date:   Wed, 24 Jul 2019 09:54:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: linux-next: build warning after merge of the input-current tree
Message-ID: <20190724095416.65450cbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zjgGk0rKApNMSn1H/+qeB+x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zjgGk0rKApNMSn1H/+qeB+x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the input-current tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/input/mouse/elantech.c: In function 'elantech_use_host_notify':
drivers/input/mouse/elantech.c:1843:6: warning: this statement may fall thr=
ough [-Wimplicit-fallthrough=3D]
   if (dmi_get_bios_year() >=3D 2018)
      ^
drivers/input/mouse/elantech.c:1845:2: note: here
  default:
  ^~~~~~~

Introduced by commit

  883a2a80f79c ("Input: elantech - enable SMBus on new (2018+) systems")

I get these warnings because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/zjgGk0rKApNMSn1H/+qeB+x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl03nigACgkQAVBC80lX
0GwE2wf+KmEV2A67BPTaTWBlqw6hD77u527SLVloOa+ERNp53/HUCBcDPL4lplJx
OZXeMX23GNqVHu0zGKrgyd5Y0IqJUzTQU+Bdz1OooLNqsLP+kmcwmUSfJlsRVhx4
DBBD2HOSmqz3W/MsMrZsgZce7/XgOcu3EUIf64kbp/YN9UpfYQozp625Q5pUhnYK
dIBkxGySCKHEUsTUoxpkpUHXSMzSmLBb2IkMPOvA4ekZJQZFFSAMcU3CEeF1AKI3
NQmrPiJJ3DCIlqszBHABF9C6zcDXfn2jNw0CTVNzQoQde/L0/K/sikmYtUKqHGHB
550LsYNcabjMknxtPNYIfU1G1Bn7mQ==
=Yhj+
-----END PGP SIGNATURE-----

--Sig_/zjgGk0rKApNMSn1H/+qeB+x--
