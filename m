Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC6C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7587208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OhZ23hRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfFXEYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:24:34 -0400
Received: from ozlabs.org ([203.11.71.1]:59987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfFXEYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:24:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XGQk0xGSz9s5c;
        Mon, 24 Jun 2019 14:24:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561350270;
        bh=If53SsAP8JaGlSkq2qrF5m/brE+5LpOGJ3XSlZpxDDc=;
        h=Date:From:To:Cc:Subject:From;
        b=OhZ23hRnhUfxg7ZDgn6v304oW/DEcNg4OIv36y/K8mq3jQUbiDR6aKde/DvFACx++
         859be67fx6sK87/aeiNzr44fBDByYClxD4NsV0Q2ZAlCfjjy+Hz6mXisZbKtLDoFkd
         BRFdAqwH/EhvU6HjuuMLkEh3cMKNuDYzLRHjQ4quDyh852blVhuBll9jFFiL5RZG/a
         P1kz01Xl2s8ZJ5ouIpncQre3pKwYlIj60e6PZs8rmAPR8ah0dL3L3SyeSFgiCzHMlt
         McYZi8CcxXl4LYEe13WTBL14VzEVd3wfbS6ZxV3g+nREFX3As179wH/B+IK0ryKhbr
         482qnqenR1yzw==
Date:   Mon, 24 Jun 2019 14:24:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Wang <kevin1.wang@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20190624142429.1791c73b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B1IjdKPb1FJe0vp1V15efai"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B1IjdKPb1FJe0vp1V15efai
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/kernel.h:15,
                 from include/asm-generic/bug.h:18,
                 from arch/x86/include/asm/bug.h:83,
                 from include/linux/bug.h:5,
                 from include/linux/mmdebug.h:5,
                 from include/linux/gfp.h:5,
                 from include/linux/firmware.h:7,
                 from drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:2=
3:
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c: In function 'smu_v11_0=
_irq_process':
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1542:5: error: implicit=
 declaration of function 'PCI_BUS_NUM' [-Werror=3Dimplicit-function-declara=
tion]
     PCI_BUS_NUM(adev->pdev->devfn),
     ^~~~~~~~~~~
include/linux/printk.h:306:37: note: in definition of macro 'pr_warning'
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                     ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1541:4: note: in expans=
ion of macro 'pr_warn'
    pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
    ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1542:27: error: derefer=
encing pointer to incomplete type 'struct pci_dev'
     PCI_BUS_NUM(adev->pdev->devfn),
                           ^~
include/linux/printk.h:306:37: note: in definition of macro 'pr_warning'
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                     ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1541:4: note: in expans=
ion of macro 'pr_warn'
    pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
    ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1543:5: error: implicit=
 declaration of function 'PCI_SLOT'; did you mean 'CC_SET'? [-Werror=3Dimpl=
icit-function-declaration]
     PCI_SLOT(adev->pdev->devfn),
     ^~~~~~~~
include/linux/printk.h:306:37: note: in definition of macro 'pr_warning'
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                     ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1541:4: note: in expans=
ion of macro 'pr_warn'
    pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
    ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1544:5: error: implicit=
 declaration of function 'PCI_FUNC'; did you mean 'STT_FUNC'? [-Werror=3Dim=
plicit-function-declaration]
     PCI_FUNC(adev->pdev->devfn));
     ^~~~~~~~
include/linux/printk.h:306:37: note: in definition of macro 'pr_warning'
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                     ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1541:4: note: in expans=
ion of macro 'pr_warn'
    pr_warn("GPU over temperature range detected on PCIe %d:%d.%d!\n",
    ^~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  5e6d266573db ("drm/amd/powerplay: add thermal ctf support for navi10")

I have used the amdgu tree from next-20190621 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/B1IjdKPb1FJe0vp1V15efai
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QUH0ACgkQAVBC80lX
0Gx5cgf/Zr24C7YgIcv1UWVj5xpT1TI9LEPyWkrzANDwIKPST30hTAcGCljDe3gY
U02rxXDibSTTIpeiqia5KLpdFUaG6wYoWrIkckDTTDrLIO3QewsYi/x8zIoDCHGb
DirSLIqwVcr7ucO8rBv/q39V1e+fdlwgpXDe026pW/CZJu7tkwRN4e4yC21eziIi
vMeZEyNcsgMDq+iBMwckE30HLqy8Lq21dpd09AnL0Tipx77f/ZA4m9mYxWnD1wan
BARJL5+b3ha7pXiBc5LI8jA3Wl9oWOSjWV3r371Y8ldX9JvSwFIckdIRRFLVQpfG
nw20myryrklPneva3KHpFGc2LlCTPw==
=VRSD
-----END PGP SIGNATURE-----

--Sig_/B1IjdKPb1FJe0vp1V15efai--
