Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E4FC73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0399B20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HDxUfezm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfGJEPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:15:33 -0400
Received: from ozlabs.org ([203.11.71.1]:45659 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfGJEPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 00:15:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45k5Sv6pzsz9sN4;
        Wed, 10 Jul 2019 14:15:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562732128;
        bh=2z69ihbJOeL8uxjtSXoBaEdSyNvycSj9d/xrM2gZTVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDxUfezmV8ivCN6IYvRjCsxCp4DVkPBvWP0iGAoEanMPV9rQNzlUIadDHXrNBlfuw
         lota7QxyTgft1EP1PfYkPG8+22Zw5BgbuH+qlKEkgrutxqHN/XuA9jZPhUP0JJUisK
         kLZTNw7HIGx9lxvJSAfeN9aUFSJEpdS+bHHL9rG2PZ7fLG+nSKH/Xt6u4jW/qPyKt3
         bwlatlHll53XoUVgmpehIZharsHi/f1p6Y6g3Zf30j6dRL4oxsVxLt1m0jjpyx/iFo
         SgZlIUrzDifwVStw2FsedkrKDLNB+jvhbU/9ofqyRxB2En9F+ynDlPk81I6/XWle/S
         cAltgpLInOUMg==
Date:   Wed, 10 Jul 2019 14:15:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc1
Message-ID: <20190710141526.2f905572@canb.auug.org.au>
In-Reply-To: <20190709182010.GA32200@embeddedor>
References: <20190709182010.GA32200@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kLC9je1p=YhC59r2X/=31Rz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kLC9je1p=YhC59r2X/=31Rz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, 9 Jul 2019 13:20:10 -0500 "Gustavo A. R. Silva" <gustavo@embeddedor=
.com> wrote:
>
>   Makefile: Globally enable fall-through warning (2019-07-08 15:23:22 -05=
00)

There are still a few of these warnings in various builds.  My x86_64
allmodconfig build after merging your tree into Linus' tree this
morning looked like below (which is way better than when you started).
I reported (most of) these along the way ...

arch/x86/events/intel/core.c: In function 'intel_pmu_init':
arch/x86/events/intel/core.c:4959:8: warning: this statement may fall throu=
gh [-Wimplicit-fallthrough=3D]
   pmem =3D true;
   ~~~~~^~~~~~
arch/x86/events/intel/core.c:4960:2: note: here
  case INTEL_FAM6_SKYLAKE_MOBILE:
  ^~~~
arch/x86/events/intel/core.c:5008:8: warning: this statement may fall throu=
gh [-Wimplicit-fallthrough=3D]
   pmem =3D true;
   ~~~~~^~~~~~
arch/x86/events/intel/core.c:5009:2: note: here
  case INTEL_FAM6_ICELAKE_MOBILE:
  ^~~~
fs/btrfs/props.c: In function 'inherit_props':
fs/btrfs/props.c:389:4: warning: 'num_bytes' may be used uninitialized in t=
his function [-Wmaybe-uninitialized]
    btrfs_block_rsv_release(fs_info, trans->block_rsv,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      num_bytes);
      ~~~~~~~~~~
drivers/mtd/nand/onenand/onenand_base.c: In function 'onenand_check_feature=
s':
drivers/mtd/nand/onenand/onenand_base.c:3261:6: warning: this statement may=
 fall through [-Wimplicit-fallthrough=3D]
   if (ONENAND_IS_DDP(this))
      ^
drivers/mtd/nand/onenand/onenand_base.c:3281:2: note: here
  case ONENAND_DEVICE_DENSITY_2Gb:
  ^~~~
drivers/mtd/nand/onenand/onenand_base.c:3285:17: warning: this statement ma=
y fall through [-Wimplicit-fallthrough=3D]
   this->options |=3D ONENAND_HAS_UNLOCK_ALL;
drivers/mtd/nand/onenand/onenand_base.c:3287:2: note: here
  case ONENAND_DEVICE_DENSITY_1Gb:
  ^~~~
drivers/net/ethernet/intel/igb/e1000_82575.c: In function 'igb_get_invarian=
ts_82575':
drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this statement=
 may fall through [-Wimplicit-fallthrough=3D]
   if (igb_sgmii_uses_mdio_82575(hw)) {
      ^
drivers/net/ethernet/intel/igb/e1000_82575.c:642:2: note: here
  case E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES:
  ^~~~
drivers/net/ethernet/intel/igb/igb_main.c: In function '__igb_notify_dca':
drivers/net/ethernet/intel/igb/igb_main.c:6692:6: warning: this statement m=
ay fall through [-Wimplicit-fallthrough=3D]
   if (dca_add_requester(dev) =3D=3D 0) {
      ^
drivers/net/ethernet/intel/igb/igb_main.c:6699:2: note: here
  case DCA_PROVIDER_REMOVE:
  ^~~~
drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_run_xdp_zc':
drivers/net/ethernet/intel/i40e/i40e_xsk.c:217:3: warning: this statement m=
ay fall through [-Wimplicit-fallthrough=3D]
   bpf_warn_invalid_xdp_action(act);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_xsk.c:218:2: note: here
  case XDP_ABORTED:
  ^~~~

--=20
Cheers,
Stephen Rothwell

--Sig_/kLC9je1p=YhC59r2X/=31Rz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lZl4ACgkQAVBC80lX
0GwgIQf/dTrBnLdI87NeJ2AKlbQdwrZk7lVuT/zECNXlGxwGhjPXNB3/oRwxpLJR
2tpDKMBjpKNiVQzhByJV/5+1EcyM6P59nmR+JGUU9t1c271njlaVhYaNBvQhZtd+
3AjEj15PPCPTEykd5T1Zr29Na98ILezmIN7Hy9NZqjOLreQxp7Tno/iW0GoW3WXf
/kIci9okoTWgjYiCG9S43FYos4TsDgiM0jvrVtAaVZYn1FPLraOtOR/ZxXQTbue2
W5Y1OL+UcGs96W4gevJ8yMd2vk8tSx6mWLbmCYxnbaEOmr2d78cbtga/2cOWnMnw
6scMqpO80CftR9YgKeHHrsiOr6uVjw==
=+mJR
-----END PGP SIGNATURE-----

--Sig_/kLC9je1p=YhC59r2X/=31Rz--
