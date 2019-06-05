Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F9620828
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kHgvB8bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFECJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:09:55 -0400
Received: from ozlabs.org ([203.11.71.1]:56093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFECJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:09:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45JXL702ynz9sCJ;
        Wed,  5 Jun 2019 12:09:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559700591;
        bh=XsGZewjxRk1dW1RfQaD9llUnChOqp7IO3x6ZtA3FviI=;
        h=Date:From:To:Cc:Subject:From;
        b=kHgvB8bmDJJt8gh/l6f0AmIL0cDVzuPhzv5sszIL6XaFdl+uF8YFhxo1GHU+qt3c+
         mOWaG022sU6l/dIhAd1YM4Dwbnvp6IVaHcbvvhBYlCWkpPXmwjSx2gVWCaiAoBh1cD
         va5Gh9/Csil/DhzcichPvxjY71SQ2eHLcu/kYYB0vFOG/9L36u2fhLYU/haIfsnvkp
         wbSwff9ToT1RdsOYx3SsCYaXIzGAqZb7Twad7oFgLVkzwIBW9PuDTa/cz1fAKf4ftl
         l/HumZqSt0fYGmeFkKQZXxcBGazQgIiSREo9rMJt+TZ2QZHdIlvaQuHx/ojEQhjWXZ
         VUVa04yqJI++w==
Date:   Wed, 5 Jun 2019 12:09:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20190605120946.43b44032@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Gb31PL/gttZQcWVCL4d94hY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gb31PL/gttZQcWVCL4d94hY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

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
include/linux/tpm_eventlog.h:207:4: note: in expansion of macro 'TPM_MEMUNM=
AP'
    TPM_MEMUNMAP(mapping, mapping_size);
    ^~~~~~~~~~~~
In file included from drivers/firmware/efi/tpm.c:13:
include/linux/tpm_eventlog.h:209:12: warning: assignment to 'void *' from '=
int' makes pointer from integer without a cast [-Wint-conversion]
    mapping =3D TPM_MEMREMAP((unsigned long)marker,
            ^
include/linux/tpm_eventlog.h:243:11: warning: assignment to 'void *' from '=
int' makes pointer from integer without a cast [-Wint-conversion]
   mapping =3D TPM_MEMREMAP((unsigned long)marker,
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
include/linux/tpm_eventlog.h:207:4: note: in expansion of macro 'TPM_MEMUNM=
AP'
    TPM_MEMUNMAP(mapping, mapping_size);
    ^~~~~~~~~~~~
drivers/firmware/efi/tpm.c: In function 'efi_tpm_eventlog_init':
drivers/firmware/efi/tpm.c:81:10: warning: passing argument 1 of 'tpm2_calc=
_event_log_size' makes pointer from integer without a cast [-Wint-conversio=
n]
  tbl_size =3D tpm2_calc_event_log_size(efi.tpm_final_log
                                      ~~~~~~~~~~~~~~~~~
          + sizeof(final_tbl->version)
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          + sizeof(final_tbl->nr_events),
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/efi/tpm.c:20:43: note: expected 'void *' but argument is o=
f type 'long unsigned int'
 static int tpm2_calc_event_log_size(void *data, int count, void *size_info)
                                     ~~~~~~^~~~
cc1: some warnings being treated as errors

Caused by commit

  b25b956d13d5 ("tpm: Reserve the TPM final events table")

I have used the tpmdd tree from next-20190604 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Gb31PL/gttZQcWVCL4d94hY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz3JGoACgkQAVBC80lX
0GxZJQf/VdioND2pmbnKziKHT63gh5B4gQlwbhX5DiLduP2le3dnY53nt1IC8h5K
VBYdGTQ/UpaQHJ2vPj3JL00lEAYzQVkVOb5zbME8l1teqsgRcRf9Z4tWYypu9Qe2
ey48XkW4dKqtx2aQavn/6vb9Q6U4bXad7F17y5DtBU9T+3PE8BiAvbd1b6kLsovL
GCuhXRLHi5Sa2K/uVIFEr3wpLf5jBzl4/OZfV+Z98Z3z5b+g/plQlhm10pJFg50B
sLe1gitKyc73JfUCGC6a0bfqM5PO/eZ7aRGbvzrSDSPV6V8/jtzqip6a66SbCIMD
Q4jszoxkKOPLjLp2JktmjGf4dkIYsw==
=pU8e
-----END PGP SIGNATURE-----

--Sig_/Gb31PL/gttZQcWVCL4d94hY--
