Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D8321872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZjmK+H8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfDEDZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:25:14 -0400
Received: from ozlabs.org ([203.11.71.1]:37629 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbfDEDZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:25:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44b4vC2bmXz9sNm;
        Fri,  5 Apr 2019 14:25:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554434711;
        bh=yI/Tm6FiLVjDEmn+s1KtqKXdOwHLdWBClm4fYWhiz0s=;
        h=Date:From:To:Cc:Subject:From;
        b=ZjmK+H8vNcdolwypkfRaa6JzF8DfqJyJezzzJt1fwUC+o4VnE43eKMjlpSFhbvmP5
         NnrF2eJCCvUV0860sojjthaVoi/Cv37txRNBeJw42CqFMDaRlWrYFiMwSRMZXy8d35
         p05jqLiiSA8Mz6YtAu9RFgtJK5aIaw7WkK1KMeXQAWtkCLk/WEwc858nGmFWDL2K7M
         fZNDiIw1SF/VkQDthx29hZKvsZbfPtKTW4BkS1C+BmWlz4tZNToGsdUspTZS88vxWf
         +BrlzQgS4yjKmI4cL7Mz9hyZiq33SnwwUGLQQRg7DHFTo7ooLusR1PsIlB4Hm66NLU
         eTN/dgcCxWwZQ==
Date:   Fri, 5 Apr 2019 14:25:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: build warning after merge of the scsi tree
Message-ID: <20190405142347.1f264cdf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qG1lbi3eneWefH0rN68cbG3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qG1lbi3eneWefH0rN68cbG3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

After merging the scsi tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/scsi/lpfc/lpfc_nvme.c:2140:1: warning: 'lpfc_nvme_lport_unreg_wait'=
 defined but not used [-Wunused-function]
 lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 ^~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  3999df75bccb ("scsi: lpfc: Declare local functions static")

It use is guarded by IS_ENABLED(CONFIG_NVME_FC).

--=20
Cheers,
Stephen Rothwell

--Sig_/qG1lbi3eneWefH0rN68cbG3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlymypYACgkQAVBC80lX
0Gw9Qwf+PcECZy9lorHevXKLfXYKO0tk7/o2Q3/5l6jBl+G5QmsK7MwZbjHvu1pf
7bXNjYtE+HZnwMDQGFxiYQwa/X2cUmXRj92YcJT62AZjy+uRyxrjjvHxkSKNziYW
7djP+G9pxzuMfXDhmVsac9K3kDx1p+12Ii1mSQgm0ZI5au+X+Ic7U5KEbOcS+KtH
OzCW882RqKvVMpfurHq8NgI18IcNxMx8uY+sQdMjYYSIo8GZLf1Qx9k0uo3y6B5j
RZDMZBGzUI1w4I6mtjmK7NT2zPrZvGGpWSQqfmBubFU+z3g1DEqT/dJBOhJ9cBFX
BPfezKbTGo7k+sK62tmqP0OPA+hrjg==
=w1Bb
-----END PGP SIGNATURE-----

--Sig_/qG1lbi3eneWefH0rN68cbG3--
