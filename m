Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EA5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569B620835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f9vVB/qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCTAs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:48:56 -0400
Received: from ozlabs.org ([203.11.71.1]:57287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfCTAsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:48:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44PBBD2zhRz9sNJ;
        Wed, 20 Mar 2019 11:48:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553042932;
        bh=eDObSQQJAPg/FGZgW9PY+axMaDSVd6xte3vhcrkKhs4=;
        h=Date:From:To:Cc:Subject:From;
        b=f9vVB/qgSy0USm9ros21BFShwk/ByZ4hol+631C5LHi9990pews4T9Uae8gAPszke
         tNvMQ1L5oOftS7vmMbXwtrYQXPHJF+K4NZfznEt3aUHUaVw/JDyVuA6d+9Lqr4LC6I
         axOB0zuBTWLA/62rsiVvH+D6cNjZkFKoFUZJDagCxgctDuPHIt1LAkJuIHsuW9xa8H
         D48Z6Yg8AehL9DJaR6mYRi9EqDy3HU7fnzDT0bet49OccZvAdI1XtVbYUE3RikEZma
         /mAuTqDzIp7nskvpMsodyTOxlvaLp68gyhKU+gNO2Eio89Vj5dSEA2opa7LKmMpYoz
         91cb07w7eIWuQ==
Date:   Wed, 20 Mar 2019 11:48:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: linux-next: build failure after merge of the scsi tree
Message-ID: <20190320114851.2b677117@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N5SU8aPv._dTQOE9WqmASGV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N5SU8aPv._dTQOE9WqmASGV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

After merging the scsi tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from drivers/scsi/lpfc/lpfc_debugfs.c:46:
drivers/scsi/lpfc/lpfc_debugfs.c: In function 'lpfc_idiag_queacc_write':
drivers/scsi/lpfc/lpfc_sli4.h:1083:14: error: inlining failed in call to al=
ways_inline 'lpfc_sli4_qe': function body not available
 inline void *lpfc_sli4_qe(struct lpfc_queue *, uint16_t);
              ^~~~~~~~~~~~
drivers/scsi/lpfc/lpfc_debugfs.c:4488:12: note: called from here
   pentry =3D lpfc_sli4_qe(pque, index);
            ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/scsi/lpfc/lpfc_debugfs.c:46:
drivers/scsi/lpfc/lpfc_sli4.h:1083:14: error: inlining failed in call to al=
ways_inline 'lpfc_sli4_qe': function body not available
 inline void *lpfc_sli4_qe(struct lpfc_queue *, uint16_t);
              ^~~~~~~~~~~~
drivers/scsi/lpfc/lpfc_debugfs.c:4488:12: note: called from here
   pentry =3D lpfc_sli4_qe(pque, index);
            ^~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  9afbee3d62a4 ("scsi: lpfc: Reduce memory footprint for lpfc_queue")

I applied the following fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 20 Mar 2019 11:44:21 +1100
Subject: [PATCH] scsi: lpfc: remove inappropriate inline

Fixes: 9afbee3d62a4 ("scsi: lpfc: Reduce memory footprint for lpfc_queue")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/scsi/lpfc/lpfc_sli4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli4.h b/drivers/scsi/lpfc/lpfc_sli4.h
index bd5b5c3de35e..6670c6e7e28d 100644
--- a/drivers/scsi/lpfc/lpfc_sli4.h
+++ b/drivers/scsi/lpfc/lpfc_sli4.h
@@ -1080,4 +1080,4 @@ int lpfc_sli4_post_status_check(struct lpfc_hba *);
 uint8_t lpfc_sli_config_mbox_subsys_get(struct lpfc_hba *, LPFC_MBOXQ_t *);
 uint8_t lpfc_sli_config_mbox_opcode_get(struct lpfc_hba *, LPFC_MBOXQ_t *);
 void lpfc_sli4_ras_dma_free(struct lpfc_hba *phba);
-inline void *lpfc_sli4_qe(struct lpfc_queue *, uint16_t);
+void *lpfc_sli4_qe(struct lpfc_queue *, uint16_t);
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/N5SU8aPv._dTQOE9WqmASGV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyRjfMACgkQAVBC80lX
0GxeLQf/QV3B/Pfu+mu/5UjVBgaWjQmP0diYpYTjL0FJmK6+gdLxwOtrD9IoDDOO
dEI/PImPkDFlaIBCuAAyDuOnRuQ8S8HstR5RKNrDD9EL3gn7geRMoPblrK8nmn5z
XVXVEyZ/mwynqW3snVZh4C0ixKcEQgFHMCeNVXaVmZ8f+gAxgeVay1sBwZ2SyG9h
5LwNw4mUkGPGUD1tXRM/P7m88EDlRlgW93nm73LLIqimNOViyqLe1g44kMc56sR0
w8xRl9ftuCaz4piTtd+MTisDtmzN+/yZV64rNUM+n1mgRl1DQXIu4Kws32Jn34B0
L8jSoia5UrnJG5GdXl1PBabLc7cpqA==
=AH4e
-----END PGP SIGNATURE-----

--Sig_/N5SU8aPv._dTQOE9WqmASGV--
