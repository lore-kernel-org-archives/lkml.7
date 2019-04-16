Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41999C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0457E2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m8Y7PJvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDPDHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:07:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37527 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDPDHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:07:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jqzw5BvFz9s4Y;
        Tue, 16 Apr 2019 13:07:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555384060;
        bh=xXQRim0wvz2wPDdiIyoSYwZ1fRCXVPfo2QhayzjlcxY=;
        h=Date:From:To:Cc:Subject:From;
        b=m8Y7PJvnOOKdr4a04eeuK7+GHtVFDyY+MNXyxv0Mpe8s5EymMVyLIQ0Q/9xZl2FsD
         Ajp1rOc6S6d1QbXnM9HFMbwl4huHhzh1geZGCMprumXJJoyfItIUF2TAAasUoNHj4x
         SpkhkwPpcu8IwmTGvRqJKHvOKMGV9dQGgi6bd8srbr3a7A9MyVMzCuniMw5mobs9zU
         gbs9SXLKB192erv5nh5GsxyhdqC66ODJr6DQej8Y8WZoEZ0ynXIcSxb4TLobJ1iml6
         UCTqRjdZM0/puwYrmmS0pWFCGW5XMG2rCNns5JBKeSQaI/aG9GtUDxgVIjk/X1Glwj
         RLcwcuWSUC49Q==
Date:   Tue, 16 Apr 2019 13:07:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20190416130740.7ff9e561@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R4VDdDOj84NdA8uEha7ASeV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R4VDdDOj84NdA8uEha7ASeV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

After merging the tpmdd tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

include/linux/tpm_eventlog.h: In function '__calc_tpm2_event_size':
drivers/firmware/efi/tpm.c:7:35: error: implicit declaration of function 'e=
arly_memremap'; did you mean 'early_memtest'? [-Werror=3Dimplicit-function-=
declaration]
 #define TPM_MEMREMAP(start, size) early_memremap(start, size)
                                   ^~~~~~~~~~~~~~
include/linux/tpm_eventlog.h:182:13: note: in expansion of macro 'TPM_MEMRE=
MAP'
   mapping =3D TPM_MEMREMAP((unsigned long)marker_start,
             ^~~~~~~~~~~~
In file included from drivers/firmware/efi/tpm.c:13:
include/linux/tpm_eventlog.h:182:11: warning: assignment to 'void *' from '=
int' makes pointer from integer without a cast [-Wint-conversion]
   mapping =3D TPM_MEMREMAP((unsigned long)marker_start,
           ^
drivers/firmware/efi/tpm.c:8:35: error: implicit declaration of function 'e=
arly_memunmap'; did you mean 'early_memtest'? [-Werror=3Dimplicit-function-=
declaration]
 #define TPM_MEMUNMAP(start, size) early_memunmap(start, size)
                                   ^~~~~~~~~~~~~~
include/linux/tpm_eventlog.h:203:4: note: in expansion of macro 'TPM_MEMUNM=
AP'
    TPM_MEMUNMAP(mapping, mapping_size);
    ^~~~~~~~~~~~
In file included from drivers/firmware/efi/tpm.c:13:
include/linux/tpm_eventlog.h:205:12: warning: assignment to 'void *' from '=
int' makes pointer from integer without a cast [-Wint-conversion]
    mapping =3D TPM_MEMREMAP((unsigned long)marker_start,
            ^
include/linux/tpm_eventlog.h:225:14: warning: assignment to 'void *' from '=
int' makes pointer from integer without a cast [-Wint-conversion]
      mapping =3D TPM_MEMREMAP((unsigned long)marker_start,
              ^
include/linux/tpm_eventlog.h:251:11: warning: assignment to 'void *' from '=
int' makes pointer from integer without a cast [-Wint-conversion]
   mapping =3D TPM_MEMREMAP((unsigned long)marker_start,
           ^
In file included from ./arch/arm/include/generated/asm/early_ioremap.h:1,
                 from drivers/firmware/efi/tpm.c:15:
include/asm-generic/early_ioremap.h: At top level:
include/asm-generic/early_ioremap.h:13:14: error: conflicting types for 'ea=
rly_memremap'
 extern void *early_memremap(resource_size_t phys_addr,
              ^~~~~~~~~~~~~~
drivers/firmware/efi/tpm.c:7:35: note: previous implicit declaration of 'ea=
rly_memremap' was here
 #define TPM_MEMREMAP(start, size) early_memremap(start, size)
                                   ^~~~~~~~~~~~~~
include/linux/tpm_eventlog.h:182:13: note: in expansion of macro 'TPM_MEMRE=
MAP'
   mapping =3D TPM_MEMREMAP((unsigned long)marker_start,
             ^~~~~~~~~~~~
In file included from ./arch/arm/include/generated/asm/early_ioremap.h:1,
                 from drivers/firmware/efi/tpm.c:15:
include/asm-generic/early_ioremap.h:20:13: warning: conflicting types for '=
early_memunmap'
 extern void early_memunmap(void *addr, unsigned long size);
             ^~~~~~~~~~~~~~
drivers/firmware/efi/tpm.c:8:35: note: previous implicit declaration of 'ea=
rly_memunmap' was here
 #define TPM_MEMUNMAP(start, size) early_memunmap(start, size)
                                   ^~~~~~~~~~~~~~
include/linux/tpm_eventlog.h:203:4: note: in expansion of macro 'TPM_MEMUNM=
AP'
    TPM_MEMUNMAP(mapping, mapping_size);
    ^~~~~~~~~~~~

Caused by commit

  05165bf3d231 ("tpm: Abstract crypto agile event size calculations")

and maybe

  cdb75b359079 ("tpm: Reserve the TPM final events table")

I have used the tmpdd tree from next-20190415 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/R4VDdDOj84NdA8uEha7ASeV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly1RvwACgkQAVBC80lX
0Gz5Ygf/VWqIWSOEQkMqZuZQ11MaN6oos1dgokn06sirX2N/MbBt777v/FZXjm6M
snrj7k1rfjBgLXxWXwZCp3jpmaNmYP1rUdWj41FTYi9ln0owBpAwexWCYFtiHzmb
khhdnggmyjroyadMhk9PogYvxAqQszoJ6KP4eRb2qy1hW8vRMLIFHUqpRayI9KKP
YymzZum7PNylCarqzTjNoXL8pozYdOjv6QjAvUA6Tv96DLBo+Kwx6YZgFeFCXNxa
GPsj8Lw8ubGMTnfuoRv8SYZ97Av+RXhGBcle6PuWgxVGbFzmRJKFjGK0cq66cEzW
nlKn4a3y8xV0FEMppXpPo6oNk4SRTA==
=5O9A
-----END PGP SIGNATURE-----

--Sig_/R4VDdDOj84NdA8uEha7ASeV--
