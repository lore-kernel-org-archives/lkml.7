Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F213AC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 02:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39E0216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 02:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qai+NTOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfHACuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 22:50:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfHACuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:50:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zZXK0vY4z9sMr;
        Thu,  1 Aug 2019 12:50:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564627810;
        bh=Vz4PbnGvp87fekQr8Axb0T3lKXfAHGX5+7DZxMwiTsE=;
        h=Date:From:To:Cc:Subject:From;
        b=qai+NTOjAghdddihkjQork1rjg5sA/onFT1l63P1d+xXvcnqjdnPG+LobkoGBsgCN
         e114GOo3LM2yYHAKgh7T6+pyIUuY3C6QxoBpBf8TfNFB1Q73nNRqzveVgiHQQRxEYm
         2UB92rK7D8sE8yUCT6jmHMwSbr1MHKZVwHZlGqBzfrberXpX6ekkwExH2j98PKPsLF
         hwIRf5S8Pp5+iHDKv8SDaQcQoa1sleK37Flik66JWpPTVBEc7hJYNSU0UGWEyDBPd/
         jzU6ONEE2txadkVi8Z/CdZolCbK2IfQrulmnLhQk66kgWzGNEzDb20fdVNGkUWeAly
         8fEhEiKhwFAZA==
Date:   Thu, 1 Aug 2019 12:50:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: linux-next: manual merge of the sound-asoc tree with the sound tree
Message-ID: <20190801125008.4a533637@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Of7hYDvcZhZJ_+VWo=quPjd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Of7hYDvcZhZJ_+VWo=quPjd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got conflicts in:

  sound/soc/intel/skylake/skl-nhlt.c
  sound/soc/intel/skylake/skl.h

between commit:

  1169cbf6b98e ("ASoC: Intel: Skylake: use common NHLT module")

from the sound tree and commit:

  bcc2a2dc3ba8 ("ASoC: Intel: Skylake: Merge skl_sst and skl into skl_dev s=
truct")

from the sound-asoc tree.

I fixed it up (I think, see below (I used the sound tree version of
ound/soc/intel/skylake/skl-nhlt.c)) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non
trivial conflicts should be mentioned to your upstream maintainer when
your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc sound/soc/intel/skylake/skl-nhlt.c
index 6f57ceb9efb7,6fc3a190067e..000000000000
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
diff --cc sound/soc/intel/skylake/skl.h
index f4dd6c767993,600a61f79b0a..000000000000
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@@ -16,7 -16,9 +16,8 @@@
  #include <sound/hdaudio_ext.h>
  #include <sound/hda_codec.h>
  #include <sound/soc.h>
 -#include "skl-nhlt.h"
  #include "skl-ssp-clk.h"
+ #include "skl-sst-ipc.h"
 =20
  #define SKL_SUSPEND_DELAY 2000
 =20
@@@ -128,24 -167,27 +166,24 @@@ struct skl_dsp_ops=20
  int skl_platform_unregister(struct device *dev);
  int skl_platform_register(struct device *dev);
 =20
- struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 -struct nhlt_acpi_table *skl_nhlt_init(struct device *dev);
 -void skl_nhlt_free(struct nhlt_acpi_table *addr);
+ struct nhlt_specific_cfg *skl_get_ep_blob(struct skl_dev *skl, u32 instan=
ce,
  					u8 link_type, u8 s_fmt, u8 no_ch,
  					u32 s_rate, u8 dirn, u8 dev_type);
 =20
- int skl_nhlt_update_topology_bin(struct skl *skl);
- int skl_init_dsp(struct skl *skl);
- int skl_free_dsp(struct skl *skl);
- int skl_suspend_late_dsp(struct skl *skl);
- int skl_suspend_dsp(struct skl *skl);
- int skl_resume_dsp(struct skl *skl);
- void skl_cleanup_resources(struct skl *skl);
 -int skl_get_dmic_geo(struct skl_dev *skl);
+ int skl_nhlt_update_topology_bin(struct skl_dev *skl);
+ int skl_init_dsp(struct skl_dev *skl);
+ int skl_free_dsp(struct skl_dev *skl);
+ int skl_suspend_late_dsp(struct skl_dev *skl);
+ int skl_suspend_dsp(struct skl_dev *skl);
+ int skl_resume_dsp(struct skl_dev *skl);
+ void skl_cleanup_resources(struct skl_dev *skl);
  const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id);
  void skl_update_d0i3c(struct device *dev, bool enable);
- int skl_nhlt_create_sysfs(struct skl *skl);
- void skl_nhlt_remove_sysfs(struct skl *skl);
- void skl_get_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks);
+ int skl_nhlt_create_sysfs(struct skl_dev *skl);
+ void skl_nhlt_remove_sysfs(struct skl_dev *skl);
+ void skl_get_clks(struct skl_dev *skl, struct skl_ssp_clk *ssp_clks);
  struct skl_clk_parent_src *skl_get_parent_clk(u8 clk_id);
- int skl_dsp_set_dma_control(struct skl_sst *ctx, u32 *caps,
+ int skl_dsp_set_dma_control(struct skl_dev *skl, u32 *caps,
  				u32 caps_size, u32 node_id);
 =20
  struct skl_module_cfg;

--Sig_/Of7hYDvcZhZJ_+VWo=quPjd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1CU2AACgkQAVBC80lX
0Gx+Jgf6A9sBdThuP5HB4RNEfLuww0j7MwkSNFi/V4Ur1+70oJbE3elPkuy+VkrO
JX4WOY0MXZ9j/b02nEkj3Tc5HAuKQlkPuSZcgNYOszHjw21ZbJRBS9OAbZ2wPp8i
bGKpsMNjgDWyCrU9ef9hbtu0juMri/DIk6i1GtSuva6Z/dMH0iLc1MFG8w5kfmLS
5gGZYmqKGOiW72Bt3QJhx9PaAiHyV4XQnp5Ru0u4YQkBCIwGEa0fXaHL8eTeXgX0
3rMZmO5MuSq+I/3h1ev9AKHkA+KDokybFIuM1P39do69t/3KLdqQQkkyZtM9m9a5
Tb9830pfCL7tTAGpMkdg0tgnGgDMkw==
=S4cp
-----END PGP SIGNATURE-----

--Sig_/Of7hYDvcZhZJ_+VWo=quPjd--
