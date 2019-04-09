Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED93DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FBA20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EBPuwaIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDIG1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:27:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfDIG1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:27:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dcm62p2pz9sNy;
        Tue,  9 Apr 2019 16:27:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554791270;
        bh=xozyPPPTL64ByOLiGj1VLCPVnTxTb+72Ib046xI/NLQ=;
        h=Date:From:To:Cc:Subject:From;
        b=EBPuwaIyjprzipws9DE9/n2UexCX29xnWGFMROWllb6x7VFvTTdwVWtxlJVWS/zUJ
         Km9BEwqFi60a3rYPIIXuhLaiOKqWP37piNRYb9hro8kHCZ2ddfAunaKXI7xqszT1DD
         mdfh7NnGfONmRonHm7LLCEDyuft9w/i55A2LU6nPFy2PjtFJi8jbPaSxoalSBMmmsT
         +cLRtPbpRWjOtsuNtVKPU+FVhOvtnaQVyiyQ+/+eHspCgzAf2fn08x3pRw+X2W2awp
         MzvayeB8S0sEjMYzIZfKdYvM8NECM2tfIsCo348aQs5sktw40FKYySVu9nxmEM6f5J
         wbwOF9u5ngvVg==
Date:   Tue, 9 Apr 2019 16:27:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20190409162749.7eb6656f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5WkA0RPc=eCqBu6NtnDm+9m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5WkA0RPc=eCqBu6NtnDm+9m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/scsi/qla2xxx/tcm_qla2xxx.c: In function 'tcm_qla2xxx_init_lport':
drivers/scsi/qla2xxx/tcm_qla2xxx.c:1614:3: error: implicit declaration of f=
unction 'vzalloc'; did you mean 'kvzalloc'? [-Werror=3Dimplicit-function-de=
claration]
   vzalloc(array_size(65536,
   ^~~~~~~
   kvzalloc
drivers/scsi/qla2xxx/tcm_qla2xxx.c:1613:26: warning: assignment to 'struct =
tcm_qla2xxx_fc_loopid *' from 'int' makes pointer from integer without a ca=
st [-Wint-conversion]
  lport->lport_loopid_map =3D
                          ^
drivers/scsi/qla2xxx/tcm_qla2xxx.c: In function 'tcm_qla2xxx_make_lport':
drivers/scsi/qla2xxx/tcm_qla2xxx.c:1677:2: error: implicit declaration of f=
unction 'vfree'; did you mean 'kvfree'? [-Werror=3Dimplicit-function-declar=
ation]
  vfree(lport->lport_loopid_map);
  ^~~~~
  kvfree

Caused by commit

  523c106ad4b1 ("scsi: tcm_qla2xxx: Minimize #include directives")

I have reverted that commit for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/5WkA0RPc=eCqBu6NtnDm+9m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlysO2UACgkQAVBC80lX
0Gx/1gf/TEBSp2Cq8xWmXP+YpXRq3EQvYiXypdp7HK1j7orWOKF5up0A5pHcn7Z/
amjMa3JwvnZoziDeN8+XottURP3Rvipm5yMxxH1njExjZd6LSKwXrYSsk7gSImlV
HLu7/hbZqnfjP2wtKs4Ybe5MgLdYuvPhGbsQAssUXmVGYj/l8mWVCHIU4sxRR9c+
OJ9MMQgm4F7Gu2h/szG+kgFey0dMd6Hv0zIXiEpHBa69pQErPyoGnNQovtkxYKLL
D+uuGv7ICwvv+JtdvVqefvLdrik/Lq+iTOjCsn5/nP4Mdpj/9H+rq0DjXo1SNRAq
FnkIVs/g7OBiew6MUaLUq8aez6B9Cw==
=tLEG
-----END PGP SIGNATURE-----

--Sig_/5WkA0RPc=eCqBu6NtnDm+9m--
